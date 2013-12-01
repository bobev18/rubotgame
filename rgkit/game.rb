require './player'
require './board'
require './bot'

class Game
  attr_accessor :player1, :player2, :board, :max_turns
  def initialize config
    @config = config
    @player1 = Player.new 1, "#FF0000"
    @player2 = Player.new 2, "#0000FF"
    @board = Board.new config
    @max_turns = 100
  end
  
  def process_turn
  end
  
  def get_game_dict
    game = {robots: {}}
  end
  
  def spawn_one coodrs, player
    Bot.new @config, player.id, coodrs, player.bots.size
  end

  def spawn
    players = [@player1, @player2]
    pool = @board.spawn_coord.sample(5*players.size)
    pool.each_slice(5).zip(players) do |data|
      data[0].each { |coords| data[1].bots << spawn_one(coords, data[1]) }
    end
  end
end