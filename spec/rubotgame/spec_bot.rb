describe Bot do
  before(:each) do
    @generic_player_id = 1
    @generic_location = [10, 10]
    @generic_bot_id = 0
    @generic_hp = 100
    @bot = Bot.new @generic_player_id, @generic_location, @generic_bot_id, @generic_hp
  end
  it "can is created with properties" do
    @bot.location.should eq @generic_location
    @bot.hp.should eq @generic_hp
    @bot.player_id.should eq @generic_player_id
    @bot.bot_id.should eq @generic_bot_id
    @bot.pending_command.should eq nil
    @bot.on_guard.should eq false
  end
  after(:each) do
    @bot = nil
  end
  it "provides neighbouring locations" do
    @bot.neighbour_locations.should =~ [[9,10],[10,9],[11,10],[10,11]]
  end
  it "validates commands: no improper names" do
    @bot.validate(['bar']).should eq false
    @bot.validate(['baz']).should eq false
    @bot.validate(['larodi', [0, 0]]).should eq false
  end
  it "validates commands: 'guard' and 'suicide' are size 1" do
    @bot.validate(['guard']).should eq true
    @bot.validate(['guard', [0, 0]]).should eq false
    @bot.validate(['guard', 'guard']).should eq false
    @bot.validate(['suicide']).should eq true
    @bot.validate(['suicide', [0, 0]]).should eq false
    @bot.validate(['suicide', 'guard', 'move']).should eq false
  end
  it "validates commands: 'move' and 'attack' are size 2" do
    @bot.validate(['move', [0, 0]]).should eq true
    @bot.validate(['attack', [0, 0]]).should eq true
    @bot.validate(['move']).should eq false
    @bot.validate(['attack']).should eq false
    @bot.validate(['move', [0, 0], 'guard']).should eq false
    @bot.validate(['attack', [0, 0], 'guard']).should eq false
  end
  it "validates commands: 'move' and 'attack', 2nd item is location" do
    @bot.validate(['move', [0, 0, 0]]).should eq false
    @bot.validate(['attack', [0]]).should eq false
    @bot.validate(['move', [:a, 0]]).should eq false
    @bot.validate(['attack', ['0', 0]]).should eq false
    @bot.validate(['move', [0.1, 0]]).should eq false
    @bot.validate(['attack', [Rational(2, 3), 0]]).should eq false
  end
  it "takes command, and if valid, stores it as pending_command" do
    @bot.pending_command.should eq nil
    @bot.prepare_to(['move', [9,10]])
    @bot.pending_command.should eq ['move', [9,10]]
  end
  it "takes command, and if invalid stores 'guard' it pending_command" do
    @bot.prepare_to(['move', [0,10, 100]])
    @bot.pending_command.should eq ['guard']
  end
end

describe Bot do
  before(:each) do
    @generic_player_id = 1
    @generic_location = [10, 10]
    @generic_bot_id = 0
    @generic_hp = 100
    @bot = Bot.new @generic_player_id, @generic_location, @generic_bot_id, @generic_hp
    @some_board = Board.new Configuration.new
  end
  it "executes a pending 'move' command which changes it's state" do
    @bot.prepare_to(['move', [9,10]])
    @bot.execute @some_board
    @bot.location.should eq [9,10]
  end
  it "executes a pending 'move' command onto obstacle, which does NOT results in 'guard'" do
    bot_on_the_edge = Bot.new 1, [7,1], 1, 100
    bot_on_the_edge.prepare_to(['move', [6,1]])
    bot_on_the_edge.execute @some_board
    bot_on_the_edge.location.should eq [7,1]
    # move is valid, although it fails, thus no guard
    bot_on_the_edge.on_guard.should eq false
  end
  # it "executes a pending 'move' command on top of an opponent, which moves away, resulting in successful move" do
  # it "executes a pending 'move' command on top of an opponent, which stays, resulting in bump" do
  # it "executes a pending 'move' command which results in bump with opponent, moving onto the same location" do
  # it "executes a pending 'attack' command which damages opponent" do
  # it "executes a pending 'suicide' command which damages opponent" do
  # it "executes a pending 'guard' command which reduces damage by opponent" do
  # it "executes invalid command, resulting in 'guard' command which reduces damage by opponent" do
end