
Running ANSYS on Palmetto requires users to check-out an ANSYS license in their job script so the necessary license will be available when the job begins running.

There are 3 types of ANSYS licenses:

1. The High Performance Research license ( aa_r_hpc ).  This is per core, and is required when running Distributed ANSYS.  That is, they execute ansys like this:   ansys130 -dis -usessh -machines ...  There are a maximum of 240 licenses of this type.

* The Teaching License ( aa_t_a ).  This license can be used  first 2 cores for 1 license, and one license for each additional core.  They are using the teaching license if they invoke ANSYS like this:   ansys130 -p AA_T_A -n $NCPUS ... (the -p means `package`).  There are 100 of this type of license available, and only 95 of those are accessible through the PBS system on Palmetto.

* The Research License ( aa_r ).  This is the default if neither of the above two options are used.  There are 25 of this type available, but only 10 are available through the PBS system on Palmetto.

#### Running ANSYS in a Batch job

Below is an example of a PBS job script used for running ANSYS.  In this example, 16 compute cores 
(two 8-core nodes) are being used, so 16 High Performance Research licenses are reserved in the job 
limits (hardware selection) line:

{% highlight bash %}
#!/bin/bash
#PBS -N ANSYSdis
#PBS -l select=2:ncpus=8:mpiprocs=8:mem=11gb:interconnect=mx,aa_r_hpc=16
#PBS -l walltime=1:00:00
#PBS -j oe

source /etc/profile
module purge
module add ansys/13.0

cd $PBS_O_WORKDIR

machines=$(uniq -c $PBS_NODEFILE | awk '{print $2":"$1}' | tr '\n' :)

ansys130 -dir $PBS_O_WORKDIR -j TOP -s read -l en-us -b -i newtop.txt -o output.txt -dis -machines $machines -usessh
{% endhighlight %}

Also, users can check to see how many of which licenses are currently in use using the following command:

    /software/ansys_inc/shared_files/licensing/linx64/lmutil lmstat -a -c 28008@licensevm4.clemson.edu


#### Running CFX-Pre, CFX-Solver, CFX-Post using a GUI

The ANSYS GUI-based applications can be started individually, or using the CFX Launcher.  
First, you must start an interactive session with X11 tunneling enabled.  Then, you can simply 
start the CFX Launcher interface and choose which application you would like to run.

Here is an example procedure (the hardware you need for your job may differ slightly):

    [galen@user001 ~]$ qsub -I -X -l select=1:ncpus=1:mem=1gb:interconnect=mx,walltime=1:00:00
    qsub (Warning): Interactive jobs will be treated as not rerunnable
    qsub: waiting for job 2695291.pbs01 to start
    qsub: job 2695291.pbs01 ready

    [galen@node0015 ~]$ module add ansys/13.0 

    [galen@node0015 ~]$ cfx5launch 


And here is what starting CFX-Post might look like if run from the CFX Launcher:


![Ansys]({{site.data.main.palmetto_url}}/images/ansys.1.jpg)

![Ansys]({{site.data.main.palmetto_url}}/images/ansys.2.jpg)

![Ansys]({{site.data.main.palmetto_url}}/images/ansys.3.jpg)


