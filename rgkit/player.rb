class Player
  attr_accessor :id, :color, :bots, :source

  def initialize id, color
    @id = id
    @color = color
    @bots = []
    @source = nil
  end
end