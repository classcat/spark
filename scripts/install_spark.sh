#!/bin/bash

###############################################################
# Copyright (C) 2015 ClassCat(R) Co.,Ltd. All rights reserved.
###############################################################

#--- HISOTRY --------------------------------------------------
# 19-sep-15 : 1.5.0
#--------------------------------------------------------------

export LC_ALL=C

. ../conf/spark.conf


function check_if_continue () {
  local var_continue

  echo -ne "About to install Spark: ${TARGET}. Continue ? (y/n) : " >&2

  read var_continue
  if [ -z "$var_continue" ] || [ "$var_continue" != 'y' ]; then
    echo -e "Exit the install program."
    echo -e ""
    exit 1
  fi
}


function init () {
  check_if_continue

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

  cp -p spark/conf/log4j.properties.template spark/conf/log4j.properties

  sed -i.bak -e "s/^log4j\.rootCategory=.*/log4j.rootCategory=WARN, console/" spark/conf/log4j.properties
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
