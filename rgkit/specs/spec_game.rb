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
    @game.turn.should eq 0
  end
  it "can provide 'game' hash" do
    @game.game_hash.should be_an_instance_of Hash
  end
  it "can provide 'game' hash for specific player" do
    @game.game_hash(@game.player2).should be_an_instance_of Hash
  end
  it "can process turns" do
    @game.public_methods.should include(:process_turn)
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
    @config = nil
  end
end

describe Game do
  before(:each) do
    @config = Configuration.new
    @game = Game.new @config
    @game_hash = @game.game_hash
  end
  it "game hash has key :robots" do
    @game_hash.should include(:robots)
    @game_hash.should include(:turn)
    @game_hash[:turn].should eq @game.turn
  end
  it "game hash includes bots of all players" do
    @game_hash[:robots].size.should eq @game.player1.bots.size + @game.player1.bots.size
  end
  it "game hash reflects spawn events" do
    old_game_hash = Hash.new(@game_hash)
    @game.spawn
    @game_hash = @game.game_hash
    @game_hash.should_not eq old_game_hash
    @game_hash[:robots].size.should eq @game.player1.bots.size + @game.player1.bots.size
  end
  after(:each) do
    @game = nil
    @config = nil
    @game_hash = nil
  end
end

describe Game do
  before(:each) do
    @config = Configuration.new
    @game = Game.new @config
    @game.spawn
    @game_hash = @game.game_hash
  end
  it "game hash has entries unique by player and robot ids" do
    ids = @game_hash[:robots].values.map { |bot| [bot[:player_id], bot[:robot_id]] }
    ids.should eq ids.uniq
  end
  it "game hash has bot location matching configuration spawn locations after initial spawn" do
    sample_bot = @game_hash[:robots].values.sample
    @config.spawns.should include(sample_bot[:location])
  end
  it "game hash has bot hit points matching configuration max_hp after initial spawn" do
    sample_bot = @game_hash[:robots].values.sample
    sample_bot[:hp].should eq @config.max_hp
  end
  after(:each) do
    @game = nil
    @config = nil
    @game_hash = nil
  end
end

describe Game do
  before(:each) do
    @config = Configuration.new
    @game = Game.new @config
    @game.spawn
    @old_player1_bot_ids = Set.new(@game.player1.bots.map(&:bot_id))
    @game.player1.bots = []
    center = [[9,9], [9, 10], [9,8], [8,9], [10,9]]
    @game.player2.bots.zip(center).map { |bot_loc| bot_loc[0].location = bot_loc[1] }
    @game.spawn
    @game_hash = @game.game_hash @game.player1
  end
  it "game hash has robot_id only if it belongs to the player" do
    # @game_hash[:robots].values.sort_by { |b| b[:player_id] }.each_with_index { |b, i| puts "#{i} #{b}" }
    player1_hash_bots = @game_hash[:robots].values.select { |bot| bot.keys.include? :robot_id }
    player1_hash_bots.map { |bot| bot[:robot_id] }.should =~ @game.player1.bots.map(&:bot_id)
  end
  # it "doesn't reuse robot_id values" do
  #   (@old_player1_bot_ids & @game.player1.bots.map(&:bot_id)).should eq Set.new
  # end
  after(:each) do
    @config = nil
    @game = nil
    @game_hash = nil
    @old_player1_bot_ids = nil
  end
end