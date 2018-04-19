### 1. Kiểm tra có bật tường lửa

* Bổ sung cấu hình agent.conf \(/var/ossec/etc/shared/default/agent.conf\)

```
<localfile>
  <log_format>full_command</log_format>
  <command>ufw status</command>
  <frequency>120</frequency>
</localfile>
```

* Bổ sung rule để alert audit command \(/var/ossec/etc/rules/local\_rules.xml\)

```
<rule id="100103" level="3">
  <!-- <list field="audit.key" lookup="match_key_value" check_value="command">etc/lists/audit-keys</list> -->
  <list field="audit.key" lookup="match_key">etc/lists/audit-keys</list>
  <description>Audit: Command: $(audit.exe)</description>
  <group>audit_command,</group>
</rule>
```

* Khởi động lại server và agent

```
/var/ossec/bin/ossec-control restart
/var/ossec/bin/agent_control -R -a
```

### 2. Kiểm tra có chạy đồng bộ thời gian tới server theo quy định hay không

### 3. Kiểm tra có cấu hình log đúng quy định

### 4. Kiểm tra nếu dùng PHP thì php.ini có để đúng quy định hay không



