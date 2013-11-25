require "minitest/autorun"

# class TestRun < Minitest::Test
class TestRun < MiniTest::Unit::TestCase
  def setup
  	load '../run.rb'
    @the_run = Run.new
  end

  def test_existence
    assert_equal Run, @the_run.class
  end

  # def test_that_it_will_not_blend
  #   refute_match /^no/i, @meme.will_it_blend?
  # end

  # def test_that_will_be_skipped
  #   skip "test this later"
  # end
end