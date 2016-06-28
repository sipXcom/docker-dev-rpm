FROM mattdm/fedora:f19

COPY sipxcom.repo /etc/yum.repos.d/sipxcom.repo

RUN yum -y install epel-release; yum clean all && yum -y install git \
  make \
  autoconf \
  automake \
  dart-sdk \
  rpm-build \
  libxslt \
  mock \
  sudo \
  createrepo \
  thttpd \
  libtool \
  openssl-devel \
  java-1.7.0-openjdk \
  java-1.7.0-openjdk-devel \
  ruby \
  ruby-devel \
  rubygems \
  wget && \
  gem install fpm && rm -rf /etc/yum.repos.d/sipxcom.repo && yum clean all && \
  useradd -m sipx && usermod -G mock sipx && echo "sipx    ALL=(ALL)       NOPASSWD:ALL" >> /etc/sudoers

VOLUME ["/home/sipx/sipxcom"]

COPY ./build_rpm.sh /home/sipx/build_rpm.sh
RUN chmod +x /home/sipx/build_rpm.sh

RUN chown -R sipx:sipx /home/sipx

USER sipx
ENV HOME /home/sipx
WORKDIR /home/sipx/sipxcom

ENTRYPOINT ["/home/sipx/build_rpm.sh"]
