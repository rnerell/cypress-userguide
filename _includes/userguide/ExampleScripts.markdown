
In these examples, optional modules used for running the desired programs are loaded within the job 
script, rather than doing this statically using a `module add ...` command in your `/home/username/.bashrc` 
file.

It's not required that you load modules in this way (from within the job script), but it may be easier to 
troubleshoot.

#### Serial Batch Job Script

    #!/bin/bash      
    #PBS -N example      
    #PBS -l select=1:ncpus=1:mem=2gb:interconnect=1g,walltime=00:10:00  
    #PBS -j oe      
    
    source /etc/profile.d/modules.sh  
    module purge  
    module add gcc/4.4 fftw/2.1.5-double 
    
    cd $PBS_O_WORKDIR  
    
    ./my-program.exe some-input.inp > some-output.log


Line | Purpose
---- | -------
`#!/bin/bash` | This is just a regular Bash shell script, all commands will be interpreted by the Bash shell
`#PBS -N example` | The name of my job must be less than 15 characters
`#PBS -l select=1:ncpus=1:mem=2gb:interconnect=1g` | Here, I'm requesting 1 "chunk" of hardware made up of 1 compute core and 2 GB RAM 
`#PBS -l walltime=00:10:00` | The requested time is set to 10 minutes
`#PBS -j oe` | I want my stderr and stdout output files to be joined into a single file that will appear in my execution directory after the job ends
`source /etc/profile.d/modules.sh` | Sourcing the modules.sh script so I can use the module command in my job script
` module purge` | Purging any modules I may have loaded from my `~/.bashrc` file
`module add gcc/4.4 fftw/2.1.5-double` | Loading only the modules I need for this job
`cd $PBS_O_WORKDIR` | Moving to my execution directory, which is the directory where I submitted this job
`./my-program.exe some-input.inp > some-output.log` | Executing the program 


#### Parallel Batch Job Script

    #!/bin/bash           
    #PBS -N example      
    #PBS -l select=2:ncpus=8:mpiprocs=8:mem=6gb:interconnect=mx,walltime=00:10:00  
    #PBS -j oe   
    
    source /etc/profile.d/modules.sh 
    module purge 
    module add gcc/4.4 mpich2/1.4 fftw/2.1.5-double  
    
    NCORES=`qstat -xf $PBS_JOBID | grep List.ncpus | sed 's/^.\{26\}//'` 
    
    cd $PBS_O_WORKDIR    
    
    mpiexec -n $NCORES ./my-parallel-program.exe some-input-file.inp > some-output.log 

Line | Purpose 
---- | ---------
`#!/bin/bash` | This is just a regular Bash shell script, all commands will be interpreted by the Bash shell
`#PBS -N example` | The name of my job must be less than 15 characters
`#PBS -l select=2:ncpus=8:mpiprocs=8:mem=6gb:interconnect=mx` | Here, I'm requesting 2 "chunks" of hardware made up of 8 compute cores, 8 MPI processes, and 6 GB RAM
`#PBS -l walltime=00:10:00` | The requested time is set to 10 minutes
`#PBS -j oe` | I want my stderr and stdout output files to be joined into a single file that will appear in my execution directory after the job ends
`source /etc/profile.d/modules.sh`  | Sourcing the modules.sh script so I can use the module command in my job script
`module purge` | Purging any modules I may have loaded from my `~/.bashrc` file
`module add gcc/4.4 mpich2/1.4 fftw/2.1.5-double` | Loading only the modules I need for this job
`NCORES=$(qstat -xf $PBS_JOBID \| grep List.ncpus \| sed 's/^.\{26\}//')` | Optional:  assigning the number of cores in my job's allocation to the NCORES variable)
`cd $PBS_O_WORKDIR` | Moving to my execution directory, which is the directory where I submitted this job
`mpiexec -n $NCORES ./my-program.exe input-file.inp > output-file.log` | Running my parallel program using mpiexec to coordinate my parallel computing environment, and using the NCORES variable instead of an integer for the number of MPI processes


#### Parallel Batch Job Script with Core Affinity set using Taskset (only works for a single node)

    #!/bin/bash
    #PBS -N example
    #PBS -l select=1:ncpus=8:mpiprocs=8:mem=6gb:interconnect=mx,walltime=00:10:00
    #PBS -j oe
    
    source /etc/profile.d/modules.sh
    module purge
    module add gcc/4.4 mpich2/1.4 fftw/2.1.5-double
    
    cd $PBS_O_WORKDIR
    
    taskset -c 0-7 mpiexec -n 8 ./my-parallel-program.exe some-input-file.inp > some-output.log
    (Running my parallel program using taskset to limit my job's tasks to the allocated 8 cores (numbered 0 through 7) and using mpiexec to coordinate my parallel computing environment)



