module API
  module WhatCounts
    
    class Request < API::Base::Request
      attr_accessor :data      
    end
    
    class OneOffMessageRequest < Request
      
      def initialize
        # corresponds to the WhatCounts HTTP API
        self.url = 'https://secure.whatcounts.com/bin/api_web'
      end
      
      def set_data(message_data)
        data_to_send = {
          :cmd => 'send', # the Send command in the API is used for one-off messages
          :pwd => message_data.pwd, 
          
          :list_id => message_data.list_id, 
          :realm => message_data.realm, 
          :format => message_data.format, 
          :to => message_data.to, 
          :template_id => message_data.template_id, 
          :data => message_data.data
        }
        
        self.data = data_to_send
      end
    end
    
  end # module WhatCounts
end # module API