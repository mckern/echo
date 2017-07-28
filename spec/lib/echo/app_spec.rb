# frozen_string_literal: true

require 'spec_helper'

describe 'Echo::App' do # rubocop:disable Metrics/BlockLength
  include Rack::Test::Methods

  def app
    @app ||= Echo::App.new
  end

  let(:body) { JSON.parse(last_response.body) }
  let(:form_hash) { body['request_headers']['rack.request.form_hash'] }

  it 'accepts and echoes an HTTP POST request' do
    post '/', 'msg' => 'Hello world!'

    form_hash.must_equal('msg' => 'Hello world!')
  end

  it 'filters dangerous values from the response' do
    get '/'

    body['request_headers'].keys
                           .wont_include app.settings.env_filters

    body['params']
      .wont_include app.settings.params_filters
  end

  it 'returns a valid JSON response' do
    get '/'

    last_response.header['Content-Type'].split(';')
                 .must_include 'application/json'

    assert(JSON.parse(last_response.body))
  end

  it 'returns a different response for a POST than a GET' do
    get_response = lambda do
      get '/'
      JSON.parse(last_response.body)
    end

    post_response = lambda do
      post '/'
      JSON.parse(last_response.body)
    end

    get_response.call.wont_equal(post_response.call)
  end
end
