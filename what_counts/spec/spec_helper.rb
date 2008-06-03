require 'rubygems'
require 'spec'

require File.dirname(__FILE__) + "/../../what_counts"

module ResponseSpecHelper
  
  def mock_success_response
    "SUCCESS: mail will be sent to test@example.com"
  end

  def mock_failure_response
    "FAILURE: Something went wrong"
  end
  
  def mock_invalid_password_response
    "Password (asdf) doesn't match entry for API user credentials in database"
  end
  
end

module RequestSpecHelper
  
  def mock_one_off_message
    test_attrs = {:pwd => 'test', :list_id => 1, :realm => 'test', :format => 1, :to => 'test@test.com', :template_id => 1, :data => {:first => 'Test'}}
    message = mock("message", test_attrs)
    
    return message
  end
  
end