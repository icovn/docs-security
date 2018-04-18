cd /var/www
git clone https://github.com/ECSC/analogi.git
cp analogi/db_ossec.php.new analogi/db_ossec.php
echo "<VirtualHost *:8080>" >> /etc/apache2/sites-enabled/000-default.conf
echo "DocumentRoot /var/www/analogi" >> /etc/apache2/sites-enabled/000-default.conf
echo "ErrorLog ${APACHE_LOG_DIR}/error.log" >> /etc/apache2/sites-enabled/000-default.conf
echo "CustomLog ${APACHE_LOG_DIR}/access.log combined" >> /etc/apache2/sites-enabled/000-default.conf
echo "</VirtualHost>" >> /etc/apache2/sites-enabled/000-default.conf

