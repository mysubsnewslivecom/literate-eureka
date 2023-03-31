---
title: Registry Setup
---
1. Generate ssl certificates:

    ```sh
    openssl req -x509 -newkey rsa:4096 -days 365 -nodes -sha256 -keyout domain.key -out domain.crt
    ```

2. Generate htpasswd:

 ```sh
    htpasswd -Bbn linux test> htpasswd
 ```

3. Copy domain.crt to /etc/docker/certs.d/$(hostname):5000 as ca.crt

    ```sh
    mkdir -pv /etc/docker/certs.d/$(hostname):5000
    sudo cp domain.crt /usr/local/share/ca-certificates/$(hostname).crt
    sudo update-ca-certificates
    ```
