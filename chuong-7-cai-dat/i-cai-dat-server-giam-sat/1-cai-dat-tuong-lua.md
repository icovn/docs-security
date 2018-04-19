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
sudo ufw allow 1514/udp
sudo ufw allow 1515/tcp
```



