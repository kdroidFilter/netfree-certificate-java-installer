# Netfree Certificate Java Installer

## Description
The Netfree Certificate Java Installer is a Bash script designed to automate the process of installing the Netfree certificate across all Java environments on your system. This is particularly useful for developers and professionals who use Java-based applications like Android Studio, ensuring that the Netfree certificate is trusted by all Java applications. By executing this script, you can seamlessly add the Netfree certificate to every Java Keystore found in your system, saving you the time and effort of manually configuring each environment.

## Prerequisites
Before running this script, ensure that you have the following:

* Curl: Utility for downloading files from the internet.
* Java: Java Development Kit (JDK) installed on your system.
* Sudo Access: Permissions to execute commands as a superuser for modifying Keystore files.

## Command to use the script

```bash
curl -s https://raw.githubusercontent.com/kdroidFilter/netfree-certificate-java-installer/main/netfree-java-cert.sh | sudo bash
```
