require 'test_helper'

class ConfigurationTest < MiniTest::Test

  def test_configuration
    Flocks.configure do |config|
      config.redis = Redis.new
      config.namespace = 'flocks_test'
      config.following_key = 'following_test'
      config.followers_key = 'followers_test'
      config.blocked_key = 'blocked_test'
      config.blocked_by_key = 'blocked_by_test'
      config.page_size = 50
    end

    assert_equal 'flocks_test', Flocks.namespace
    assert_equal 'following_test', Flocks.following_key
    assert_equal 'followers_test', Flocks.followers_key
    assert_equal 'blocked_test', Flocks.blocked_key
    assert_equal 'blocked_by_test', Flocks.blocked_by_key
    assert_equal  50, Flocks.page_size
  end
end
