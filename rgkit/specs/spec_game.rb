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
    @game.rounds.should eq 100
  end
  after(:each) do
    @game = nil
  end
end