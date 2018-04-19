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



