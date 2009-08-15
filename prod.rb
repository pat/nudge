require 'rubygems'
require 'sinatra'
require 'json'
require 'haml'
require 'dm-core'

# Setup Database
local_directory = File.expand_path File.dirname(__FILE__)
DataMapper.setup :default, "sqlite3:///#{local_directory}/prod.db"

# Local Library
$:.unshift File.dirname(__FILE__) + '/lib'
require 'site'
require 'web'

DataMapper.auto_upgrade!
