require 'sinatra'
require_relative './lib/xRPS.rb'


set :bind, '0.0.0.0'


get '/' do
  erb :start
end

get '/signup' do
  erb :sign
end

post '/signup' do
  # params = {:username =>, :password => }
  @result = RPS.script.sign_up(params)
  erb :test
end



get '/signin' do
  erb :sign
end

post '/signin' do
  erb :welcome
end