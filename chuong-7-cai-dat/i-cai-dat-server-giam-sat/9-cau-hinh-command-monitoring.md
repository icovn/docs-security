### 1. Kiểm tra có bật tường lửa

* Bổ sung cấu hình agent.conf \(/var/ossec/etc/shared/default/agent.conf\)

```
<localfile>
     <log_format>full_command</log_format>
     <command>ufw status</command>
     <frequency>120</frequency>
</localfile>
```

### 2. Kiểm tra có chạy đồng bộ thời gian tới server theo quy định hay không

### 3. Kiểm tra có cấu hình log đúng quy định

### 4. Kiểm tra nếu dùng PHP thì php.ini có để đúng quy định hay không



