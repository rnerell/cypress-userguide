Hadoop Distributed File System, the underlying storage support infrastructure of DSCI, follows a write-once-read-many model with emphasis on sequential access. HDFS does not employ RAID to support fault tolerant and error recovery. Rather, it uses a straightforward data replication scheme. The default replication rate for Cypress is 2, which means that each data file is automatically replicated twice across different nodes on Cypress.

If you have a data set that is not bound by IP and licenses, please consider working with us to store your data under hdfs:///user/repository so that it can be shared with other DSCI users.

By default, each account can have up to 0.5TB of storage (total 1.0TB with replication). We are currently working on a priority storage scheme to support DSCI owners withadditional storage requirements. 

To check for status of your storage, you can use the following command (replace lngo with your username):

    [lngo@resourcemgr ~]$ hdfs fsck /user/lngo
      Total size:    2196596137 B
      Total dirs:    1095
      Total files:   3268
      Total symlinks:                0
      Total blocks (validated):      1206 (avg. block size 1821389 B)
      Minimally replicated blocks:   1206 (100.0 %)
      Over-replicated blocks:        0 (0.0 %)
      Under-replicated blocks:       0 (0.0 %)
      Mis-replicated blocks:         0 (0.0 %)
      Default replication factor:    2
      Average block replication:     2.07131
      Corrupt blocks:                0
      Missing replicas:              0 (0.0 %)
      Number of data-nodes:          16
      Number of racks:               1
      FSCK ended at Mon Mar 14 11:47:25 EDT 2016 in 331 milliseconds
      The filesystem under path '/user/lngo' is HEALTHY

Additional information about the storage can be viewed by adding **-files**, **-blocks**, and **-locations** flags to the end of the command. 
