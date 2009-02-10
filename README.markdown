# mini_feed

A DSL for creating feed events in a web two-point-oh style kind of thing...

... no, seriously, a really small ActiveRecord plugin for a pattern I used many times: generating feed-like
events when certain callbacks are fired.

    class Message < ActiveRecord::Base
      generates_feed do
        after :create, :like => ":sender has sent a message to :recipient"
      end
    end

Capisce?

The symbol-like words (e.g.: :foo) will be "resolved" to methods. So if in a Message model (for instance) you have
a :title attribute that happens to be "look ma no hands", in here

    generates_feed do
      after :create, :like => "message sent with title: :title"
    end

the feed body will end up like "message sent with title: look ma no hands".

# Usage

Just run rake mini_feeds:run_migrations before you start. Then follow the example above.
