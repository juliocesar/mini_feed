module Feed
  
  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      has_many :feed_entries, :as => :about
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
        
    def after(event, options = {})
      assign_callback('after', event, options)
    end
    
    def before(event, options = {})
      assign_callback('before', event, options)
    end
    
    protected
    def assign_callback(before_or_after, event, options = {})
      @callbacks["#{before_or_after}_#{event}".to_sym] = Proc.new do |record|
        body = in_ur_colonz(options[:like], record)
        FeedEntry.create :body => body, :owner => record.send(options[:owner]), :about => record
      end            
    end

    def in_ur_colonz(text, something)
      text.gsub(/\:(\w+[.\w]+)/) { something.instance_eval $1 }  # \m/
    end
            
  end
  
end

