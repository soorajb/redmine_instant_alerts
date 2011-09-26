require 'pusher'
require_dependency 'issue'

module IssuePusherPatch
 PUSHER_APP_ID = '8775'
 PUSHER_KEY = '38ac0cbe898194b348e0'
 PUSHER_SECRET = '5e85154d7a10d3f47489'

  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable
      after_save :trigger_pusher      
    end
  end
  
  module InstanceMethods
 
   def trigger_pusher
    Pusher.app_id = PUSHER_APP_ID
    Pusher.key = PUSHER_KEY
    Pusher.secret = PUSHER_SECRET
    data = {:project=>self.project.name,:issue_name=>self.subject,:issue_status=>self.status.name}
    Pusher["project-#{self.project.id}"].trigger('issue_add', "#{data.to_json}")
   end
  end    
end

