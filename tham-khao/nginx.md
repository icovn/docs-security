* Download files

```
wget http://nginx.org/download/nginx-1.12.2.tar.gz
wget https://github.com/arut/nginx-rtmp-module/archive/v1.2.1.tar.gz
wget https://github.com/vozlt/nginx-module-vts/archive/v0.1.15.tar.gz
```

* Cài đặt thư viện

```
sudo apt-get install git gcc make libpcre3-dev libssl-dev
```

* Cài đặt FFMPEG
* Cài đặt Nginx

```
tar -xzf nginx-1.12.2.tar.gz
tar -xzf v1.2.1.tar.gz
tar -xzf v0.1.15.tar.gz
cd nginx-1.12.0
./configure --prefix=/u01/applications/nginx-1.12.2 --with-http_ssl_module --add-module=../nginx-rtmp-module-1.2.1 --add-module=../nginx-module-vts-0.1.15 --with-http_stub_status_module 
make -j8
make install -j8
```

* 


