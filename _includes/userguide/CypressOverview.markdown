The Cypress cluster uses the Hortonworks Data Platform version 2.4.2.0-258 to support data-intensive computing and big data analytics.

Phase	| Count | Make | Model | CPU type | Cores | RAM | Local Storage | Host Names
--------|-------|------|-------|----------|-------|-----|----------------|--------------
0 | 16 | HP | PE1950 | Intel Xeon E2665 | 16 | 256 GB | 12 TB | dsci00[1-16].palmetto.clemson.edu
1 | 1 | HP | PE1950 | Intel Xeon E2620 | 6 | 128 GB | 500 GB | dsciu001.palmetto.clemson.edu
1 | 1 | HP | PE1950 | Intel Xeon E2620 | 6 | 128 GB | 500 GB | dscim001.palmetto.clemson.edu
1 | 1 | HP | PE1950 | Intel Xeon E2620 | 6 | 128 GB | 500 GB | dscim002.palmetto.clemson.edu
1 | 1 | HP | PE1950 | Intel Xeon E2620 | 6 | 128 GB | 500 GB | dscim003.palmetto.clemson.edu
1 | 24 | HP | PE1950 | Intel Xeon E2620 | 24 | 256 GB | 500 GB | dsci[17-40].palmetto.clemson.edu


- In order to interact with Cypress, users must be logged on to **dsciu001**. This can be done from **user001** after logging on to the Palmetto cluster. At the moment, there is no specific Palmetto queue for **dsciu001**. This might be changed in the future. Users do not have direct ssh access to any other nodes in the Cypress cluster.  
- The web interface to the Apache Ambari server is located at http://dscim003.palmetto.clemson.edu:8080. The public login/password to observe the server component is *user/user*. The IP address of this web interface, as well as the web interfaces of all components on Hadoop is only available internally to Palmetto nodes. To view these interfaces, you must open a Firefox browser from one of the compute nodes of Palmetto via X11 tunnel. 
