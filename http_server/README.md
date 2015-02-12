##### Simple Served HTTP server

```
$ ./http_server.rb
GET /index.html HTTP/1.1

$ curl -v -XGET http://localhost:8080/index.html
* About to connect() to localhost port 8080 (#0)
*   Trying ::1...
* Connected to localhost (::1) port 8080 (#0)
> GET /index.html HTTP/1.1
> User-Agent: curl/7.29.0
> Host: localhost:8080
> Accept: */*
>
< HTTP/1.1 200 OK
< Content-Type: text/html
< Content-Length: 12
< Connection: close
<
hello world
```

Reference: [http served file](https://practicingruby.com/articles/implementing-an-http-file-server)
