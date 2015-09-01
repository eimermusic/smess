require 'spec_helper'

describe Smess do
  describe "#output" do
    let(:sms) {
      Smess.new(
        to: '46701234567',
        message: 'Test SMS',
        originator: 'TestSuite',
        output: "test"
      )
    }
    it "returns a populated Sms when mobule macro is invoked" do
      sms.class.should == Smess::Sms
      sms.to.should == '46701234567'
      sms.output.should == 'test'
    end
  end

  describe "Config behavior" do
    it "reads config defaults" do
      expect(Smess.config.nothing).to be_false
    end

    it "reads changed config values" do
      Smess.configure do |config|
        config.nothing = true
      end
      expect(Smess.config.nothing).to be_true
    end

    it "can reset config back to defaults" do
      Smess.configure do |config|
        config.nothing = true
      end
      expect(Smess.config.nothing).to be_true
      Smess.reset_config
      expect(Smess.config.nothing).to be_false

    end

    it "can add a country code" do
      Smess.configure do |config|
        config.add_country_code(99, "twilio")
      end
      expect(Smess.config.output_by_country_code["99"]).to eq(:twilio)
    end

    it "can add a country code without specifying the output" do
      Smess.configure do |config|
        config.add_country_code("99")
      end
      expect(Smess.config.output_by_country_code["99"]).to eq(Smess.config.default_output)
    end

    it "raises when given a non-numeric country code" do
      expect{
        Smess.configure do |config|
          config.add_country_code("hello")
        end
      }.to raise_error
    end

    it "raises when given an unknown output" do
      expect{
        Smess.configure do |config|
          config.add_country_code("99", :hello)
        end
      }.to raise_error
    end

  end

end
