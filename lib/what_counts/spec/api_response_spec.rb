require File.dirname(__FILE__) + '/spec_helper'

include API::Base
include API::WhatCounts

describe OneOffMessageResponse do
  include ResponseSpecHelper
  
  it "should initialize and determine if the result is a success" do
    OneOffMessageResponse.new(mock_success_response).result.should eql(true)
  end
  
  it "should initialize and determine if the result is a failure" do
    OneOffMessageResponse.new(mock_failure_response).result.should eql(false)
  end
  
  it "should handle and unknown result" do
    OneOffMessageResponse.new("some unknown response that makes no sense").result.should eql(false)
  end
  
  it "should store the raw_response" do
    OneOffMessageResponse.new(mock_success_response).raw_response.should eql("SUCCESS: mail will be sent to test@example.com")
  end
end
