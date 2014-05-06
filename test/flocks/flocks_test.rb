require 'test_helper'

class FlocksTest < MiniTest::Test

  def test_initialization
    flock = Flocks.new(1, 1)
    assert_equal 1, flock.user_id
    assert_equal 4948484848, flock.username_score
  end
end
