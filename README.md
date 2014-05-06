# Flocks

Flocks is a lightweight searchable social graph that tracks a user's followers, who they are following, and who they have blocked.

Flocks uses [Redis](http://redis.io/documentation) to store the relationships.

User lists are sorted alphabetically and can be searched!

Flocks uses usernames (or any unique string identifier) when following in order to sort the following/followers lists.
By requiring usernames when establishing relationships, Flocks becomes searchable.
Flocks will return all user ids with user_ids matching the query string.
Flocks search capabilities can be used to autocomplete text fields with usernames in a user's social graph.

For example, if a user is following: 'Adam', 'Aaron', 'Addison', and 'John'

Searching for 'a' will return the ids associated with Adam, Aaron, and Addison
Searching for 'ad' will return the id associated with Adam


## Installation

Add this line to your application's Gemfile:

    gem 'flocks'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flocks

## Usage

Configure flocks:

```ruby
Flocks.configure do |configuration|
  configuration.redis = Redis.new
  configuration.namespace = 'flocks'
  configuration.following_key = 'following'
  configuration.followers_key = 'followers'
  configuration.blocked_key = 'blocked'
  configuration.page_size = 25
end
```

Use flocks:

```ruby
require 'flocks'
=> true

Flocks.configure do |configuration|
  configuration.redis = Redis.new
  configuration.namespace = 'flocks'
  configuration.following_key = 'following'
  configuration.followers_key = 'followers'
  configuration.blocked_key = 'blocked'
  configuration.page_size = 25
end

Flocks.new(1, 'username').follow(11, 'other_username')
=> true

Flocks.new(1, 'username').following?(11)
=> true

Flocks.new(11, 'other_username').following?(1)
=> false

Flocks.new(11, 'other_username').follow(1, 'username')
=> true

Flocks.new(11, 'other_username').following?(1)
=> true

Flocks.new(1, 'username').following_count
=> 1

Flocks.new(1, 'username').followers_count
=> 1

Flocks.new(11, 'other_username').unfollow(1)
=> true

Flocks.new(11, 'other_username').following_count
=> 0

Flocks.new(1, 'username').following_count
=> 1

Flocks.new(1, 'username').following
=> ["11"]

Flocks.new(1, 'username').block(11)
=> true

Flocks.new(11, 'username').following?(1)
=> false

Flocks.new(1, 'username').blocked?(11)
=> true

Flocks.new(11, 'other_username').follow(1)
=> nil

Flocks.new(1, 'username').unblock(11)
=> true

Flocks.new(1, 'username').blocked?(11)
=> false

Flocks.new(11, 'other_username').follow(1)
=> true

Flocks.new(1, 'username').follow(11)
=> true

Flocks.new(1, 'username').search_following('other')
=> ["11"]

Flocks.new(1, 'username').search_followers('other')
=> ["11"]

Flocks.new(1, 'username').search_graph('other')
=> ["11"]

```

## Thanks

Many thanks to [amico](https://github.com/agoragames/amico) creator [agoragames](https://github.com/agoragames).  A lot of the code used was inspired by the [amico gem](https://github.com/agoragames/amico).

## Contributing

1. Fork it ( http://github.com/<my-github-username>/flocks/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
