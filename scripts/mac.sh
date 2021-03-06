#!/bin/sh

echo "\nadding loopback alias"
sudo ifconfig lo0 10.0.0.100 alias

echo "\nadding routing rule"
echo "rdr pass on lo0 inet proto tcp from any to 10.0.0.100 port 0:30000 -> 127.0.0.1 port 6314" | sudo pfctl -ef -

echo "\n starting docker container"
echo "docker run -v /var/run/docker.sock:/var/run/docker.sock -it -p 6314:80 --rm benjamincaldwell/docker-proxy"
docker run -v /var/run/docker.sock:/var/run/docker.sock -it -p 6314:80 --rm benjamincaldwell/docker-proxy