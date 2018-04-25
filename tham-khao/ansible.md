* Cài đặt

```
apt-get install lsb-release software-properties-common 
apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install ansible
apt-get install sshpass
```

* Cấu hình hosts

```
vi /etc/ansible/hosts
#thêm hosts như sau
[wazuh-elasticsearch]
hosts1.example.net
hosts2.example.net
```

* Sinh SSH key

```
ssh-keygen
```

* Copy nội dung của ~/.ssh/id\_rsa.pub  vào file ~/.ssh/authorized\_keys trên các host

* Kiểm thử kết nối tới các hosts

```
ansible all -m ping
```

* Roles

```
cd /etc/ansible/roles
git clone https://github.com/wazuh/wazuh-ansible.git .
```



