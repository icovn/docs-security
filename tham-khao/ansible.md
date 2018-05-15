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

  * [http://docs.ansible.com/ansible/latest/user\_guide/playbooks.html](http://docs.ansible.com/ansible/latest/user_guide/playbooks.html)

  * [http://docs.ansible.com/ansible/latest/modules/modules\_by\_category.html](http://docs.ansible.com/ansible/latest/modules/modules_by_category.html)

  * [http://docs.ansible.com/ansible/latest/user\_guide/playbooks\_reuse.html](http://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse.html)

  * [https://github.com/ansible/ansible-examples](#)

* Docker container

  * [https://github.com/ansible/hello-world](#)

  * [https://github.com/ansible/ansible-kubernetes-modules](#)

# 6. Các lệnh cơ bản

* ansible

```
ansible <host-pattern> [options]

#Adhoc command

##check ram
ansible 210.245* -a "free -m"

##get hostname
ansible all -a "hostname"

##get process of sondt2
ansible all -a "ps aux | grep sondt2"

##check ram in ungrouped
ansible ungrouped -a "free -m"


#File Transfer

##copy file from Manager
ansible all -m copy -a "src=/etc/hosts dest=/tmp/hosts"

##get content of remote file
ansible all -a "cat /tmp/hosts"


#Managing Packages

##Ensure a package is installed, but don’t update it
ansible all -m apt -a "name=mlocate state=absent" -b

##Ensure a package is installed to a specific version
ansible all -m apt -a "name=mlocate state=present" -b

##Ensure a package is at the latest version
ansible all -m apt -a "name=mlocate state=latest" -b

##Ensure a package is not installed:
ansible all -m apt -a "name=mlocate state=absent" -b


#Users and Group
ansible all -m user -a "name=foo password=<crypted password here>
ansible all -m user -a "name=foo state=absent"


#Deploying From Source Contro
ansible webservers -m git -a "repo=https://foo.example.org/repo.git dest=/srv/myapp version=HEAD"


#Managing Services

##Managing Services
ansible webservers -m service -a "name=httpd state=started"

##Alternatively, restart a service on all webservers
ansible webservers -m service -a "name=httpd state=restarted"

##Ensure a service is stopped
ansible webservers -m service -a "name=httpd state=stopped"


#Time Limited Background Operations

##ong running operations can be run in the background, and it is possible to check their status later. For example, to execute long_running_operation asynchronously in the background, with a timeout of 3600 seconds (-B), and without polling (-P)
ansible all -B 3600 -P 0 -a "/usr/bin/long_running_operation --do-stuff"

##If you do decide you want to check on the job status later, you can use the async_status module, passing it the job id that was returned when you ran the original job in the background
ansible web1.example.com -m async_status -a "jid=488359678239.2844"

##Polling is built-in and looks like this 
ansible all -B 1800 -P 60 -a "/usr/bin/long_running_operation --do-stuff"
##The above example says “run for 30 minutes max (-B 30*60=1800), poll for status (-P) every 60 seconds”
```

* ansible-config

```
ansible-config [view|dump|list] [--help] [options] [ansible.cfg]
```

* **ansible-console**

```
ansible-console [<host-pattern>] [options]

ansible-console all
ps aux | grep sondt2
exit
```

* ansible-playbook

```
ansible-playbook [options] playbook.yml [playbook2 ...]
```

* ansible-pull: pulls playbooks from a VCS repo and executes them for the local host

```
ansible-pull -U <repository> [options] [<playbook.yml>]
```

* 


