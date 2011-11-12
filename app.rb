require 'sinatra'

$:.unshift File.join(settings.root, 'lib')

require 'github'

ID_KEY = 'GITHUB_CLIENT_ID'
SECRET_KEY = 'GITHUB_CLIENT_SECRET'
client_id = ENV[ID_KEY]
client_secret = ENV[SECRET_KEY]

raise "Expected environment variables #{ID_KEY} and #{SECRET_KEY}" if !client_id or !client_secret

set :protection, :except => :frame_options

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
