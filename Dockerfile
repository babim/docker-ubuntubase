FROM ubuntu:bionic
# Maintainer
# ----------
MAINTAINER babim <babim@matmagoc.com>

RUN  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
	apt-get update && apt-get install -y \
	    locales nano openssh-server bash curl

# copyright and timezone
RUN bash <(curl -s https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20SCRIPT%20AUTO/copyright.sh)

RUN mkdir /var/run/sshd
# set password root is root
RUN echo 'root:root' | chpasswd
# allow root ssh
RUN sed -i -e '/^PermitRootLogin/s/^.*$/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
ENTRYPOINT ["/runssh.sh"]

   
ADD runssh.sh /runssh.sh
RUN chmod +x /runssh.sh
