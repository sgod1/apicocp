#!/bin/bash

export PATH=.:./bin:$PATH

source pak.env

oc ibm-pak config repo 'IBM Cloud-Pak OCI registry' -r oci:cp.icr.io/cpopen --enable

# oc-mirror, oc-image-mirror
oc ibm-pak config mirror-tools --enabled $MIRROR_TOOLS
