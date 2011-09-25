require 'pusher'
require_dependency 'issue'

module IssuePusherPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable
      after_save :trigger_pusher      
    end
  end
  
  module InstanceMethods
   def last_update
    if self.journals.last.notes.blank? 
     content =  self.description 
    else
     content =  self.journals.last.notes
    end
    content
   end
  
   def trigger_pusher
    Pusher.app_id = PUSHER_APP_ID
    Pusher.key = PUSHER_KEY
    Pusher.secret = PUSHER_SECRET
    data = {:project=>self.project.name,:issue_name=>self.subject,:issue_status=>self.status.name,:description=>self.last_update}
    Pusher["project-#{self.project.id}"].trigger('issue_add', "#{data.to_json}")
   end
  end    
end

