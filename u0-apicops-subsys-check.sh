#!/bin/bash

export PATH=.:bin:$PATH

subsys=${1:-"management"}

set -x

apicops system:pre-upgrade-check $subsys
