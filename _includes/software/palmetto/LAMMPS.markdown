
A variety of different versions of [LAMMPS](http://lammps.sandia.gov/) are available cluster-wide 
on Palmetto, and users are encouraged to install LAMMPS for themselves if sepcial features or 
configuration options are needed.  The instructions provided here will focus only on LAMMPS version 
17Dec13.

On Palmetto, LAMMPS 17Dec13 is configured for double-precision (dp) with the following optional 
packages:

ASPHERE, ATC, CLASS2, COLLOID, DIPOLE, FLD, GPU, GRANULAR, KSPACE, MANYBODY, MC, MEAM, MOLECULE, OPT, PERI, POEMS, REAX, REPLICA, RIGID, SHOCK, SRD, XTC, USER-ATC, USER-GC-CMM, USER-EFF, USER-MISC, USER-MOLFILE, USER-REAXC, USER-SPH

All of the LAMMPS 17Dec13 modules were built using the Intel 13.0 compiler suite `intel/13.0`, 
FFTW3 libraries `fftw/3.2.2-double`, the InfiniBand-enabled OpenMPI package `openmpi/1.6.4`, and 
CUDA toolkit 5.5.22 `cuda-toolkit/5.5.22`.

#### Building LAMMPS 17Dec13 on Palmetto

**Single precision**

{% highlight bash %}
module add intel/13.0
module add fftw/2.1.5-single

wget http://lammps.sandia.gov/tars/lammps.tar.gz
tar -zxf lammp.tar.gz
cd ~/lammps-17Dec13

cd ../meam
sed -i 's*-lifcore -lsvml -lompstub -limf*-lifcore -lsvml -liompstubs5 -limf*' Makefile.lammps.ifort
sed -i 's*/opt/intel/fce/10.0.023/lib*/opt/intel/composer_xe_2013.4.183/compiler/lib/intel64*' Makefile.lammps.ifort
make F90=mpif90 F90FLAGS="-O -fPIC -mkl=parallel" -f Makefile.ifort

cd ../poems
make -f Makefile.icc CC=mpicxx LINK=mpicxx LINKFLAGS="-O -mkl=parallel"

cd ../reax
sed -i 's*-lifcore -lsvml -lompstub -limf*-lifcore -lsvml -liompstubs5 -limf*' Makefile.lammps.ifort
sed -i 's*/opt/intel/fce/10.0.023/lib*/opt/intel/composer_xe_2013.4.183/compiler/lib/intel64*' Makefile.lammps.ifort
make F90=mpif90 F90FLAGS="-O -fPIC -mkl=parallel" -f Makefile.ifort

cd ../../src
make yes-asphere;make yes-class2;make yes-colloid;make yes-dipole;make yes-fld;make yes-granular;make yes-kspace;make yes-manybody;make yes-mc;make yes-meam;make yes-molecule;make yes-opt;make yes-peri;make yes-poems;make yes-reax;make yes-replica;make yes-rigid;make yes-shock;make yes-srd;make yes-xtc;make yes-user-atc;make yes-user-gc-cmm;make yes-user-eff;make yes-user-misc;make yes-user-molfile;make yes-user-reaxc;make yes-user-sph

make CC=mpicxx LINK=mpicxx FFT_INC=-DFFT_FFTW FFT_LIB=-lfftw MPI_INC=/opt/openmpi/1.6.4/include openmpi
{% endhighlight %}

**Double precision**

{% highlight bash %}
module add intel/13.0
module add fftw/3.2.2-double

wget http://lammps.sandia.gov/tars/lammps.tar.gz
tar -zxf lammp.tar.gz
cd ~/lammps-17Dec13

sed -i 's/CUDA_PRECISION = -D_SINGLE_SINGLE/CUDA_PRECISION = -D_DOUBLE_DOUBLE/g' Makefile.linuxsed -i 's%CUDA_HOME = /usr/local/cuda%CUDA_HOME = /opt/cuda-toolkit/5.0.35%g' Makefile.linux

cd ../meam
sed -i 's*-lifcore -lsvml -lompstub -limf*-lifcore -lsvml -liompstubs5 -limf*' Makefile.lammps.ifort
sed -i 's*/opt/intel/fce/10.0.023/lib*/opt/intel/composer_xe_2013.4.183/compiler/lib/intel64*' Makefile.lammps.ifort
make F90=mpif90 F90FLAGS="-O -fPIC -mkl=parallel" -f Makefile.ifort

cd ../poems
make -f Makefile.icc CC=mpicxx LINK=mpicxx LINKFLAGS="-O -mkl=parallel"

cd ../reax
sed -i 's*-lifcore -lsvml -lompstub -limf*-lifcore -lsvml -liompstubs5 -limf*' Makefile.lammps.ifort
sed -i 's*/opt/intel/fce/10.0.023/lib*/opt/intel/composer_xe_2013.4.183/compiler/lib/intel64*' Makefile.lammps.ifort
make F90=mpif90 F90FLAGS="-O -fPIC -mkl=parallel" -f Makefile.ifort

cd ../../src
make yes-asphere;make yes-class2;make yes-colloid;make yes-dipole;make yes-fld;make yes-granular;make yes-kspace;make yes-manybody;make yes-mc;make yes-meam;make yes-molecule;make yes-opt;make yes-peri;make yes-poems;make yes-reax;make yes-replica;make yes-rigid;make yes-shock;make yes-srd;make yes-xtc;make yes-user-atc;make yes-user-gc-cmm;make yes-user-eff;make yes-user-misc;make yes-user-molfile;make yes-user-reaxc;make yes-user-sph

make CC=mpicxx FFT_INC=-DFFT_FFTW3 FFT_LIB=-lfftw3 LINK=mpicxx MPI_INC=/opt/openmpi/1.6.4/include openmpi
{% endhighlight %}

**GPU enabled version**

{% highlight bash %}
module add intel/13.0
module add cuda-toolkit/5.5.22
module add openmpi/1.6.4

wget http://lammps.sandia.gov/tars/lammps.tar.gz
tar -zxf lammp.tar.gz
cd ~/lammps-17Dec13

cd lib/gpu
sed -i 's%CUDA_HOME = /usr/local/cuda%CUDA_HOME = /opt/cuda-toolkit/5.5.22%g' Makefile.linux

** For NVIDIA Tesla m2075 GPUs (compute capability = 2.0):
sed -i 's/CUDA_ARCH = -arch=sm_21/CUDA_ARCH = -arch=sm_20/g' Makefile.linux

** For NVIDIA Tesla K20m GPUs (compute capability = 3.5):
sed -i 's/CUDA_ARCH = -arch=sm_21/CUDA_ARCH = -arch=sm_35/g' Makefile.linux

make -f Makefile.linux

cd ../meam
sed -i 's*-lifcore -lsvml -lompstub -limf*-lifcore -lsvml -liompstubs5 -limf*' Makefile.lammps.ifort
sed -i 's*/opt/intel/fce/10.0.023/lib*/opt/intel/composer_xe_2013.4.183/compiler/lib/intel64*' Makefile.lammps.ifort
make F90=mpif90 F90FLAGS="-O -fPIC -mkl=parallel" -f Makefile.ifort

cd ../poems
make -f Makefile.icc CC=mpicxx LINK=mpicxx LINKFLAGS="-O -mkl=parallel"

cd ../reax
sed -i 's*-lifcore -lsvml -lompstub -limf*-lifcore -lsvml -liompstubs5 -limf*' Makefile.lammps.ifort
sed -i 's*/opt/intel/fce/10.0.023/lib*/opt/intel/composer_xe_2013.4.183/compiler/lib/intel64*' Makefile.lammps.ifort
make F90=mpif90 F90FLAGS="-O -fPIC -mkl=parallel" -f Makefile.ifort

cd ../../src
make yes-gpu
make yes-asphere;make yes-class2;make yes-colloid;make yes-dipole;make yes-fld;make yes-granular;make yes-kspace;make yes-manybody;make yes-mc;make yes-meam;make yes-molecule;make yes-opt;make yes-peri;make yes-poems;make yes-reax;make yes-replica;make yes-rigid;make yes-shock;make yes-srd;make yes-xtc;make yes-user-atc;make yes-user-gc-cmm;make yes-user-eff;make yes-user-misc;make yes-user-molfile;make yes-user-reaxc;make yes-user-sph

make CC=mpicxx LINK=mpicxx MPI_INC=/opt/openmpi/1.6.4/include openmpi
{% endhighlight %}

#### Querying the GPU Accelerator (only on nodes with GPU accelerators)

When you build the optional GPU package within LAMMPS, you'll create an executable named `nvc_get_devices`.  
You can run this executable to get information about the GPU accelerator installed on the node where you 
are currently logged-in:

    [galen@node1665 ~]$  nvc_get_devices 

    Found 1 platform(s).
    Using platform: NVIDIA Corporation NVIDIA CUDA Driver
    CUDA Driver Version:                           5.0
    Device 0: "Tesla M2075"
      Type of device:                                GPU
      Compute capability:                            2
      Double precision support:                      Yes
      Total amount of global memory:                 5.24945 GB
      Number of compute units/multiprocessors:       14
      Number of cores:                               448
      Total amount of constant memory:               65536 bytes
      Total amount of local/shared memory per block: 49152 bytes
      Total number of registers available per block: 32768
      Warp size:                                     32
      Maximum number of threads per block:           1024
      Maximum group size (# of threads per block)    1024 x 1024 x 64
      Maximum item sizes (# threads for each dim)    65535 x 65535 x 65535
      Maximum memory pitch:                          2147483647 bytes
      Texture alignment:                             512 bytes
      Clock rate:                                    1.147 GHz
      Run time limit on kernels:                     Yes
      Integrated:                                    No
      Support host page-locked memory mapping:       Yes
      Compute mode:                                  Default
      Concurrent kernel execution:                   Yes
      Device has ECC support enabled:                Yes


#### Input Script Requirements for the GPU Package

GPU package input script usage and options (copied from here),

Usage:  `package gpu [gpu args]`

    gpu args = mode first last split keyword value
    	mode = force or force/neigh
    	first = ID of first GPU to be used on each node
    	last = ID of last GPU to be used on each node
    	split = fraction of particles assigned to the GPU
    	zero or more keyword/value pairs may be appended
    	keywords = threads_per_atom or cellsize
    		threads_per_atom value = Nthreads
    			Nthreads = # of GPU threads used per atom
    		cellsize value = dist
    			dist = length (distance units) in each dimension for neighbor bins

For example, if you have 2 GPU accelerators per node and 16 CPU cores per node, and you would like to 
run LAMMPS on 2 nodes (32 cores) with dynamic balancing of force calculation across CPU and GPU cores, 
you could specify

    package gpu force/neigh 0 1 -1 

in your input script.  In this case, all CPU cores and GPU devices on the nodes would be utilized. 
Each GPU device would be shared by 4 CPU cores. The CPU cores would perform force calculations for 
some fraction of the particles at the same time the GPUs performed force calculation for the other 
particles. 

**Additional examples:**

    package gpu force 0 0 1.0
    package gpu force 0 0 0.75
    package gpu force/neigh 0 0 1.0
    package gpu force/neigh 0 1 -1.0
    package gpu force/neigh 0 0 1
    package gpu force/neigh 0 1 1

For further details, please refer to the LAMMPS documetation for the GPU package, avilable [here](http://lammps.sandia.gov/doc/Section_accelerate.html#acc_6).

#### Running CPU-Only

A simple example job that's ready to run can be found here: 
`/newscratch/intro.palmetto/examples/lammps.dp.example`

An example PBS job script for this version of LAMMPS should look something like this:

{% highlight bash %}
#!/bin/bash
#PBS -N lmps-dp
#PBS -l select=1:ncpus=8:mpiprocs=8:chip_type=l5420:mem=11gb:interconnect=mx,walltime=00:30:00
#PBS -j oe

source /etc/profile.d/modules.sh
module purge
module add intel/13.0 fftw/3.2.2-double openmpi/1.6.4 lammps/17Dec13-dp

cd $PBS_O_WORKDIR

mpiexec -n $NCORES lmp_openmpi < binary.solution.input
{% endhighlight %}

#### Running CPU+GPU

This example shows how to run one of the built-in benchmark jobs that comes with the LAMMPS 
package. The PBS job script should look something like this:

{% highlight bash %}
#!/bin/bash
#PBS -N lmps-sg
#PBS -l select=1:ncpus=16:mpiprocs=16:ngpus=2:gpu_model=k20:mem=62gb:interconnect=fdr,walltime=00:30:00
#PBS -j oe

source /etc/profile.d/modules.sh
module purge
module add intel/13.0 fftw/3.2.2-double cuda-toolkit/5.5.22 openmpi/1.6.4 lammps/17Dec13-dp-k20

cd $PBS_O_WORKDIR

mpirun -np 16 lmp_openmpi -sf gpu -c off -v g 2 -v x 64 -v y 64 -v z 64 -v t 10000 < in.lj.gpu
{% endhighlight %}

