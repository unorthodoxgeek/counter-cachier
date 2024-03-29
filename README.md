counter-cachier
===============

usage
-------------

counter cachier is a generic counter caching solution (using redis) for stuff where ActiveRecord's counter cache just does not cut it. i.e. when the counter is on a complex association, etc.

usage is pretty simple, simply include CounterCachier in the class you wish to use it on, and define counter cachiers:

```ruby
class User
  include CounterCachier

  counter_cachier :approved_posts_count do |user|
    user.posts.approved.count
  end
end
```

the block's argument is the object you're making the calculations for (i.e. an instance of User), the value returned in the block will be the new counter. From this moment, two new methods are added to User - approved_posts_count and recalc_approved_posts_count.

```ruby
user = User.first
user.approved_posts_count #=> 10
#...user adds an approved post...
user.recalc_approved_posts_count #=> 11, but it actually recalculates and pushes the number into redis.
```

installation
-------------

in your gemfile
gem "counter_cachier"

in an initializer:
```ruby
CounterCachier.redis = Redis.new(redis_configuration)
```
you can skip this if you've got the $redis global.
