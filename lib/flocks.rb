require 'redis'
require 'core_ext'
require 'flocks/version'
require 'flocks/configuration'
require 'flocks/relationships'

module Flocks
  class << self
    include Configuration
    include Relationships

    attr_accessor :user_id, :username_score

    def new(user_id, username = nil)
      self.user_id = user_id
      self.username_score = username.to_s.score
      self
    end
  end
end
