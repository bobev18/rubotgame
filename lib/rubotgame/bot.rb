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

  def neighbour_locations
    [[location[0]-1,location[1]],[location[0],location[1]-1],
      [location[0]+1,location[1]],[location[0],location[1]+1]]
  end

  def validate command
    case command.size
      when 1 
        ['guard', 'suicide'].include? command[0]
      when 2
        ['move', 'attack'].include? command[0] and 
          neighbour_locations.include? command[1]
        # proper_command_name = ['move', 'attack'].include? command[0]
        # proper_target_location = neibhour_locations.include? command[1]
        # return proper_command_name and proper_target_location
      else
        false
    end
  end

  def prepare_to command
    @pending_command = validate(command) ? command : ['guard']
  end

  def execute
    case @pending_command[0]
    when 'move'
      @location = @pending_command[1]
    else
      @on_guarg = true
    end
  end
end