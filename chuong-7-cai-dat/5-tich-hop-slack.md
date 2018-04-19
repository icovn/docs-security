* Bật integration

```
/var/ossec/bin/ossec-control enable integrator
```

* Cập nhật cấu hình OSSEC \(/var/ossec/etc/ossec.conf\)

```
<integration>
  <name>slack</name>
  <hook_url>https://hooks.slack.com/services/...</hook_url>
</integration>
```

* Restart server

```
/var/ossec/bin/ossec-control restart
```



