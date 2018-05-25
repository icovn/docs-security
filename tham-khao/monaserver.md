* Cài đặt LuaJIT \(http://www.monaserver.ovh/installation.html\#luajit-installation\)

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



