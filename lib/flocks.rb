require 'redis'
require 'flocks/configuration'
require 'flocks/ordering'
require 'flocks/relationships'
require 'flocks/search'
require 'flocks/version'

module Flocks
  class << self
    include Configuration
    include Ordering
    include Search
    include Relationships

    attr_accessor :user_id, :username_score

    def new(user_id, username = nil)
      self.user_id = user_id
      self.username_score = rank_username(username)
      self
    end
  end
end
