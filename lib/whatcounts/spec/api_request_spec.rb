require File.dirname(__FILE__) + '/spec_helper'

include API::Base
include API::WhatCounts

describe OneOffMessageRequest do
  include RequestSpecHelper
  
  it "should initialize with an API url to call" do
    OneOffMessageRequest.new.url.should eql("https://secure.whatcounts.com/bin/api_web")
  end
  
  it "should accept data for the message and store internally in the data hash" do
    test_attrs = {:pwd => 'test', :list_id => 1, :realm => 'test', :format => 1, :to => 'test@test.com', :template_id => 1, :data => {:first => 'Test'}}
    
    message_request = OneOffMessageRequest.new
    message_request.set_data(mock_one_off_message)
    
    message_request.data.should == test_attrs.merge({:cmd => 'send'}) # the 'send' command is added internallly for the API call
  end
  
end
