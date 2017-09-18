# jaguar_cors

Example demonstrating Cross-Origin resource sharing (CORS) using Jaguar.dart

# Setup



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
