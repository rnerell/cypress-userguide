
## HDFS

Hadoop Distributed File System (HDFS), the underlying storage support infrastructure of the Cypress Cluster, follows a write-once-read-many model with emphasis on sequential access. Files may not be modified after they have been created and closed.

### HDFS Fault Tolerance

HDFS does not employ RAID to support fault tolerance and error recovery. Rather, it uses a straightforward data replication scheme. The default replication factor for Cypress is 2, which means that each block of data has an identical copy located on a different Cypress node. If the replication factor were set to 3, then there would be two additional copies of each block of data, all located on different nodes.

If you have a data set that is not bound by IP and licenses, please consider working with us to store your data under hdfs:///repository so that it can be shared with other Cypress users.

By default, each user account can have up to 0.5TB of storage (total 1.0TB with replication). We are currently working on a priority storage scheme to support Cypress owners with additional storage requirements.

To check for status of your storage, you can use the following command (replace lngo with your username):

    [lngo@dsciutil ~]$ hdfs fsck /user/lngo
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


## Which File Systems Are Present On Particular Cypress Nodes

Of the many Cypress Cluster nodes, **only** the Cypress *User Node* has Palmetto's */home, /scratch1, /scratch2*, and *owner purchased* filesystems mounted; however, all of the Cypress nodes have the */software* file system mounted.

This configuration is atypical compared with the configuration of Palmetto compute nodes, and the reason is intentional:

- Only the Cypress User Node should be used to stage data in and out of HDFS from the other file systems mentioned above since HDFS should be the only file system used by jobs running on Cypress.
- **NOTE**: We make an exception for the */software* file system, and it is available on all nodes (similarly to Palmetto compute nodes) because we know users may want to leverage the programs and libraries available under */software* in their jobs.

Also, **it is important to understand that HDFS is not a typical mounted file system**. You must use the ```hdfs``` command, which is present on *dsciutil*, to interact with HDFS. This is discussed in more detail below.
