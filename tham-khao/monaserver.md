* Cài đặt LuaJIT \([http://www.monaserver.ovh/installation.html\#luajit-installation\](http://www.monaserver.ovh/installation.html#luajit-installation%29\)

```
wget http://luajit.org/download/LuaJIT-2.0.5.tar.gz
tar -xzf LuaJIT-2.0.5.tar.gz
cd LuaJIT-2.0.5/

#enable DLUAJIT_ENABLE_LUA52COMPAT 
vi src/Makefile

#install
make
sudo make install
```

* Cài đặt MonaServer

```
wget https://github.com/MonaSolutions/MonaServer/archive/1.2.zip
unzip 1.2.zip
cd MonaServer-1.2/
make
sudo mv MonaBase/lib/libMonaBase.so /usr/local/lib
sudo mv MonaCore/lib/libMonaCore.so /usr/local/lib
sudo ldconfig
```

* Cấu hình chạy daemon trên Ubuntu

```
vi /etc/systemd/system/monaserver.service

#thêm đoạn sau
[Unit]
Description=MonaServer service

[Service]
Type=forking
WorkingDirectory=/u01/applications/MonaServer-1.2
ExecStart=/u01/applications/MonaServer-1.2/MonaServer --daemon
Restart=on-abort

[Install]
WantedBy=multi-user.target
```

* Cấu hình MonaServer

```
;MonaServer.ini
socketBufferSize = 114688
[RTMFP]
port = 1986
keepAlivePeer = 10
keepAliveServer = 15
[RTMP]
port = 1986
[HTTP]
port = 8000
[RTSP]
port = 554
[logs]
name=log
```



