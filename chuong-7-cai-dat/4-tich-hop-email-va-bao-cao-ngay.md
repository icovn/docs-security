### 1. Tích hợp Wazuh với email

* Cài đặt thư viện

```
sudo apt-get install postfix mailutils libsasl2-2 ca-certificates libsasl2-modules -y
```

* Cấu hình Postfix

```
vi /etc/postfix/main.cf
#thêm đoạn sau, comment cấu hình cũ nếu trùng
relayhost = [smtp.gmail.com]:587
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_tls_CAfile = /etc/ssl/certs/thawte_Primary_Root_CA.pem
smtp_use_tls = yes
```

* Cấu hình email và mật khẩu

```
echo [smtp.gmail.com]:587 USERNAME@gmail.com:PASSWORD > /etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd
chmod 400 /etc/postfix/sasl_passwd
```

* Bảo mật mật khẩu

```
chown root:root /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
chmod 0600 /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
```

* Khởi động lại Postfix

```
systemctl reload postfix
```

* Test

```
echo "Test mail from postfix" | mail -s "Test Postfix" you@example.com
```

* Cấu hình OSSEC \(/var/ossec/etc/ossec.conf\)

```
<global>
  <email_notification>yes</email_notification>
  <smtp_server>localhost</smtp_server>
  <email_from>USERNAME@gmail.com</email_from>
  <email_to>you@example.com</email_to>
</global>
```

* Restart server

```
/var/ossec/bin/ossec-control restart
```

### 2. Cấu hình báo cáo ngày

* Cập nhật cấu hình OSSEC \(/var/ossec/etc/ossec.conf\)

```
<ossec_config>
  <reports>
    <category>syscheck</category>
    <level>10</level>
    <title>Daily report: Alerts with level higher than 10</title>
    <email_to>example@test.com</email_to>
  </reports>
</ossec_config>
```

* Restart server

```
/var/ossec/bin/ossec-control restart
```



