FROM i386/ubuntu:bionic
# Maintainer
# ----------
MAINTAINER babim <babim@matmagoc.com>

# Set timezone to VN
ENV TZ Asia/Ho_Chi_Minh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ARG DEBIAN_FRONTEND="noninteractive"
ENV TERM="xterm" LANG="C.UTF-8" LC_ALL="C.UTF-8"

RUN rm -f /etc/motd && \
    echo "---" > /etc/motd && \
    echo "Support by Duc Anh Babim. Contact: babim@matmagoc.com" >> /etc/motd && \
    echo "---" >> /etc/motd && \
    touch "/(C) Babim"

RUN  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
	apt-get update && apt-get install -y \
	    locales nano

RUN dpkg-reconfigure locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /build && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup
