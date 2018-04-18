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

* Start

/var/ossec/bin/ossec-control start

* Stop

/var/ossec/bin/ossec-control stop

* Thêm client & generate key cho client

/var/ossec/bin/manage\_agents

* **Cài đặt UI**

  * Cài đặt Apache, MySQL, PHP

  sudo apt-get install apache2 mysql-server php php-{bcmath,bz2,intl,gd,mbstring,mcrypt,mysql,zip} libapache2-mod-php -y

  sudo systemctl enable apache2.service

  sudo systemctl enable mysql.service

  * Cài đặt UI và cấu hình

  ./ossec-ui-install.sh

  * Restart apache

  systemctl restart apache2

* **Cài đặt Analogi Web Dashboard**

  * Tạo database

  mysql -u root -p  
  CREATE DATABASE ossec;  
  GRANT ALL PRIVILEGES ON ossec.\* TO 'ossecuser'@'%' IDENTIFIED BY 'ossec' WITH GRANT OPTION;  
  GRANT ALL PRIVILEGES ON ossec.\* TO 'ossecuser'@'localhost' IDENTIFIED BY 'ossec' WITH GRANT OPTION;

  * Cấu hình database cho ossec

  vi /var/ossec/etc/ossec.conf  
  \#thêm đoạn sau  
  &lt;database\_output&gt;  
      &lt;hostname&gt;127.0.0.1&lt;/hostname&gt;  
      &lt;username&gt;ossecuser&lt;/username&gt;  
      &lt;password&gt;ossec&lt;/password&gt;  
      &lt;database&gt;ossec&lt;/database&gt;  
      &lt;type&gt;mysql&lt;/type&gt;  
  &lt;/database\_output&gt;

  * import database

  mysql -u root -p ossec &lt; /tmp/ossec-hids-2.9.3/src/os\_dbd/mysql.schema

  * Enable database và restart

  /var/ossec/bin/ossec-control enable database  
  /var/ossec/bin/ossec-control restart

  * Cài đặt analogi UI

  ./ossec-analogi.sh

  * Restart apache

  systemctl restart apache2

Ghi chú: tham khảo [link](https://glynrob.com/monitoring/ossec/)

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



