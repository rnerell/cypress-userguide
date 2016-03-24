**Pre-Installed Software Packages Available on Palmetto**

The software pre-installed on Palmetto includes a limited variety of libraries and site-licensed packages. 
For each of these packages, only the most recent current version of the package, plus the most recent previous 
major release, will be maintained.  Older packages may be retired without warning.

The responsibility of software management is primarily that of users since it is not practical or helpful to 
maintain a large library of packages with different configurations of each package.


**Installing Your Own Software**

Most users install their own software (applications, application dependencies, libraries, scripts, etc.) in 
their /home or /scratch1 directories.  When installing software, users are invited to use the compilers and 
libraries available through the module system (see previous section of this guide), but that is not necessary. 
If a software package you wish to install requires a specific version of the MPICH2 libraries, FFTW libraries, or 
even GCC compilers, you can install those packages for yourself.

For a typical Linux installation, the default settings may attempt to install files in system directories outside 
your `/home` or `/scratch1` directory.  This is not permitted on Palmetto, so the installation process (specifically, 
the installation "configure" step) needs to be changed so that files are installed in a specified location.


Here is a typical example of installing software on a Linux cluster:  Installing [GROMACS](http://www.gromacs.org/) 
(molecular simulation software):

1. **Get the software**
I usually download a software package to my laptop, then transfer the downloaded package to my `/home` directory on 
Palmetto for installation.  Alternatively, if I have the http or ftp address for the package I need, I can transfer 
that package directly to my `/home` directory while logged-in to Palmetto using the wget utility:

        wget ftp://ftp.gromacs.org/pub/gromacs/gromacs-4.5.5.tar.gz

* **Unzip and unpack the "tarball"**

        tar -zxf gromacs-4.5.5.tar.gz

* **Read the instructions for installing the software**

        cd gromacs-4.5.5
        more README

    Here, the README file is a text file containing information and instructions, and it might have a different name 
like `INSTALL` or `SETUP`.  Alternatively, the installation instruction may be posted on the website from which I downloaded 
the software.

* **Setup your envionment for compiling the software**

        module add gcc/4.4 mpich2/1.4 fftw/2.1.5-double

    Here, to compile a parallel build of GROMACS, I need the MPICH2 libraries.  Compiling GROMACS also requires some version 
of the GCC compilers and the FFTW libraries.  Now I'm ready to begin compiling my software.

* **Run the configure script**

    Typical Linux installations will make use of a script named "configure" that allows me to specify details about how I 
want the installation to proceed.  This step should be described in your software's installation instructions.

        ./configure --prefix=/home/galen/gromacs/4.5.5 --disable-float --enable-mpi --without-x --disable-shared

    Here, I'm specifying that I want my software to be installed in my `/home` directory (specifically, `/home/galen/gromacs/4.5.5`).  
Also, I'm specifying a few other options such as the choice of not installing a graphical interface (--without-x), which may not be 
used on the cluster.

* **Run make to compile the source code**

    Typical Linux installations involve the process of compiling the software so it will run with the particular hardware and 
software available.  The make command uses a special file called `Makefile` to guide the process of compiling large numbers of 
source code files (instead of just compiling one or a few source code files).

        make

    **NOTE:**  If you're compiling a large amount of code (a long compilation), you may want to consider compiling code in your 
`/home` directory or in `/local_scratch`, instead of compiling in `/scratch1`.  Compiling code can take longer than usual if it's 
done in the `/scratch1` filesystem.

* **Install the newly compiled software**

        make install

    At this point, the new software will be installed in my specified `/home/galen/gromacs/4.5.5` directory.

* **Configure environment settings**

    Now that I've installed a new software package, I can customize my environment so I'll be able to access the new software 
automatically.  This usually involves appending the location of the new sotware to my existing `PATH`, `LD_LIBRARY_PATH`, `INCLUDE`, 
or other environment variables.  Or I may need to add new environment variables.  The installation instructions for my software 
package should explain what needs to be done.  Here are a few examples of the syntax I might use in my `/home/galen/.bashrc` file, or 
in my PBS job script, so I can use my newly installed software:

        module add gcc/4.4 mpich2/1.4 fftw/2.1.5-double
        export PATH=/home/galen/gromacs/4.5.5/bin:$PATH
        export LD_LIBRARY_PATH=/home/galen/gromacs/4.5.5/lib:$LD_LIBRARY_PATH
        export LIBRARY_PATH=/home/galen/gromacs/4.5.5/lib:$LIBRARY_PATH
        export C_INCLUDE_PATH=/home/galen/gromacs/4.5.5/include:$C_INCLUDE_PATH
        export CPLUS_INCLUDE_PATH=/home/galen/gromacs/4.5.5/include:$CPLUS_INCLUDE_PATH
        export MANPATH=/home/galen/gromacs/4.5.5/share/man:$MANPATH
        export MPI_HOME=/opt/mpich2/1.4
        export FFTW_HOME=/opt/fftw/2.1.5-double
 

