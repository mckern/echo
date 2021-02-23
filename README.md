## Echo: everything you wanted to know about your HTTP request but didn't want to install a browser plugin to ask

Maybe you're writing a client for a web service and you want to test some new calls. Maybe you're writing a web service that talks to another web service. Maybe you **just want to know**.

[![Build Status](https://travis-ci.org/mckern/echo.svg?branch=master)](https://travis-ci.org/mckern/echo)

### Usage: server-side

Echo is a very simple [Sinatra](http://www.sinatrarb.com) 1.4 application. It expects to be run via
[Puma](https://github.com/puma/puma), but any generic Rack application server will do. It has been tested with:

  - [Passenger](https://www.phusionpassenger.com): pretty fast.
  - [Thin](https://github.com/macournoyer/thin): kinda slow for this application.
  - [Unicorn](https://bogomips.org/unicorn/): it's fine.
  - [Puma](https://github.com/puma/puma): Worked best with [JRuby](http://jruby.org).

Echo's dependencies are installed just like any other garden-variety Rack application: with Bundler.
For ease of deployment or execution, Puma also comes with a basic Procfile. You can run this anywhere you want using [Forego](ddollar/forego) or even a low-end tier on [Heroku](https://www.heroku.com).

```
mckern@flexo echo (git:1.0.1) $ bundle install --path vendor/gems
Resolving dependencies...
Using backports 3.6.8
Using multi_json 1.10.1
Using puma 3.6.2
Using rack 1.6.5
Using tilt 2.0.5
Using bundler 1.13.7
Using rack-protection 1.5.3
Using rack-test 0.6.3
Using sinatra 1.4.7
Using sinatra-contrib 1.4.7
Bundle complete! 3 Gemfile dependencies, 10 gems now installed.
Bundled gems are installed into vendor/gems.
mckern@flexo echo (git:1.0.1) $
```

### Usage: client-side

```bash
# Use curl to send a GET request to a generic example API endpoint
mckern@flexo ~ $ curl -H "Macguffin-Token: deadcafebeefbabe" "http://127.0.0.1:3000/example/endpoint"
```

And get back a valid, relatively easy-to-follow JSON hash with all the pertinent details
of your dummy request:

```json
{
  "content_length": null,
  "cookies": {
  },
  "host": "127.0.0.1",
  "ip": "127.0.0.1",
  "media_type": null,
  "params": {
    "splat": [
      "example/endpoint"
    ],
    "captures": [
      "example/endpoint"
    ]
  },
  "path": "/example/endpoint",
  "path_info": "/example/endpoint",
  "port": 3000,
  "query_string": "",
  "referer": null,
  "request_headers": {
    "macguffin_token": "deadcafebeefbabe"
  },
  "request_method": "GET",
  "scheme": "http",
  "script_name": "",
  "url": "http://127.0.0.1:3000/example/endpoint",
  "user_agent": "curl/7.37.1"
}
```

### Support & contribution?

In the spirit of Jordan Sissel (a hero to admins and operations people everywhere), if Echo is not helping you debug weirdo random HTTP requests from your weirdo random clients, then there is a bug in Echo. Please open an issue or submit a pull request if something doesn't work.

## License

Echo is licensed under the MIT License.

> In computing, turning the obvious into the useful is a
> living definition of the word 'frustration'.
>    &#8213; <cite>Alan Perlis</cite>

## Maintainer

Ryan McKern &lt;ryan@orangefort.com&gt;
