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
    expect(sms.to).to eq('46701234567')
    expect(sms.message).to eq('Test SMS')
    expect(sms.originator).to eq('TestSuite')
  end

  it 'delivering should instantiate an output object and pass itself to it' do
    results = sms.deliver
    expect(sms).to eq(Smess::Test.instance.sms)
    expect(sms.results[:sent_with]).to eq(:test)
  end

end
