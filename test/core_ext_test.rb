require 'test_helper'

class CoreExtTest < MiniTest::Test

  def test_score_string_extension
    # ASCII 'd' == 100, summed up in the scorer == 10101010100
    assert_equal 10101010100, 'ddddd'.score
  end

end
