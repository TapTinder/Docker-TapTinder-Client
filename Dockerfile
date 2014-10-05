FROM centos:latest
MAINTAINER Michal Jurosz <docker@mj41.cz>

RUN yum install -y perl git perl-JSON perl-Data-Dumper perl-YAML perl-libwww-perl perl-File-Copy-Recursive \
  && yum clean all

RUN useradd taptinder
WORKDIR /home/taptinder/
USER taptinder
ENV HOME /home/taptinder

RUN git clone https://github.com/mj41/TapTinder-Client.git tt-client
RUN mkdir -p /home/taptinder/client-conf /home/taptinder/client-data
RUN cp /home/taptinder/tt-client/conf/client-conf.yml.example /home/taptinder/client-conf/client-conf.yml
VOLUME [ "/home/taptinder/client-conf" ]

WORKDIR /home/taptinder/tt-client
RUN git log -n1 --oneline HEAD

ENV TAPTINDER_COMPONENT client

CMD /home/taptinder/tt-client/ttclient-start.sh --ver=5
