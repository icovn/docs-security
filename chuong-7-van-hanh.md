# 1. Giới thiệu về Wazuh

Wazuh is a security detection, visibility, and compliance open source project. It was born as a fork of [OSSEC HIDS](http://ossec.github.io/), and later was integrated with [Elastic Stack](https://www.elastic.co/) and [OpenSCAP](https://www.open-scap.org/), evolving into a more comprehensive solution![](/assets/wazuh-component.png)

* **OSSEC HIDS** is a Host-based Intrusion Detection System \(HIDS\) used for security detection, visibility, and compliance monitoring. It’s based on a multi-platform agent that forwards system data \(e.g log messages, file hashes, and detected anomalies\) to a central manager, where it is further analyzed and processed, resulting in security alerts. Agents convey event data to the central manager for analysis via a secure and authenticated channel.
* **OpenSCAP **is an [OVAL](https://oval.mitre.org/)\(Open Vulnerability Assessment Language\) and XCCDF \(Extensible Configuration Checklist Description Format\) interpreter used to check system configurations and to detect vulnerable applications.
* **Elastic Stack** is a software suite \(Filebeat, Logstash, Elasticsearch, Kibana\) used to collect, parse, index, store, search, and present log data. It provides a web front-end that gives a high-level dashboard view of events that allows for advanced analytics and data mining deep into your store of event data.

# 2. Kiến trúc

* Single server

![](/assets/single.png)

* Distributed

![](/assets/distributed.png)

* Communications and data flow![](/assets/communication.png)

# 2. Cài đặt Wazuh-SERVER

* Cài đặt thư viện \(gcc, make, ...\)

sudo apt-get install build-essential mysql-dev postgresql-dev libmysqlclient-dev -y

* Cài đặt ossec-server

./ossec-install.sh

* Cấu hình

/var/ossec/etc/ossec.conf

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



