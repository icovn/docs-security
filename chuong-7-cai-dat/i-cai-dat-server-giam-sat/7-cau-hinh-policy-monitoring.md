### 1. Đánh giá sự tuân thủ PCI-DSS của Ubuntu

* Cập nhật cấu hình cho agent \(/var/ossec/etc/shared/default/agent.conf\)

```
<agent_config profile="ubuntu">

  <wodle name="open-scap">
    <disabled>no</disabled>
    <timeout>1800</timeout>
    <interval>1d</interval>
    <scan-on-start>yes</scan-on-start>

    <content type="xccdf" path="ssg-debian-8-ds.xml">
      <profile>xccdf_org.ssgproject.content_profile_pci-dss</profile>
      <profile>xccdf_org.ssgproject.content_profile_common</profile>
    </content>
    <content type="xccdf" path="ssg-ubuntu-1604-ds.xml">
      <profile>xccdf_org.ssgproject.content_profile_pci-dss</profile>
      <profile>xccdf_org.ssgproject.content_profile_common</profile>
    </content>
  </wodle>

</agent_config>
```

* Khởi động lại manager và agent

```
/var/ossec/bin/ossec-control restart
/var/ossec/bin/agent_control -R -a
```

Tham khảo:

* [https://documentation.wazuh.com/current/user-manual/capabilities/policy-monitoring/openscap/how-it-works.html](https://documentation.wazuh.com/current/user-manual/capabilities/policy-monitoring/openscap/how-it-works.html)

* [https://static.open-scap.org/ssg-guides/ssg-ubuntu1604-guide-common.html](https://static.open-scap.org/ssg-guides/ssg-ubuntu1604-guide-common.html)

* [https://www.open-scap.org/security-policies/choosing-policy/](https://www.open-scap.org/security-policies/choosing-policy/)

* [https://github.com/OpenSCAP/scap-security-guide](https://github.com/OpenSCAP/scap-security-guide)

### 2. Kiểm tra lỗ hổng bảo mật của Ubuntu

### Cập nhật cấu hình cho agent \(/var/ossec/etc/shared/default/agent.conf\)

```
<agent_config profile="ubuntu">

  <wodle name="open-scap">
    <disabled>no</disabled>
    <timeout>1800</timeout>
    <interval>1d</interval>
    <scan-on-start>yes</scan-on-start>

    <content type="xccdf" path="cve-debian-8-oval.xml"/>
    <content type="xccdf" path="cve-ubuntu-xenial-oval.xml"/>
  </wodle>

</agent_config>
```

* Khởi động lại manager và agent

```
/var/ossec/bin/ossec-control restart
/var/ossec/bin/agent_control -R -a
```

### 3. Đánh giá sự tuân thủ PCI-DSS & Kiểm tra lỗ hổng bảo mật của RHEL7

Tham khảo:

* [https://documentation.wazuh.com/current/user-manual/capabilities/policy-monitoring/openscap/oscap-configuration.html](https://documentation.wazuh.com/current/user-manual/capabilities/policy-monitoring/openscap/oscap-configuration.html)

Ghi chú: policy được lưu ở folder /var/ossec/wodles/oscap/content trên mỗi agent

