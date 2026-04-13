# 🚀 개발 워크스테이션 구축 미션

## 1. 프로젝트 개요
- 본 프로젝트는 터미널, Docker, Git 환경을 구축하고 이해하는 것을 목표로 합니다.

## 2. 실행 환경
- OS: macOS (OrbStack 환경)
- Shell: Zsh
- Docker 버전:Docker version 28.5.2
- Git 버전:git version 2.50.1

## 3. 수행 항목 체크리스트
- [x] 터미널 기본 조작 및 권한 실습
- [X] Docker 설치 및 기본 명령어 확인
- [X] Dockerfile 작성 및 커스텀 이미지 빌드
- [X] 포트 매핑 및 볼륨 영속성 검증
- [X] GitHub 저장소 연동

## 4-1. 터미널 조작 및 권한 실습 로그

1. 터미널 조작 실습

기본적인 명령어들을 사용해 보았습니다.
```
howdy@gwonminhyeog-ui-MacBookPro ~ % pwd
/Users/howdy
howdy@gwonminhyeog-ui-MacBookPro ~ % ls -a 
.			.config			.vscode			Documents		Pictures
..			.copilot		.zprofile		Downloads		Public
.CFUserTextEncoding	.docker			.zsh_history		Library
.DS_Store		.lesshst		.zsh_sessions		Movies
.Trash			.orbstack		Applications		Music
.cagent			.ssh			Desktop			OrbStack
howdy@gwonminhyeog-ui-MacBookPro ~ % cd public   
howdy@gwonminhyeog-ui-MacBookPro public % touch test.txt
howdy@gwonminhyeog-ui-MacBookPro public % cp test.txt ../music
howdy@gwonminhyeog-ui-MacBookPro music % mv test.txt ../ 
howdy@gwonminhyeog-ui-MacBookPro music % cd ../
howdy@gwonminhyeog-ui-MacBookPro ~ % ls
Applications	Documents	Library		Music		Pictures	test.txt
Desktop		Downloads	Movies		OrbStack	Public
howdy@gwonminhyeog-ui-MacBookPro ~ % mv test.txt hello.txt
howdy@gwonminhyeog-ui-MacBookPro ~ % ls
Applications	Documents	Library		Music		Pictures	hello.txt
Desktop		Downloads	Movies		OrbStack	Public
howdy@gwonminhyeog-ui-MacBookPro ~ % rm hello.txt
howdy@gwonminhyeog-ui-MacBookPro ~ % ls
Applications	Documents	Library		Music		Pictures
Desktop		Downloads	Movies		OrbStack	Public
howdy@gwonminhyeog-ui-MacBookPro ~ % touch hi.txt
howdy@gwonminhyeog-ui-MacBookPro ~ % echo "hello" >> hi.txt
howdy@gwonminhyeog-ui-MacBookPro ~ % cat hi.txt
hello
howdy@gwonminhyeog-ui-MacBookPro ~ % less hi.txt
howdy@gwonminhyeog-ui-MacBookPro ~ % head hi.txt
hello
```

2. 터미널 권한부여 실습

text 파일을 만들고, echo 명령어를 이용하여 소유자의 쓰기권한이 없음을 확인했습니다.
```
howdy@gwonminhyeog-ui-MacBookPro howdy % touch test.txt
howdy@gwonminhyeog-ui-MacBookPro howdy % ls -l
total 0
drwx------@  4 howdy  staff   128 Mar 27 11:14 Applications
drwx------+  5 howdy  staff   160 Apr  1 20:36 Desktop
drwx------+  4 howdy  staff   128 Mar 31 12:38 Documents
drwx------+ 14 howdy  staff   448 Apr  1 20:33 Downloads
drwx------@ 87 howdy  staff  2784 Mar 31 19:01 Library
drwx------   4 howdy  staff   128 Mar 27 16:15 Movies
drwx------+  4 howdy  staff   128 Mar 31 19:02 Music
drwx------   4 howdy  staff   160 Apr  1 22:41 OrbStack
drwx------+  6 howdy  staff   192 Mar 27 01:25 Pictures
drwxr-xr-x+  4 howdy  staff   128 Mar 26 17:48 Public
-rw-r--r--   1 howdy  staff     0 Apr  1 22:47 test.txt
howdy@gwonminhyeog-ui-MacBookPro howdy % chmod 477 test.txt
howdy@gwonminhyeog-ui-MacBookPro howdy % echo "hello" >> test.txt
zsh: permission denied: test.txt
```

mission-test 디렉터리를 만들고, 권한을 변경한 뒤, cd 명령어를 이용하여 소유자의 실행권한이 없음을 확인했습니다.
```
howdy@gwonminhyeog-ui-MacBookPro howdy % mkdir mission-test
howdy@gwonminhyeog-ui-MacBookPro howdy % ls -l 
drwxr-xr-x   2 howdy  staff    64 Apr  4 16:38 mission-test
howdy@gwonminhyeog-ui-MacBookPro howdy % chmod 655 mission-test 
howdy@gwonminhyeog-ui-MacBookPro howdy % cd mission-test 
cd: permission denied: mission-test
```
### 4.2 Docker 설치 및 점검, 명령어 실습 로그

1. 설치 및 버전 확인 명령어 실습

docker --version 과 docker info 명령어를 사용해 보았습니다.

```
docker --version
howdy@gwonminhyeog-ui-MacBookPro howdy % docker --version
Docker version 28.5.2, build ecc6942
howdy@gwonminhyeog-ui-MacBookPro howdy % docker info
Client:
 Version:    28.5.2
 Context:    orbstack
 Debug Mode: false
 Plugins:
  agent: Docker AI Agent Runner (Docker Inc.)
    Version:  v1.34.0
    Path:     /Users/howdy/.docker/cli-plugins/docker-agent
  ai: Docker AI Agent - Ask Gordon (Docker Inc.)
    Version:  v1.20.1
    Path:     /Users/howdy/.docker/cli-plugins/docker-ai
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.29.1
    Path:     /Users/howdy/.docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.40.3
    Path:     /Users/howdy/.docker/cli-plugins/docker-compose
  debug: Get a shell into any image or container (Docker Inc.)
    Version:  0.0.47
    Path:     /Users/howdy/.docker/cli-plugins/docker-debug
  desktop: Docker Desktop commands (Docker Inc.)
    Version:  v0.3.0
    Path:     /Users/howdy/.docker/cli-plugins/docker-desktop
  dhi: CLI for managing Docker Hardened Images (Docker Inc.)
    Version:  v0.0.2
    Path:     /Users/howdy/.docker/cli-plugins/docker-dhi
  extension: Manages Docker extensions (Docker Inc.)
    Version:  v0.2.31
    Path:     /Users/howdy/.docker/cli-plugins/docker-extension
  init: Creates Docker-related starter files for your project (Docker Inc.)
    Version:  v1.4.0
    Path:     /Users/howdy/.docker/cli-plugins/docker-init
  mcp: Docker MCP Plugin (Docker Inc.)
    Version:  v0.40.3
    Path:     /Users/howdy/.docker/cli-plugins/docker-mcp
  model: Docker Model Runner (Docker Inc.)
    Version:  v1.1.28
    Path:     /Users/howdy/.docker/cli-plugins/docker-model
  offload: Docker Offload (Docker Inc.)
    Version:  v0.5.77
    Path:     /Users/howdy/.docker/cli-plugins/docker-offload
  pass: Docker Pass Secrets Manager Plugin (beta) (Docker Inc.)
    Version:  v0.0.24
    Path:     /Users/howdy/.docker/cli-plugins/docker-pass
  sandbox: Docker Sandbox (Docker Inc.)
    Version:  v0.12.0
    Path:     /Users/howdy/.docker/cli-plugins/docker-sandbox
  sbom: View the packaged-based Software Bill Of Materials (SBOM) for an image (Anchore Inc.)
    Version:  0.6.0
    Path:     /Users/howdy/.docker/cli-plugins/docker-sbom
  scout: Docker Scout (Docker Inc.)
    Version:  v1.20.3
    Path:     /Users/howdy/.docker/cli-plugins/docker-scout

Server:
 Containers: 1
  Running: 0
  Paused: 0
  Stopped: 1
 Images: 1
 Server Version: 28.5.2
 Storage Driver: overlay2
  Backing Filesystem: btrfs
  Supports d_type: true
  Using metacopy: false
  Native Overlay Diff: true
  userxattr: false
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Cgroup Version: 2
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
 CDI spec directories:
  /etc/cdi
  /var/run/cdi
 Swarm: inactive
 Runtimes: io.containerd.runc.v2 runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 1c4457e00facac03ce1d75f7b6777a7a851e5c41
 runc version: d842d7719497cc3b774fd71620278ac9e17710e0
 init version: de40ad0
 Security Options:
  seccomp
   Profile: builtin
  cgroupns
 Kernel Version: 6.17.8-orbstack-00308-g8f9c941121b1
 Operating System: OrbStack
 OSType: linux
 Architecture: aarch64
 CPUs: 15
 Total Memory: 11.72GiB
 Name: orbstack
 ID: b380f4ab-d8cb-4005-9147-331e0083e7f7
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Experimental: false
 Insecure Registries:
  ::1/128
  127.0.0.0/8
 Live Restore Enabled: false
 Product License: Community Engine
 Default Address Pools:
   Base: 192.168.97.0/24, Size: 24
   Base: 192.168.107.0/24, Size: 24
   Base: 192.168.117.0/24, Size: 24
   Base: 192.168.147.0/24, Size: 24
   Base: 192.168.148.0/24, Size: 24
   Base: 192.168.155.0/24, Size: 24
   Base: 192.168.156.0/24, Size: 24
   Base: 192.168.158.0/24, Size: 24
   Base: 192.168.163.0/24, Size: 24
   Base: 192.168.164.0/24, Size: 24
   Base: 192.168.165.0/24, Size: 24
   Base: 192.168.166.0/24, Size: 24
   Base: 192.168.167.0/24, Size: 24
   Base: 192.168.171.0/24, Size: 24
   Base: 192.168.172.0/24, Size: 24
   Base: 192.168.181.0/24, Size: 24
   Base: 192.168.183.0/24, Size: 24
   Base: 192.168.186.0/24, Size: 24
   Base: 192.168.207.0/24, Size: 24
   Base: 192.168.214.0/24, Size: 24
   Base: 192.168.215.0/24, Size: 24
   Base: 192.168.216.0/24, Size: 24
   Base: 192.168.223.0/24, Size: 24
   Base: 192.168.227.0/24, Size: 24
   Base: 192.168.228.0/24, Size: 24
   Base: 192.168.229.0/24, Size: 24
   Base: 192.168.237.0/24, Size: 24
   Base: 192.168.239.0/24, Size: 24
   Base: 192.168.242.0/24, Size: 24
   Base: 192.168.247.0/24, Size: 24
   Base: fd07:b51a:cc66:d000::/56, Size: 64
```

2. Docker 기본 운영 명령어 실습

images, run, ps, logs, stats, stop, rm 등의 명령어를 사용해 보았습니다.

```
howdy@gwonminhyeog-ui-MacBookPro howdy % docker images
REPOSITORY    TAG       IMAGE ID       CREATED       SIZE
hello-world   latest    eb84fdc6f2a3   11 days ago   5.2kB
howdy@gwonminhyeog-ui-MacBookPro howdy % docker run -d alpine sleep 20
5edaa6f6e2f030168d2f84caa5a8de7d1f6409e39bfc2bf813dfa6506b7473cc
howdy@gwonminhyeog-ui-MacBookPro howdy % docker ps
CONTAINER ID   IMAGE     COMMAND      CREATED         STATUS         PORTS     NAMES
5edaa6f6e2f0   alpine    "sleep 20"   4 seconds ago   Up 3 seconds             frosty_lederberg
howdy@gwonminhyeog-ui-MacBookPro howdy % docker ps -a
CONTAINER ID   IMAGE         COMMAND      CREATED              STATUS                          PORTS     NAMES
5edaa6f6e2f0   alpine        "sleep 20"   About a minute ago   Exited (0) About a minute ago             frosty_lederberg
65b764935f12   alpine        "sleep 10"   3 minutes ago        Exited (0) 2 minutes ago                  youthful_sammet
dc1fac7838f4   hello-world   "/hello"     11 minutes ago       Exited (0) 11 minutes ago                 suspicious_wozniak
4acff389ddf5   hello-world   "/hello"     31 hours ago         Exited (0) 31 hours ago                   flamboyant_euclid
howdy@gwonminhyeog-ui-MacBookPro howdy % docker run -d --name logger alpine sh -c "while true; do echo 'Working...'; sleep 1; done"
5cf9de9ec97feb7f366fb7a38ade96844505ecc6e144ebda41922057beef66f0
howdy@gwonminhyeog-ui-MacBookPro howdy % docker logs logger 
Working...
Working...
Working...
Working...
Working...
Working...
Working...
Working...
Working...
Working...
Working...
Working...
howdy@gwonminhyeog-ui-MacBookPro howdy % docker stats logger
CONTAINER ID   NAME      CPU %     MEM USAGE / LIMIT     MEM %     NET I/O         BLOCK I/O     PIDS 
d386b807aef6   logger    0.10%     3.547MiB / 11.72GiB   0.03%     1.13kB / 126B   1.68MB / 0B   2 
howdy@gwonminhyeog-ui-MacBookPro howdy % docker stop logger
logger
howdy@gwonminhyeog-ui-MacBookPro howdy % docker rm logger
logger
howdy@gwonminhyeog-ui-MacBookPro howdy % docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```
3. 컨테이너 실행 실습

이미지를 통해 hello-world 와 ubuntu 를 실행하고, 간단한 명령어를 사용해 보았습니다.
```
howdy@gwonminhyeog-ui-MacBookPro howdy % docker run hello-world

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (arm64v8)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

howdy@gwonminhyeog-ui-MacBookPro howdy % docker run -it ubuntu
root@2d5b7d463289:/# #
root@2d5b7d463289:/# ls
bin  boot  dev  etc  home  lib  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@2d5b7d463289:/# echo "hello"
hello
root@2d5b7d463289:/# uname -a
Linux 2d5b7d463289 6.17.8-orbstack-00308-g8f9c941121b1 #1 SMP PREEMPT Thu Nov 20 09:34:02 UTC 2025 aarch64 aarch64 aarch64 GNU/Linux
```

docker attach 와 exec 명령어의 차이에 대해 알아보았습니다.

attach 명령어는 메인 프로세스(PID 1)과 연결되기 때문에 exit 명령어 이후 컨테이너도 정지  \
exec 명령어는 추가 프로세스(PID 1과 관련 x)이기 때문에 exit 이후에도 컨테이너 유지

```
howdy@gwonminhyeog-ui-MacBookPro howdy % docker exec -it a1c1 /bin/bash
root@a1c15e2942be:/# exit
exit
howdy@gwonminhyeog-ui-MacBookPro howdy % docker ps
CONTAINER ID   IMAGE     COMMAND       CREATED         STATUS         PORTS     NAMES
a1c15e2942be   ubuntu    "/bin/bash"   2 minutes ago   Up 2 minutes             angry_mcnulty
```
```
howdy@gwonminhyeog-ui-MacBookPro howdy % docker attach 0f0e
root@0f0ebefa9ec5:/# exit
exit
howdy@gwonminhyeog-ui-MacBookPro howdy % docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```
4. 기존 Dockerfile 기반 커스텀 이미지 제작

컨테이너와 이미지
- 이미지: 서비스 실행에 필요한 환경을 고정해 둔 읽기 전용 템플릿.
- 컨테이너: 이미지를 기반으로 격리된 환경에서 실행되는 프로세스. 호스트와 운영체제를 공유하며 외부에서 직접적인 접근이 불가능함.

이미지는 베이스 이미지를 기반으로 읽기 전용 레이어를 쌓아가며 파일을 추가/수정/삭제하는데, 컨테이너를 생성할 때 읽기-쓰기 레이어가 그 위에 추가됩니다. 컨테이너 안에서의 변경사항은 이 '쓰기 계층' 안에서만 저장됩니다.

Dockerfile을 기반으로 커스텀 이미지를 제작 해 보겠습니다.
응집도를 높이기 위해 다른 프로젝트 파일들과 분리하여 my-custom-image 디렉터리를 따로 만들어 주었습니다. \ 이후 touch 명령어를 이용해 Dockerfile 을 생성해 주었습니다.
```
howdy@gwonminhyeog-ui-MacBookPro my mission % mkdir my-custom-image
howdy@gwonminhyeog-ui-MacBookPro my mission % cd my-custom-image
howdy@gwonminhyeog-ui-MacBookPro my-custom-image % touch Dockerfile
```
VSCode 를 이용해 작성한 Dockerfile 의 내용입니다. Linux 기반 이미지인 ubuntu 를 사용했습니다.
```
FROM ubuntu:latest
LABEL maintainer="howdy <kmoru0103@gmail.com>"
ENV APP_ENV=production
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    nginx \
    curl \
    && rm -rf /var/lib/apt/lists/*
RUN useradd -m myuser
COPY welcome.txt /home/myuser/welcome
USER myuser
CMD ["cat", "/home/myuser/welcome"]
```
커스텀 포인트에 대해 3개의 단락으로 나누어 살펴보겠습니다.

ENV 명령어를 이용하여 환경변수를 설정하였습니다.\
앱의 구동환경을 local(개발용) 이 아닌 production(운영용)으로 설정하였고\
Dockerfile 을 이용하면 사용자의 수동입력을 받을 수 없으므로 변수를 noninteractive 로 설정하였습니다.
```
ENV APP_ENV=production
ENV DEBIAN_FRONTEND=noninteractive
```
RUN 명령어를 이용하여 nginx(웹서버)와 curl(네트워크 도구)을 탑재했습니다. \
이후 불필요한 캐시 파일을 삭제하여 용량을 줄였습니다.\
myuser 라는 새로운 사용자 계정을 생성하고, -m 옵션으로 home directory 를 생성했습니다.
```
RUN apt-get update && apt-get install -y \
    nginx \
    curl \
    && rm -rf /var/lib/apt/lists/*
 RUN useradd -m myuser
```
Dockerfile 과 동일한 디렉토리에 미리 생성해둔 welcome.txt 파일을 컨테이너 내부에 welcome 이라는 이름으로 복사했습니다.\
CMD 명령어 사용 시 보안 취약점(컨테이너가 관리자 권한을 가지게 되는 상황) 방지를 위해 관리자 권한이 아닌, myuser(기타사용자) 계정으로 변경했습니다.\
CMD 명령어를 사용하여 컨테이너 내부에 복사해 두었던 welcome 파일을 출력했습니다.
```
COPY welcome.txt /home/myuser/welcome
USER myuser
CMD ["cat", "/home/myuser/welcome"]
```
이후 docker build 명령어를 이용해 이미지를 만들고, 실행해 보았습니다.
```
howdy@gwonminhyeog-ui-MacBookPro my-custom-image % docker build .
[+] Building 14.4s (9/9) FINISHED                                                             docker:orbstack
 => [internal] load build definition from Dockerfile                                                     0.1s
 => => transferring dockerfile: 371B                                                                     0.0s
 => [internal] load metadata for docker.io/library/ubuntu:latest                                         0.0s
 => [internal] load .dockerignore                                                                        0.1s
 => => transferring context: 2B                                                                          0.0s
 => [1/4] FROM docker.io/library/ubuntu:latest                                                           0.0s
 => [internal] load build context                                                                        0.1s
 => => transferring context: 55B                                                                         0.0s
 => [2/4] RUN apt-get update && apt-get install -y     nginx     curl     && rm -rf /var/lib/apt/lists  13.9s
 => [3/4] RUN useradd -m myuser                                                                          0.1s
 => [4/4] COPY welcome.txt /home/myuser/welcome                                                          0.0s 
 => exporting to image                                                                                   0.1s 
 => => exporting layers                                                                                  0.1s 
 => => writing image sha256:8a191705008e08d79f7ceef10390deda63839ab4c782cefeb5dc9a81e69f6053             0.0s 
howdy@gwonminhyeog-ui-MacBookPro my-custom-image % docker run my-image:v1
hello, everyone.
```

[트러블 슈팅 #1. 이미지의 latest 태그 문제]
(문제): docker run my-image 명령어로 컨테이너를 실행하려고 했지만, "Unable to find image 'my-image:latest' locally" 라는 오류가 발생함.\
(원인 가설): 이미지를 빌드할 때 v1 이라는 태그를 사용했으나, run 명령어에서는 따로 태그를 붙이지 않아 문제가 생김.\
(확인): docker run my-image:v1 명령어로 실행하였을 때, 컨테이너가 정상적으로 실행됨.\
(해결): 태그를 확실히 붙여 실행함.
배운 점: 이미지를 빌드하거나 실행할 때 태그를 명시하지 않으면 자동으로 latest라는 태그를 붙여주지만 latest는 최신버전이라는 관용적 의미가 있을 뿐, 알아서 최신버전을 찾아 실행해주는 기능은 가지고있지 않다. 따라서 태그를 확실히 붙여야한다..

### 4-3. 포트매핑 및 접속 증거

포트매핑이란?
- 컨테이너는 내부 프라이빗 ip를 자동으로 할당받아 사용하므로, 외부와의 통신이 불가함.
- 이러한 한계를 극복하기 위해 호스트의 포트와 컨테이너의 포트를 매핑하여, 외부에서 들어오는 트래픽을 컨테이너로 전달하는 기술.

기존에 만들었던 my-image:v1 은 cat 명령어를 실행하고 바로 컨테이너가 종료되기 때문에, Nginx 가 포그라운드 프로세스로 유지될 수 있도록 Dockerfile 을 수정해 주었습니다.
```
FROM ubuntu:latest
LABEL maintainer="howdy <kmoru0103@gmail.com>"
ENV APP_ENV=production
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    nginx \
    curl \
    && rm -rf /var/lib/apt/lists/*
RUN useradd -m myuser
COPY welcome.txt /var/www/html/index.html
# USER myuser
CMD ["nginx", "-g", "daemon off;"]
```

이후 my-image:v2 를 빌드했습니다.
```
howdy@gwonminhyeog-ui-MacBookPro my-custom-image % docker build -t my-image:v2 .
[+] Building 0.1s (9/9) FINISHED                                                         docker:orbstack
 => [internal] load build definition from Dockerfile                                                0.0s
 => => transferring dockerfile: 376B                                                                0.0s
 => [internal] load metadata for docker.io/library/ubuntu:latest                                    0.0s
 => [internal] load .dockerignore                                                                   0.0s
 => => transferring context: 2B                                                                     0.0s
 => [1/4] FROM docker.io/library/ubuntu:latest                                                      0.0s
 => [internal] load build context                                                                   0.0s
 => => transferring context: 32B                                                                    0.0s
 => CACHED [2/4] RUN apt-get update && apt-get install -y     nginx     curl     && rm -rf /var/li  0.0s
 => CACHED [3/4] RUN useradd -m myuser                                                              0.0s
 => CACHED [4/4] COPY welcome.txt /var/www/html/index.html                                          0.0s
 => exporting to image                                                                              0.0s
 => => exporting layers                                                                             0.0s
 => => writing image sha256:1724e6088b9a909ee18de60c50833dbb131412f1abef257a4cca01fcf9a9c71f        0.0s
 => => naming to docker.io/library/my-image:v2   
```
컨테이너를 실행할 때, docker run 명령어의 -p 옵션을 이용하여 포트매핑을 시도할 수 있습니다.
docker run -p [호스트 포트번호]:[컨테이너 포트번호] [이미지]
```
howdy@gwonminhyeog-ui-MacBookPro my-custom-image % docker run --name my-container -p 8080:80 my-image:v2
```

일반적으로 컨테이너는 독립된 네트워크 환경을 가지므로 외부에서 직접 컨테이너 내부에 접근할 수 없지만, 포트 매핑을 통해 컨테이너 내부의 Nginx 가 제공하는 파일에 접근이 가능함을 확인할 수 있습니다.
```
howdy@gwonminhyeog-ui-MacBookPro ~ % curl localhost:8080
hello, everyone.
```

[트러블 슈팅 #2. 컨테이너의 종료 시점 문제]\
(문제): 정상적인 명령어로 포트매핑을 시도했음에도, localhost:8080 으로 접속이 되지 않음.\
(원인 가설): 기존 Dockerfile 의 CMD 명령어가 cat 명령어로 설정되어 있었기 때문에, 컨테이너가 실행되자마자 cat 명령어가 실행되고 종료되어 버렸을 가능성이 있음.\
(확인): docker run 명령어를 실행한 직후 ps 명령어로 컨테이너의 상태를 확인해 보았을 때, 실행중인 컨테이너가 확인되지 않음.\
(해결): CMD 명령어를 nginx 가 포그라운드 프로세스로 유지될 수 있도록 수정해 주었음. 이후 컨테이너를 재실행하였을 때, localhost:8080 으로 접속이 가능해졌음.

[트러블 슈팅 #3. 이미 사용중인 호스트 포트를 다른 컨테이너 포트에 연결하기]
(문제): second-container 에 호스트 포트 8080을 연결했지만 에러가 남.
```
howdy@gwonminhyeog-ui-MacBookPro my-custom-image % docker run -d -it --name second-container -p 8080:80 my-image:v2 
231bd7a083af0220d8c1febbb87e9d72fa37e16722227c9e0d75d5177d7853e3
docker: Error response from daemon: failed to set up container networking: driver failed programming external connectivity on endpoint second-container (6b93113ce51824a2f8937e2a99f713a80e9973575f4b378cbe02e99e0cc0d6cb): Bind for 0.0.0.0:8080 failed: port is already allocated
```
(원인 가설): 다른 컨테이너가 이미 호스트의 8080 포트를 점유중\
(확인): lsof -i 명령어를 사용히야 특정 포트를 점유중인 프로세스 확인
```
howdy@gwonminhyeog-ui-MacBookPro my-custom-image % lsof -i :8080
COMMAND    PID  USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
OrbStack  1626 howdy   95u  IPv4 0x8a2ee9c043ad79cb      0t0  TCP *:http-alt (LISTEN)
OrbStack  1626 howdy   96u  IPv6 0xf194e62d780a9269      0t0  TCP *:http-alt (LISTEN)
```
(해결): 기존에 8080 포트를 점유중이던 컨테이너를 종료하고 새로 연결함.
```
howdy@gwonminhyeog-ui-MacBookPro my-custom-image % docker stop first-container 
first-container
howdy@gwonminhyeog-ui-MacBookPro my-custom-image % docker rm first-container
first-container
howdy@gwonminhyeog-ui-MacBookPro my-custom-image % docker run -d -it --name second-container -p 8080:80 my-image:v2 
76e03fb4a3c3f99b3f3585b3f321b4003bb27026bf3e8d8fba58ee2986de1582
```
### 4-4. 바인드 마운트 반영, 볼륨 영속성 검증
볼륨과 마운트
- 볼륨: 도커가 컨테이너의 데이터를 보존하기 위해 자체적으로 관리하는 디렉터리 또는 파일. 
- 바인드 마운트: 호스트의 파일 시스템 경로를 컨테이너 내부에 연결하는 기술

호스트의 bind 디렉토리를 컨테이너 내부의 data 디렉토리와 바인드 마운트 한 뒤, 호스트의 bind 디렉토리에 hello.txt 파일을 만들고, 컨테이너 내부의 data 디렉토리에서 해당 파일이 존재하는지 확인해 보았습니다.
1. 바인드 마운트 반영
```
howdy@gwonminhyeog-ui-MacBookPro ~ % docker run -d -it --name sec-container -v ./bind:/data my-image:v2 
bdda78f106e5bc1f561997202c165b51daf74f27ba7583bf0f84f05d8d3504c6
howdy@gwonminhyeog-ui-MacBookPro ~ % cd bind 
howdy@gwonminhyeog-ui-MacBookPro bind % touch hello.txt 
howdy@gwonminhyeog-ui-MacBookPro bind % echo 'hi everyone.' >> hello.txt
howdy@gwonminhyeog-ui-MacBookPro bind % docker exec -it sec-container sh
# cat ./data/hello.txt
hi everyone.
```
\
2. 볼륨 영속성 검증\
볼륨을 생성하고, 컨테이너를 만들어 연결해 주었습니다.
```
howdy@gwonminhyeog-ui-MacBookPro ~ % docker volume create my-volume
howdy@gwonminhyeog-ui-MacBookPro ~ % docker run -d -it --name my-contaner -v my-volume:/data my-image:v2
e1f2050aaeb2fb5c689fe14154aa8b9933303e99647962a2b6e6155b4edc68a1
```
docker inspect 명령어를 이용하여 컨테이너의 메타데이터를 확인해주면, Mount 섹션에서 볼륨 연결을 확인해 볼 수 있습니다.
```
howdy@gwonminhyeog-ui-MacBookPro ~ % docker inspect my-container

  "Mounts": [
            {
                "Type": "volume",
                "Name": "my-volume",
                "Source": "/var/lib/docker/volumes/my-volume/_data",
                "Destination": "/data",
                "Driver": "local",
                "Mode": "z",
                "RW": true,
                "Propagation": ""
            }
        ]
```

볼륨과 연결된 컨테이너 내부의 data 폴더에 hello.txt 를 만들고, 내용도 입력해 주었습니다.
```
howdy@gwonminhyeog-ui-MacBookPro ~ % docker exec -it my-container sh
# ls
bin		   boot  dev  home  media  opt	 root  sbin		   srv	tmp  var
bin.usr-is-merged  data  etc  lib   mnt    proc  run   sbin.usr-is-merged  sys	usr
# cd data
# touch test.txt
# echo 'hello' >> test.txt
```
기존에 연결해 두었던 컨테이너를 삭제하고, 새로 컨테이너를 생성한 뒤, 볼륨을 연결하였습니다.\
이로서 기존에 볼륨에 저장되어있는 데이터의 영속성을 확인할 수 있었습니다.
```
howdy@gwonminhyeog-ui-MacBookPro ~ % docker rm -f my-container   
my-container
howdy@gwonminhyeog-ui-MacBookPro ~ % docker run -d -it --name test-container -v my-volume:/data my-image:v2 
59c3952d70c3f6ee5012b8c85eb7ff1338d54d169485067ef9107c0607741e16
howdy@gwonminhyeog-ui-MacBookPro ~ % docker exec -it test-container sh
# ls
bin		   boot  dev  home  media  opt	 root  sbin		   srv	tmp  var
bin.usr-is-merged  data  etc  lib   mnt    proc  run   sbin.usr-is-merged  sys	usr
# cd data
# ls
test.txt
# cat test.txt
hello
```

### 5. Git 설정 및 GitHub 연동
1. Git 설정
사용자 이름과 이메일을 설정해 주었습니다. \
이후 git config --list 명령어로 설정이 잘 반영되었는지 확인해 보았습니다.
```
howdy@gwonminhyeog-ui-MacBookPro ~ % mkdir git-project
howdy@gwonminhyeog-ui-MacBookPro ~ % cd git-project 
howdy@gwonminhyeog-ui-MacBookPro git-project % git init
Initialized empty Git repository in /Users/howdy/git-project/.git/
howdy@gwonminhyeog-ui-MacBookPro git-project % git config --global user.name "howdy27"
howdy@gwonminhyeog-ui-MacBookPro git-project % git config --global user.email "kmoru0103@gmail.com"
howdy@gwonminhyeog-ui-MacBookPro git-project % git config --list
credential.helper=osxkeychain
init.defaultbranch=main
user.name=howdy27
user.email=kmoru0103@gmail.com
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
core.ignorecase=true
core.precomposeunicode=true
```
GitHub 와 VSCode 를 연동한 뒤, remote-v 명령어로 확인해 보았습니다.
```
howdy@gwonminhyeog-ui-MacBookPro git-project % git remote -v
origin	https://github.com/howdy27/git-project.git (fetch)
origin	https://github.com/howdy27/git-project.git (push)
```

절대경로와 상대경로 선택
- 절대경로: 파일 시스템의 루트에서부터 해당 위치까지의 경로.
- 상대경로: 현재 위치에서 해당 위치까지의 상대적인 경로.

이식성을 위해 프로젝트 내부 자원끼리는 상대경로를 사용하고, 시스템 공용 설정 파일들은 절대경로를 사용하는 것이 좋음.

파일 권한 숫자 표기
- 읽기/쓰기/실행 권한에는 각각 4/2/1 이라는 값이 부여되어 있음.
- 소유자/그룹/기타사용자 의 권한을 표기할 때 그 값들을 모두 더해 표기할 수 있음.
- 예를 들어 rw-r--r-- 는 644 라고 표기하는 식.