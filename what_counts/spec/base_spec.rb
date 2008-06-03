require File.dirname(__FILE__) + '/spec_helper'

include API::Base
include API::WhatCounts

describe Service do
  include ResponseSpecHelper
  include RequestSpecHelper
  
  before(:each) do
    @service = API::WhatCounts::Service.new
  end
  
  it "should be able to handle an Exception in send_one_off_message() when calling the API" do
    @service.stub!(:ssl_post).and_raise(Exception)
    lambda { @service.send_one_off_message(mock_one_off_message) }.should raise_error(ServiceError)
  end
  
  it "should be able to handle a successful API response" do
    @service.stub!(:ssl_post).and_return(mock_success_response)
    
    @service.send_one_off_message(mock_one_off_message).should be_an_instance_of(API::WhatCounts::OneOffMessageResponse)
    @service.api_message_response.should be_an_instance_of(API::WhatCounts::OneOffMessageResponse)
  end

  it "should be able to handle a failed API response" do
    @service.stub!(:ssl_post).and_return(mock_failure_response)
    
    @service.send_one_off_message(mock_one_off_message).should be_an_instance_of(API::WhatCounts::OneOffMessageResponse)
    @service.api_message_response.should be_an_instance_of(API::WhatCounts::OneOffMessageResponse)
  end


end


describe OneOffMessage do
  include ResponseSpecHelper
  include RequestSpecHelper
  
  before(:each) do
    @test_attrs = {:pwd => 'test', :list_id => 1, :realm => 'test', :format => 1, :to => 'test@test.com', :template_id => 1, :data => {:first => 'Test'}}
  end
  
  it "should initialize with configuration values in a hash" do
    msg = OneOffMessage.new(@test_attrs)
    
    msg.api_service.should be_an_instance_of(API::WhatCounts::Service)
    msg.pwd.should eql(@test_attrs[:pwd])
    msg.list_id.should eql(@test_attrs[:list_id])
    msg.realm.should eql(@test_attrs[:realm])
    msg.format.should eql(@test_attrs[:format])
    msg.to.should eql(@test_attrs[:to])
    msg.template_id.should eql(@test_attrs[:template_id])
    msg.data.should eql('first^Test')
  end
  
  it "should raise and exception if the requried values are not present on initialization" do
    lambda { OneOffMessage.new }.should raise_error(ServiceError)
  end
  
  it "should receive a true value back from a succesful message sent" do
    serv = API::WhatCounts::Service.new
    serv.stub!(:ssl_post).and_return(mock_success_response)
    msg = OneOffMessage.new(@test_attrs)
    msg.api_service = serv
    
    msg.send.should be_true
  end
  
  it "should receive a false value back from a failed message sent" do
    serv = API::WhatCounts::Service.new
    serv.stub!(:ssl_post).and_return(mock_failure_response)
    msg = OneOffMessage.new(@test_attrs)
    msg.api_service = serv
    
    msg.send.should be_false
  end
  
  it "sould receive a false value back from an error during message sending" do
    serv = API::WhatCounts::Service.new
    serv.stub!(:send_one_off_message).and_raise(ServiceError)
    msg = OneOffMessage.new(@test_attrs)
    msg.api_service = serv
    
    msg.send.should be_false
  end
  
end
