FROM centos:latest
MAINTAINER Michal Jurosz <docker@mj41.cz>

RUN yum install -y perl git perl-JSON perl-Data-Dumper perl-YAML perl-libwww-perl perl-File-Copy-Recursive \
  && yum clean all

RUN useradd ttucl
WORKDIR /home/ttucl/
USER ttucl
ENV HOME /home/ttucl

RUN git clone https://github.com/mj41/TapTinder-Client.git tt-client
RUN mkdir -p /home/ttucl/client-conf /home/ttucl/client-data
RUN cp /home/ttucl/tt-client/conf/client-conf.yml.example /home/ttucl/client-conf/client-conf.yml

WORKDIR /home/ttucl/tt-client
RUN git log -n1 --oneline HEAD

ENV TAPTINDER_COMPONENT client

CMD /home/ttucl/tt-client/ttclient-start.sh --ver=5
