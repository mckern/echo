# frozen_string_literal: true

describe 'Echo::App' do
  include Rack::Test::Methods

  def app
    @app ||= Echo::App.new
  end

  let(:body) { JSON.parse(last_response.body) }
  let(:form_hash) { body['request_headers']['rack.request.form_hash'] }

  it 'accepts and echoes an HTTP POST request' do
    post '/', 'msg' => 'Hello world!'

    expect(form_hash)
      .to include('msg' => 'Hello world!')
  end

  it 'filters dangerous values from the response' do
    get '/'

    expect(body['request_headers'].keys)
      .not_to include app.settings.env_filters

    expect(body['params'])
      .not_to include app.settings.params_filters
  end

  it 'returns a valid JSON response' do
    get '/'

    expect(last_response.header['Content-Type'].split(';'))
      .to include 'application/json'

    expect(JSON.parse(last_response.body))
      .to be_truthy
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

    expect(get_response.call != post_response.call)
      .to be true
  end
end
