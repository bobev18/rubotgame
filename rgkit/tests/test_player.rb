require "minitest/autorun"

# class TestRun < Minitest::Test
class TestRun < MiniTest::Unit::TestCase
  def setup
    load '../player.rb'
    @player = Player.new
  end

  def test_existence
    assert_instance_of Player, @player
  end

  def test_attributes
    assert_equal 1, @player.id
    assert_equal "#FF0000", @player.color
    assert_equal [], @player.bots
    assert_equal nil, @player.source
  end

  # def test_that_will_be_skipped
  #   skip "test this later"
  # end
end