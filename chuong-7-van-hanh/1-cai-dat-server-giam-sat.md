# 1. Cài đặt Wazuh server

* Cài đặt thư viện

```
sudo apt-get update
sudo apt-get install curl apt-transport-https lsb-release -y
sudo curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add -
sudo echo "deb https://packages.wazuh.com/3.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list
sudo apt-get update
```

* Cài đặt Wazuh Manager

```
sudo apt-get install wazuh-manager -y
```

* Cài đặt Wazuh API

```
sudo curl -sL https://deb.nodesource.com/setup_6.x 
sudo apt-get update
sudo apt-get install nodejs -y
sudo apt-get install wazuh-api -y
```

* Cấu hình API

```
/var/ossec/api/scripts/configure_api.sh
```

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

* Bổ sung custom rule

```
vi /var/ossec/etc/rules/local_rules.xml
```

* Start OSSEC auth ở server

```
echo "HuyNQ12Secret" > /var/ossec/etc/authd.pass
/var/ossec/bin/ossec-authd -P
```

* Restart server

```
/var/ossec/bin/ossec-control restart
```

Ghi chú: Filebeat không cần thiết khi cài ở chế độ Single vì khi đó Logstash sẽ đọc dữ liệu trực tiếp từ hệ thống mà không cần thông qua trung gian

# 2. Cài đặt Elastic stack

* Cài đặt Java

```
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer -y
```

* Fix Java version 161

```
cd /var/lib/dpkg/info
sudo sed -i 's|JAVA_VERSION=8u161|JAVA_VERSION=8u172|' oracle-java8-installer.*
sudo sed -i 's|PARTNER_URL=http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/|PARTNER_URL=http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/|' oracle-java8-installer.*
sudo sed -i 's|SHA256SUM_TGZ="6dbc56a0e3310b69e91bb64db63a485bd7b6a8083f08e48047276380a0e2021e"|SHA256SUM_TGZ="28a00b9400b6913563553e09e8024c286b506d8523334c93ddec6c9ec7e9d346"|' oracle-java8-installer.*
sudo sed -i 's|J_DIR=jdk1.8.0_161|J_DIR=jdk1.8.0_172|' oracle-java8-installer.*
```

* Cài đặt Elastic repository

```
sudo apt-get install curl apt-transport-https
sudo curl -s https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
sudo echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | tee /etc/apt/sources.list.d/elastic-6.x.list
sudo apt-get update
```

* Cài đặt **Elastic Search**

```
sudo apt-get install elasticsearch=6.2.3 -y
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service
sudo curl https://raw.githubusercontent.com/wazuh/wazuh/3.2/extensions/elasticsearch/wazuh-elastic6-template-alerts.json | curl -XPUT 'http://localhost:9200/_template/wazuh' -H 'Content-Type: application/json' -d @-
```

* Cài đặt **Logstash**

```
sudo apt-get install logstash=1:6.2.3-1
sudo curl -so /etc/logstash/conf.d/01-wazuh.conf https://raw.githubusercontent.com/wazuh/wazuh/3.2/extensions/logstash/01-wazuh-local.conf
sudo systemctl daemon-reload
sudo systemctl enable logstash.service
sudo systemctl start logstash.service
```

* Cài đặt **Kibana**

```
sudo apt-get install kibana=6.2.3 -y
export NODE_OPTIONS="--max-old-space-size=3072"
sudo /usr/share/kibana/bin/kibana-plugin install https://packages.wazuh.com/wazuhapp/wazuhapp-3.2.1_6.2.3.zip
sudo systemctl daemon-reload
sudo systemctl enable kibana.service
sudo systemctl start kibana.service
```

* Cho phép truy cập Kibana từ bên ngoài

```
vi /etc/kibana/kibana.yml
#cấu hình --> server.host: "0.0.0.0"

sudo systemctl restart kibana.service
```

* Cài đặt nginx

```
sudo apt-get install nginx -y
vi /etc/nginx/sites-enabled/default
#cấu hình nginx cho Kibana và Wazuh API 
server {
    listen 80;
    server_name ossec.ivynative.com;

    root /var/www/html;

    # Add index.php to the list if you are using PHP
    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        auth_basic "Restricted";
        auth_basic_user_file /etc/nginx/conf.d/nginx.htpasswd;
        proxy_pass http://127.0.0.1:5601;
    }
    location /wazuh_api/ {
        proxy_pass http://127.0.0.1:55000/;
    }
}
#

# tạo account 
sudo sh -c "echo -n 'icovn:' >> /etc/nginx/conf.d/nginx.htpasswd"

# đặt password
sudo sh -c "openssl passwd -apr1 >> /etc/nginx/conf.d/nginx.htpasswd"

# restart nginx
sudo systemctl restart nginx
```

* Kết nối Wazuh App với API

```
https://documentation.wazuh.com/current/installation-guide/installing-elastic-stack/connect_wazuh_app.html
```

# 3. Tích hợp với email

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

* Cấu hình Wazuh

```
vi /var/ossec/etc/ossec.conf
# bổ sung đoạn sau
<global>
  <email_notification>yes</email_notification>
  <smtp_server>localhost</smtp_server>
  <email_from>USERNAME@gmail.com</email_from>
  <email_to>you@example.com</email_to>
</global>
```

# 4. Tích hợp với Slack

* Bật integration

```
/var/ossec/bin/ossec-control enable integrator
vi /var/ossec/etc/ossec.conf
#thêm đoạn sau:
<integration>
  <name>slack</name>
  <hook_url>https://hooks.slack.com/services/...</hook_url>
</integration>
#restart
/var/ossec/bin/ossec-control restart
```

# 5. Cấu hình active response

* Cấu hình: Tham khảo [https://blog.wazuh.com/blocking-attacks-active-response/](https://blog.wazuh.com/blocking-attacks-active-response/)
* Xem log

```
tail -f /var/ossec/logs/active-responses.log
```


