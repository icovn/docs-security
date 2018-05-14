# 1. Cài đặt

Download file cài

```
wget http://dl.bintray.com/rundeck/rundeck-deb/rundeck_2.11.3-1-GA_all.deb
```

Thực hiện cài đặt

```
apt-get install openjdk-8-jdk
dpkg -i rundeck_2.11.3-1-GA_all.deb
```

# 2. Vận hành

Kiểm tra trạng thái

```
/etc/init.d/rundeckd status
```

# 3. Đổi URL truy cập \(run behind Nginx\)

Cấu hình nginx

```
location / {
    proxy_pass http://rundeck/;

    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Forwarded-Host $host:$server_port;
    proxy_set_header X-Forwarded-Server $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
}
```

Cấu hình rundeck

```
sed -i "/^grails.serverURL/c grails.serverURL = ${RUNDECK_URL}" /etc/rundeck/rundeck-config.properties
sed -i "/^framework.server.url/c framework.server.url = ${RUNDECK_URL}" /etc/rundeck/framework.properties
sed -i '/^RDECK_JVM="$RDECK_JVM/ s/"$/ -Dserver.web.context=\/rundeck"/' /etc/rundeck/profile
```

# 4. Đổi password admin

Generate a random password

```
RD_PASS=$(openssl rand -base64 16)
```

Show unencrypted password

```
echo ${RD_PASS}
```

Generate MD5 sum

```
RD_PASS_MD5=$(java -cp /var/lib/rundeck/bootstrap/jetty-all-9.0.7.v20131107.jar org.eclipse.jetty.util.security.Password admin ${RD_PASS} 2>&1 | grep MD5)
```

Change default rundeck admin password

```
sed -i "s/^admin:admin/admin:${RD_PASS_MD5}/g" /etc/rundeck/realm.properties
```

Restart rundeck

```
service rundeckd restart
```

# 5. Cài đặt plugin

Download plugin để vào folder /var/lib/rundeck/libext/

```
cd  /var/lib/rundeck/libext/
wget https://github.com/Batix/rundeck-ansible-plugin/releases/download/2.4.0/ansible-plugin-2.4.0.jar
```

Restart 

```
/etc/init.d/rundeckd restart
```

# 6. Tham khảo

[http://rundeck.org/docs/](http://rundeck.org/docs/)

[https://www.rundeck.com/ansible](https://www.rundeck.com/ansible)

[https://github.com/rundeck-plugins](https://github.com/rundeck-plugins)

