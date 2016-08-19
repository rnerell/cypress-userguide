
## Capacity Scheduler
YARN applications (e.g., MapReduce, Spark, non-Hadoop applications, etc.) are submitted to the YARN Resource Manager. The Resource Manager is configured to use the Capacity Scheduler which allows administrators to specify policies which guarantee that a percentage of the cluster's resources are accessible to particular queues. When the resources allocated to one queue are not being fully utilized by its authorized users, those resources are made available to other users from other queues, including the default queue. When a queue is using more than its guaranteed capacity and another queue is simultaneously underserved, job "containers" submitted to the first queue will be preempted in order for the underserved queue to leverage its guaranteed capacity. Preemption should take place very quickly (in less than a minute after job submission).

## Default Queue
Any user with an account on Cypress can submit jobs to the default queue (root.default). Jobs are submitted to this queue by default unless otherwise specified. The amount of cluster capacity guaranteed to this queue fluctuates with:

- the addition of new hardware (purchased in lots by CCIT that are called *phases*)
- owner purchases of cluster resources
- hardware falling out of warranty and thus any associated ownership of them expiring

So, the capacity guaranteed to this queue is composed of:

- new phases of hardware that have not been purchased by owners.
- hardware that has fallen out of warranty but is still operational

## Owner Queues
If you purchase a percentage of the cluster's resources, then a queue will be created for you. Owner queues enable authorized users to have on-demand access to a guaranteed capacity of cluster resources PLUS any resources not being used by other owner queues and the default queue.

### Who can access my queue?
You may specify which users and groups are allowed to submit to your queue by specifying:

- a list of one or more *users* AND/OR
- a list of one or more *group* of users

This access control list may be updated by submitting a request to ithelp@clemson.edu. Be sure to specify exactly which users and groups should be able to submit jobs to your YARN queue on the Cypress Cluster.

## Hierarchical Queues
Hierarchy of queues is supported to ensure resources are shared among the sub-queues of an organization before other queues are allowed to use free resources, thereby providing more control and predictability.

It is possible to configure an owner queue to be a *parent* queue with its own hierarchy. This enables an owner to purchase a guaranteed amount of resources for the parent queue and have those resources divided amongst specified child queues.

For example: Owner "jsmith" has purchased 1.0 % of cluster resources and wants to divide those resources amongst his or her different teams as follows: half of the purchased resources are allocated for team_A and 0.25 % will be allocated for team_B and team_C. His parent and child queues would have configured guaranteed capacities like so:

- jsmith_lab: 1.0 %
  - jsmith_team_A: 0.50  %
  - jsmith_team_B: 0.25 %
  - jsmith_team_C: 0.25 %

Users may submit applications to leaf queues only (queues with no child queues).
