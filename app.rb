require 'bundler/setup'
require 'sinatra'
require 'gittycat'

ID_KEY = 'GITHUB_CLIENT_ID'
SECRET_KEY = 'GITHUB_CLIENT_SECRET'
client_id = ENV[ID_KEY]
client_secret = ENV[SECRET_KEY]

raise "Expected environment variables #{ID_KEY} and #{SECRET_KEY}" if !client_id or !client_secret

set :protection, :except => :frame_options

configure :production do
  set :public_folder, File.dirname(__FILE__) + "/dist"
end

get '/' do
  @title = "GitHub widgets for your website"
  erb :index
end

get '/follow/:user' do
  code = params[:code]
  
  if code
    connection = GittyCat::Connection.new({
      :client_id => client_id,
      :client_secret => client_secret,
      :code => code
    })
    
    connection.user.follow params[:user]

    redirect "https://github.com/#{params[:user]}"
  else
    query = "scope=user&client_id=#{client_id}&redirect_uri=#{request.url}"
    redirect "https://github.com/login/oauth/authorize?#{query}"
  end
end
