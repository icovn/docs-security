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

* Cấu hình nginx

```
#user  nobody;
worker_processes  1;
 
error_log  logs/error.log;
error_log  logs/error.log  notice;
error_log  logs/error.log  info;
 
pid        logs/nginx.pid;
 
 
events {
    worker_connections  1024;
}
 
http {
    include       mime.types;
    default_type  application/octet-stream;
 
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
 
    access_log  logs/access.log  main;
 
    sendfile        on;
    #tcp_nopush     on;
 
    #keepalive_timeout  0;
    keepalive_timeout  65;
 
    #gzip  on;

    include /u01/applications/nginx-1.12.2/conf/site-enabled/*.conf; 

    vhost_traffic_status_zone;
}
 
rtmp {
    server {
        listen 1935;      
 
        chunk_size 4096;
 
        application live {
            live on;
 
            on_play http://live.topicanative.edu.vn:8888/stream/on_play;
            on_publish http://live.topicanative.edu.vn:8888/stream/on_publish;
            on_publish_done http://live.topicanative.edu.vn:8888/stream/on_publish_done;
            on_record_done http://live.topicanative.edu.vn:8888/stream/on_record_done;
 
            recorder recorder1 {
               record all manual;
               record_path /u01/applications/room-video/;
            }
 
            hls on;
            hls_nested on;
            hls_path /u01/applications/HLS/live;
            hls_playlist_length 4s;
            hls_fragment 1s;
            hls_cleanup off;
 
            exec_record_done /u01/applications/convert-flv-to-mp4.sh $name;
 
            #creates the downsampled or "trans-rated" mobile video stream as a 400kbps, 480x360 sized video
            exec ffmpeg -i rtmp://localhost:1935/$app/$name -acodec copy -c:v libx264 -preset veryfast -profile:v baseline -vsync cfr -s 480x360 -b:v 400k maxrate 400k -bufsize 400k -threads 0 -r 30 -f flv rtmp://localhost:1935/mobile/$;
        }
 
        #creates our "mobile" lower-resolution HLS videostream from the ffmpeg-created stream and tells where to put the HLS video manifest and video fragments
        application mobile {
            allow play all;
            live on;
            hls on;
            hls_nested on;
            hls_path /u01/applications/HLS/mobile;
            hls_playlist_length 4s;
            hls_fragment 1s;
        }
 
        #allows you to play your recordings of your live streams using a URL like "rtmp://my-ip:1935/vod/filename.flv"
        application vod {
            play /u01/applications/room-video;
        }  
    }
}

```

* Cấu hình live.topicanative.edu.vn

* Cấu hình streaming.topicanative.edu.vn



