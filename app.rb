require 'sinatra'
require 'httparty'

class Token
  include HTTParty
  
  base_uri "https://github.com"
  
  def initialize(code)
    @access_token = self.class.post("/login/oauth/access_token", {
      :client_id => "148718244dbf91ab58bc",
      :client_secret => "e065813ece4e5738c0a37aa7b11e5da7db4d27bf",
      :code => code
    })
  end
  
  def to_s
    @access_token
  end
end

get '/' do
  erb :index
end

get '/follow/:user' do
  user = params[:user]
  code = params[:code]
  token = Token.new code
  logger.info "USER: #{user}, CODE: #{code}, ACCESS TOKEN: #{token.to_s}"
end