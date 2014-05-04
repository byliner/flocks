module Flocks
  module Relationships

    def relationship_following_key
      "#{following_key}/#{user_id}"
    end

    def relationship_followers_key(id = user_id)
      "#{followers_key}/#{id}"
    end

    def relationship_blocked_key
      "#{blocked_key}/#{user_id}"
    end

    def follow(other_user_id, other_username)
      return if (user_id == other_user_id) || (blocked? other_user_id)

      other_username_score = other_username.score
      redis.zadd relationship_following_key, other_username_score, other_user_id
      redis.zadd relationship_followers_key(other_user_id), username_score, user_id
    end

    def unfollow(other_user_id)
      redis.zrem relationship_following_key, other_user_id
      redis.zrem relationship_followers_key(other_user_id), user_id
    end

    def following(page = 0, limit = 0)
      # Without arguments returns the full set
      start, stop = bounds(page, limit)
      redis.zrange relationship_following_key, start, stop
    end

    def followers(page = 0, limit= 0)
      start, stop = bounds(page, limit)
      redis.zrange relationship_followers_key(user_id), start, stop
    end

    def following?(other_user_id)
      following.include? other_user_id.to_s
    end

    def following_count
      redis.zcard relationship_following_key
    end

    def followers_count
      redis.zcard relationship_followers_key
    end

    def following_page_count(limit = page_size)
      (following_count.to_f / limit.to_f).ceil
    end

    def followers_page_count(limit = page_size)
      (followers_count.to_f / limit.to_f).ceil
    end

    def block(other_user_id)
      # Unfollow
      unfollow other_user_id
      self.new(other_user_id).unfollow user_id

      # Block
      redis.sadd relationship_blocked_key, other_user_id
    end

    def unblock(other_user_id)
      redis.srem relationship_blocked_key, other_user_id
    end

    def blocked
      redis.smembers relationship_blocked_key
    end

    def blocked?(other_user_id)
      blocked.include? other_user_id.to_s
    end

    def bounds(page, limit)
      [(page - 1) * limit, (page * limit) - 1]
    end
  end
end
