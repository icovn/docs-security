* Cài đặt

```
sudo apt-get install tcpdump -y
```

* Bắt bản tin của server 118.70.223.167 trên card mạng em1

```
tcpdump -i em1 host 118.70.223.167 -v -w fail.cap -s 0
```



