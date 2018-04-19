# 1. Cài đặt tường lửa

* Cài đặt ufw

```
sudo apt-get install ufw -y
```

* Cấu hình ufw

```
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 1322
```

# 2. Cài đặt Wazuh agent

* Cài đặt thư viện

```
sudo apt-get install curl apt-transport-https lsb-release -y

sudo curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add -
sudo echo "deb https://packages.wazuh.com/3.x/apt/ stable main" | tee /etc/apt/sources.list.d/wazuh.list
sudo apt-get update
```

* Cài đặt OpenSCAP

```
sudo apt-get install libopenscap8 xsltproc -y
```

* Cài đặt auditd

```
sudo apt-get install auditd -y
```

* Cập nhật rule mặc định cho auditd

```
mkdir /u01
auditctl -w /u01 -p w -k audit-wazuh-w
auditctl -w /u01 -p a -k audit-wazuh-a
auditctl -w /u01 -p r -k audit-wazuh-r
auditctl -w /u01 -p x -k audit-wazuh-x
auditctl -a exit,always -F euid=0 -F arch=b64 -S execve -k audit-wazuh-c
auditctl -a exit,always -F euid=0 -F arch=b32 -S execve -k audit-wazuh-c
```

* Cài đặt Wazuh agent

```
sudo apt-get install wazuh-agent -y
```

# 3. Đăng ký agent với manager

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

* 


