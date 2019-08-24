#!/bin/bash -
#===============================================================================
#
#          FILE: provision.sh
#
#         USAGE: ./provision.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (),
#  ORGANIZATION:
#       CREATED: 22.08.2019 15:02
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
sudo apt -y update && sudo apt install -y docker.io python-pip && pip install docker-py\
 && sudo systemctl start docker && sudo systemctl enable docker && sudo usermod -aG docker appuser\
 && sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose\
 && sudo chmod +x /usr/local/bin/docker-compose && sudo mkdir -p /srv/gitlab/config /srv/gitlab/data /srv/gitlab/logs && cd /srv/gitlab/\
 && sudo curl -LJO https://gist.githubusercontent.com/Nklya/c2ca40a128758e2dc2244beb09caebe1/raw/e9ba646b06a597734f8dfc0789aae79bc43a7242/docker-compose.yml
