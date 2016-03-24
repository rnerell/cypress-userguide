#!/bin/bash  -xe

: "Deploying Hadoop User Guide to Clemix"

ssh clemix.clemson.edu 'rm -r /web/virts/citi/public_html/hadoop/*'
rsync -avzhe ssh --progress _site/ clemix.clemson.edu:/web/virts/citi/public_html/hadoop/
ssh clemix.clemson.edu 'chown -R :web_citi /web/virts/citi/public_html/hadoop/*'
ssh clemix.clemson.edu 'chmod g+w -R /web/virts/citi/public_html/hadoop/*'

