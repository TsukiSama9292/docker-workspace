FROM kasmweb/ubuntu-jammy-dind:1.16.0-rolling-daily

ENV DEBUG=false \
    DEBIAN_FRONTEND=noninteractive \
    SKIP_CLEAN=true

# 安裝 gnome-keyring 
RUN sudo apt-get update && sudo apt-get upgrade -y

RUN sudo apt install gnome-keyring -y && sudo rm -rf /var/lib/apt/lists/*

# 安裝工具資料庫管理工具
RUN wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
RUN sudo dpkg -i dbeaver-ce_latest_amd64.deb
RUN sudo apt update && sudo apt-get install -f -y
RUN rm -rf dbeaver-ce_latest_amd64.deb

# 安裝 docker-compose
RUN sudo curl -L -o docker-compose-linux-x86_64 https://github.com/docker/compose/releases/download/v2.29.2/docker-compose-linux-x86_64
RUN sudo mv docker-compose-linux-x86_64 /usr/local/bin/docker-compose
RUN sudo chmod +x /usr/local/bin/docker-compose

# 建立工作目錄
RUN mkdir /home/kasm-user/workspace

# 下載並安裝 Postman
RUN wget https://dl.pstmn.io/download/latest/linux64 -O postman-linux-x64.tar.gz \
    && sudo tar -xvzf postman-linux-x64.tar.gz -C /opt \
    && rm postman-linux-x64.tar.gz

# 切換到 root 用戶
USER root
# 建立 Postman 桌面連結
RUN echo '[Desktop Entry]' >> /usr/share/applications/postman.desktop && \
    echo 'Name=Postman' >> /usr/share/applications/postman.desktop && \
    echo 'Exec=/opt/Postman/Postman' >> /usr/share/applications/postman.desktop && \
    echo 'Icon=/opt/Postman/app/icons/icon_128x128.png' >> /usr/share/applications/postman.desktop && \
    echo 'Type=Application' >> /usr/share/applications/postman.desktop && \
    echo 'Categories=Development;' >> /usr/share/applications/postman.desktop
# 授權 Postman 桌面連結
RUN chmod +x /usr/share/applications/postman.desktop
    
# 切換回非 root 用戶
USER kasm-user