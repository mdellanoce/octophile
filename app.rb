require 'bundler/setup'
require 'sinatra'
require 'omniauth-github'
require 'octokit'

enable :sessions
use OmniAuth::Builder do
  provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET']
end

set :protection, :except => :frame_options

configure :production do
  set :public_folder, File.dirname(__FILE__) + "/dist"
end

get '/' do
  @title = "GitHub widgets for your website"
  erb :index
end

get '/auth/github/callback' do
  session[:token] = params['omniauth.auth']
  puts params
  redirect params['omniauth.origin']
end

get '/follow/:user' do
  code = session[:token]
  
  if code
    client = Octokit::Client.new(:login => "me", :oauth_token => code)
    client.follow! params[:user]
    
    redirect "https://github.com/#{params[:user]}"
  else
    redirect "/auth/github?origin=" + request.path
  end
end
