
require 'pry-byebug'



module RPS
  class Script 

            # USER LOG IN

    #input params {:usernmae =>, :password=> }
    def sign_up(input)
      username = input[:username]
      password = input[:password]
      result =  RPS.orm.username_exist?(input)
      if !result
        new_user = RPS::User.new(username)
        new_user.update_password(password)
        RPS.orm.add_user(username, new_user.password_digest)
        {:success? => true}
      else
        {:success? => false, :error => "username already taken"}
      end
    end

    def sign_in(input)

    end


            # USER PLAY ACTIONS

    # input params {:user_id =>, }
    def run_start_match(input)
      user_id = input[:user_id]
      match = RPS::Match.new(user)
      match.player1 = input[:user_id]
      match
    end

    # input params {:user_id =>, :match_id =>}
    def run_join_match(input)
      user_id = input[:user_id]
      match_id = input[:match_id]
      match.player2 = input[:user_id]
       # database
    end

    # input params {:match_id =>, :user1_id =>, :user2_id => }
    def run_start_game(input)
      game = RPS::Game.new(input[:user1], input[:user2])
      match = input[:match]
      match.history << input[:match]
    end

    # input params {:match =>, :game=>, :user1 =>, :user2 => }
    def run_play_game(input)
      match = input[:match]
      game = input[:game]

    end



  end # class end

  def self.script
    @__db_instance ||= Script.new
  end

end # module end