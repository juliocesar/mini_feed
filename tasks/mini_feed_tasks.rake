namespace :mini_feeds do
  # Runs the necessary migrations for the feed_entries database
  
  require 'active_record'
  
  class CreateFeedEntries < ActiveRecord::Migration
    class << self
      def up
        create_table :feed_entries do |t|
          t.references  :owner
          t.string      :owner_type
          t.text        :body
          t.datetime    :created_at
        end
      end
      def down
        drop_table :feed_entries
      end
    end
  end
  
  task :run_migrations => :environment do
    CreateFeedEntries.up
  end
  
  task :drop_table => :environment do
    CreateFeedEntries.down
  end
  
end