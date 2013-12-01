require 'yaml'
CONFIG = YAML.load_file('config.yml')

class Run
  attr_accessor :config
  def initialize config = 'default'
    @config = CONFIG[config]
  end
end