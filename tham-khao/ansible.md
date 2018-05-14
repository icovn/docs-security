# 1. Cài đặt Ansible

* Cài đặt

```
apt-get install lsb-release software-properties-common -y
apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install ansible -y
apt-get install sshpass -y
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

# 2. Cài đặt Ansible-semaphore \(Open Source alternative to Ansible Tower\)

* Cài đặt mysql server

```
sudo apt-get install mysql-server -y
```

* Cài đặt semaphore

```
curl https://github.com/ansible-semaphore/semaphore/releases/download/v2.5.0/semaphore_2.5.0_linux_amd64.deb
sudo dpkg -i semaphore_2.5.0_linux_amd64.deb
```

* Roles

```
cd /etc/ansible/roles
git clone https://github.com/wazuh/wazuh-ansible.git .
```



