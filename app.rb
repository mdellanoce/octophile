require 'sinatra'
require 'httparty'

class Token
  include HTTParty
  
  base_uri "https://github.com"
  
  def initialize(code)
    params = {
      :client_id => "148718244dbf91ab58bc",
      :client_secret => "e065813ece4e5738c0a37aa7b11e5da7db4d27bf",
      :code => code
    }
    query = "?client_id=" + params[:client_id] + "&client_secret=" + params[:client_secret] + "&code=" + params[:code]
    @access_token = self.class.post("/login/oauth/access_token" + query)

    #access_token=X&type_bearer=Y
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
end
