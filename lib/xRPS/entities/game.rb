

class Game

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @round = 0
    @hand_beats_hand = {:rock => :scissors, 
                        :}
  end 

  def turn(hand1, hand2)
    return hand1
  end

end # class end


# win best of three rounds