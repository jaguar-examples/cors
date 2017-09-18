# jaguar_cors

Example demonstrating Cross-Origin resource sharing (CORS) using Jaguar.dart

The aim of this example is to demonstrate CORS capabilities of Jaguar. 

# Explanation

## Implementation details

The example contains two servers and a client.

### Main server (Local server)

Main server contains non-CORS GET and POST method on path `/api`.

**Source**: bin/main.dart

### Foreign server

Foreign server contains CORS GET and POST methods on path `/api`.

**Source**: bin/foreign.dart

## Domains

To demonstrate CORS capabilities, three domains muse be used:

* mine.com
* foreign.com
* malicious.com

### Foreign domain

### Mine domain

Mine domain uses the CORS methods of foreign domain. Routes on foreign domain are programmed to allow CORS requests from
*mine.com* domain. These calls must succeed and display expect output. 

### Malicious domain

Mailicious domain tries to use the CORS methods of foreign domain. But routes on foreign domain do not allow CORS requests
from domains other than *mine.com* domain. All these calls must fail with 403 status code.

# Testing on Linux

## Configure domain names
Add the following line to `/etc/hosts`

```text
127.0.0.1	mine.com foreign.com malicious.com
```

## Configure nginx

```text
server {
  listen       80;
  server_name  mine.com;

  client_max_body_size 200M;
  #access_log  logs/host.access.log  main;
  proxy_read_timeout 86400s;
  proxy_send_timeout 86400s;
  fastcgi_read_timeout 300;

  location /api/ {
    proxy_intercept_errors on;
    proxy_pass http://localhost:8000;
    proxy_connect_timeout       300;
    proxy_send_timeout          300;
    proxy_read_timeout          300;
    send_timeout                300;
  }

  #html files
  location / {
    proxy_http_version 1.1;
    proxy_intercept_errors on;
    proxy_pass http://localhost:8001;
  }

  error_page   500 502 503 504  /50x.html;
  location = /50x.html {
    root   html;
  }
}

server {
  listen       80;
  server_name  foreign.com;

  client_max_body_size 200M;
  #access_log  logs/host.access.log  main;
  proxy_read_timeout 86400s;
  proxy_send_timeout 86400s;
  fastcgi_read_timeout 300;

  location /api/ {
    proxy_intercept_errors on;
    proxy_pass http://localhost:9000;
    proxy_connect_timeout       300;
    proxy_send_timeout          300;
    proxy_read_timeout          300;
    send_timeout                300;
  }

  #html files
  location / {
    proxy_intercept_errors on;
    proxy_pass http://localhost:8001;
  }

  error_page   500 502 503 504  /50x.html;
  location = /50x.html {
    root   html;
  }
}

server {
  listen       80;
  server_name  malicious.com;

  client_max_body_size 200M;
  #access_log  logs/host.access.log  main;
  proxy_read_timeout 86400s;
  proxy_send_timeout 86400s;
  fastcgi_read_timeout 300;

  location /api/ {
    proxy_intercept_errors on;
    proxy_pass http://localhost:8000;
    proxy_connect_timeout       300;
    proxy_send_timeout          300;
    proxy_read_timeout          300;
    send_timeout                300;
  }

  #html files
  location / {
    proxy_http_version 1.1;
    proxy_intercept_errors on;
    proxy_pass http://localhost:8001;
  }

  error_page   500 502 503 504  /50x.html;
  location = /50x.html {
    root   html;
  }
}
```

## Serve APIs and pub

### Start APIs

```bash
dart bin/main.dart
dart bin/foreign.dart
```

### Start pub server

```bash
pub serve web --port 8001
```
