## 測試狀態
```bash
docker pull kasmweb/ubuntu-jammy-dind:1.16.0-rolling-daily 
docker run --privileged -t -d -p "6901:6901" -e "VNC_PW=password" kasmweb/ubuntu-jammy-dind:1.16.0-rolling-daily
```
## 登入/更新/建立/上傳
```bash
docker login
docker build --no-cache -t tsukisama9292/ubuntu-jammy-dind:1.16.0-latest .
docker push tsukisama9292/ubuntu-jammy-dind:1.16.0-latest
```
## 拉取
```bash
docker pull tsukisama9292/ubuntu-jammy-dind:1.16.0-latest
```