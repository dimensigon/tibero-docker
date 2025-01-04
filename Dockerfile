#Dockerfile
#Requirements on host(Linux): sysctl -w net.ipv4.ip_forward=1

#Check "Testing Tibero on your own" Blog post for sysctl config and limits.

# License file requires hostname "tibero7" from now on.
#docker run -h tibero7 -it dimensigon/tibero
#docker run -h tibero7 -dt dimensigon/tibero

### Base + Prereqs

FROM centos:7

LABEL maintainer="contact@dimensigon.com"

COPY prepare.bash /root/prepare.bash

COPY CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo

COPY bash_profile_tibero /home/tibero/.bash_profile

COPY --chown=tibero:dba --chmod=755 start.bash /home/tibero/

ADD --chown=tibero:dba https://store.dimensigon.com/wp-content/tibero-docker/tibero7-latest.tar.gz /home/tibero/

ADD --chown=tibero:dba https://store.dimensigon.com/wp-content/tibero-docker/license.xml /home/tibero/tibero7/license/

RUN bash /root/prepare.bash

WORKDIR /home/tibero

RUN tar -xf tibero7-latest.tar.gz

RUN rm tibero7-latest.tar.gz

RUN chown -R tibero:dba /home/tibero

ENTRYPOINT su - tibero -c "bash /home/tibero/start.bash" && /bin/bash

EXPOSE 8629-8649

