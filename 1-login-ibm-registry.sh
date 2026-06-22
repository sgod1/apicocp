#!/bin/bash

export PATH=".:bin:$PATH"

credsenv=${1:-"creds.env"}

if [[ ! -f $credsenv ]]; then
   echo creds env file $credenv not found
   exit 1
fi

source $credsenv

reguser="$CP_ICR_IO_USER"
regpass="$IBM_ENTITLEMENT_KEY"

set -x

podman login cp.icr.io -u "$reguser" -p "$regpass"
