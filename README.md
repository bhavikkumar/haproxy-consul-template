# haproxy-consul-template
HAProxy 1.8 using Consul Template 19.4 to generate the configuration

The default haproxy.ctmpl expects services to be tagged with edge and have version=replace-me before they will be in HAProxy under /replace-me/service-name which will get routed to /service-name.

## Build
```
docker build -t haproxy-consul-template .
```

## Usage
Runs the template file which is mounted to /tmp/haproxy.ctmpl.
```
docker run -d -p 80:80 -p 1936:1936 -v `pwd`/haproxy.ctmpl:/tmp/haproxy.ctmpl bhavikk/haproxy-consul-template -config="/tmp/haproxy.json" -consul-addr="10.0.0.5:8500"
```
