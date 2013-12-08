describe Bot do
  before(:each) do
  	@generic_player_id = 1
  	@generic_location = [10, 10]
  	@generic_bot_id = 0
  	# @config = Configuration.new
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
  it "validates commands" do
    [['move', [9, 10]], ['attack', [9, 10]], ['guard'], ['suicide']
      ].map { |command| @bot.validate(command) }.all?.should eq true
    [['move', [0, 10]], ['attack', [9, 9]], ['bar'], ['baz']
      ].map { |command| @bot.validate(command) }.none?.should eq true
  end
  it "takes command, and if valid stores it pending_command" do
    @bot.pending_command.should eq nil
    @bot.prepare_to(['move', [9,10]])
    @bot.pending_command.should eq ['move', [9,10]]
  end
  it "takes command, and if invalid stores 'guard' it pending_command" do
    @bot.prepare_to(['move', [0,10]])
    @bot.pending_command.should eq ['guard']
  end
  it "executes a pending 'move' command which changes it's state" do
    @bot.prepare_to(['move', [9,10]])
    @bot.execute
    @bot.location.should eq [9,10]
  end
end