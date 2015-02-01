FROM fedora:21
MAINTAINER Michal Jurosz <docker@mj41.cz>

RUN yum install -y perl \
     perl-Test-Simple perl-Test-More perl-Test-Harness perl-ExtUtils-MakeMaker \
     perl-ExtUtils-Install perl-Module-Build perl-ExtUtils-MakeMaker perl-Module-Install \
     perl-JSON perl-Data-Dumper perl-YAML perl-libwww-perl perl-File-Copy-Recursive \
     make gcc gcc-c++ tree tar gzip git \
  && yum clean all

RUN useradd --uid 460 -U ttucl
WORKDIR /home/ttucl/
USER ttucl
ENV HOME /home/ttucl

# ToDo? RUN eval $(perl -I/home/ttucl/perl5/lib/perl5/ -Mlocal::lib)
ENV PERL_LOCAL_LIB_ROOT /home/ttucl/perl5
ENV PERL_MB_OPT --install_base /home/ttucl/perl5
ENV PERL_MM_OPT INSTALL_BASE=/home/ttucl/perl5
ENV PERL5LIB /home/ttucl/perl5/lib/perl5
ENV PATH /home/ttucl/perl5/bin:$PATH

RUN mkdir /tmp/cpanm-ins \
  && cd /tmp/cpanm-ins \
  && curl -LO https://raw.githubusercontent.com/miyagawa/cpanminus/master/cpanm \
  && chmod +x cpanm \
  && export PERL_CPANM_HOME=/tmp/cpanm-ins/ \
  && ./cpanm App::cpanminus \
  && cd /home/ttucl \
  && rm -rf /tmp/cpanm-ins

RUN mkdir -p -m 0777 /tmp/cpanm/ \
  && export PERL_CPANM_HOME=/tmp/cpanm/ \
  && ~/perl5/bin/cpanm TAP::Harness::Archive \
  && echo "cpanm finished ok" \
  && rm -rf /tmp/cpanm/

RUN git clone https://github.com/mj41/TapTinder-Client.git tt-client
WORKDIR /home/ttucl/tt-client
RUN echo "Force Docker image rebuild of TapTinder client to particular revision." \
  && git fetch && git reset --hard 02e5ed028b \
  && git log -n1 --oneline HEAD

ENV TAPTINDER_COMPONENT client
ENV TAPTINDER_REPOS_DIR /opt/taptinder/repos
ENV TAPTINDER_CLIENT_CONF_DIR /opt/taptinder/client/conf/

CMD /home/ttucl/tt-client/ttclient-start.sh --ver=5
