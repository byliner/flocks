require 'test_helper'

class FlocksTest < MiniTest::Test

  def setup
    Flocks.configure do |config|
      config.redis = Redis.new
      config.namespace = 'flocks'
      config.following_key = 'following'
      config.followers_key = 'followers'
      config.blocked_key = 'blocked'
      config.blocked_by_key = 'blocked_by'
      config.default_scope_key = 'default'
      config.page_size = 25
    end

    Flocks.redis.flushdb
  end

  def test_initialization
    flock = Flocks.new(1, 1)
    assert_equal 1, flock.user_id
    assert_equal 4948484848, flock.username_score
  end

  def test_configuration
    Flocks.configure do |config|
      config.redis = Redis.new
      config.namespace = 'flocks_test'
      config.following_key = 'following_test'
      config.followers_key = 'followers_test'
      config.blocked_key = 'blocked_test'
      config.blocked_by_key = 'blocked_by_test'
      config.default_scope_key = 'default_test'
      config.page_size = 50
    end

    assert_equal 'flocks_test', Flocks.namespace
    assert_equal 'following_test', Flocks.following_key
    assert_equal 'followers_test', Flocks.followers_key
    assert_equal 'blocked_test', Flocks.blocked_key
    assert_equal 'blocked_by_test', Flocks.blocked_by_key
    assert_equal 'default_test', Flocks.default_scope_key
    assert_equal  50, Flocks.page_size
  end

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
