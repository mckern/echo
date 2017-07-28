# frozen_string_literal: true

require 'echo/app'
require 'rack/test'
require 'rspec'
require 'webmock/rspec'

ENV['RACK_ENV'] = 'test'
WebMock.disable_net_connect!
