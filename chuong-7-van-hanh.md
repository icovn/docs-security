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

* Kết nối Wazuh App với API

```
https://documentation.wazuh.com/current/installation-guide/installing-elastic-stack/connect_wazuh_app.html
```

# 3. Cài đặt Wazuh agent

* Cài đặt thư viện

```
sudo apt-get install curl apt-transport-https lsb-release -y

sudo curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add -
sudo echo "deb https://packages.wazuh.com/3.x/apt/ stable main" | tee /etc/apt/sources.list.d/wazuh.list
sudo apt-get update
```

* Cài đặt Wazuh agent

```
sudo apt-get install wazuh-agent -y
```

# 4. Vận hành

* Start OSSEC auth ở server

```
echo "HuyNQ12Secret" > /var/ossec/etc/authd.pass
/var/ossec/bin/ossec-authd -P
```

* Đăng ký agent

```
/var/ossec/bin/agent-auth -m 118.70.223.163 -P "HuyNQ12Secret"
```

* 


