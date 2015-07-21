require 'sinatra/base'
require 'multi_json'
require 'echo'

module Echo
  # Echo out everything that's requested
  class App < Sinatra::Base
    # Global configuration
    disable :sessions

    set :rack_filters, %w(
      puma.config
      puma.socket
      rack.errors
      rack.hijack
      rack.hijack?
      rack.input
      rack.logger
    )

    set :rack_methods, %w(
      content_length
      cookies
      env
      host
      ip
      media_type
      path
      path_info
      port
      query_string
      referer
      request_method
      scheme
      script_name
      url
      user_agent
    )

    configure :production do
      use Rack::Deflater
    end

    # Make development a little bit chattier
    # and make sure code is reloaded for every request
    configure :development do
      require 'sinatra/reloader'
      register Sinatra::Reloader
      enable :dump_errors, :raise_errors
    end

    # Define a default route and echo out
    # headers and ENV variables for anything requested
    get '/*' do
      dump = Hash[settings.rack_methods.map { |method| [method.to_sym, request.send(method)] }]
      dump[:params] = params
      dump[:env].delete_if { |key| settings.rack_filters.include? key }

      # Use a custom status code if one of the parameters is "status="
      status params['status'] if params['status']

      # This route explicitly converts its output to JSON instead of using the
      # Sinatra::JSON helper because we want the line-breaks that come with
      # :pretty => true.
      content_type 'application/json;charset=utf-8'
      body MultiJson.dump(dump, pretty: true)
    end
  end
end
