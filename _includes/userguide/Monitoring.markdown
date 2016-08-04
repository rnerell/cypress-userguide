The status of applications and data on Cypress is monitored through various web UIs that are accessible from Clemson internal IP addresses (Clemson eduroam, Ethernet, or VPN).

#### Hadoop File System
The UIs for the Hadoop Namenodes are:

    dscim002.palmetto.clemson.edu:50070
    OR
    dscim003.palmetto.clemson.edu:50070

Usually, only one of the two namenodes will be active.

#### YARN
The UI for YARN's Resource Manager is:

    dscim001.palmetto.clemson.edu:8088
    OR
    dscim003.palmetto.clemson.edu:8088

#### HBase
The UIs for HBase's Master Server is:

    dscim001.palmetto.clemson.edu:16010
    OR
    dscim003.palmetto.clemson.edu:16010

#### Oozie
The UI for Oozie's Web Console is:

    dscim003.palmetto.clemson.edu:11000

#### Storm
The UI for Storm is:

    dscim003.palmetto.clemson.edu:8744

#### Accumulo
The UI for Accumulo is:

   dscim003.palmetto.clemson.edu:50095

#### Kafka
Kafka brokers are located at:

dsci[002,004,006].palmetto.clemson.edu:50095


#### Spark
For Cypress, Spark is not set up as a stand-alone Spark cluster, but users can submit interactive and batch Spark jobs to YARN. The Master WebUI of the resulting Spark cluster, run as a YARN application, is accessible via the application's record from YARN's Resource Manager. The final log information are aggregated and stored in Spark's History Server at:

    dscim003.palmetto.clemson.edu:18080 
