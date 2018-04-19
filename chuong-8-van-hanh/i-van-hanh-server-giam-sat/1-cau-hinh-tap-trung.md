### 1. Cài đặt thư viện

### 2. Cài đặt OSSEC agent

* Bổ sung cấu hình cho agent

```
vi /var/ossec/etc/shared/default/agent.conf
```

* Theo dõi log audit ở agent \(/var/ossec/etc/shared/default/agent.conf\)

```
<localfile>
  <log_format>audit</log_format>
  <location>/var/log/audit/audit.log</location>
</localfile>
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



```

```



