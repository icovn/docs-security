* Install

```
https://openvidu.io/docs/deployment/deploying-ubuntu/
```

* Start, stop

```
sudo service coturn restart
sudo service kurento-media-server restart
```

* Run openvidu-server

```
java -jar -Dopenvidu.secret=YOUR_SECRET -Dopenvidu.publicurl=https://YOUR_MACHINE_PUBLIC_IP:4443/ openvidu-server.jar &
```

* Tham khảo

  * Android [https://github.com/OpenVidu/openvidu-android-app](https://github.com/OpenVidu/openvidu-android-app)

  * 

* 


