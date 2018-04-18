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
sudo apt-get install nodejs -y
sudo apt-get install wazuh-api -y
```

Ghi chú: Filebeat không cần thiết khi cài ở chế độ Single vì khi đó Logstash sẽ đọc dữ liệu trực tiếp từ hệ thống mà không cần thông qua trung gian

# 3. Cài đặt Wazuh-Agent

* Cài đặt thư viện \(gcc, make, ...\)

sudo apt-get install build-essential libmysqlclient-dev -y

* Cài đặt ossec-server

./ossec-install.sh

* Import key từ server

/var/ossec/bin/manage\_agents

* Cho phép thêm command từ server

vi /var/ossec/etc/internal\_options.conf

\#logcollector.remote\_commands đặt là 1

* Start agent

/var/ossec/bin/ossec-control restart

# 4. Vận hành



