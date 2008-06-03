require 'net/http'
require 'net/https'
require 'logger'

module API
  module WhatCounts
    
    class Service
      include API::Base # for error classes
      
      attr_accessor :api_message_response
      
      def send_one_off_message(message)
        message_request = API::WhatCounts::OneOffMessageRequest.new
        
        # assemble the data in a hash for the POST
        message_request.set_data(message)
        
        # make the call, parse the response
        response = API::WhatCounts::OneOffMessageResponse.new( ssl_post(message_request.url, message_request.data) )
        
        self.api_message_response = response
        
        return response
      rescue Exception => err
        log_error(err, 'send_one_off_message()')
        
        # raise a generic error for the caller
        raise ServiceError
      end
      
      
      private
      
      def ssl_post(url, data, headers = {})
        url = URI.parse(url)
        
        # create a Proxy class, incase a proxy is being used - will work even if proxy options are nil
        connection = Net::HTTP.new(url.host, url.port)
        
        connection.use_ssl = true
        connection.read_timeout += 15
        
        if ENV['RAILS_ENV'] == 'production'
          # we want SSL enforced via certificates
          connection.verify_mode = OpenSSL::SSL::VERIFY_PEER
          connection.ca_file = File.dirname(__FILE__) + "/certs/cacert.pem"
        else
          # do not enforce SSL in dev modes
          connection.verify_mode = OpenSSL::SSL::VERIFY_NONE
          
          # for debugging
          connection.set_debug_output $stderr
        end
        
        connection.start { |https|
          # setup the POST request
          req = Net::HTTP::Post.new(url.path)
          req.set_form_data(data, '&')
          
          # do the POST and return the response body
          return https.request(req).body
        }
      end

      def log_error(err, method_name)
        logger = Logger.new(File.dirname(__FILE__) + "/log/error.log")
        logger.error "WhatCounts API Error in Service.#{method_name} - " + err.message
        logger.close
      end
    end # class Service
    
    class OneOffMessage
      include API::Base # for error classes
      
      attr_accessor :pwd, :list_id, :realm, :format, :to, :template_id, :data
      attr_accessor :api_service
      
      def initialize(message_data = {})
        # check for required params
        [:pwd, :list_id, :realm, :format, :to, :template_id, :data].each do |key|
          raise ServiceError, "#{key.to_s} is required" unless message_data.has_key?(key)
        end
        
        self.api_service = API::WhatCounts::Service.new
        
        self.pwd          = message_data[:pwd]
        self.list_id      = message_data[:list_id]
        self.realm        = message_data[:realm]
        self.format       = message_data[:format]
        self.to           = message_data[:to]
        self.template_id  = message_data[:template_id]
        self.data         = build_data_args(message_data[:data])
      end
      
      def send
        msg = self.api_service.send_one_off_message(self)
        
        return msg.result
      rescue ServiceError
        return false
      end
      
      
      private
      
      def build_data_args(data)
        # WhatCounts requires the data to be in the format of key1,key2,key3^value1,value2,value3
        return "" if data.empty?
        
        keys = data.keys.join(",")
        values = data.values.join(",")
        
        return keys + "^" + values
      end
    end # class OneOffMessage
    
  end # module WhatCounts
end # module API