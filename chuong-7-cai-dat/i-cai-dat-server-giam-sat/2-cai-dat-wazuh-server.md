* Cài đặt thư viện

```
sudo apt-get update
sudo apt-get install curl apt-transport-https lsb-release -y
sudo curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add -
sudo echo "deb https://packages.wazuh.com/3.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list
sudo apt-get update
```

* Cài đặt **Wazuh Manager**

```
sudo apt-get install wazuh-manager -y
```

* Cài đặt **Wazuh API**

```
sudo curl -sL https://deb.nodesource.com/setup_6.x 
sudo apt-get update
sudo apt-get install nodejs -y
sudo apt-get install wazuh-api -y
```

* Cấu hình **Wazuh API**

```
/var/ossec/api/scripts/configure_api.sh
```

* Chạy OSSEC auth

```
echo "HuyNQ12Secret" > /var/ossec/etc/authd.pass
/var/ossec/bin/ossec-authd -P
```

* Restart server

```
/var/ossec/bin/ossec-control restart
```

Ghi chú: Filebeat không cần thiết khi cài ở chế độ Single vì khi đó Logstash sẽ đọc dữ liệu trực tiếp từ hệ thống mà không cần thông qua trung gian

