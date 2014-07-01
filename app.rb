require 'sinatra'
require 'pry-byebug'
require_relative './lib/xRPS.rb'


set :bind, '0.0.0.0'

enable :sessions

get '/' do
  if session[:username]
    @username = session[:username]
    redirect to '/userhome'
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
  # binding.pry
  result = RPS.script.sign_in(params)
  if result[:success?]
    user = result[:user]
    @username = user.username
    @user_id = user.id
    session[:username] = user.username
    redirect '/userhome'
  else
    @error = result[:error]
    erb :signin_error
  end
end

post '/userhome' do
  @username = params[:username]
  erb :user_home
end

get '/userhome' do
  @username = session[:username] 
  erb :user_home
end




get '/newmatch' do
  @username = session[:username]
  RPS.script.start_match(@username)
  erb :new_match
end

get '/joinmatch' do #=> iplay
  #{username=>, match_id=> }
  @result = RPS.script.show_open_matches
  erb :join_match
end

# get '/currentmatch' do #=> iplay
#   #{username=> }
#   @result = RPS.script.show_current_matches(params)
#   @username = params[:username]
#   erb :current_match
# end

post '/iplay' do
  # {username=>, match_id=> }
  @username = session[:username]
  result = RPS.script.join_match(params, @username)
  @player1 = result[0]['player1']
  @player2 = result[0]['player2']
  RPS.script.play_turn(@username)

  erb :game_play
end





