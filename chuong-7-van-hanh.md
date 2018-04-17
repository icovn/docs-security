# 1. Giới thiệu về OSSEC

OSSEC - Open Source HIDS SECurity

* _**Watching**_: OSSEC watches it all, actively monitoring all aspects of Unix system activity with file integrity monitoring, log monitoring, rootcheck, and process monitoring. With OSSEC you won't be in the dark about what is happening to your valuable computer system assets.
* _**Alerting**_: When attacks happen OSSEC lets you know through alert logs and email alerts sent to you and your IT staff so you can take quick actions. OSSEC also exports alerts to any SIEM system via syslog so you can get real-time analytics and insights into your system security events.
* _**Everywhere**_: Got a variety of operating systems to support and protect? OSSEC has you covered with comprehensive host based intrusion detection across multiple platforms including Linux,Solaris, AIX, HP-UX, BSD, Windows, Mac and VMware ESX.

# 2. Cài đặt

* Cài đặt thư viện \(gcc, make, ...\)

sudo apt-get install build-essential

* Cài đặt ossec-server

./ossec-install.sh

* Cấu hình

/var/ossec/etc/ossec.conf

* Start

/var/ossec/bin/ossec-control start

* Stop

/var/ossec/bin/ossec-control stop

* Cài đặt Apache, MySQL, PHP

sudo apt-get install apache2 mysql-server php php-{bcmath,bz2,intl,gd,mbstring,mcrypt,mysql,zip} libapache2-mod-php -y

sudo systemctl enable apache2.service

sudo systemctl enable mysql.service

* Cài đặt UI

./ossec-ui-install.sh

* Restart apache

systemctl restart apache2

# 3. Vận hành



