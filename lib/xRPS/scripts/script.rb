module RPS
  class Script 

            # USER ACTIONS

    # input params {:username =>, }
    def run_start_match(input)
      username = input[:username]
      match = RPS::Match.new(username)
      match.player1 = input[:username]
      match
    end

    # input params {:username =>, :match =>}
    def run_join_match(input)
      username = input[:username]
      match = input[:match]
      match.player2 = input[:username]
    end

    # input params {:match => , :user1 =>, :user2 => }
    def run_start_game(input)
      game = RPS::Game.new(input[:user1], input[:user2])
      match = input[:match]
      match.history << input[:match]
    end

    # input params {:match => , :game=>, :user1 =>, :user2 => }
    def run_play_game(input)
      match = input[:match]
      game = input[:game]
    end

  end # class end
end # module end