require './player'
require './board'
class Game
  attr_accessor :player1, :player2, :board, :rounds
  def initialize
    @player1 = Player.new
    @player2 = Player.new
    @board = Board.new
    @rounds = 100
  end
end