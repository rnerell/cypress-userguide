
## Understand Which File Systems Are Present On Particular Cypress Nodes

Of the many Cypress Cluster nodes, **only** the Cypress *User Node* has Palmetto's */home, /scratch1, /scratch2*, and *owner purchased* filesystems mounted; however, all of the Cypress nodes have the */software* file system mounted.

This configuration is atypical compared with the configuration of Palmetto compute nodes, and the reason is intentional:

- Only the Cypress User Node should be used to stage data in and out of HDFS from the other file systems mentioned above since HDFS should be the only file system used by jobs running on Cypress.
- **NOTE**: We make an exception for the */software* file system, and it is available on all nodes (similarly to Palmetto compute nodes) because we know users may want to leverage the programs and libraries available under */software* in their jobs.

Also, **it is important to understand that HDFS, the primary file system used by Cypress, is not a typical mounted file system**. You must use the ```hdfs``` command, which is present on *dsciu001*, to interact with HDFS. This is discussed in more detail in the Data Management section of this User Guide.

## Environment Customization

Instructions detailing how to customize your environment (especially important for streaming jobs that drive external applications) can be found at <a href="http://www.palmetto.clemson.edu/pages/userguide.html#software" target="_blank">Palmetto's User Guide</a>.
