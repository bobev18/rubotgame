class Bot
  attr_accessor :player_id, :location, :bot_id, :hp
  def initialize config, player_id, location, bot_id
    @player_id = player_id
    @location = location
    @bot_id = bot_id
    @hp = config.max_hp
  end
end