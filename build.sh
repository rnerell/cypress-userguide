#!/bin/bash

cd $(dirname $0)

set -xe
module load ruby/2.1.1

# Remove old site, rebuild it, and change permissions to _site/
rm -rf _site
sudo chown -R :staff .
sudo chmod -R g+rw .
jekyll build --config _config_palmetto_build.yml
chown -R :staff _site 
chmod -R g+w _site

