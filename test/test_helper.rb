require 'rubygems'
require 'bundler'
Bundler.require :test

require 'minitest/autorun'
require 'redis'
require 'flocks'

# Support files
Dir["#{File.expand_path(File.dirname(__FILE__))}/support/*.rb"].each do |file|
  require file
end

class MiniTest::Test
  def setup
    Flocks.configure do |config|
      config.redis = Redis.new
      config.namespace = 'flocks'
      config.following_key = 'following'
      config.followers_key = 'followers'
      config.blocked_key = 'blocked'
      config.blocked_by_key = 'blocked_by'
      config.page_size = 25
    end

    Flocks.redis.flushdb
  end
end
