require 'spec_helper'

describe OmniAuth::Strategies::Weixin do
  let(:access_token) { double(:openid => "open_id", :access_token => "access_token") }


  let(:parsed_response) { double('ParsedResponse') }
  let(:response) { double('Response', :parsed => parsed_response) }

  subject do
    OmniAuth::Strategies::Weixin.new({})
  end

  before(:each) do
    subject.stub(:access_token).and_return(access_token)
  end

  context "client options" do
    it 'should have correct site' do
      subject.options.client_options.site.should eq("https://api.weixin.qq.com")
    end

    it 'should have correct authorize url' do
      subject.options.client_options.authorize_url.should eq('https://open.weixin.qq.com/connect/oauth2/authorize')
    end

    it 'should have correct token url' do
      subject.options.client_options.token_url.should eq('https://api.weixin.qq.com/sns/oauth2/access_token')
    end
  end

  context "#raw_info" do
    it "should get user info" do
      access_token.stub("[]") do |key|
        "some value"
      end

      access_token.should_receive(:get).and_return(response)
      subject.raw_info.should eq(parsed_response)
    end
  end
end