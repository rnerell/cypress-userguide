
There are 2 ways to run COMSOL on Palmetto.  You can launch the COMSOL GUI (graphical user interface) 
and interact with the program that way, or you can run COMSOL in batch mode using a PBS job script.

#### Running COMSOL 4.2a Using the GUI

This is covered in the X11 Tunneling with SSH for Palmetto section above.


#### Running COMSOL 4.2a Batch Jobs

Below is an example PBS job script that can be used for running COMSOL 4.2 on one of the large shared memory nodes:

{% highlight bash %}
#!/bin/bash
#PBS -N COMSOL
#PBS -l select=1:ncpus=8:mpiprocs=24:mem=128gb,walltime=01:30:00
#PBS -q bigmem
#PBS -j oe

source /etc/profile.d/modules.sh
module purge
module add comsol/4.2a

cd $PBS_O_WORKDIR

comsol batch -tmpdir /local_scratch -inputfile CMX-334-input.mph -outputfile CMX-334-output.mph
{% endhighlight %}

In this example, my job will run using 8 cores (the maximum available on one large shared memory node) 
and 128 GB RAM, and this job will run for a maximum of 1 hour and 30 minutes. I'm specifying that this 
job must run in the "bigmem" queue because of the large memory requirement.

Here, I'm adding the COMSOL 4.2a environment module in the PBS job script, and the `cd $PBS_O_WORKDIR` 
command ensures that my comsol command will be executed in the same directory where I issue the `qsub` 
command to submit this job to the scheduler.

I'm using `/local_scratch` for storing temporary files.
