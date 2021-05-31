## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![](Diagrams/VMTopology.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook (.yml) file may be used to install only certain pieces of it, such as Filebeat.

  The following ansible playbooks are needed to create and install the ELK-Stack server and DVWA.
  * [my-playbook.yml](Ansible/my-playbook.yml) - Used to install the DVWA server.
  * [install-elk.yml](Ansible/install-elk.yml) - Used to install the ELK server.
  * [filebeat-playbook.yml](Ansible/filebeat-playbook.yml) - Used to install and configure Filebeat on the DVWA and ELK servers.
  * [metricbeat-playbook.yml](Ansible/metricbeat-playbook.yml) - Used to install and configure Metricbeat on the DVWA and ELK servers.

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
- Beats in Use
- Machines Being Monitored
- How to Use the Ansible Build

## Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.

What aspect of security do load balancers protect?
Load Balancing ensures availability to the web-servers which is the availability aspect of security in regards to the CIA Triad. 

What is the advantage of a jump box?
The main advantage of using a JumpBox is having one origination point for administrative tasks. This ultimately sets the JumpBox as a Secure Admin Workstation (SAW). In order to conduct administrative tasks administrators are required to access the JumpBox before accessing the other servers.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the logs and system traffic.
* Filebeat watches for log files/locations and collect log events.
* Metricbeat records metrics and statistical data from the operating system and from services running on the server.

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name       | Function               | IP Address | Operating System         |  
|------------|------------------------|------------|--------------------------|
| JumpBox    | Gateway                | 10.0.0.1   | Linux (Ubuntu 18.04 LTS) |
| Web-1      | Web Server-Docker-DVWA | 10.0.0.5   | Linux (Ubuntu 18.04 LTS) |
| Web-2      | Web Server-Docker-DVWA | 10.0.0.6   | Linux (Ubuntu 18.04 LTS) |
| Web-3      | Web Server-Docker-DVWA | 10.0.0.8   | Linux (Ubuntu 18.04 LTS) |
| ELK-Server | ELK Stack              | 10.1.0.4   | Linux (Ubuntu 18.04 LTS) |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box Provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
* Personal IP Address

Machines within the network can only be accessed by SSH.
* The ELK-Server is only accessible by SSH from the JumpBox via web access from your Personal IP Address. 

A summary of the access policies in place can be found in the table below.

| Name       | Publicly Accessible   | Allowed IP Addresses                                               |
|------------|-----------------------|--------------------------------------------------------------------|
| JumpBox    | No                    | Personal IP Address                                                |
| Web-1      | Yes via Load Balancer | Load Balancer Public IP 40.83.39.183 & JumpBox Private IP 10.0.0.4 |
| Web-2      | Yes via Load Balancer | Load Balancer Public IP 40.83.39.183 & JumpBox Private IP 10.0.0.4 |
| ELK-Server | No                    | SSH 10.0.0.4 - JumpBox HTTP Port 5601 Personal IP                  |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- The main advantage of automating the installation process is that we could deploy multiple servers easily and quickly without having to
physically touch each server.

The playbook implements the following tasks:
- Install Docker.io and pip3
- Increases Virtual Machine memory
- Downloads and configures ELK Stack docker container
- Sets published ports

The following screenshot displays the result of running `sudo docker ps` after successfully configuring the ELK instance.

![](Images/docker-ps.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
* Web-1 10.0.0.5
* Web-2 10.0.0.6

We have installed the following Beats on these machines:
* Filebeat
* Metricbeat

These Beats allow us to collect the following information from each machine:
* Filebeat watches for log files/locations and collect log events. (Filebeat: Lightweight Log Analysis &amp; Elasticsearch)
* Metricbeat records metrics and statistical data from the operating system and from services running on the server (Metricbeat: Lightweight Shipper for Metrics)

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the filebeat-config.yml file to metricbeat-config.yml files into /etc/ansible/files.
- Update the configuration files to include the Private IP of the ELK-Server. Do this under the Elasticsearch and Kibana sections of the configurations files.
- Run the playbook, and navigate to 20.41.102.105:5601/app/kibana (ELK-Server-Publicip) to check that the installation worked as expected.

- Which file is the playbook? The playbook files are: 
* [install-elk.yml](C:\Users\benca\RepoBenny\Ansible\install-elk.yml) - Used to install the the ELK Server.
* [filebeat-playbook.yml](C:\Users\benca\RepoBenny\Ansible\filebeat-playbook.yml) - Used to install and configure Filebeat on the Elk and DVWA servers.
* [metricbeat-playbook.yml](C:\Users\benca\RepoBenny\Ansible\metricbeat-playbook.yml) - Used to install and configure Metricbeat on the Elk and DVWA servers.

- Where do you copy it?
* /etc/ansible/

- Which file do you update to make Ansible run the playbook on a specific machine? 
* /etc/ansible/hosts.cfg

- How do I specify which machine to install the ELK server on versus which to install Filebeat on?
* By updating the desired IP addresses and details required within the /etc/ansible/hosts file.

- Which URL do you navigate to in order to check that the ELK server is running?
* http://publicip(elkserver):5601 For example - http://20.41.102.105:5601/app/kibana

### ELK-Server Ansible conifiguration run commands:
1. ssh sysadmin@JumpBox (PrivateIP)
2. sudo docker container list -a - Locate the ansible container.
3. sudo docker start <name of container> e.g. (tender_wiles) - To start the container.
4. sudo docker attach <name of container> e.g. (tender_wiles) - To attach the container.
5. Navigate to playbook directory cd /etc/ansible/
6. Run the playbook files - ansible-playbook elk-playbook.yml (Installs and Configures ELK-Server)
7. Run the playbook files - ansible-playbook beats-playbook.yml (Installs and Configures Beats)
8. Open a new browser on your personal machine and navigate to (ELK-Server-PublicIP:5601/app/kibana)

This will bring up Kibana web portal when the server is setup correctly.













