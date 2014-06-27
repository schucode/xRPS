require 'spec_helper'



describe 'Script' do

    it "creates a new match and sets the user to player 1" do
      input = {:username => "some_username"}
      match = RPS.script.run_start_match(input)
      expect(match.player1).to eq('some_username')
    end

    it "allows a user to join a game" do 
      match = RPS::Match.new()
      input = {:username => "some_username", :match => match}
      RPS.script.run_join_match(input)
      expect(match.player2).to eq("some_username")
    end

end # Script end

