require 'spec_helper'

describe Smess::Sms, iso_id: "7.3" do

  let(:sms) {
    Smess::Sms.new(
      to: '46701234567',
      message: 'Test SMS',
      originator: 'TestSuite',
      output: "test"
    )
  }

  it 'can be created with arguments' do
    sms.to.should == '46701234567'
    sms.message.should == 'Test SMS'
    sms.originator.should == 'TestSuite'
  end

  it 'delivering should instantiate an output object and pass itself to it' do
    results = sms.deliver
    sms.should == Smess::Test.instance.sms
    sms.results[:sent_with].should == :test
  end

  it 'changing the response' do
    Smess::Test.delivery_result = {
      :response_code => '-100',
      :response  => {
        :temporaryError =>'false',
        :responseCode => '-100',
        :responseText => 'Custom return value'
      }
    }
    results = sms.deliver
    sms.should == Smess::Test.instance.sms
    sms.results[:sent_with].should == :test
    puts sms.results
  end

end