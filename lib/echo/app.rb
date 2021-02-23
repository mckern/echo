# frozen_string_literal: true

require 'json'
require 'sinatra/base'
require 'echo'

module Echo
  # Echo out everything that's requested
  class App < Sinatra::Base
    # Global configuration
    disable :sessions

    set :env_filters, %w[
      GATEWAY_INTERFACE
      HTTP_VERSION
      PATH_INFO
      QUERY_STRING
      REQUEST_METHOD
      REQUEST_PATH
      REQUEST_URI
      SCRIPT_NAME
      SERVER_PROTOCOL
      HTTP_HOST
      REMOTE_ADDR
      SERVER_NAME
      SERVER_PORT
      SERVER_SOFTWARE
      puma.config
      puma.socket
      rack.after_reply
      rack.errors
      rack.hijack
      rack.hijack?
      rack.input
      rack.logger
      rack.multiprocess
      rack.multithread
      rack.request.cookie_hash
      rack.request.query_hash
      rack.request.query_string
      rack.run_once
      rack.url_scheme
      rack.version
      sinatra.route
    ]

    set :params_filters, %w[
      splat
      captures
    ]

    set :rack_methods, %w[
      content_length
      cookies
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
    ]

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

    # Define a default route and echo out headers and ENV
    # variables for anything requested. This is wrapped up
    # in a Lambda so that it can be executed on demand by
    # any of the metaprogramatically generated HTTP method hooks.
    parrot = lambda do
      dump = settings.rack_methods.map do |method|
        value = request.send(method)

        # Thanks to the magic of pass-by-reference, when dump[:env] is created from
        # rack.env, any alterations to dump[:env] (like dropping keys) meander their way
        # down into rack.env. Eventually you hit a value like rack.after_reply, and everything
        # goes sideways in a big, big way. Highly undesirable.
        value = begin
          value.dup
        rescue TypeError
          value
        end

        # Return the method name and the value
        # as an Array, to facilitate squashing this down
        # into a readable Hash.
        [method.to_sym, value]
      end.to_h

      # Prune values from dump[:env] that are rack-specific or sensitive
      dump[:request_headers] = env.reject { |key, _| settings.env_filters.include? key }

      # Add any passed parameters to the dump, but prune sinatra-specific values
      dump[:params] = params.reject { |key, _| settings.params_filters.include? key }

      # Sort the dump for presentation
      dump = dump.sort_by { |key, _| key }.to_h

      # Use a custom status code if one of the parameters is "status="
      status params['status'] if params['status']

      # This route explicitly converts output to JSON instead of using the
      # Sinatra::JSON helper because we want the line-breaks that come with
      # :pretty => true.
      content_type 'application/json;charset=utf-8'
      body JSON.pretty_generate(dump)
    end

    %w[
      get
      post
      put
      delete
    ].each do |method|
      send method, '/*', &parrot
    end
  end
end
