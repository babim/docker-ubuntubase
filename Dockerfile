FROM ubuntu

MAINTAINER "Duc Anh Babim" <ducanh.babim@yahoo.com>

RUN rm -f /etc/motd && \
    echo "---" > /etc/motd && \
    echo "Support by Duc Anh Babim. Contact: ducanh.babim@yahoo.com" >> /etc/motd && \
    echo "---" >> /etc/motd && \
    echo "Babim Container Framework \n \l" > /etc/issue && \
    touch "/(C) Babim"

RUN apt-get clean && \
    apt-get update && \
    apt-get dist-upgrade -y --force-yes && \
    apt-get install nano -y

## Fix locale.
RUN apt-get install language-pack-en
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8 
RUN echo -n en_US.UTF-8 > /etc/container_environment/LANG
RUN echo -n en_US.UTF-8 > /etc/container_environment/LC_CTYPE
RUN echo -n en_US:en > /etc/container_environment/LANGUAGE
RUN echo -n en_US.UTF-8 > /etc/container_environment/LC_ALL
    
RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /build && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup
