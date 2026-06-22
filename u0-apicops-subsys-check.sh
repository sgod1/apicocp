#!/bin/bash

export PATH=.:bin:$PATH

set -x

apicops system:pre-upgrade-check management
