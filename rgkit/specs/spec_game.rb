describe Game do
  before(:each) do
    @game = Game.new
  end
  it "can be created with no arguments" do
    @game.should be_an_instance_of Game
  end
  it "has the attributes" do
    @game.player1.should be_an_instance_of Player
    @game.player2.should be_an_instance_of Player
    @game.board.should be_an_instance_of Board
    @game.max_turns.should eq 100
  end
  it "can process turns" do
    @game.public_methods.should include(:process_turn)
  end
  it "can generate 'game' dict" do
    game_dict = @game.get_game_dict
    game_dict.should be_an_instance_of Hash
    game_dict.should include(:robots)
    game_dict[:robots].size.should eq @game.player1.bots.size + @game.player1.bots.size
  end
  it "can spawn robots" do
    old_p1_bots = @game.player1.bots
    old_p2_bots = @game.player2.bots
    @game.spawn
    @game.player1.bots.size.should eq old_p1_bots.size + 5
  end
  after(:each) do
    @game = nil
  end
end