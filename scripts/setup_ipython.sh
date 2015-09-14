#!/bin/bash

###############################################################
# Copyright (C) 2015 ClassCat(R) Co.,Ltd. All rights reserved.
###############################################################

export LC_ALL=C


function init () {
  sudo apt-get update
}

function install_ipython () {
  sudo apt-get install -y ipython ipython-notebook
}

function config_ipython () {
  ipython profile create ccnb

  mv .ipython/profile_spark/ipython_notebook_config.py .ipython/profile_spark/ipython_notebook_config.py.orig

  cp -p ../assets/ipython_notebook_config.py.template .ipython/profile_spark/ipython_notebook_config.py

  local PW_SHA1=`../pyscripts/pwgen.py ${NOTEBOOK_PASSWD}`

  sed -i.bak -e "s/^c\.NotebookApp\.password\s*= \s*.*/c.NotebookApp.password = u'${PW_SHA1}'/" ~/.ipython/profile_spark/ipython_notebook_config.py
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

intall_ipython

config_ipython

config_bash_profile

exit 0

### End of Script ###
