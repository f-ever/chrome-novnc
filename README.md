# msedge-novnc
## Run Microsoft Edge Browser in docker container
```
docker build -t fever/msedge-novnc ./
docker run -d --restart=always --name=msedge-novnc -e WIDTH=1280 -e HEIGHT=720 -e LANGUAGE=zh_CN.UTF-8 -e VNC_PASSWD=my_vnc_password -p 36080:6080 -v /data/msedge-novnc:/config  fever/msedge-novnc
```
