#!/bin/bash

export PATH=.:bin:$PATH

caseenv=${1:-case.env}

if [[ -z $caseenv ]]; then echo case env file required; exit 1; fi
if [[ ! -f $caseenv ]]; then echo case env file $caseenv not found; exit 1; fi

source pak.env
source registry.env
source $caseenv

if [[ -z $CASE_NAME ]]; then echo "case name parameter required..."; exit 1; fi
if [[ -z $CASE_VERSION ]]; then echo "case version parameter required..."; exit 1; fi
if [[ -z $TARGET_REGISTRY ]]; then echo "target registry parameter required..."; exit 1; fi
if [[ -z $REGISTRY_AUTH_FILE ]]; then echo "registry auth file parameter required..."; exit 1; fi

0-config-ibm-pak.sh

set -x
oc image mirror -f $IBMPAK_HOME/.ibm-pak/data/mirror/$CASE_NAME/$CASE_VERSION/images-mapping.txt --filter-by-os '.*' -a $REGISTRY_AUTH_FILE --skip-multiple-scopes --max-per-registry=1
