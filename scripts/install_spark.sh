#!/bin/bash

###############################################################
# Copyright (C) 2015 ClassCat(R) Co.,Ltd. All rights reserved.
###############################################################

export LC_ALL=C

. ../conf/my.conf


function init () {
  apt-get update
}


function install_jdk () {
  apt-get install -y openjdk-7-jdk
}


function get_spark_archive () {
  wget ${URL_FOR_DOWNLOAD}/${TARGET}.tgz
}


function config_spark () {
  tar xfz ${TARGET}.tgz

  chown -R root.root ${TARGET}

  ln -s ${TARGET} spark

  cp -p conf/log4j.properties.template conf/log4j.properties
}


###################
### ENTRY_POINT ###
###################

init

install_jdk

cd ${PREFIX}

get_spark_archive

config_spark

cd ~

exit 0

### End of Script ###
