#!/bin/bash

if [ ! -e "env.sh" ]
then
  echo "ERROR: env.sh not found."
  exit 3
fi
# shellcheck disable=SC1091
source env.sh

if [ ! -e "generate.C" ]
then
  echo "ERROR: generate.C not found."
  exit 3
fi
aliroot -b -q generate.C > generation.log

if [ ! -e "lego_train.sh" ]
then
  echo "ERROR: lego_train.sh not found."
  exit 3
fi
#chmod u+x lego_train.sh

# for MC generation testing
export ALIEN_PROC_ID=12345678

bash ./lego_train.sh > stdout 2> stderr

if [ ! -e "lego_train_validation.sh" ]
then
  echo "ERROR: lego_train_validation.sh not found."
  exit 3
fi
#chmod u+x lego_train_validation.sh

bash ./lego_train_validation.sh > validation.log
