require 'sinatra'
require 'httparty'

module Form
  def parse_form(form_data)
    hash = {}
    form_data.split("&").each do |pair|
      key,value = pair.split("=")
      hash[key] = value
    end
    hash
  end
end

class Token
  include HTTParty
  include Form
  
  base_uri "https://github.com"
  
  def initialize(params)
    response = self.class.post "/login/oauth/access_token", :query => params
    @access_token = parse_form(response)["access_token"]
  end
  
  def to_s
    @access_token
  end
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
  token = Token.new({
    :client_id => "148718244dbf91ab58bc",
    :client_secret => "e065813ece4e5738c0a37aa7b11e5da7db4d27bf",
    :code => code
  })
  
  user = User.new token
  user.follow params[:user]
end
