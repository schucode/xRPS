require "spec_helper"

describe 'Game' do
      
  before do
    @player1 = Player.new()
    @player2 = Player.new()
    @game = Game.new(@player1, @player2)
  end

  it "exists" do
    expect(@game).to be_a(Game)
  end

  it "produces a winner" do
  end

end