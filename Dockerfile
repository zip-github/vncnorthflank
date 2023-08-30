FROM debian
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install firefox-esr mate-system-monitor git lxde tightvncserver wget vim sudo  -y
RUN useradd -m -p $(openssl passwd -1 zaq12wsx) -s /bin/bash -G sudo dvps
RUN wget https://github.com/novnc/noVNC/archive/refs/tags/v1.2.0.tar.gz
RUN tar -xvf v1.2.0.tar.gz
RUN mkdir /dvps/.vnc
RUN echo 'zaq12wsx' | vncpasswd -f > /dvps/.vnc/passwd
RUN chmod 600 /dvps/.vnc/passwd
RUN cp /noVNC-1.2.0/vnc.html /noVNC-1.2.0/index.html
RUN echo "sed -i 's/1024x768/1024x600/g' /usr/bin/vncserver" >>/luo.sh
RUN echo 'cd /dvps' >>/luo.sh
RUN echo "su dvps -l -c 'vncserver :2000 ' "  >>/luo.sh
RUN echo 'cd /noVNC-1.2.0' >>/luo.sh
RUN echo './utils/launch.sh  --vnc localhost:7900 --listen 80 ' >>/luo.sh
RUN echo root:vncnorthflank1234|chpasswd
RUN chmod 755 /luo.sh
EXPOSE 80
CMD  /luo.sh
