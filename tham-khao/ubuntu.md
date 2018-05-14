# Increase "Max open files" limit

##### Xem giá trị limit hiện tại

```
cat /proc/sys/fs/file-max

ulimit -n
```

##### Thay đổi kết quả của 'ulimit -n'

```
sudo nano /etc/sysctl.conf
#thêm
fs.file-max = 131072

sudo sysctl -p

sudo nano /etc/security/limits.conf
#thêm
* soft     nproc          131072    
* hard     nproc          131072   
* soft     nofile         131072   
* hard     nofile         131072
root soft     nproc          131072    
root hard     nproc          131072   
root soft     nofile         131072   
root hard     nofile         131072

sudo nano /etc/pam.d/common-session
#thêm
session required pam_limits.so
```

##### Logout, login và chạy lại lệnh kiểm tra

# Tạo SSH key

Máy client

```
ssh-keygen

```



