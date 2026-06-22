#!/bin/bash

export PATH=.:bin:$PATH

caseenv=${1:-case.env}

if [[ -z $caseenv ]]; then echo case env file required; exit 1; fi
if [[ ! -f $caseenv ]]; then echo case env file $caseenv not found; exit 1; fi

source pak.env
source $caseenv

if [[ -z $CASE_NAME ]]; then echo "case name parameter required..."; exit 1; fi
if [[ -z $CASE_VERSION ]]; then echo "case version parameter required..."; exit 1; fi

image_digest_file=$IBMPAK_HOME/.ibm-pak/data/mirror/$CASE_NAME/$CASE_VERSION/image-digest-mirror-set.yaml

if [[ ! -f $image_digest_file ]]; then
   echo image digest file $image not found
   exit 1
fi

echo applying $image_digest_file

set -x

oc apply -f $image_digest_file
