#!/bin/bash
export PATH=.:bin:$PATH

caseenv=${1:-case.env}

if [[ -z $caseenv ]]; then echo case env file required; exit 1; fi
if [[ ! -f $caseenv ]]; then echo case env file $caseenv not found; exit 1; fi

source pak.env
source registry.env
source $caseenv

case_name=$CASE_NAME
case_version=$CASE_VERSION
#filterarg="--filter <list of groups>"
target_registry=$TARGET_REGISTRY

if [[ -z $case_name ]]; then echo "case name parameter required..."; exit 1; fi
if [[ -z $case_version ]]; then echo "case version parameter required..."; exit 1; fi
if [[ -z $target_registry ]]; then echo "target registry parameter required..."; exit 1; fi

0-config-ibm-pak.sh

echo "generating mirror manifests for... $case_name $case_version"

oc ibm-pak generate mirror-manifests $case_name $target_registry --version $case_version $filterarg
