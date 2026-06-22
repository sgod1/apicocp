#!/bin/bash

export PATH=".:bin:$PATH"

credsenv=${1:-"creds.env"}

if [[ ! -f $credsenv ]]; then
   echo creds env file $credenv not found
   exit 1
fi

source $credsenv
source registry.env

reguser="$PRIVATE_REGISTRY_USER"
regpass="$PRIVATE_REGISTRY_PASSWORD"

set -x

podman login $TARGET_REGISTRY -u $reguser -p $regpass
