**rootcheck **cho phép:

* kiểm tra xem 1 tiến trình có đang chạy hay không \(dựa vào id, port\)
* kiểm tra xem 1 file hoặc Windows registry key có tồn tại hay không
* kiểm tra xem nội dung của file hoặc Windows registry key có theo 1 pattern định trước không

### 1. Kiểm tra cấu hình SSH \(mặc định của Wazuh\)

### 2. Kiểm tra cấu hình Web Server

##### 2.1. Apache

##### 2.2. Tomcat

##### 2.3. IIS

##### 2.4. Nginx

##### 2.5. Unicorn

### 3. Kiểm tra cấu hình PHP

### 4. Kiểm tra cấu hình database



### 1. Kiểm tra có bật tường lửa

* Tạo file audit\_firewall.txt \(/var/ossec/etc/shared/default/audit\_firewall.txt\) với nội dung như sau 

```
# PermitRootLogin not allowed
# PermitRootLogin indicates if the root user can log in by ssh.
$sshd_file=/etc/ssh/sshd_config;

[SSH Configuration - 1: Root can log in] [any] [1]
f:$sshd_file -> !r:^# && r:PermitRootLogin\.+yes;
f:$sshd_file -> r:^#\s*PermitRootLogin;
```

* Cập nhật agent.conf \(/var/ossec/etc/shared/default/agent.conf\)

```
<rootcheck>
   <system_audit>/var/ossec/etc/shared/default/audit_firewall.txt</system_audit>
</rootcheck>
```

### 2. Kiểm tra có chạy đồng bộ thời gian tới server theo quy định hay không

### 3. Kiểm tra có cấu hình log đúng quy định

### 4. Kiểm tra nếu dùng PHP thì php.ini có để đúng quy định hay không



