require 'test_helper'

class OrderingTest < MiniTest::Test
  include Flocks::Ordering
  include Flocks::Configuration

  def test_score_string_extension
    # ASCII 'd' == 100, summed up in the scorer == 10101010100
    assert_equal 10101010100, rank_username('ddddd')
  end

end
