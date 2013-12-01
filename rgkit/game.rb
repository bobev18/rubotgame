require './player'
require './board'
require './bot'

class Game
  attr_accessor :player1, :player2, :board, :max_turns
  def initialize
    @player1 = Player.new
    @player2 = Player.new
    @board = Board.new
    @max_turns = 100
  end
  
  def process_turn
  end
  
  def get_game_dict
    game = {robots: {}}
  end
  
  def spawn_one coodrs, player
    Bot.new player.id, coodrs, player.bots.size
  end

  def spawn
    players = [@player1, @player2]
    pool = @board.spawn_coord.sample(5*players.size)
    pool.each_slice(5).zip(players) { |data| puts data.inspect; data[1].bots << spawn_one(*data); puts "bots: #{data[1].bots.inspect}" }
  end
end