describe Bot do
  before(:each) do
  	@generic_player_id = 1
  	@generic_location = [10, 10]
  	@generic_bot_id = 0
  	@config = Configuration.new
    @bot = Bot.new @config, @generic_player_id, @generic_location, @generic_bot_id
  end
  it "can is created with properties" do
    @bot.location.should eq @generic_location
    @bot.hp.should eq @config.max_hp
    @bot.player_id.should eq @generic_player_id
    @bot.bot_id.should eq @generic_bot_id
  end
  after(:each) do
    @bot = nil
  end
end