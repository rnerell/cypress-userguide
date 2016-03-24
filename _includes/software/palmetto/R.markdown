
#### Using R (already on Palmetto)

[R](http://www.r-project.org/) is not available as a software module on Palmetto.  Instead, R version 
2.13.0 is available natively as an integral part of the Scientific Linux 6 OS.  To run R, simply type 
the `R` command.

    [galen@user001 ~]$ which R
    /usr/bin/R

    [galen@user001 ~]$ R --version
    R version 2.13.0 (2011-04-13)
    Copyright (C) 2011 The R Foundation for Statistical Computing
    ISBN 3-900051-07-0
    Platform: x86_64-unknown-linux-gnu (64-bit)

    R is free software and comes with ABSOLUTELY NO WARRANTY.
    You are welcome to redistribute it under the terms of the
    GNU General Public License version 2.
    For more information about these matters see
    http://www.gnu.org/licenses/.

#### Installing your own R and Rmpi

Rmpi is an optional package that can be used with R, and it's an interface (a wrapper) to MPI 
(Message-Passing Interface).  Rmpi is not currently installed as a software module on Palmetto, 
and you'll have to install your own build of R before you can install and use Rmpi.  Setting-up 
Rmpi to work with the build of R that's already installed on Palmetto can be more difficult than 
installing your own, so here we'll present the procedures for installing both R and Rmpi:

**Download and install R in your /home directory**

    [galen@user001 ~]$ wget http://mirrors.nics.utk.edu/cran/src/base/R-2/R-2.15.2.tar.gz
    --2012-12-13 11:24:48--  http://mirrors.nics.utk.edu/cran/src/base/R-2/R-2.15.2.tar.gz
    Resolving mirrors.nics.utk.edu... 192.249.6.59
    Connecting to mirrors.nics.utk.edu|192.249.6.59|:80... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 24338934 (23M) [application/x-gzip]
    Saving to: R-2.15.2.tar.gz
    100%[==================================================================================>] 24,338,934  20.0M/s   in 1.2s    
    2012-12-13 11:24:50 (20.0 MB/s) - R-2.15.2.tar.gz saved [24338934/24338934]

    [galen@user001 ~]$ module add gcc/4.4
    [galen@user001 ~]$ tar -zxf R-2.15.2.tar.gz
    [galen@user001 ~]$ cd R-2.15.2
    [galen@user001 ~]$ ./configure --prefix=/home/galen/R/2.15.2
    [galen@user001 ~]$ make
    [galen@user001 ~]$ make install

Once you've installed R, you'll need to configure your environment settings to use this new build. 
Adding commands similar to these (below) at the end of your `~/.bashrc` file will take care of this:

    export PATH=/home/galen/R/2.15.2/bin:$PATH
    export LD_LIBRARY_PATH=/home/galen/R/2.15.2/lib64:$LD_LIBRARY_PATH

Your environment configuration can be tested after you source your newly edited `~/.bashrc` file. 
Here, you want to ensure that the version of R in your `PATH` is the one you just installed in 
your `/home` directory:

    [galen@user001 ~]$ which R
    ~/R/2.15.2/bin/R


**Download and install Rmpi in your /home directory:**

    [galen@user001 ~]$ wget http://www.stats.uwo.ca/faculty/yu/Rmpi/download/linux/Rmpi_0.6-1.tar.gz
    --2012-12-13 11:42:51--  http://www.stats.uwo.ca/faculty/yu/Rmpi/download/linux/Rmpi_0.6-1.tar.gz
    Resolving www.stats.uwo.ca... 129.100.76.201
    Connecting to www.stats.uwo.ca|129.100.76.201|:80... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 90557 (88K) [application/x-gzip]
    Saving to: Rmpi_0.6-1.tar.gz
    100%[==================================================================================>] 90,557       205K/s   in 0.4s    
    2012-12-13 11:42:52 (205 KB/s) - Rmpi_0.6-1.tar.gz saved [90557/90557]

    [galen@user001 ~]$ module add mpich2/1.4

    [galen@user001 ~]$ R CMD INSTALL Rmpi_0.6-1.tar.gz --configure-args=--with-mpi=/opt/mpich2/1.4 --configure-args=--prefix=/home/galen/Rmpi/0.6-1


That's it, Rmpi has now been added to the list of installed packages in your R installation.  
You can verify this by querying your R installed packages:

    [galen@user001 ~]$ R -q -e 'installed.packages()' | grep Rmpi
    Rmpi       "Rmpi"       "/home/galen/R/2.15.2/lib64/R/library" "0.6-1"  


If needed, you can also remove the Rmpi package:

    [galen@user001 ~]$ R CMD REMOVE -l /home/galen/R/2.15.2/lib64/R/library Rmpi
    Updating HTML index of packages in '.Library'
    Making packages.html  ... done


Here's an example PBS job script for running R with Rmpi:

{% highlight bash %}
#!/bin/bash
#PBS -N Rmpi-ex
#PBS -l select=1:ncpus=8:mpiprocs=8:mem=4gb:interconnect=mx,walltime=01:00:00
#PBS -j oe

source /etc/profile.d/modules.sh
module purge
module add gcc/4.4 mpich2/1.4

NCORES=`qstat -xf $PBS_JOBID | grep List.ncpus | sed 's/^.\{26\}//'`
cd $PBS_O_WORKDIR

mpiexec -n 8 R --slave CMD BATCH example.R
{% endhighlight %}


