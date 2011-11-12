require 'httparty'

module HTTParty
  class Parser
    class Form < HTTParty::Parser
      SupportedFormats.merge!({"application/x-www-form-urlencoded" => :form})
      
      protected
      
      def form
        hash = {}
        body.split("&").each do |pair|
          key,value = pair.split("=")
          hash[key] = value
        end
        hash
      end
    end
  end
end
