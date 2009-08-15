# require 'rubygems'
# require 'sinatra'
require 'prod'

set :run, false
set :environment, :production
 
FileUtils.mkdir_p 'log' unless File.exists?('log')
log = File.new("log/sinatra.log", "a")
$stdout.reopen(log)
$stderr.reopen(log)

# root_dir = File.dirname(__FILE__)
# 
# set :environment, ENV['RACK_ENV'].to_sym
# set :root,        root_dir
# set :app_file,    File.join(root_dir, 'prod.rb')
# disable :run

# HACK HACK HACK
# class NginxPassengerFix
#   def initialize(app)
#     @app = app
#   end
# 
#   def call(env)
#     env["PATH_INFO"] = env["REQUEST_URI"].sub(/\?[^\?]*$/, "")
#     r = @app.call(env)
#   end
# end
# use NginxPassengerFix
# END HACK HACK HACK

run Sinatra::Application
