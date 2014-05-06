module Flocks
  module Search

    # Search a user's list of following
    def search_following(query)
      redis.zrangebyscore relationship_following_key, start_score(query), stop_score(query)
    end

    # Search a user's list of followers
    def search_followers(query)
      redis.zrangebyscore relationship_followers_key, start_score(query), stop_score(query)
    end

    # Search a user's entire social graph
    def search_graph(query)
      (search_following(query) + search_followers(query)).uniq
    end

    protected

    # Set constraints to return relevent results
    # Starting score for redis zrangebyscore
    def start_score(query)
      rank_username(query)
    end

    # 'aaa' -> 'aab'
    # Ending score for redis zrangebyscore
    def stop_score(query)
      query_array = query.chars
      last_char = (query_array.pop.ord + 1).chr
      stop_name = query_array.push(last_char).join('')
      rank_username(stop_name)
    end

  end
end
