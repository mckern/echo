# frozen_string_literal: true

# define our source to loook for gems
source 'https://rubygems.org/'

# declare the sinatra dependency
gem 'sinatra', '~> 2.1'
gem 'sinatra-contrib', '~> 2.1'

# written around Puma, but you could use literally
# any other Rack-compatible middleware.
gem 'puma', group: :puma, require: false

group(:development, :test) do
  gem 'minitest', require: false
  gem 'minitest-reporters', require: false
  gem 'rack-test', require: false
  gem 'rake', require: false
  gem 'rubocop', '~> 1.4', require: false
  gem 'simplecov', require: false
  gem 'webmock', require: false
end
