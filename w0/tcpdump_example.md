
# Capture Telnet Traffic to localhost:8080 Using tcpdump

## 1. Start tcpdump on Loopback Interface
```bash
sudo tcpdump -i lo0 tcp port 8080 -w telnet_capture.pcap
```

## 2. Perform Telnet Request
```bash
telnet localhost 8080
```

Send the HTTP request:
```plaintext
GET / HTTP/1.1
Host: localhost
```
(Press `Enter` twice to send the request.)

## 3. Stop tcpdump
Press `Ctrl+C` in the terminal running `tcpdump`.

## 4. Analyze Captured Traffic
### View in Terminal:
```bash
sudo tcpdump -r telnet_capture.pcap
```

### View in Wireshark (Optional):
Open the `telnet_capture.pcap` file in Wireshark for detailed analysis.
```bash
open telnet_capture.pcap
```
