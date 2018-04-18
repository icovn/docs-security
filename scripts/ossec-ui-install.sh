cd /tmp && wget https://github.com/ossec/ossec-wui/archive/0.9.tar.gz
cd /tmp && tar -xf 0.9.tar.gz
mkdir /var/www/ossecwui/
mv /tmp/ossec-wui-0.9/* /var/www/ossecwui/
cd /var/www/ossecwui/ && htpasswd -c .htpasswd admin admin
/var/www/ossecwui/setup.sh
echo > /etc/apache2/sites-enabled/000-default.conf
echo "<VirtualHost *:80>" >> /etc/apache2/sites-enabled/000-default.conf
echo "DocumentRoot /var/www/ossecwui" >> /etc/apache2/sites-enabled/000-default.conf
echo "ErrorLog ${APACHE_LOG_DIR}/error.log" >> /etc/apache2/sites-enabled/000-default.conf
echo "CustomLog ${APACHE_LOG_DIR}/access.log combined" >> /etc/apache2/sites-enabled/000-default.conf
echo "</VirtualHost>" >> /etc/apache2/sites-enabled/000-default.conf

