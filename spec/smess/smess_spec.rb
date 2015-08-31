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
      expect(Smess.config.debug).to be_false
    end

    it "reads changed config values" do
      Smess.configure do |config|
        config.debug = true
      end
      expect(Smess.config.debug).to be_true
    end

    it "can reset config back to defaults" do
      Smess.configure do |config|
        config.debug = true
      end
      expect(Smess.config.debug).to be_true
      Smess.reset_config
      expect(Smess.config.debug).to be_false
    end

  end

end
