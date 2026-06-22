#!/bin/bash

export PATH=.:bin:$PATH

caseenv=${1:-case.env}

if [[ -z $caseenv ]]; then echo case env file required; exit 1; fi
if [[ ! -f $caseenv ]]; then echo case env file $caseenv not found; exit 1; fi

source pak.env
source $caseenv

if [[ -z $CASE_NAME ]]; then echo "case name parameter required..."; exit 1; fi
if [[ -z $CASE_VERSION ]]; then echo "case version parameter required..."; exit 1; fi

cats=$IBMPAK_HOME/.ibm-pak/data/mirror/$CASE_NAME/$CASE_VERSION/catalog-sources.yaml

if [[ ! -f $cats ]]; then
   echo catalog sources file $cats not found
   exit 1
fi

echo applying $cats

set -x

oc apply -f $cats
