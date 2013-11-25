require "minitest/autorun"

# class TestRun < Minitest::Test
class TestRun < MiniTest::Unit::TestCase
  def setup
    load '../game.rb'
    load '../player.rb'
    load '../board.rb'
    @game = Game.new
  end

  def test_existence
    assert_instance_of Game, @game
  end

  def test_attributes
    assert_instance_of Player, @game.player1
    assert_instance_of Player, @game.player2
    assert_instance_of Board,  @game.board
  end

  # def test_that_will_be_skipped
  #   skip "test this later"
  # end
end