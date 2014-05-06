require 'test_helper'

class RelationshipsTest < MiniTest::Test

  def test_follow_and_unfollow
    flock = Flocks.new(1, 'username')
    flock.follow(2, 'other_username')
    assert flock.following?(2)

    flock.unfollow(2)
    refute flock.following?(2)
  end

  def test_following_and_following_count
    flock = Flocks.new(1, 'username')
    flock.follow(2, 'other_username')
    assert_equal ['2'], flock.following
    assert_equal 1, flock.following_count
  end

  def test_followers_and_followers_count
    flock = Flocks.new(1, 'username')
    flock.follow(2, 'other_username')

    other_flock = Flocks.new(2, 'other_username')
    assert_equal ['1'], other_flock.followers
    assert_equal 1, other_flock.followers_count
  end

  def test_following_page_count
    flock = Flocks.new(1, 'username')
    (2..40).to_a.each { |i| flock.follow(i, "#{i}") }
    assert_equal 2, flock.following_page_count
  end

  def test_followers_page_count
    (2..40).to_a.each { |i| Flocks.new(i, "#{i}").follow(1, "username") }
    flock = Flocks.new(1, 'username')
    assert_equal 2, flock.followers_page_count
  end

  def test_block_blocked_and_unblock
    flock = Flocks.new(1, 'username')
    flock.follow(2, 'other_username')

    flock.block(2)
    assert_equal ['2'], flock.blocked
    assert flock.blocked? 2
    refute Flocks.new(2).following? 1

    flock.unblock(2)
    assert_equal ([]), flock.blocked
  end

end
