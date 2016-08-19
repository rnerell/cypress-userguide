
The Cypress cluster uses many components included with the <a href="https://hortonworks.com/products/data-center/hdp/" target="_blank">Hortonworks Data Platform (HDP)</a> - Version 2.4.2.0-258 to support data-intensive computing and big data analytics.

Phase	| Count | Make | Model | CPU type | Cores | RAM | Local Storage | Host Names
--------|-------|------|-------|----------|-------|-----|----------------|--------------
000 | 16 | Dell Inc. | PowerEdge C8220 | Intel Xeon CPU E5-2650 0 @ 2.00GHz | 16 | 256 GB | 12 x 1 TB Drives | {dsci001-dsci016}.palmetto.clemson.edu
001 | 24 | HP | ProLiant XL420 Gen9 | Intel Xeon CPU E5-2680 v3 @ 2.50GHz | 24 | 256 GB | 24 x 6 TB Drives | {dsci017-dsci040}.palmetto.clemson.edu

**NOTE:** The following nodes are not described above because they are dedicated for user access and master services respectively:

- **USER NODE**: dsciu001.palmetto.clemson.edu (also known as cypress.clemson.edu)
- **MASTER NODES:** {dscim001-dscim003}.palmetto.clemson.edu
