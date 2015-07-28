## Echo: everything you wanted to know about your HTTP request but didn't want to install a browser plugin to ask

Maybe you're writing a client for a web service and you want to test some new calls. Maybe you're writing a web service that talks to another web service. Maybe you just want to know

```bash
# Use curl to send a GET request to a generic example API endpoint
curl -H "Macguffin-Token: <token value>" "http://127.0.0.1:3000/example/endpoint"
```

```
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
    "macguffin_token": "<token value>"
  },
  "request_method": "GET",
  "scheme": "http",
  "script_name": "",
  "url": "http://127.0.0.1:3000/example/endpoint",
  "user_agent": "curl/7.37.1"
}
```
