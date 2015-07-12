#!/bin/bash
sudo docker run -d -p 9000:9000 --name dockerui --privileged -v /var/run/docker.sock:/var/run/docker.sock dockerui/dockerui
