
Palmetto is configured so that [MATLAB](http://www.mathworks.com/products/matlab) code should be compiled 
while logged-in to a compute node using an interactive job. After using MATLAB's mcc compiler, the resulting executable can be run within a 
job submitted to the cluster (with the `matlab/2013a` module and, if needed, a GCC compiler module loaded).

Note:  MATLAB will try to use all the available CPU cores on the system where it's running, and this 
presents a problem when your compiled executable on the cluster where available cores on a single node 
might be shared amongst mulitple users.  You can disable this "feature" when you compile your code by 
adding the `-R -singleCompThread` option, like this (at the MATLAB command prompt):

    >> mcc -R -nodisplay -R -singleCompThread -R -nojvm -m mycode.m

or if you have multiple related .m files:

    >> mcc -R -nodisplay -R -singleCompThread -R -nojvm -m my_main_code.m myfunction1.m myfunction2.m myfunction3.m

Once you've created your executable, you can run it in a PBS job on Palmetto.  Of course, you'll 
also need the same `matlab/2013a` and (optional) GCC module loaded for your job's runtime environment.

#### Compiling a New MATLAB-based Executable and Running it in a Batch Job

In this example, "galen" is the username for the user running this job. First, copy the matlab.example 
directory to your `/home` directory:

    [galen@node1942 ~]$ cp -r /newscratch/intro.palmetto/examples/matlab.example/ ~

Go into that directory and list the contents:

    [galen@node1942 ~]$ cd matlab.example
    [galen@node1942 matlab.example]$ ls
    job.matlab.pbs  matchx.m  mccExcludedFiles.log  README  sample.m  surf-plot.m

We need to compile those `*.m` files, so load the MATLAB 2013a module and launch MATLAB. **Note:** compiling `*.m` 
files MUST be done in your `/home` directory.  In case your `*.m` files have been modified in a Windows environment, 
you'll need to use the `dos2unix` utility to ensure that they are converted to pure ASCII files.  After compiling, 
the compiled programs can be moved to `/newscratch` for running them.

    [galen@node1942 matlab.example]$ dos2unix *.m
    [galen@node1942 matlab.example]$ module add matlab/2013a
    [galen@node1942 matlab.example]$ matlab
    Warning: No display specified.  You will not be able to display graphics on the screen.
    Warning: No window system found.  Java option 'Desktop' ignored.

                         < M A T L A B (R) >
                Copyright 1984-2013 The MathWorks, Inc.
                  R2013a (8.1.0.604) 64-bit (glnxa64)
                          February 15, 2013

    No window system found.  Java option 'Desktop' ignored.
    To get started, type one of these: helpwin, helpdesk, or demo.
    For product information, visit www.mathworks.com.

Compile each of the `*.m` files, and then quit MATLAB:
 
    >> mcc -R -nodisplay -R -singleCompThread -R nojvm -m sample.m
    >> mcc -R -nodisplay -R -singleCompThread -R nojvm -m matchx.m
    >> mcc -R -nodisplay -R -singleCompThread -R nojvm -m surfplot.m
    >> quit

Now, the `*.m` files have been compiled -- converted into standalone executable files (sample, matchx, surfplot).  
Those can now be run on the cluster.

    [galen@node1942 matlab.example]$ ls
    job.matlab.pbs  mccExcludedFiles.log  run_matchx.sh    sample    surfplot.m
    matchx          README                run_sample.sh    sample.m
    matchx.m        readme.txt            run_surfplot.sh  surfplot

Let's move this entire folder to the `/newscratch` filesystem before running them.

    [galen@node1942 matlab.example]$ cd ..
    [galen@node1942 ~]$ mv matlab.example /newscratch/galen

You can now exit from your interactive session and return to user001. Let's look at the PBS job script we'll use to run this job:

    [galen@node1942 ~]$ exit
    [galen@user001 ~]$ cd /newscratch/galen/matlab.example
    [galen@user001 matlab.example]$ cat job.matlab.pbs

{% highlight bash %}
#!/bin/bash
#PBS -N example  (Name for this job, I'm calling it "example")
#PBS -l select=1:ncpus=1:mpiprocs=1:mem=1gb:interconnect=mx,walltime=00:05:00
#PBS -j oe

source /etc/profile.d/modules.sh
module purge
module add matlab/2013a

cd $PBS_O_WORKDIR

HOST=$(qstat -n ${PBS_JOBID} | egrep -o 'node..../[0-9]+')
taskset -c ${HOST##*/} ./sample
taskset -c ${HOST##*/} ./matchx
taskset -c ${HOST##*/} ./surfplot
{% endhighlight %}

Submit this batch job to run on the cluster

    [galen@user001 matlab.example]$ qsub matlab.pbs
    4523066.pbs01

Notice that my job was assigned job ID number 4523066. Let's check on the status of any jobs we have running:

    [galen@user001 matlab.example]$ qstat -u galen
    pbs01:                                                      Req'd  Req'd   Elap
    Job ID          Username Queue    Jobname    SessID NDS TSK Memory Time  S Time
    --------------- -------- -------- ---------- ------ --- --- ------ ----- - -----
    4523066.pbs01   galen    solo     example     12956   1   1    1gb 00:05 R 00:00

Looks like we have only 1 job, and it has already started running (see the `R`, indicating a status of "running").

When my job has finished, I can look in the working directory (the directory where I submitted this job) to see 
the output files. Here, I'm using the `l`,`h`,`t`, and `r` options to customize the output of the basic `ls` 
command -- this sorts the list by time with the newest files at the bottom.

    [galen@user001 matlab.example]$ ls -lhtr
    total 644K
    -rw-r--r-- 1 galen cuuser   74 Apr  9 16:13 matchx.m
    -rw-r--r-- 1 galen cuuser   38 Apr  9 16:13 sample.m
    -rw-r--r-- 1 galen cuuser  404 Apr  9 16:13 surfplot.m
    -rwxr--r-- 1 galen cuuser 1.2K Apr  9 16:16 run_sample.sh
    -rwxr--r-- 1 galen cuuser  94K Apr  9 16:16 sample
    -rw-r--r-- 1 galen cuuser  471 Apr  9 16:19 README
    -rwxr-xr-x 1 galen cuuser  361 Apr  9 16:19 job.matlab.pbs
    -rwxr--r-- 1 galen cuuser 1.2K Apr  9 16:20 run_matchx.sh
    -rwxr--r-- 1 galen cuuser  94K Apr  9 16:20 matchx
    -rw-r--r-- 1 galen cuuser 189K Apr  9 16:23 mccExcludedFiles.log
    -rw-r--r-- 1 galen cuuser 3.2K Apr  9 16:23 readme.txt
    -rwxr--r-- 1 galen cuuser 1.2K Apr  9 16:23 run_surfplot.sh
    -rwxr--r-- 1 galen cuuser  94K Apr  9 16:23 surfplot
    -rw------- 1 galen cuuser   45 Apr  9 16:25 example.o4523066
    -rw-r--r-- 1 galen cuuser 8.2K Apr  9 16:25 fig1.ps
    -rw-r--r-- 1 galen cuuser  14K Apr  9 16:26 surf-plot.jpg

The `fig1.ps` and `surf-plot.jpg` files are plots generated by MATLAB. The numerical/text output from that other 
small MATLAB executable was written to the `example.o4523066` PBS job output file.

    [galen@user001 matlab.example]$ cat example.o4523066
    a =  1     2     3
         4     5     6

#### How Many MATLAB Licenses are Available?

There are a limited number of MATLAB licenses available for use on campus, and specific MATLAB packages have their 
own limited number of licenses available.  For example, if I'm trying to compile MATLAB code that uses the Statistics Toolbox, 
my compilation may fail if all available Statistics Toolbox licenses are in use.  This rarely happens, but if it does,  
I'll have to wait until another time to compile my MATLAB code.

You can check to see how many licences of each MATLAB package are available using the cluster dashboard. Go to 
<http://citi.clemson.edu/palmetto/dashboard> and click on the License Status tab.

#### Running a New MATLAB-based exe Interactively

To do this, the first step is to have my local X-server running (Xming, if I'm using Windows, the XQuatz utility if I'm using Mac OS X, but no need to do anything if I'm using Linux).

Since MATLAB is going to display the plot for me when I run this program, I'll do this using X11 tunneling in both my 
connection to Palmetto (ssh -Y username@user.palmetto.clemson.edu) and in my interactive session (qsub -X -I):

    [galen@user001 ~]$ qsub -I -X
    qsub: waiting for job 722527.pbs01 to start
    qsub: job 722527.pbs01 ready

    [galen@node1170 ~]$

Now, I can run my new executable and generate a GUI tunneled from `node1170`.  Note here that I'm setting a variable called 
`HOST` and using the taskset utility to ensure that my serial code only uses the CPU core allocated for my interactive session:

    [galen@node1170 ~]$ cd /newscratch/galen/mtest
    [galen@node1170 ~]$ module add matlab/2013a
    [galen@node1170 ~]$ HOST=$(qstat -n ${PBS_JOBID} | egrep -o 'node..../[0-9]+')
    [galen@node1170 ~]$ taskset -c ${HOST##*/} ./matchx

At this point, the plot is displayed by the X-server running on my local workstation.


