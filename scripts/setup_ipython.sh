#!/bin/bash

###############################################################
# Copyright (C) 2015 ClassCat(R) Co.,Ltd. All rights reserved.
###############################################################

export LC_ALL=C

. ../conf/notebook.conf


function init () {
  sudo apt-get update
}

function install_ipython () {
  sudo apt-get install -y ipython ipython-notebook

  sudo apt-get install -y python-numpy python-matplotlib python-nose
  sudo apt-get install -y python-scipy python-pandas python-sympy
}


function config_ipython () {
  local PROFILE_PATH=~/.ipython/profile_spark
  local PW_SHA1=`../pyscripts/pwgen.py ${NOTEBOOK_PASSWD}`

  ipython profile create spark

  mv ${PROFILE_PATH}/ipython_notebook_config.py ${PROFILE_PATH}/ipython_notebook_config.py.orig

  cp -p ../assets/ipython_notebook_config.py.template ${PROFILE_PATH}/ipython_notebook_config.py

  sed -i.bak -e "s/^c\.NotebookApp\.password\s*= \s*.*/c.NotebookApp.password = u'${PW_SHA1}'/" ${PROFILE_PATH}/ipython_notebook_config.py
}


function config_bash_profile () {
  echo "export SPARK_HOME=/opt/spark" >> ~/.bash_profile
  echo 'export PATH=${SPARK_HOME}/bin:$PATH' >> ~/.bash_profile

  echo -e "\nexport IPYTHON=1" >> ~/.bash_profile
  echo 'export IPYTHON_OPTS="notebook --profile=spark"' >> ~/.bash_profile
}


###################
### ENTRY_POINT ###
###################

init

install_ipython

config_ipython

config_bash_profile

exit 0

### End of Script ###
