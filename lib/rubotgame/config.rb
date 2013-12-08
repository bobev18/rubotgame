require 'yaml'
CONFIG = YAML.load_file('config.yml')

class Configuration
  attr_accessor :max_hp, :max_turns, :spawns, :obstacles, :spawn_cycle_turns,
    :bump_damage, :attack_damage_min, :attack_damage_max, :suicide_damage_min,
    :suicide_damage_max, :behaviour_on_error, :spawns_per_player, :board_size
    
  def initialize config='default'
    CONFIG[config].each { |k, v| public_send((k+'=').to_sym, v) }
  end
end