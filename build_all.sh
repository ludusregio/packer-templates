#!/bin/bash -eu

LOGFILE="/tmp/build_all.log"
#export USE_DOCKERIZED_PACKER="true"

(

  for PACKER_VAGRANT_PROVIDER in libvirt virtualbox; do
    for BUILD in ubuntu-18.04-desktop ubuntu-{18.04,16.04,14.04}-server my_ubuntu-{18.04,16.04}-server my_centos-7 my_windows-10 windows-10 windows-2016 windows-2012_r2; do
      echo "**** `date`"
      ./build.sh $BUILD:$PACKER_VAGRANT_PROVIDER
    done
  done

  ./vagrant_init_destroy_boxes.sh

) 2>&1 | tee $LOGFILE
