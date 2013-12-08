describe Board do
  before(:each) do
    @config = Configuration.new
    @board = Board.new @config
  end
  it "can be created with no arguments" do
    @board.should be_an_instance_of Board
  end
  it "has the attributes" do
    @board.side.should eq @config.board_size
    @board.spawn_coord.should eq @config.spawns
    @board.obstacle_coord.should eq @config.obstacles
  end
  after(:each) do
    @board = nil
  end
end