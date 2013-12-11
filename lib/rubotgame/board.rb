class Board
  attr_accessor :side, :spawn_coord, :obstacle_coords

  def initialize config
    @side = config.board_size
    @spawn_coord = config.spawns
    @obstacle_coords = config.obstacles
  end

  def on_board?(location)
  	location.map { |coord| (0..@side) === coord }.all?
  	location.map { |coord| coord.between? 0, @side }.all?
  end

  def move(start_location, end_location)
  	# on_board? end_location and @obstacle_coords.exclude? end_location
  	if on_board? end_location and not @obstacle_coords.include? end_location
			end_location
		else
			start_location
		end
  end
end