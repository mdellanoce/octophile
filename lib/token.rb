require 'httparty'

class Token
  include HTTParty
  
  base_uri "https://github.com"
  
  def initialize(params)
    response = self.class.post "/login/oauth/access_token", :query => params
    @access_token = response["access_token"]
  end
  
  def to_s
    @access_token
  end
  
  parser Parser::Form
end
