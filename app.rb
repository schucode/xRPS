require 'sinatra'


set :bind, '0.0.0.0'


get '/sign_in' do
  erb :sign_in
end




