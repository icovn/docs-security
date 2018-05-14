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

* Cài đặt python 2 trên client

```
sudo apt install python2.7 python-pip
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

# 3. Ghi chú

**Playsbooks** contain **plays**

Plays contain **tasks**

Tasks call **modules**

**Tasks** run **sequentially**

**Handlers** are triggered by **tasks**, and are run oncce, at the end of plays

# 4. Admin GUI

[https://github.com/vstconsulting/polemarch](https://github.com/vstconsulting/polemarch)

# 5. Tham khảo

* Install
  * [http://docs.ansible.com/ansible/latest/installation\_guide/intro\_installation.html](#)

  * [https://github.com/ansible/ansible-doctor](https://github.com/ansible/ansible-doctor)
* Sử dụng
  * [https://www.ansible.com/resources/get-started](#)

  * [http://docs.ansible.com/ansible/latest/modules/modules\_by\_category.html](http://docs.ansible.com/ansible/latest/modules/modules_by_category.html)

  * [http://docs.ansible.com/ansible/latest/user\_guide/playbooks\_reuse.html](http://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse.html)

  * [https://github.com/ansible/ansible-examples](#)
* Docker container
  * [https://github.com/ansible/hello-world](#)

  * [https://github.com/ansible/ansible-kubernetes-modules](#)



