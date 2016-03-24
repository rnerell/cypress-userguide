The status of applications and data on Cypress is monitored through various web UIs that are accessible from Clemson internal IP addresses (Clemson eduroam, Ethernet, or VPN). 

#### Hadoop File System
The UIs for the Hadoop Namenodes are:

    namenode1.palmetto.clemson.edu:50070
    OR
    namenode2.palmetto.clemson.edu:50070

Usually, only one of the two namenodes will be active. 

#### YARN
The UI for YARN's Resource Manager is:

    resourcemgr.palmetto.clemson.edu:8088

#### HBase
The UIs for HBase's Master Server is:

    namenode1.palmetto.clemson.edu:16010
    OR
    namenode2.palmetto.clemson.edu:16010
  
#### Oozie
The UI for Oozie's Web Console is:

    namenode2.palmetto.clemson.edu:11000

#### Storm
The UI for Storm is:

    namenode2.palmetto.clemson.edu:8744

#### Spark
For Cypress, Spark is not set up as a stand-alone Spark cluster, but users can submit interactive and batch Spark jobs to YARN. The Master WebUI of the resulting Spark cluster, run as a YARN application, is accessible via the application's record from YARN's Resource Manager. The final log information are aggregated and stored in Spark's History Server at:

    namenode2.palmetto.clemson.edu:18080 
