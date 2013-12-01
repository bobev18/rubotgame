class Player
  attr_accessor :id, :color, :bots, :source

  def initialize config, id, color
    @config = config
    @id = id
    @color = color
    @bots = []
    @source = nil
    max_bots = @config.spawns_per_player*@config.max_turns/@config.spawn_cycle_turns
    @id_pool = Range.new(0,max_bots).step
  end

  def spawn coodrs
    @bots << Bot.new(@id, coodrs, @id_pool.next, @config.max_hp)
  end

end