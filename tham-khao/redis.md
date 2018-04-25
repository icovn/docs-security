* Cài đặt redis

```
tar -xzf redis-4.0.9.tar.gz
mv redis-4.0.9 /u01/applications/
mkdir /u01/applications/redis-4.0.9-cluster/
cd /u01/applications/redis-4.0.9/
make 
cp /u01/applications/redis-4.0.9/src/redis-server /u01/applications/redis-4.0.9-cluster/
cp /u01/applications/redis-4.0.9/redis.conf /u01/applications/redis-4.0.9-cluster/
```

* Cấu hình redis \(/u01/applications/redis-4.0.9/redis.conf\)

```
bind 0.0.0.0
port 6379
daemonize yes
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
appendonly yes
```

* Cấu hình cluster \(/u01/applications/redis-4.0.9-cluster/redis.conf\)

```
bind 0.0.0.0
port 6380
daemonize yes
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
appendonly yes
```

* Chạy cluster

```
/u01/applications/redis-4.0.9/src/redis-server /u01/applications/redis-4.0.9/redis.conf
/u01/applications/redis-4.0.9-cluster/redis-server /u01/applications/redis-4.0.9-cluster/redis.conf

/u01/applications/redis-4.0.9/src/redis-trib.rb create --replicas 1 210.245.3.86:6379 210.245.3.86:6380 210.245.3.67:6379 210.245.3.67:6380 210.245.3.69:6379 210.245.3.69:6380
```

* Stop 

```
redis-cli shutdown
redis-cli -p 6380 shutdown
```



