# 🛡️ SOC-Park Deployment Guide

## 📘 Overview

**SOC-Park** is a simulated cybersecurity environment designed for blue team and red team operations, training, and experimentation. It brings together essential open-source security tools in a virtualized lab setup to emulate real-world SOC operations.

This project was built on a **Proxmox VE** server using an Ubuntu 20.04 base template. Each tool in the SOC-Park fulfills a critical role in cyber defense, offense simulation, and threat intelligence management:

### 🧩 Components

- **Wazuh**  
  Acts as the core **SIEM (Security Information and Event Management)** system. It collects, parses, and analyzes logs from various sources, and provides real-time alerts based on custom rules and integrations with the Elastic Stack.

- **Caldera**  
  An **adversary emulation platform** developed by MITRE. It is used to simulate cyber attacks and test the effectiveness of blue team defenses. Useful for training, purple teaming, and validating detection rules.

- **OpenCTI (Open Cyber Threat Intelligence)**  
  An **open-source threat intelligence platform** that allows the aggregation, analysis, and sharing of structured threat data. It integrates with external feeds and platforms to enhance situational awareness and incident response.

---

## ⚙️ Prerequisites

Before setting up SOC-Park, ensure that you have the following:

### 🔲 Virtualization Platform

A **Type 1 or Type 2 hypervisor** is required to create and manage virtual machines. Supported platforms include:

- [Proxmox VE](https://www.proxmox.com/) *(used in our setup)*
- [VirtualBox](https://www.virtualbox.org/)
- [VMware Workstation Pro](https://www.vmware.com/products/workstation-pro.html)

### 🖥️ Minimum System Resources

Each component has its own system requirements. Below are the **recommended minimum** specifications for a functional lab deployment:

| Component   | RAM     | CPU                  | Storage     | Notes                                              |
|-------------|---------|----------------------|-------------|----------------------------------------------------|
| **Wazuh**   | 8 GB    | 2 cores / 1 socket   | 100 GB      | Includes Elasticsearch, Filebeat, Kibana          |
| **Caldera** | 4 GB    | 1 core / 1 socket    | 32 GB       | Lightweight; for red team simulations              |
| **OpenCTI** | 8 GB    | 2 sockets × 2 cores  | 100 GB+     | Multiple services; SSD storage highly recommended  |

> ⚠️ **Note:** These are **minimum** recommendations. For production or more intense testing scenarios, higher specs are encouraged—especially for OpenCTI and Wazuh, which rely heavily on Elasticsearch and other high-memory components.

---

## 🚀 Deployment Strategy

1. **Create a base Ubuntu 20.04 template** VM on your hypervisor.
2. **Clone/deploy** that template for each SOC-Park component.
3. **Install the required tools** (Wazuh, Caldera, OpenCTI) following their respective guides.
4. **Configure networking, logging, and integration** between tools if necessary.
5. **Simulate attacks** using Caldera and verify detection and alerts via Wazuh and analysis through OpenCTI.

---

## 📝 Author

**Ahmed SAFTA**  
Cybersecurity Engineering Student & Infrastructure Architect  

---

## 📎 License

This project is open-source and free to use for learning, testing, and non-commercial deployment purposes.