
For batch jobs:   `qsub myjob.pbs`   (where `myjob.pbs` is your PBS job script).  Example PBS job scripts can be found here.

For interactive jobs:   `qsub -I`


Common Parameters for the `qsub` Command

These can be used for both interactive or batch jobs:

Parameter | Purpose | Example
--------- | ------- | -------- 
`-N` | Job name (7 characters)	| `-N maxrun1`
`-l` | Job limits (lowercase L), hardware & other requirements for job | `-l select=1:ncpus=8:mem=1gb`
`-q` | Queue to direct this job to (workq is the default, supabad is an example of specific research group's job queue) | `-q supabad`
`-o` | Path to stdout file for this job (environment variables are no longer accepted here) | `-o stdout.txt`
`-e` | Path to stderr file for this job (environment variables are no longer accepted here) | `-e stderr.txt`
`-M` | E-mail for messages from the PBS server	 | `-M username@clemson.edu`
`-m` | Type of notification you wish to receive (b,e,a,n) | `-m ea`

There is a very large variety of qsub options (aka PBS directives) available in the 
[PBS Professional 12.0 User's Guide]({{site.data.main.palmetto_url}}/files/PBSProUserGuide12-2.pdf).

Requirements you can specify for your Job

When specifying the hardware you require for your job, it's helpful to review the cluster hardware table,

    [galen@user001 ~]$ cat /etc/hardware-table
    
    PALMETTO HARDWARE TABLE      Last updated:  May 12 2015
    
    PHASE COUNT  MAKE   MODEL    CHIP(0)                CORES  RAM(1)    /local_scratch   Interconnect         FLOP  GPUs  PHIs SSD
     0      5    HP     DL580    Intel Xeon    7542       24   505 GB(2)    99 GB         1g, 10g, mx           4     0     0    0
     0      1    HP     DL980    Intel Xeon    7560       64     2 TB(2)    99 GB         1g, 10g, mx           4     0     0    0
     1    247    Dell   PE1950   Intel Xeon    E5345       8    12 GB       37 GB         1g, 10g, mx           4     0     0    0
     2    245    Dell   PE1950   Intel Xeon    E5410       8    12 GB       37 GB         1g, 10g, mx           4     0     0    0
     3    247    Sun    X2200    AMD   Opteron 2356        8    16 GB      193 GB         1g, 10g, mx           4     0     0    0
     4    332    IBM    DX340    Intel Xeon    E5410       8    16 GB      111 GB         1g, 10g, mx           4     0     0    0
     5a   383    Sun    X6250    Intel Xeon    L5420       8    32 GB       31 GB         1g, 10g, mx           4     0     0    0
     5b     9    Sun    X4150    Intel Xeon    E5410       8    16 GB       99 GB         1g, 10g, mx           4     0     0    0
     6     69    HP     DL165    AMD   Opteron 6176       24    48 GB      193 GB         1g, 10g, mx           4     0     0    0
     7a    42    HP     SL230    Intel Xeon    E5-2665    16    64 GB      240 GB         1g, 56g, fdr          8     0     0    0
     7b    12    HP     SL250s   Intel Xeon    E5-2665    16    64 GB      240 GB         1g, 56g, fdr          8     2(3)  0    0
     8a    96    HP     SL250s   Intel Xeon    E5-2665    16    64 GB      900 GB         1g, 56g, fdr          8     2(4)  0    300 GB(7)
     8b    32    HP     SL250s   Intel Xeon    E5-2665    16    64 GB      420 GB         1g, 56g, fdr          8     2(4)  0    0
     8c    68    Dell   PEC6220  Intel Xeon    E5-2665    16    64 GB      350 GB         1g, 40g, qdr, 10ge    8     0     0    0
     8d     7    Dell   PER720   Intel Xeon    E5-2665    16    64 GB      350 GB         1g, 40g, qdr, 10ge    8     2(5)  0    0
     9     72    HP     SL250s   Intel Xeon    E5-2665    16   128 GB      420 GB         1g, 56g, fdr, 10ge    8     2(4)  0    0
    10     80    HP     SL250s   Intel Xeon    E5-2670v2  20   128 GB      800 GB         1g, 56g, fdr, 10ge    8     2(4)  0    0
    11a    40    HP     SL250s   Intel Xeon    E5-2670v2  20   128 GB      800 GB         1g, 56g, fdr, 10ge    8     2(6)  0    0
    11b     4    HP     SL250s   Intel Xeon    E5-2670v2  20   128 GB      800 GB         1g, 56g, fdr, 10ge    8     0     2(8) 0
    12     30    Lenovo NX360M5  Intel Xeon    E5-2680v3  24   128 GB      800 GB         1g, 56g, fdr, 10ge   16     2(6)  0    0

    TOTAL: 2021 nodes / 22008 cores

     *** PHASE 11b PHI NODES ARE NOT YET CONFIGURED
     *** PHASE 12 NODES SHOULD BE READY BY END OF MAY

    PBS resource requests are always lowercase   

    (0) CHIP has 3 resources:   chip_manufacturer, chip_model, chip_type
    (1) Leave 2GB for the operating system when requesting memory in PBS jobs
    (2) Specify queue "bigmem" to access the large memory machines
    (3) 2 NVIDIA Tesla M2075 cards per node, use resource request "ngpus=[1|2]" and "gpu_model=m2075"
    (4) 2 NVIDIA Tesla K20m cards per node, use resource request "ngpus=[1|2]" and "gpu_model=k20"
    (5) 2 NVIDIA Tesla M2070-Q cards per node, use resource request "ngpus=[1|2]" and "gpu_model=m2070q"
    (6) 2 NVIDIA Tesla K40m cards per node, use resource request "ngpus=[1|2]" and "gpu_model=k40"
    (7) Use resource request "ssd=true" to request a chunk with SSD in location /ssd1, /ssd2, and /ssd3 (100GB max each)
    (8) Use resource request "nphis=[1|2]" to request phi nodes, the model is Xeon 7120p

An example hardware limits specification (hardware needed for your job):  

    -l select=2:ncpus=8:mpiprocs=8:mem=6gb:interconnect=10g,walltime=16:00:00

Here, I'm requesting 2 "chunks" of hardware, and EACH chunk will comprise 8 cores, 8 MPI processes (tasks), 6 GB RAM, 
using nodes with Myrinet network hardware, and this job will run for a maximum of 16 hours.  We use the term "chunk" because 
that is the term used in the PBS Professional job scheduler documentation.

Memory per chunk is specified using  `mem=##gb` or `mem=##kb`

**Note:**  Each core in the workq execution queues (e.g., tiny_long, solo_quick, etc.) comes with 1 GB RAM by default.  
If you request 2 GB RAM for each core, then you are reserving the equivalent of 2 cores. This is important when considering 
the maximum number of jobs you can run in one of the workq execution queues. To ensure fair use of the cluster, each 1 GB is 
treated as equivalent to 1 core. 

The maximum amount of memory you can request on any type of compute node is 1 GB less than the total RAM available on the 
compute node. That remaining 1 GB is for the operating system.  For example, if you want to request the maximum amount of memory 
for a node with 16 GB onboard, you must request 16 GB - 1 GB = 15 GB.  Of course, any amount less than 15 GB would be fine too.

Cores per chunk and available MPI processes per node (these values should usually the same):   `ncpus=8:mpiprocs=8`

You can specify hardware details using keywords like intel, xeon, amd, opteron as in these examples: 

    -l select=1:ncpus=8:chip_manufacturer=intel:interconnect=10g
    -l select=1:ncpus=8:chip_model=opteron:interconnect=10g
    -l select=1:ncpus=16:chip_type=e5-2665:interconnect=56g:mem=62gb,walltime=16:00:00
    -l select=1:ncpus=8:chip_type=2356:interconnect=10g:mem=15gb
    -l select=1:ncpus=1:node_manufacturer=ibm:mem=15gb,walltime=00:20:00

Possible `qsub -l` hardware specification options include:

    chip_manufacturer=amd
    chip_manufacturer=intel
    chip_model=opteron
    chip_model=xeon
    chip_type=e5345
    chip_type=e5410
    chip_type=l5420
    chip_type=x7542
    chip_type=2356
    chip_type=6172
    chip_type=e5-2665
    node_manufacturer=dell
    node_manufacturer=hp
    node_manufacturer=ibm
    node_manufacturer=sun
    interconnect=1g   (1 Gbps Ethernet)
    interconnect=10g   (10 Gbps Myrinet, same as mx)
    interconnect=10ge   (10 Gbps Ethernet)
    interconnect=40g   (40 Gbps QDR InfiniBand, same as qdr)
    interconnect=56g   (56 Gbps QDR InfiniBand, same as fdr)
    interconnect=mx   (10 Gbps Myrinet, same as 10g)
    interconnect=qdr   (40 Gbps QDR InfiniBand, same as 40g)
    interconnect=fdr   (56 Gbps QDR InfiniBand, same as 56g)
    ssd=true   (Use a node with an SSD hard drive)


The PBS documentation makes an important distinction between "nodes" and "chunks" when it comes to the `select=` specification. 
Hardware resrouces are allocated in the form of "chunks" (not simply nodes), since these units of hardware may not necessarily 
be equivalent to individual nodes.

For example, this select statement (below) requests one chunk of 6 cores + 10gb RAM and 3 chunks of 16 cores + 4 gb RAM, with all 
nodes using Myrinet network hardware.  This results in a total job request of 54 cores and 22gb:

    #PBS -l select=1:ncpus=6:mem=10gb:interconnect=mx+3:ncpus=16:mem=4gb:interconnect=mx

The place= specification can be used to control how requested "chunks" are distributed amongst the nodes in an allocation:

    #PBS -l place=pack      Force each chunk to reside on the same node
    #PBS -l place=scatter   Force each chunk to be on a different node
    #PBS -l place=free      No preference for how the chunks are distributed (default)


You can also request a specific node for you job using the host=node#### option in your resource limits specification, for example:

    -l select=1:host=node1572:ncpus=1:mem=1gb,walltime=00:10:00

Or, if you need to specify multiple nodes, here's how you could reserve `node1672` and `node1675` 
(note the "+" between the 2 separate "select" statements):

    -l select=1:ncpus=16:mpiprocs=16:mem=19gb:host=node1682+1:ncpus=16:mpiprocs=16:mem=19gb:host=node1675


**Requesting Nodes with GPUs**

To access compute nodes with GPUs, you can add the ngpus=# specification in your hardware limits.  For example,

    #PBS -l select=1:ngpus=1

This will reserve 1 "chunk" of hardware comprising 1 node with 1 NVIDIA Tesla M2075 GPU on-board.

There are 2 NVIDIA Tesla GPUs on each of the GPU nodes, so you can request a maximum of `ngpus=2` per chunk.

Also, there are 3 different types of NVIDIA Tesla GPUs,  M2070-Q's, M2075's, and K20m's, so you can further specify the 
GPU hardware you require using the `gpu_model=` specification:

    gpu_model=k20
    gpu_model=m2070q
    gpu_model=m2075

For example,

    #PBS -l select=1:ngpus=1:gpu_model=k20

When you run a job on these nodes, you can use the  module avail  command to see which version of the CUDA Toolkit is availble:

    [galen@node1750 ~]$ module avail cuda
    -------------------------------- /usr/share/Modules/modulefiles ---------------------------------
    cuda-toolkit/4.2.9    cuda-toolkit/5.0.35   cuda-toolkit/5.5.22

**Wall time**

Maximum wall time for all jobs in the default "workq" queue is 72 hours.

Your job will terminate abruptly when it reaches the wall time, so specify a wall time that is slightly longer than what your job 
will actually require (to allow for any delays in network communication or data I/O).  For example, with a 34-hour job, use `walltime=34:00:00`.

**Note:**  the wall time for a job that has already started running cannot be extended.

Owner queues (special queues useable by researchers and groups who have purchased dedicated resources) can run jobs up to 168 hours.

If a regular (non-owner) user needs to run a job for longer than the default 72-hour wall time, that user must submit an allocation request 
explaining what resources are needed (e.g., how many cores), for how long, and some justification for why this work must be run in a single 
job without being divided into shorter jobs.  This request can be submitted by filling the form [Reservation
Request](http://citi.clemson.edu/reservation-request/).

These special allocation requests are reviewed by CU-CAT and may take 2-3 weeks to be processed.


**Jobs Requiring Lots of Memory**

If your job requires more memory than what is available on the regular compute nodes, you can run your job on the "large memory" nodes 
by submitting your job to the bigmem job queue.  This can be done for both batch and interactive jobs by adding the `-q bigmem` specification 
to your qsub command or to the PBS directives in your job script.

If your job requires more than 125 GB per node, you should be using the "large memory" nodes in the bigmem queue.  When using the 
"large memory" nodes (`nodelm01-nodelm04`), you can allocate up to 504 GB per node for your job. These nodes have 512 GB of RAM, 
but a portion of that memory must be used by the OS, so you can only allocate up to 504 GB for your job.

The nodemath node can accomodate jobs requesting up to 2019

The large shared memory nodes have only Myrinet network hardware (`interconnect=mx`), but it's not necessary to specify this in your hardware limits.

Here's an example of an interactive job that uses the "large memory" nodes:

    qsub -I -q bigmem -l select=1:ncpus=12:mpiprocs=12:mem=172gb,walltime=02:00:00


And here's an example of the PBS directives in a batch job script that uses the "large memory" nodes:

    #PBS -N MyJobXX
    #PBS -l select=1:ncpus=12:mem=172gb,walltime=02:00:00
    #PBS -q bigmem
    #PBS -j oe 


**Killing Jobs**

Killing a single job, or just a few jobs:    `qdel 3012334 3012338 3012339`    (here, you can specify one or more job ID numbers)

Killing all of your jobs:    `qselect -u username | xargs qdel`

Killing jobs with a specified status (`R` for running, `Q` for queued):    `qselect -u username -s R | xargs qdel`


