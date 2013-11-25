class Game
  attr_accessor :player1, :player2, :board
  def initialize
    @player1 = Player.new
    @player2 = Player.new
    @board = Board.new
  end
end