* Cài đặt server

```
sudo apt-get install nfs-kernel-server -y
mkdir -p /u01/applications/nfs/general
```

* Cấu hình server \(sudo vi /etc/exports\)

```
/u01/applications/nfs/general 210.245.3.67(rw,sync,no_subtree_check) 210.245.3.69(rw,sync,no_subtree_check)
```

* Khởi động lại nfs-server

```
sudo systemctl restart nfs-kernel-server
```

* Cài đặt client

```
sudo apt-get install nfs-common -y
```

* Cấu hình client

```
mkdir -p /u01/applications/nfs/general
sudo mount 210.245.3.86:/u01/applications/nfs/general /u01/applications/nfs/general
```

* 


