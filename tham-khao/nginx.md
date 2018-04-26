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
            hls_path /u01/applications/room-video/live;
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
            hls_path /u01/applications/room-video/mobile;
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

* Cấu hình streaming.topicanative.edu.vn

```
server {
    listen 8888;
    server_name streaming.topicanative.edu.vn;

    error_page 404 /static/404.html;
    access_log logs/streaming.topicanative.edu.vn.access.log;
    error_log  logs/streaming.topicanative.edu.vn.error.log;

    #creates the http-location for our full-resolution (desktop) HLS stream - "http://my-ip/live/my-stream-key/index.m3u8"     
    location /live {
        types {
            application/vnd.apple.mpegurl m3u8;
            video/mp2t ts;
        }
        root /u01/appplications/room-video/live;
        add_header Cache-Control no-cache;

        # CORS setup
        add_header 'Access-Control-Allow-Origin' '*' always;
        add_header 'Access-Control-Expose-Headers' 'Content-Length';

        # allow CORS preflight requests
        if ($request_method = 'OPTIONS') {
            add_header 'Access-Control-Allow-Origin' '*';
            add_header 'Access-Control-Max-Age' 1728000;
            add_header 'Content-Type' 'text/plain charset=UTF-8';
            add_header 'Content-Length' 0;
            return 204;
        }
    }

    #creates the http-location for our mobile-device HLS stream - "http://my-ip/mobile/my-stream-key/index.m3u8"       
    location /mobile {
        types {
            application/vnd.apple.mpegurl m3u8;
        }
        alias /u01/applications/room-video/mobile;
        add_header Cache-Control no-cache;
    }

    location /vod {
        types {
            video/mp4 mp4;
        }
        alias /u01/applications/room-video/mp4;
        add_header Cache-Control no-cache;
    }  

    location /status {
        vhost_traffic_status_display;
        vhost_traffic_status_display_format html;
    }  

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   html;
    }
}

server {
    listen 9999;
    server_name streaming.topicanative.edu.vn;

    location /control {
        rtmp_control all;
    }

    # This URL provides RTMP statistics in XML
    location /stat {
        rtmp_stat all;

        # Use this stylesheet to view XML as web page
        # in browser
        rtmp_stat_stylesheet stat.xsl;
    }

    location /stat.xsl {
        # XML stylesheet to view RTMP stats.
        # Copy stat.xsl wherever you want
        # and put the full directory path here
        root /u01/applications/nginx-1.12.2/stat/;
    }
}
```

* Cấu hình live.topicanative.edu.vn

```
upstream roomManager {
    server 210.245.3.67:8083;
    server 210.245.3.69:8083;
    server 210.245.3.86:8083;
}

upstream roomWebSocket {
    server 210.245.3.67:8085;
    server 210.245.3.69:8085;
    server 210.245.3.86:8085;
}

server {
    listen 8888;
    server_name live.topicanative.edu.vn;

    root /u01/applications/livestream-public;
    index index.html index.htm;

    error_page 404 /static/404.html;
    access_log logs/live.topicanative.edu.vn.access.log;
    error_log  logs/live.topicanative.edu.vn.error.log;

    client_max_body_size 100m;

    location ~ ^/api(.*)$ {
        proxy_pass http://roomManager;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    location ~ ^/material(.*)$ {
        root /u01/applications/room-material/;
    }

    location ~ ^/socket(.*)$ {
        proxy_pass http://roomWebSocket;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        # WebSocket support (nginx 1.4)
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }

    location ~ ^/stream(.*)$ {
        proxy_pass http://roomManager;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }    

    location ~ ^/video(.*)$ {
        root /u01/applications/room-video/;
    }

    location ~ ^/ws(.*)$ {
        proxy_pass http://roomWebSocket;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    location /status {
        vhost_traffic_status_display;
        vhost_traffic_status_display_format html;
    }

    location / {

    }
}
```

* Script convert /u01/applications/convert-flv-to-mp4.sh

```
/u01/bin/ffmpeg -y -i /u01/applications/room-video/$name.flv -acodec libfdk_aac -ar 44100 -ac 1 -vcodec libx264 /u01/applications/room-video/mp4/$name.mp4
curl "http://live.topicanative.edu.vn:8888/stream/on_convert_done?name=${name}"
```



