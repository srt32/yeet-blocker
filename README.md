

Follow https://www.haproxy.com/blog/how-to-run-haproxy-with-docker

and then https://www.haproxy.com/documentation/haproxy-runtime-api/installation/

start haproxy

```
docker run -d \                                                           
   --name haproxy \
   --net mynetwork \
   -v $(pwd)/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro \
   -v $(pwd)/blocks.lua:/usr/local/etc/haproxy/blocks.lua:ro \
   -p 80:80 \
   -p 8404:8404 \
   haproxytech/haproxy-alpine:2.4
```

docker run -d \
   --name haproxy \
   --net mynetwork \                                           
   -v $(pwd)/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro \
   -v $(pwd)/blocks.lua:/usr/local/etc/haproxy/blocks.lua:ro \
   -v $(pwd)/path_status.map:/usr/local/etc/haproxy/path_status.map:rw \
   -p 80:80 \
   -p 8404:8404 \
   haproxytech/haproxy-alpine:2.4

reload haproxy config

```
docker kill -s HUP haproxy
```

```
docker run -d --name yolo --net mynetwork -p 8080:8080 yolo 
```