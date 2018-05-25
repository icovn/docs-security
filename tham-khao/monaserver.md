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



