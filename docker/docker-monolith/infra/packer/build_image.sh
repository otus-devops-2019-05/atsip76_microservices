#!/bin/bash - 
#===============================================================================
#
#          FILE: build_image.sh
# 
#         USAGE: ./build_image.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 04.08.2019 16:28
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

#packer build -var-file=./variables.json ./ubuntu16-docker.json
packer build ./ubuntu16-docker.json
