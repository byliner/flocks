require 'test_helper'

class SearchTest < MiniTest::Test

  def test_search_following
    flock = Flocks.new(1, 'username')
    flock.follow(2, 'other_username')
    flock.follow(3, 'other_username2')
    flock.follow(4, 'dissimilar_username')
    results = flock.search_following('other')

    assert_equal ['2', '3'], results
  end

  def test_search_followers
    Flocks.new(2, 'other_username').follow(1, 'username')
    Flocks.new(3, 'other_username2').follow(1, 'username')
    Flocks.new(4, 'disssimilar_username').follow(1, 'username')

    flock = Flocks.new(1, 'username')
    results = flock.search_followers('other')
    assert_equal ['2', '3'], results
  end

  def test_search_graph
    Flocks.new(1, 'username').follow(2, 'other_username')
    Flocks.new(2, 'other_username').follow(1, 'username')
    Flocks.new(1, 'username').follow(3, 'other_username3')
    Flocks.new(4, 'other_username4').follow(1, 'username')
    Flocks.new(5, 'disssimilar_username').follow(1, 'username')

    flock = Flocks.new(1, 'username')
    results = flock.search_graph('other')
    assert_equal ['2', '3', '4'], results
  end
end
