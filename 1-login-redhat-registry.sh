#!/bin/bash -x

export PATH=.:bin:$PATH

credsenv=${1:-"creds.env"}

if [[ ! -f $credsenv ]]; then
   echo creds env file $credsenv not found
   exit 1
fi

source $credsenv

rhu="$REGISTRY_REDHAT_IO_USER"
rhp="$REGISTRY_REDHAT_IO_PASSWORD"

podman login registry.redhat.io -u $rhu -p $rhp
