Cài đặt

```
apt-get install lsb-release software-properties-common 
apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install ansible
apt-get install sshpass
```

Cấu hình connection user cho Ansible

```
ansible -m setup all -u ubuntu -k -b -K
```

Cấu hình hosts

```
vi /etc/ansible/hosts
#thêm hosts như sau
[wazuh-elasticsearch]
hosts1.example.net
hosts2.example.net
```

Kiểm thử kết nối tới các hosts

```
ansible all -m ping
```

Roles

```
cd /etc/ansible/roles
git clone https://github.com/wazuh/wazuh-ansible.git .
```



