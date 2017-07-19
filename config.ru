# This will be used for defining a lot of things
# deeper down in the Sinatra and Echo namespaces
APP_ROOT = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(APP_ROOT, 'lib')).uniq!

# Load Bundler, and bundle up them gems
require 'rubygems'
require 'bundler'

# Ensuring that an appropriate environment is defined
# will ensure that appropriate gems are loaded
ENV['RACK_ENV'] ||= 'development'
Bundler.require

# Load Echo and start it
require 'echo/app'
run Echo::App
