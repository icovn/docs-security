### 1. Cấu hình "Active response"

* Tham khảo 
  * [https://blog.wazuh.com/blocking-attacks-active-response/](https://blog.wazuh.com/blocking-attacks-active-response/)
  * https://ossec-docs.readthedocs.io/en/latest/manual/ar/ar-custom.html
* Xem log

```
tail -f /var/ossec/logs/active-responses.log
```

### 2. Cấu hình Rule

* Bổ sung custom rule

```
vi /var/ossec/etc/rules/local_rules.xml
```

* Kiểm thử rule

```
/var/ossec/bin/ossec-logtest
#sau đó paste log vào, vd: Mar  8 22:39:13 ip-10-0-0-10 sshd[2742]: Accepted publickey for root from 73.189.131.56 port 57516
```

* Debug rule

```
/var/ossec/bin/ossec-logtest -v
```

* 


