# frozen_string_literal: true

require 'echo/app'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/spec'
require 'rack/test'
require 'webmock/minitest'

Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new

ENV['RACK_ENV'] = 'test'
WebMock.disable_net_connect!

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    # exclude common Bundler locations
    %w[.bundle vendor].each { |dir| add_filter dir }
    # exclude test code
    add_filter 'spec'
  end
end
