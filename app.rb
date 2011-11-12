require 'sinatra'
require 'httparty'

ID_KEY = 'GITHUB_CLIENT_ID'
SECRET_KEY = 'GITHUB_CLIENT_SECRET'
client_id = ENV[ID_KEY]
client_secret = ENV[SECRET_KEY]

raise "Expected environment variables #{ID_KEY} and #{SECRET_KEY}" if !client_id or !client_secret

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
  code = params[:code]
  
  if code
    token = Token.new({
      :client_id => client_id,
      :client_secret => client_secret,
      :code => code
    })
    
    user = User.new token
    user.follow params[:user]

    erb :follow
  else
    query = "scope=user&client_id=#{client_id}&redirect_uri=#{request.url}"
    redirect "https://github.com/login/oauth/authorize?#{query}"
  end
end
