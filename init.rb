require 'redmine'
require File.join(File.dirname(__FILE__), 'lib','redmine_instant_alerts')

Issue.send(:include, IssuePusherPatch)
Redmine::Plugin.register :redmine_instant_alerts do
  name 'Redmine Instant Alerts plugin'
  author 'Sooraj B'
  description 'This is a plugin for instant alerts in Redmine using PusherApp'
  version '0.0.1'
  url 'http://github.com.com/soorajb/redmine_instant_alerts'
  author_url 'http://github.com/soorajb'
end

PUSHER_APP_ID = ""
PUSHER_KEY = ""
PUSHER_SECRET = ""
