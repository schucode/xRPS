require 'sinatra'
require 'pry-byebug'
require_relative './lib/xRPS.rb'


set :bind, '0.0.0.0'

enable :sessions

get '/' do
  # binding.pry
  if session[:username]
    @username = session[:username]
    erb :user_home
  else
    erb :start
  end
end

post '/logout' do
  session.clear
  redirect to '/'
end

get '/signup' do
  erb :signup
end

get '/signin' do
  erb :signin
end

post '/signup' do
  # params = {:username =>, :password => }
  result = RPS.script.sign_up(params)
  if result[:success?]
    @username = params[:username]
    erb :signup_success
  else
    @error = result[:error]
    erb :signup_error
  end
end

post '/signin' do
  # params = {:username =>, :password => }
  result = RPS.script.sign_in(params)
  if result[:success?]
    user = result[:user]
    @username = user.username
    @user_id = user.id
    session[:username] = user.username
    erb :user_home
    # binding.pry 
  else
    @error = result[:error]
    erb :signin_error
  end
end




post '/newmatch' do
  # params = {:username =>, }
  RPS.script.start_match(params)
  @message = params
  erb :create_match
end

post '/joinmatch' do
  @result = RPS.script.show_open_matches
  @username = params[:username]
  erb :join_match
end

post '/currentmatch' do
  @result = RPS.script.show_current_matches(params)
  @username = params[:username]
  erb :current_match
end


post '/play_joined_match' do
  RPS.script.join_match(params)
  @player1 = RPS.script.get_player1(params[:match_id])
  @player2 = params[:username]
 
end
