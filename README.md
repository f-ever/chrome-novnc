# chrome-novnc
## Run Chrome in docker container
```
docker build -t fever/chrome-novnc ./
docker run -d --restart=always --name=chrome-novnc -e WIDTH=1280 -e HEIGHT=720 -e LANGUAGE=zh_CN.UTF-8 -e VNC_PASSWD=my_vnc_password -p 26080:6080 -v /data/chrome-novnc:/config  fever/chrome-novnc
```
