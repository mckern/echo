# frozen_string_literal: true

# define our source to loook for gems
source 'https://rubygems.org/'

# declare the sinatra dependency
gem 'sinatra', '~> 1.4'
gem 'sinatra-contrib', '~> 1.4'

# written around Puma, but you could use literally
# any other Rack-compatible middleware.
gem 'puma', group: :puma, require: false

group(:development, :test) do
  gem 'rake', require: false
  gem 'rspec', '~> 3.0', require: false
  gem 'rubocop', '~> 0.47', require: false
  gem 'simplecov', require: false
  gem 'webmock', require: false
end
