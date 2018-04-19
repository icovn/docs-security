* Bật logall \(/var/ossec/etc/ossec.conf\)

```
<ossec_config>
  <global>
    <logall>yes</logall>
    <logall_json>yes</logall_json>
  </global>
</ossec_config>  
```

* Restart server

```
/var/ossec/bin/ossec-control restart
```

* Theo dõi log

```
tailf /var/ossec/logs/archives/archives.json
```

* Test log

```

```



