class Bot
  attr_accessor :player_id, :location, :bot_id, :hp
  def initialize player_id, location, bot_id, hp
    @player_id = player_id
    @location = location
    @bot_id = bot_id
    @hp = hp
  end
end