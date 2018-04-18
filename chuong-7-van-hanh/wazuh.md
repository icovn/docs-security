# 1. Giới thiệu về Wazuh

Wazuh is a security detection, visibility, and compliance open source project. It was born as a fork of [OSSEC HIDS](http://ossec.github.io/), and later was integrated with [Elastic Stack](https://www.elastic.co/) and [OpenSCAP](https://www.open-scap.org/), evolving into a more comprehensive solution![](/assets/wazuh-component.png)

* **OSSEC HIDS** is a Host-based Intrusion Detection System \(HIDS\) used for security detection, visibility, and compliance monitoring. It’s based on a multi-platform agent that forwards system data \(e.g log messages, file hashes, and detected anomalies\) to a central manager, where it is further analyzed and processed, resulting in security alerts. Agents convey event data to the central manager for analysis via a secure and authenticated channel.
* **OpenSCAP **is an [OVAL](https://oval.mitre.org/)\(Open Vulnerability Assessment Language\) and XCCDF \(Extensible Configuration Checklist Description Format\) interpreter used to check system configurations and to detect vulnerable applications.
* **Elastic Stack** is a software suite \(Filebeat, Logstash, Elasticsearch, Kibana\) used to collect, parse, index, store, search, and present log data. It provides a web front-end that gives a high-level dashboard view of events that allows for advanced analytics and data mining deep into your store of event data.

# 2. Kiến trúc

* Single server

![](/assets/single.png)

* Distributed

![](/assets/distributed.png)

* Communications and data flow![](/assets/communication.png)

# 3. Wazuh agent

# 4. Wazuh server

The server component is in charge of analyzing the data received from the agents and triggering alerts when an event matches a rule \(e.g. intrusion detected, file changed, configuration not compliant with policy, possible rootkit, etc…\)![](/assets/wazuh-server.png)The server usually runs on a stand-alone physical machine, virtual machine or cloud instance and runs agent components with the purpose of monitoring itself. Below is a list of the main server components:

* **Registration service: **This is used to register new agents by provisioning and distributing pre-shared authentication keys that are unique to each agent. This process runs as a network service and supports authentication via TLS/SSL and/or by a fixed password.

* **Remote daemon service: **This is the service that receives data from the agents. It makes use of the pre-shared keys to validate each agent’s identity and to encrypt the communications between the agent and the manager.

* **Analysis daemon: **his is the process that performs data analysis. It utilizes decoders to identify the type of information being processed \(e.g. Windows events, SSHD logs, web server logs, etc.\) and then extract relevant data elements from the log messages \(e.g. source ip, event id, user, etc.\). Next, by using rules, it can identify specific patterns in the decoded log records which could trigger alerts and possibly even call for automated countermeasures \(active responses\) like an IP ban on the firewall.

* **RESTful API: **This provides an interface to manage and monitor the configuration and deployment status of agents. It is also used by the Wazuh web interface, which is a Kibana app.

# 5. Elastic Stack





