* Theo dõi log audit ở agent \(/var/ossec/etc/shared/default/agent.conf\)

```
<localfile>
  <log_format>audit</log_format>
  <location>/var/log/audit/audit.log</location>
</localfile>
```

* Bổ sung rule để alert audit command \(/var/ossec/etc/rules/local\_rules.xml\)

```
  <rule id="100102" level="3" >
    <if_sid>80700</if_sid>
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

* Bổ sung rule cho auditd

```
# theo dõi truy cập đến folder /u01
mkdir /u01
auditctl -w /u01 -p w -k audit-wazuh-w
auditctl -w /u01 -p a -k audit-wazuh-a
auditctl -w /u01 -p r -k audit-wazuh-r
auditctl -w /u01 -p x -k audit-wazuh-x

# theo dõi lệnh từ user root và lệnh sudo
auditctl -a exit,always -F euid=0 -F arch=b64 -S execve -k audit-wazuh-c
auditctl -a exit,always -F euid=0 -F arch=b32 -S execve -k audit-wazuh-c
```



