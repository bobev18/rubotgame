class Run
  attr_accessor :config
  def initialize config='default'
    @config = Configuration.new config
  end
end