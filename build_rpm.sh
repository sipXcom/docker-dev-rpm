#!/bin/bash
set -e

if [ "$1" = 'init' ]; then
    cd /home/sipx/sipxcom
    sudo rm -rf build
    sudo autoreconf -if
    sudo mkdir build && cd build
    sudo ../configure --enable-rpm UPSTREAM_URL=http://download.sipxcom.org/pub/$SIPXCOM_VERSION-unstable/ CENTOS_RSYNC_URL=rsync://download.sipxcom.org/pub MIRROR_SITE=http://download.sipxcom.org/pub PACKAGE_REVISION=stable
    sudo make repo-create
    sudo chown -R sipx:sipx /home/sipx/sipxcom/build/repo/
    sudo make repo-init
else
  cd /home/sipx/sipxcom/build
  IFS=',' list=($1)
  for item in "${list[@]}"; do sudo make $item.rpm; done
fi
