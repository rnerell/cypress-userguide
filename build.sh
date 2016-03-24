#!/bin/bash

module load ruby/2.1.1

set -xe

rm -rf _site
jekyll build
chown -R :staff _site 
chmod -R g+w _site

