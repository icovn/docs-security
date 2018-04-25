* Cài đặt

```
export OSQUERY_KEY=1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $OSQUERY_KEY
sudo add-apt-repository 'deb [arch=amd64] https://pkg.osquery.io/deb deb main'
sudo apt-get update
sudo apt-get install osquery -y
```

* Danh sách tiến trình và cổng

```
SELECT DISTINCT process.name, listening.port, process.pid 
FROM processes AS process JOIN listening_ports AS listening ON process.pid = listening.pid 
WHERE listening.address = '0.0.0.0' ORDER BY process.name;
```

* 


