#!/bin/bash

export PATH=.:$PATH

set -x

mkdir -p bin

outdir=bin
cd bin

# oc
wget https://mirror.openshift.com/pub/openshift-v4/amd64/clients/ocp/stable-4.20/openshift-client-linux.tar.gz
wget https://mirror.openshift.com/pub/openshift-v4/amd64/clients/ocp/stable-4.20/openshift-client-mac-arm64.tar.gz

# oc mirror
wget https://mirror.openshift.com/pub/openshift-v4/amd64/clients/ocp/stable-4.20/oc-mirror.tar.gz

# cloudpak plugin
wget https://github.com/IBM/ibm-pak/releases/download/v1.23.1/oc-ibm_pak-linux-amd64.tar.gz
wget https://github.com/IBM/ibm-pak/releases/download/v1.23.1/oc-ibm_pak-darwin-arm64.tar.gz
wget https://github.com/IBM/ibm-pak/releases/download/v1.23.1/oc-ibm_pak-darwin-amd64.tar.gz

# apicops
wget https://github.com/ibm-apiconnect/apicops/releases/download/v0.12.2/apicops-v12-linux-amd64
wget https://github.com/ibm-apiconnect/apicops/releases/download/v0.12.2/apicops-v12-macos

cd ..
