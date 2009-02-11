class FeedEntry < ActiveRecord::Base
  attr_accessible :body, :owner
  belongs_to :owner, :polymorphic => true
end