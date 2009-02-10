module Feed
  
  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      has_many :feed_entries, :as => :owner
    end
  end
  
  module ClassMethods
    
    def generates_feed(&block)
      feeder = Feeder.new(&block)
      feeder.callbacks.each do |method, proc|
        send(method, &proc)
      end  
    end
    
  end
  
  class Feeder
    attr_accessor :callbacks
    
    def initialize(&block)
      @callbacks = {}
      self.instance_eval &block      
    end
        
    def after(*args)
      options = args.last
      @callbacks["after_#{args.first}".to_sym] = Proc.new do |record|
        body = in_ur_colonz(options[:like], record)
        FeedEntry.create :body => body, :owner => record
      end
    end
    
    def in_ur_colonz(text, something)
      text.gsub(/\:(\w+)/) { something.send($1) }  #  :-O
    end
            
  end
  
end

