#!/bin/bash

export PATH=.:./bin:$PATH

source pak.env

source ${1:-"./case.env"}

0-config-ibm-pak.sh

oc ibm-pak list
