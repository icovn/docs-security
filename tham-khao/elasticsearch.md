* Cài đặt 

```
uznip elasticsearch-2.4.6.zip
mv elasticsearch-2.4.6 /u01/applications/
```

* Cấu hình

```
cluster.name: live-streaming

node.name: node-fpt-69
node.rack: r1

network.host: 0.0.0.0
discovery.zen.ping.unicast.hosts: ["210.245.3.67", "210.245.3.69", "210.245.3.66"]

http.port: 9334
http.cors.allow-origin: "http://dejavu.ivynative.com:8888"
http.cors.enabled: true
http.cors.allow-headers : X-Requested-With,X-Auth-Token,Content-Type,Content-Length,Authorization
http.cors.allow-credentials: true

transport.tcp.port: 9333
```

* Start \(/u01/applications/elasticsearch-2.4.6/start.sh\)

```
/u01/applications/elasticsearch-2.4.6/bin/elasticsearch -d
```

* Stop \(/u01/applications/elasticsearch-2.4.6/stop.sh\)

```
PIDS="$(pgrep -f elasticsearch-2.4.6)"
if [ -z "$PIDS" ]; then
echo "nothing"
else
kill -SIGTERM $PIDS
fi
```



