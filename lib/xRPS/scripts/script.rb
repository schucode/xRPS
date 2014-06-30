
require 'pry-byebug'



module RPS
  class Script 

            # USER LOG IN

    #input params {:usernmae =>, :password=> }
    def sign_up(input)
      username = input[:username]
      password = input[:password]
      result =  RPS.orm.username_exist?(username)
      if !result
        new_user = RPS::User.new(username) 
        new_user.update_password(password)
        RPS.orm.add_user(username, new_user.password_digest)
        {:success? => true}
      else
        {:success? => false, :error => "username already taken"}
      end
    end

    #input params {:usernmae =>, :password=> }
    def sign_in(input)
      username = input[:username]
      password = input[:password]
      result = RPS.orm.username_exist?(username)
      if !result
        {:success? => false, :error => "either the username or password is wrong"}
      end

      actual_pass = RPS.orm.get_pass(username)
      user_pass = Digest::SHA1.hexdigest(password)

      if actual_pass == user_pass
        new_user = RPS::User.new(username)
        new_user.id = RPS.orm.get_userid(username)

        {:success? => true, :user => new_user}
      else
        {:success? => false, :error => "either the username or password is wrong"}
      end
    end


            # USER PLAY ACTIONS

    # input params {:user_id =>, }
    def start_match(input)
      username = input[:username]
      RPS::orm.add_match(username)
      match = RPS::Match.new()
      match.player1 = username
      match.open = true
    end

    def show_open_matches
      result = RPS.orm.get_open_matches
      result
    end

    # input params {:user_id =>, :match_id =>}
    def join_match(input)
      username = input[:username]
      match_id = input[:match_id]
      RPS.orm.set_player2(username, match_id)
    end

    def get_player1(match_id)
      result = RPS.orm.match_player1(match_id)
      result[0]["player1"]
    end

    def show_current_matches(input)
      username = input[:username]
      result = RPS.orm.get_current_matches(username)
      result
    end

    





    # input params {:match_id =>, :user1_id =>, :user2_id => }
    # def run_start_game(input)
    #   game = RPS::Game.new(input[:user1], input[:user2])
    #   match = input[:match]
    #   match.history << input[:match]
    # end

    # # input params {:match =>, :game=>, :user1 =>, :user2 => }
    # def run_play_game(input)
    #   match = input[:match]
    #   game = input[:game]
    # end



  end # class end

  def self.script
    @__db_instance ||= Script.new
  end

end # module end