describe Game do
  before(:each) do
    @config = Configuration.new
    @game = Game.new @config
  end
  it "can be created" do
    @game.should be_an_instance_of Game
  end
  it "has the attributes" do
    @game.player1.should be_an_instance_of Player
    @game.player2.should be_an_instance_of Player
    @game.players.should be_an_instance_of Array
    @game.players.should =~ [@game.player1, @game.player2]
    @game.board.should be_an_instance_of Board
    @game.max_turns.should eq @config.max_turns
  end
  it "can process turns" do
    @game.public_methods.should include(:process_turn)
  end
  it "can generate 'game' dict" do
    game_dict = @game.get_game_dict
    game_dict.should be_an_instance_of Hash
    game_dict.should include(:robots)
    game_dict[:robots].size.should eq @game.player1.bots.size + @game.player1.bots.size
    @game.spawn
    game_dict = @game.get_game_dict
    game_dict[:robots].size.should eq @game.player1.bots.size + @game.player1.bots.size
  end
  it "can spawn robots" do
    old_p1_bots = Array.new @game.player1.bots
    old_p2_bots = Array.new @game.player2.bots
    @game.spawn
    @game.player1.bots.size.should eq old_p1_bots.size + @config.spawns_per_player
    @game.player2.bots.size.should eq old_p2_bots.size + @config.spawns_per_player
    @game.player1.bots.each { |bot| @config.spawns.should include(bot.location) }
    @game.player2.bots.each { |bot| @config.spawns.should include(bot.location) }
    player2_bot_locations = @game.player2.bots.map(&:location)
    @game.player1.bots.each { |bot| player2_bot_locations.should_not include(bot.location) }
  end
  after(:each) do
    @game = nil
  end
end