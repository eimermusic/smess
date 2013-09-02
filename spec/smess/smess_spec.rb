require 'spec_helper'

describe "Smess.output", iso_id: "7.1" do

  let(:sms) {
    Smess.new(
      to: '46701234567',
      message: 'Test SMS',
      originator: 'TestSuite',
      output: "test"
    )
  }

  it 'returns a populated Sms when mobule macro is invoked' do
    sms.class.should == Smess::Sms
    sms.to.should == '46701234567'
    sms.output.should == 'test'
  end

end