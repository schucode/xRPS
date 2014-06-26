

class Game
  attr_accessor :player1, :player2, :round, :rules


  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @round = 0
    @rules = {:rock => :scissors,             # key beats value
              :scissors => :paper,
              :paper => :rock}
    @winner = :tbd
  end 

  def play()

  end

end # class end


# win best of three rounds