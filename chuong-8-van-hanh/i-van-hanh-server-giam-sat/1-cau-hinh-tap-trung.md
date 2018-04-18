* Bổ sung cấu hình cho agent

```
vi /var/ossec/etc/shared/default/agent.conf
```

* Kiểm tra config cho agent

```
/var/ossec/bin/verify-agent-conf
```

* Kiểm tra version config của agent \(mặc định 10' agent cập nhật cấu hình 1 lần, muốn nhanh hơn thì restart manager\)

```
md5sum /var/ossec/etc/shared/default/agent.conf
/var/ossec/bin/agent_control -i 001
/var/ossec/bin/agent_control -i 002
```

* Restart agent

```
/var/ossec/bin/agent_control -R -u 001
/var/ossec/bin/agent_control -R -u 002
```



