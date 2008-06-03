module API
  module WhatCounts
    
    class Response
      attr_accessor :raw_response, :result      
    end # class Response
    
    class OneOffMessageResponse < Response
      
      def initialize(raw_response)
        if ! (/SUCCESS:/ =~ raw_response).nil?
          # check for success
          self.result = true
        elsif ! (/FAILURE:/ =~ raw_response).nil?
          # check for failure
          self.result = false
        else
          # some other error occurred
          self.result = false
        end
        
        # store the raw response
        self.raw_response = raw_response
      end
    end # class OneOffMessageResponse
    
  end # module WhatCounts
end # module API