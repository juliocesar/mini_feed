# t.text    :body
# t.integer :owner_id
# t.string  :owner_type

class FeedEntry < ActiveRecord::Base
  attr_accessible :body
  belongs_to :owner, :polymorphic => true
end