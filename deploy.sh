#!/bin/bash

set -xe

sudo rsync -avzhe ssh --progress _site/ webapp01:/var/www/hadoop

