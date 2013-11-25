class Player
  attr_accessor :id, :color, :bots, :source

  def initialize
    @id = 1
    @color = "#FF0000"
    @bots = []
    @source = nil
  end
end