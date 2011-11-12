require 'httparty'

class User
  include HTTParty
  
  base_uri "https://api.github.com"
  
  def initialize(token)
    @token = token
  end
  
  def follow(user)
    response = self.class.put "/user/following/#{user}", :query => {:access_token => @token.to_s}, :headers => {"Content-Length" => "0"}
    status = response.headers["status"] || response.response.class.name
    raise "Failed to follow #{user}: #{status}" if response.code != 204
  end
end
