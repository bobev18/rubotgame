require 'yaml'

CONFIG = YAML.load_file(File.join(File.dirname(__FILE__), 'config.yml'))

# [TODO] match the attribute names
# rg.settings.spawn_every - how many turns pass between robots being spawned
# rg.settings.spawn_per_player - how many robots are spawned per player
# rg.settings.robot_hp - default robot HP
# rg.settings.attack_range - a tuple (minimum, maximum) holding range of damage dealt by attacks
# rg.settings.collision_damage - damage dealt by collisions
# rg.settings.suicide_damage - damage dealt by suicides
# rg.settings.max_turns - number of turns per game

class Configuration
  attr_accessor :max_hp, :max_turns, :spawns, :obstacles, :spawn_cycle_turns,
    :bump_damage, :attack_damage_min, :attack_damage_max, :suicide_damage_min,
    :suicide_damage_max, :behaviour_on_error, :spawns_per_player, :board_size
    
  def initialize config='default'
    CONFIG[config].each { |k, v| public_send("#{k}=", v) }
  end
end