##### Simple Served HTTP server

* checkout this git and run
```
$ echo "hello world" > ./webdocs/index.html

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
* security vulnerability present when you use this case. need ot sanitize the path before serving
```
$ curl -v -XGET http://localhost:8080/../../../../../../etc/passwd
```
* use clean up on request path to ignore path with '..'
```
  # Split the path into components
  parts = path.split("/")

  parts.each do |part|
    # skip any empty or current directory (".") path components
    next if part.empty? || part == '.'
    # If the path component goes up one directory level (".."),
    # remove the last clean component.
    # Otherwise, add the component to the Array of clean components
    part == '..' ? clean.pop : clean << part
  end
```
* run with patched version
```
$ ./better_http_server.rb
GET /index.html HTTP/1.1

$ curl -v -XGET http://localhost:8080/../../../../../../etc/passwd
* About to connect() to localhost port 8080 (#0)
*   Trying ::1...
* Connected to localhost (::1) port 8080 (#0)
> GET /../../../../../../etc/passwd HTTP/1.1
> User-Agent: curl/7.29.0
> Host: localhost:8080
> Accept: */*
>
< HTTP/1.1 404 Not Found
< Content-Type: text/plain
< Content-Length: 15
< Connection: close
<
File not found
```
* try [Rack Webserver Interface](http://rack.github.io/) or [Jekyll Markdown type Blogger](http://jekyllrb.com/) instead
##### try with rack web server
* install rack (if you do not have it)
```
$ gem list --local rack
$ gem install rack
```
* prepare config.ru file
```
$ cat config.ru
# config.ru
#
run Proc.new { |env| ['200', {'Content-Type' => 'text/html'}, ['get rack\'d']] }
```
* run rackup (it prevents vulnerability that previously test)
```
$ rackup config.ru
[2015-02-12 10:16:43] INFO  WEBrick 1.3.1
[2015-02-12 10:16:43] INFO  ruby 2.1.0 (2013-12-25) [x86_64-linux]
[2015-02-12 10:16:43] INFO  WEBrick::HTTPServer#start: pid=4331 port=9292
::1 - - [12/Feb/2015:10:17:01 -0800] "GET / HTTP/1.1" 200 - 0.0005
::1 - - [12/Feb/2015:10:17:05 -0800] "GET / HTTP/1.1" 200 - 0.0003
::1 - - [12/Feb/2015:10:17:12 -0800] "GET / HTTP/1.1" 200 - 0.0003
::1 - - [12/Feb/2015:10:17:13 -0800] "GET / HTTP/1.1" 200 - 0.0003
::1 - - [12/Feb/2015:10:17:17 -0800] "GET / HTTP/1.1" 200 - 0.0003
[2015-02-12 10:17:33] ERROR bad URI `/../../../../../../etc/password'.
[2015-02-12 10:17:37] ERROR bad URI `/../../../../../../etc/passwd'.
[2015-02-12 10:17:43] ERROR bad URI `/../../../../../etc/passwd'.
```

* Reference: [http served file](https://practicingruby.com/articles/implementing-an-http-file-server)
