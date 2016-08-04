
The Cypress cluster uses many components included with the <a href="https://hortonworks.com/products/data-center/hdp/" target="_blank">Hortonworks Data Platform</a> - Version 2.4.2.0-258 to support data-intensive computing and big data analytics.

Phase	| Count | Make | Model | CPU type | Cores | RAM | Local Storage | Host Names
--------|-------|------|-------|----------|-------|-----|----------------|--------------
000 | 16 | Dell Inc. | PowerEdge C8220 | Intel Xeon CPU E5-2650 0 @ 2.00GHz | 16 | 256 GB | 12 x 1 TB Drives | {dsci001-dsci016}.palmetto.clemson.edu
001 | 24 | HP | ProLiant XL420 Gen9 | Intel Xeon CPU E5-2680 v3 @ 2.50GHz | 24 | 256 GB | 24 x 6 TB Drives | {dsci017-dsci040}.palmetto.clemson.edu

**NOTE:** The following nodes are not described above because they are dedicated for user access and master services respectively:
- dsciu001.palmetto.clemson.edu
- {dscim001-dscim003}.palmetto.clemson.edu

- In order to interact with Cypress, users must be logged on to **dsciu001**. This can be done from **user001** after logging on to the Palmetto cluster. At the moment, there is no specific Palmetto queue for **dsciu001**. This might be changed in the future. Users do not have direct ssh access to any other nodes in the Cypress cluster.  
- The web interface to the Apache Ambari server is located at http://dscim003.palmetto.clemson.edu:8080. The public login/password to observe the server component is *user/user*. The IP address of this web interface, as well as the web interfaces of all components on Hadoop is only available internally to Palmetto nodes. To view these interfaces, you must open a Firefox browser from one of the compute nodes of Palmetto via X11 tunnel. Instruction on how to set upo X11 tunneling can be found [here](http://www.palmetto.clemson.edu/pages/userguide.html#graphical).
