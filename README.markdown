# mini_feed

A DSL for creating feed events in a web two-point-oh style kind of thing...

... no, seriously, a really small ActiveRecord plugin for a pattern I used many times: generating feed-like
events when certain callbacks are fired.

    class Message < ActiveRecord::Base
      generates_feed do
        after :create, :like => ":sender has sent a message to :recipient"
      end
    end
    
Alternatively if you have an association, and you want to pull a property from it from inside the body of the feed, you can go

    class Message < ActiveRecord::Base
      generates_feed do
        after :create, :like => ":sender.name has sent a message to :recipient.name"
      end
    end

When generates_feed() is invoked, an association feed_entries is made available on the class. Each entry can reach the model
that generated it via #about. So feeds are "about" something.

You can declare an "owner" for a feed, which generally is an association on the feed. This helps for when you're trying to make
a bunch of entries belong to someone and not be visible to everyone else. So like in the example above, let's say we want feeds
to belong to the recipient

    class Message < ActiveRecord::Base
      generates_feed do
        after :create, :like => ":sender.name has sent a message to :recipient.name", :owner => :recipient
      end
    end

Capisce?

The symbol-like stuff (e.g.: :foo) will be eval'ed against the feed instance. So if in a Message model (for instance) you have
a :title attribute that happens to be "look ma no hands", in here

    generates_feed do
      after :create, :like => "message sent with title: :title"
    end

the feed body will end up like "message sent with title: look ma no hands".

# Usage

Just run rake mini_feeds:run_migrations before you start. Then follow the examples above. Source is simple enough to be easily
understood anyways.