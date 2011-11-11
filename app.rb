require 'sinatra'
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

get '/' do
  erb :index
end

get '/follow/:user' do
  client_id = "148718244dbf91ab58bc"
  code = params[:code]
  
  if code
    token = Token.new({
      :client_id => client_id,
      :client_secret => "e065813ece4e5738c0a37aa7b11e5da7db4d27bf",
      :code => code
    })
    
    user = User.new token
    user.follow params[:user]
  else
    query = "scope=user&client_id=#{client_id}&redirect_uri=#{request.url}"
    redirect "https://github.com/login/oauth/authorize?#{query}"
  end
end
