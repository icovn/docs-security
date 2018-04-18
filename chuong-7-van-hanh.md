# 1. Giới thiệu về OSSEC

OSSEC - Open Source HIDS SECurity

* _**Watching**_: OSSEC watches it all, actively monitoring all aspects of Unix system activity with file integrity monitoring, log monitoring, rootcheck, and process monitoring. With OSSEC you won't be in the dark about what is happening to your valuable computer system assets.
* _**Alerting**_: When attacks happen OSSEC lets you know through alert logs and email alerts sent to you and your IT staff so you can take quick actions. OSSEC also exports alerts to any SIEM system via syslog so you can get real-time analytics and insights into your system security events.
* _**Everywhere**_: Got a variety of operating systems to support and protect? OSSEC has you covered with comprehensive host based intrusion detection across multiple platforms including Linux,Solaris, AIX, HP-UX, BSD, Windows, Mac and VMware ESX.

# 2. Cài đặt OSSEC-SERVER

* Cài đặt thư viện \(gcc, make, ...\)

sudo apt-get install build-essential libmysqlclient-dev -y

* Cài đặt ossec-server

./ossec-install.sh

* Cấu hình

/var/ossec/etc/ossec.conf

* Start

/var/ossec/bin/ossec-control start

* Stop

/var/ossec/bin/ossec-control stop

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

# 3. Cài đặt OSSEC-CLIENT

* Cài đặt thư viện \(gcc, make, ...\)

sudo apt-get install build-essential libmysqlclient-dev -y

* Cài đặt ossec-server

./ossec-install.sh

# 4. Vận hành



