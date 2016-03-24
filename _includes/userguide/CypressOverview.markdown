The Cypress cluster uses the Hortonworks Data Platform version 2.3.4.0-3485 to support data-intensive computing and big data analytics. 

Phase	| Count | Make | Model | CPU type | Cores | RAM | Local Storage | Host Names 
--------|-------|------|-------|----------|-------|-----|----------------|--------------
0 | 1 | HP | DL580 | Intel Xeon E2665 | 16 | 64 GB | 500 GB | resourcemgr.palmetto.clemson.edu
0 | 1 | HP | DL980 | Intel Xeon E2665 | 16 | 64 TB | 500 GB | namenode1.palmetto.clemson.edu
0 | 1 | HP | PE1950 | Intel Xeon E2665 | 16 | 64 GB | 500 GB | namenode2.palmetto.clemson.edu
0 | 16 | HP | PE1950 | Intel Xeon E2665 | 16 | 256 GB | 12 TB | dsci00[1-16].palmetto.clemson.edu

- In order to interact with Cypress, users must be logged on to **resourcemgr**. This can be done from **user001** after logging on to the Palmetto cluster. At the moment, there is no specific Palmetto queue for **resourcemgr**. This might be changed in the future. Users do not have direct ssh access to any other nodes in the Cypress cluster.  
- **resourcemgr** runs the following services: HBase Client, HCat Client, HDFS Client, Hive Client, JournalNode, MapReduce2 Client, Metrics Monitor, Oozie Client, Pig, ResourceManager, Spark Client, Sqoop, Tez Client, YARN Client, ZooKeeper Client, and ZooKeeper Server.
- **namenode1** runs the following services: HBase Master, HDFS Client, Hive Metastore, JournalNode, MapReduce2 Client, Metrics Monitor, NameNode, YARN Client, ZKFailoverController, ZooKeeper Client, and ZooKeeper Server.
- **namenode2** runs the following services: App Timeline Server, DRPC Server, HBase Master, HDFS Client, History Server, Hive Metastore, HiveServer2, JournalNode, MapReduce2 Client, Metrics Collector, Metrics Monitor, MySQL Server, NameNode, Nimbus, Oozie Server, Pig, ResourceManager, Spark History Server, Storm UI Server, Tez Client, WebHCat Server, YARN Client, ZKFailoverController, ZooKeeper Client, and ZooKeeper Server.
- **dsci001-016** runs the following services: DataNode, HDFS Client, MapReduce2 Client, Metrics Monitor, NodeManager, Supervisor, YARN Client, and ZooKeeper Client.
- **002, 004, and 006** also runs the following service: Kafka Broker
- **001, 003, and 005** also runs the following service: HBase RegionServer
