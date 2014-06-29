require 'sinatra'
require_relative './lib/xRPS.rb'


set :bind, '0.0.0.0'

enable :sessions

get '/' do
  session[:stuff] ||= "morestuff"
  erb :start
end

get '/signup' do
  erb :signup
end

get '/signin' do
  erb :signin
end

post '/signup' do
  # params = {:username =>, :password => }
  @result = RPS.script.sign_up(params)
  erb :test
end

post '/signin' do
  # params = {:username =>, :password => }
  @result = RPS.script.sign_in(params)
  erb :test
end

# session[:user_id] = result.user.id
#     redirect back