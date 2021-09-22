# Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Newtwork Diagram](https://github.com/gibby430EN/Elk-Stack-Project1/blob/aa9c03a1a4b36798bfdaae2aff3cfa3df9fb86c4/Diagrams/Project1_v1.1.jpg)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to recreate the deployment pictured above.
  - [my-playbook.yml](https://github.com/gibby430EN/Elk-Stack-Project1/blob/cd14007740467165031f602c13c9ccc1438dfc71/Ansible/my-playbook.yml) Used to set up DVWA Containers
  - [install-elk.yml](https://github.com/gibby430EN/Elk-Stack-Project/blob/9ddd85087a3bd220bf5553780a0b600d25197efd/Ansible/install-elk.yml) Used to set up ELK machine

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build

## Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA (Damn Vulnerable Web Application).

Load balancing ensures that the application will be highly stable and available, in addition to restricting access to the network.
- Load balancers protect against DOS attacks by keeping the network traffic balanced. 
- The advantage of using a Jump-Box-Provisioner is ensuring access to only one or selected administrators.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the machines and system logs.
- Filebeat and Metricbeat are used to monitor the machines running DVWA

The configuration details of each machine may be found below.

| Name                 | Function | IP Address | Public IP Address  | Operating System |
|----------------------|----------|------------|--------------------|------------------|
| Jump-Box-Provisioner | Gateway  | 10.0.0.4   | 20.106.141.218     | Linux            |
| Web-1                |  WebApp  | 10.0.0.5   | 40.114.112.227 (LB)| Linux            |
| Web-2                |  WebApp  | 10.0.0.6   | 40.114.112.227 (LB)| Linux            |
| Elk                  |  Elk     | 10.1.0.4   | 52.225.232.246     | Linux            |

- LB = Load balancer

## Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump-Box-Provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 0.0.0.0 = My personal workstation

Machines within the network can only be accessed by Jump-Box-Provisioner Machine.
- The Elk machine also allowed my personal workstation ip:0.0.0.0 though port 5601.

A summary of the access policies in place can be found in the table below.

| Name                 | Publicly Accessible | Allowed IP Addresses |
|----------------------|---------------------|----------------------|
| Jump-Box-Provisioner | Yes                 | Personal Ip          |
| Web-1                | No/Yes through LB   | 10.0.0.4, 10.1.0.4   |
| Web-2                | No/Yes through LB   | 10.0.0.4, 10.1.0.4   |
| Elk                  | Yes                 | Personal Ip, 10.0.04 |

## Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, and all the work was done through yml files. Creating and keeping the yml files updated, you are able to set up or update multiple machines quickly. This will eliminate human error and keep the process simple. 

The playbook implements the following tasks:
- Installs Docker.io
- Installs pip3
- Installs Docker python module
- Increase virtual memory
- Download and launch a docker web container

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![docker_ps_run](https://github.com/gibby430EN/Elk-Stack-Project1/blob/0bdde45f4ace267ae6ac62057a42ff0e5cd15d82/Images/docker_ps_run.jpg)

## Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1 = 10.0.0.5
- Web-2 = 10.0.0.6

We have installed the following Beats on these machines:
- Filebeat
  - [filebeats-playbook.yml](https://github.com/gibby430EN/Elk-Stack-Project1/blob/0bdde45f4ace267ae6ac62057a42ff0e5cd15d82/Ansible/Filebeats-playbook.yml)
  - [filebeat-config.yml](https://github.com/gibby430EN/Elk-Stack-Project1/blob/0bdde45f4ace267ae6ac62057a42ff0e5cd15d82/Ansible/filebeat-config.yml)
- Metricbeat
  - [metricbeat-playbook.yml](https://github.com/gibby430EN/Elk-Stack-Project1/blob/0bdde45f4ace267ae6ac62057a42ff0e5cd15d82/Ansible/metricbeat-playbook.yml)
  - [metricbeat-config.yml](https://github.com/gibby430EN/Elk-Stack-Project1/blob/0bdde45f4ace267ae6ac62057a42ff0e5cd15d82/Ansible/metricbeat-config.yml)

These Beats allow us to collect the following information from each machine:
- Filebeat collects and forwards log data from the web machines it is installed on and sends the data to the Elk stack for processing using elasticsearch. The information in this case is viewed through Kibana.

![Filebeat](https://github.com/gibby430EN/Elk-Stack-Project1/blob/0bdde45f4ace267ae6ac62057a42ff0e5cd15d82/Images/filebeats1.jpg)

- Metricbeat collects metrics from the operationg system and services running on the server. Then sends data to the Elk stack for processing using elasticsearch. This information is also viewed through Kibana.

![metricbeat](https://github.com/gibby430EN/Elk-Stack-Project1/blob/0bdde45f4ace267ae6ac62057a42ff0e5cd15d82/Images/metricbeat1.jpg)

## Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the filebeat-playbook.yml and metricbeat-playbook.yml file to /etc/ansible/roles. Make sure to change the host names if needed.
- Copy the file filbeat-config.yml and metricbeat-config.yml file to /etc/ansible/files. Make sure to edit ip addresses.
- Update the hosts file to include [webservers] and [elk]
- Run the playbook, and navigate to http://[your.ELK-VM.External.IP]:5601/app/kibana to check that the installation worked as expected.

Specific commands the user will need to run to download the playbook, update the files, etc.
- SSH into JumpBoxProvisioner from Local Desktop:
  - ssh [username]@{your.jumpbox.IP]

- View list of docker containers:
  - sudo docker container list -a
	
- Start docker:
  - sudo docker start [dockername]
	
- Attach to docker:
  - sudo docker attach [dockername]
	
- Add DVWAs to hosts file:
  - nano /etc/ansible/hosts
  - Add additional private IPs under [webservers]
	
- Run playbook to update elk:
  - ansible-playbook /etc/ansible/install-elk.yml
	
- Copy filebeat configuration file:
  - copy filebeat-config.yml file to /etc/ansible/files/
  - copy metricbeat-config.yml file to /etc/ansible/files/
	
- Run playbook for filebeat:
  - ansible-playbook /etc/ansible/roles/filebeat-playbook.yml
  - ansible-playbook /etc/ansible/roles/metricbeat-config.yml
	
- Open Kibana in browser:
  - http://[your.ELK-VM.External.IP]:5601/app/kibana
