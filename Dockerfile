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