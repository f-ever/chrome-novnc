#!/bin/bash
export USER=nobody
msedge_window_size=$[$WIDTH+1],$[$HEIGHT+1]
msedge_parm="--no-first-run --disable-gpu --use-gl=swiftshader --disable-software-rasterizer --ignore-gpu-blocklis --test-type --window-size=$msedge_window_size --no-sandbox --window-position=0,0 --user-data-dir=/config/msedge"
vnc_geometry=$WIDTH'x'$HEIGHT
vnc_config=/root/.vnc

[ ! -e "$vnc_config" ] && mkdir -p $vnc_config
vncpasswd -f <<< $VNC_PASSWD > "$vnc_config/passwd"
chmod 600 $vnc_config//passwd
echo "while [ 1 ]; do /opt/microsoft/msedge/msedge $msedge_parm; done" > "$vnc_config/xstartup"
chmod +x $vnc_config/xstartup
vncserver -kill :1 1>/dev/null 2>&1
[ -e /tmp/.X11-unix ] && rm -rf /tmp/.X11-unix
[ -e /tmp/.X1-lock ] && rm -rf /tmp/.X1-lock
vncserver -name msedge-novnc -depth 24 -geometry $vnc_geometry :1
/opt/novnc/utils/novnc_proxy --vnc localhost:5901
