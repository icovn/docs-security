# 1. Cài đặt

#  2. Đổi URL truy cập \(run behind Nginx\)

# 3. Đổi password admin

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



