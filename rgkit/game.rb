require './player'
require './board'
require './bot'

class Game
  attr_accessor :player1, :player2, :board, :max_turns, :players
  def initialize config
    @config = config
    @player1 = Player.new 1, "#FF0000"
    @player2 = Player.new 2, "#0000FF"
    @board = Board.new config
    @max_turns = 100
    @players = [@player1, @player2]
  end
  
  def process_turn
  end
  
  def game_hash for_player = nil
    game = {}
    @players.each do |player|
      player.bots.each do |bot|
        game[bot.location] = {
          location: bot.location,
          hp: bot.hp,
          player_id: player.id
        }
        game[bot.location][:robot_id] = bot.bot_id unless for_player and
          bot.player_id != for_player.id
      end
    end
    {robots: game}
  end
  
  def spawn_one coodrs, player
    Bot.new @config, player.id, coodrs, player.bots.size
  end

  def spawn
    pool = @board.spawn_coord.sample(5*players.size)
    pool.each_slice(5).zip(players) do |data|
      data[0].each { |coords| data[1].bots << spawn_one(coords, data[1]) }
    end
  end
end