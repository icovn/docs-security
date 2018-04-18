mkdir /tmp
cd /tmp && wget https://github.com/ossec/ossec-hids/archive/2.9.3.tar.gz
cd /tmp && tar -xzf 2.9.3.tar.gz
cd /tmp/ossec-hids-2.9.3 && make TARGET=server DATABASE=mysql
chmod +x /tmp/ossec-hids-2.9.3/install.sh
/tmp/ossec-hids-2.9.3/install.sh
