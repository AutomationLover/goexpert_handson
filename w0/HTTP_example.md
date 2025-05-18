
# Quick Guide: Start Nginx with Docker, Test with Telnet, View in Wireshark

## 1. Start Nginx Container
```bash
docker run --name nginx-container -d -p 8080:80 nginx
```

## 2. Test Nginx with Telnet
### Connect to Nginx:
```bash
telnet localhost 8080
```

### Send HTTP Request:
```plaintext
GET / HTTP/1.1
Host: localhost
```

(Press `Enter` twice after `Host: localhost`.)

### Exit Telnet:
Press `Ctrl+]`, then type:
```plaintext
quit
```


## 3. view from Wireshark
1. Open Wireshark and select loopback interface.
2. Apply the capture filter: `tcp port 8080`.



## 4. Stop and Remove the Container
### Stop the container:
```bash
docker stop nginx-container
```

### Remove the container:
```bash
docker rm nginx-container
```

(Optional) Remove the Nginx image:
```bash
docker rmi nginx
```


