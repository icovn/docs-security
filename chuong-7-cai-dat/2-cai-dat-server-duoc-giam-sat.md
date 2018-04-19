# 1. Cài đặt Wazuh agent

* Cài đặt thư viện

```
sudo apt-get install curl apt-transport-https lsb-release -y

sudo curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add -
sudo echo "deb https://packages.wazuh.com/3.x/apt/ stable main" | tee /etc/apt/sources.list.d/wazuh.list
sudo apt-get update
```

* Cài đặt Wazuh agent

```
sudo apt-get install wazuh-agent -y
```

# 2. Đăng ký agent với manager

* Đăng ký agent \(ip 210.245.3.67\) với manager có ip 118.70.223.163

```
/var/ossec/bin/agent-auth -m 118.70.223.163 -P "MySecret" -A LIVE-STREAM-FPT-210.245.3.67
```

* Fix cấu hình MANAGER\_IP 

```
vi /var/ossec/etc/ossec.conf
#thay MANAGER_IP bằng IP của server
```

* Cho phép chạy remote command ở agent

```
echo "logcollector.remote_commands=1" >> /var/ossec/etc/local_internal_options.conf
echo "wazuh_command.remote_commands=1" >> /var/ossec/etc/local_internal_options.conf
```

* Restart agent

```
/var/ossec/bin/ossec-control restart
```

# 3. Cài đặt tool

* Cài đặt OpenSCAP

```
sudo apt-get install libopenscap8 xsltproc -y
```

* 


