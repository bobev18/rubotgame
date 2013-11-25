require "minitest/autorun"

# class TestRun < Minitest::Test
class TestRun < MiniTest::Unit::TestCase
  def setup
    load '../bot.rb'
    @bot = Bot.new
  end

  def test_existence
    assert_instance_of Bot, @bot
  end

  def test_attributes
    # assert_equal (8,8), @bot.location
  end

  # def test_that_will_be_skipped
  #   skip "test this later"
  # end
end