module Flocks
  # Configuration settings for Flocks.
  module Configuration
    # Redis instance.
    attr_accessor :redis

    # Flocks namespace for Redis.
    attr_writer :namespace

    # Key used in Redis for tracking who an individual is following.
    attr_writer :following_key

    # Key used in Redis for tracking the followers of an individual.
    attr_writer :followers_key

    # Key used in Redis for tracking who an individual blocks.
    attr_writer :blocked_key

    # Key used in Redis for tracking who has blocked an individual.
    attr_writer :blocked_by_key

    # Key used in Redis for tracking who has reciprocated a follow for an individual.
    attr_writer :reciprocated_key

    # Key used in Redis for tracking pending follow relationships for an individual.
    attr_writer :pending_key

    # Key used in Redis for tracking who an individual is awaiting approval from.
    attr_writer :pending_with_key

    # Key used to indicate whether or not a follow should be pending or not.
    attr_writer :pending_follow

    # Default key used to indicate the scope for the current call
    attr_writer :default_scope_key

    # Page size to be used when paging through the various types of relationships.
    attr_writer :page_size

    # Set the percision for relationship sorting granularity
    attr_writer :string_score_percision

    # Yield self to be able to configure Flocks with block-style configuration.
    #
    # Example:
    #
    #   Flocks.configure do |configuration|
    #     configuration.redis = Redis.new
    #     configuration.namespace = 'flocks'
    #     configuration.following_key = 'following'
    #     configuration.followers_key = 'followers'
    #     configuration.blocked_key = 'blocked'
    #     configuration.blocked_by_key = 'blocked_by'
    #     configuration.reciprocated_key = 'reciprocated'
    #     configuration.pending_key = 'pending'
    #     configuration.pending_with_key = 'pending_with'
    #     configuration.default_scope_key = 'default'
    #     configuration.pending_follow = false
    #     configuration.page_size = 25
    #   end
    def configure
      yield self
    end

    # Flocks namespace for Redis.
    #
    # @return the Flocks namespace or the default of 'flocks' if not set.
    def namespace
      @namespace ||= 'flocks'
    end

    # Key used in Redis for tracking who an individual is following.
    #
    # @return the key used in Redis for tracking who an individual is following or the default of 'following' if not set.
    def following_key
      @following_key ||= 'following'
    end

    # Key used in Redis for tracking the followers of an individual.
    #
    # @return the key used in Redis for tracking the followers of an individual or the default of 'followers' if not set.
    def followers_key
      @followers_key ||= 'followers'
    end

    # Key used in Redis for tracking who an individual blocks.
    #
    # @return the key used in Redis for tracking who an individual blocks or the default of 'blocked' if not set.
    def blocked_key
      @blocked_key ||= 'blocked'
    end

    # Key used in Redis for tracking who has blocked an individual.
    #
    # @return the key used in Redis for tracking who has blocked an individual or the default of 'blocked_by' if not set.
    def blocked_by_key
      @blocked_by_key ||= 'blocked_by'
    end

    # Key used in Redis for tracking who has reciprocated a follow for an individual.
    #
    # @return the key used in Redis for tracking who has reciprocated a follow for an individual or the default of 'reciprocated' if not set.
    def reciprocated_key
      @reciprocated_key ||= 'reciprocated'
    end

    # Default key used in Redis for tracking scope for the given relationship calls.
    #
    # @return the default key used in Redis for tracking scope for the given relationship calls.
    def default_scope_key
      @default_scope_key ||= 'default'
    end

    # Page size to be used when paging through the various types of relationships.
    #
    # @return the page size to be used when paging through the various types of relationships or the default of 25 if not set.
    def page_size
      @page_size ||= 25
    end

    # Number of characters to be used when scoring a username for indexing in redis
    #
    # @return the scoring percision
    def string_score_percision
      @string_score_percision ||= 5
    end
  end
end
