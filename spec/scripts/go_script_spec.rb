require 'spec_helper'

describe 'go_Script' do
  
  describe 'run_start_match' do

    it "creates a new match and sets the user to player 1" do
      input = {:username => "some_username"}
      match = RPS::Script.run_start_match(input[:username])
      expect(match.player1).to eq('some_username')
    end
  end

end

