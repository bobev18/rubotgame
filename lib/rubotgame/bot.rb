class Bot
  attr_accessor :player_id, :location, :bot_id, :hp, :pending_command,
    :on_guard
  
  def initialize player_id, location, bot_id, hp
    @player_id = player_id
    @location = location
    @bot_id = bot_id
    @hp = hp
    @pending_command = nil
    @on_guard = false
  end

  # this should move under Board; also rename to match the guide:
  #   rg.locs_around(self.location, filter_out=('invalid', 'obstacle'))
  def neighbour_locations
    [[location[0]-1,location[1]],[location[0],location[1]-1],
      [location[0]+1,location[1]],[location[0],location[1]+1]]
  end

  def validate command
    simple_command  = ['guard', 'suicide'].include? command[0]
    complex_command = ['move', 'attack'].include? command[0]
    proper_command_name = (simple_command or complex_command)
    proper_command_size = ((simple_command and command.size == 1 ) or
                          (complex_command and command.size == 2 ))
    proper_command = (proper_command_name and proper_command_size )

    if command.size == 1
      proper_command
    elsif command.size == 2 and command[1].kind_of? Array
      proper_target_type = command[1].map { |coord| coord.kind_of? Integer }.all?
      proper_target_size = (command[1].size == 2)
      proper_target = (proper_target_type and proper_target_size)
      proper_command and proper_target
    else
      false
    end
  end

  def prepare_to command
    @pending_command = validate(command) ? command : ['guard']
  end

  def execute(board = nil)
    case @pending_command[0]
    when 'move'
      @location = board.move(@location, @pending_command[1])
    else
      @on_guard = true
    end
  end
end