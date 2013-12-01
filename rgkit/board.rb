class Board
  attr_accessor :side, :spawn_coord, :obstacle_coord
  def initialize config
    @side = config.board_size
    @spawn_coord = config.spawns
    @obstacle_coord = config.obstacles
  end
end