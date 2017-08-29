Havlvade is a Hadoop-based software that implement the best practice DNA-seq/RNA-rseq pipeline by Broad Institute. It is open sourced and free for use under the GPLv3 license. The Git repository for Halvade is located [here](https://github.com/biointec/halvade). Technical details of Halvade implementations can be found in [this bioinformatics paper](http://bioinformatics.oxfordjournals.org/content/early/2015/04/15/bioinformatics.btv179.full.pdf+html)

Halvade's full documentation can be found [here](https://halvade.readthedocs.io/). In the remainder of this section, we present the detailed instructions on how to acquire, compile, and configure Halvade to run in Cypress. 

### Preparing Halvade

You can download Halvade jar releases, or you can download the source code to modify and compile Halvade yourself. 

** Halvade jar releases: **

To download Halvade releases, follow these steps:

```
qsub -I -l walltime=01:00:00
wget https://github.com/biointec/halvade/releases/download/1.2.1/Halvade_v1.2.1.tar.gz
```

A copy of Halvade version 1.2.1 is also stored in Cypress' HDFS storage. This copy is downloadable via the following command:

```
qsub -I -l walltime=01:00:00
module load cypress
hdfs dfs -get /repository/halvade/Halvade_v1.2.1.tar.gz
```

Decompress the `.tar.gz` file for the actual binary:

```
mkdir ~/halvade
tar xzf Halvade_v1.2.1.tar.gz -C ~/halvade
```

The `~/halvade` directory should include the following files:

```
bin.tar.gz
example.config
halvade_bootstrap.sh
HalvadeUploaderWithLibs.jar
HalvadeWithLibs.jar
runHalvade.py
```

** Compile Halvade from source: **

Halvade uses `Ant` to support source code compilation. To compile Halvade, follow these steps:

```
qsub -I -l walltime=01:00:00
module load java/1.8.0 ant/1.9.4
cd ~
mkdir tmp
cd tmp
git clone https://github.com/biointec/halvade.git
cd halvade/halvade
ant
cd ~/halvade/halvade_upload_tool
ant
```

Once the compilation process is completed, you need to create another directory to store the newly created jar files:

```
cd ~
mkdir halvade
cd halvade
cp ~/tmp/halvade/bin.tar.gz ~/halvade
cp ~/tmp/halvade/scripts/* ~/halvade
cp ~/tmp/halvade/halvade/dist/HalvadeWithLibs.jar ~/halvade
cp ~/tmp/halvade/halvade_upload_tool/dist/HalvadeUploaderWithLibs.jar ~/halvade
```

Similar to the previous approach in getting Halvade, the `~/halvade` directory should include the following files:

```
bin.tar.gz
example.config
halvade_bootstrap.sh
HalvadeUploaderWithLibs.jar
HalvadeWithLibs.jar
runHalvade.py
```


** Add GATK binary: **

Halvade uses GATK to run, so the binary needs to be present in the `bin.tar.gz` file. The current GATK version stored on HDFS is **3.6-0-g89b7209**. You can choose to download and use your own GATK version. 

```
cd ~/halvade
tar xzf bin.tar.gz
hdfs dfs -get /repository/halvade/GenomeAnalysisTK.jar 
cp GenomeAnalysisTK.jar bin/
rm bin.tar.gz
tar -cvzf bin.tar.gz bin/*
```

For both examples, all relevant data and supporting binaries are assumed to be placed in a predefined directory in HDFS:

```
hdfs dfs -mkdir -p /user/$USER/halvade/in
hdfs dfs -mkdir -p /user/$USER/halvade/ref/dbsnp/
hdfs dfs -put bin.tar.gz /user/$USER/halvade/
```

### Example: DNA-seq variant calling pipeline

This example is based on the [Halvade DNA-seq variant calling Recipe](https://github.com/biointec/halvade/wiki/Recipe:-DNA-seq-with-Halvade-on-a-local-Hadoop-cluster). 

In this example, we are processing FASTQ data with paired-end reads. The two files of the sample dataset, NA12878, can be copied from HDFS
The dataset used in this example is the NA12878 dataset. This consists of two gzipped FASTQ files with paired-end reads:

```
mkdir /scratch3/$USER/input_data
hdfs dfs -get /repository/halvade/dna/ERR194147_1.fastq.gz /scratch3/$USER/input_data/
hdfs dfs -get /repository/halvade/dna/ERR194147_2.fastq.gz /scratch3/$USER/input_data/
```

The starting directory is the `~/halvade` directory where the binaries are located:

```
cd ~/halvade
```



** Step 1: Prepare FASTQ data into format readable by Halvade **

The input data needs to be preprocessed and stored onto HDFS, this is done with `HalvadeUploaderWithLibs.jar`:

```
export HADOOP_HEAPSIZE=32768
yarn jar HalvadeUploaderWithLibs.jar -1 /scratch3/$USER/input_data/ERR194147_1.fastq.gz -2 /scratch3/$USER/input_data/ERR194147_2.fastq.gz -O /user/$USER/halvade/in/ -t 8
```

** Step 2: Prepare reference data **

The reference consists of a FASTA file containing the human genome, an index and a dictionary file:

```
hdfs dfs -get /repository/halvade/references
cd references
gunzip ucsc.hg19*.gz
cd ..
```

For the BQSR step, GATK needs a dbSNP file:

```
hdfs dfs -get /repository/halvade/dbsnp
cd dbsnp
gunzip dbsnp_138.hg19*.gz
cd ..
```

The bwa index needs to be created, for this untar the bin.tar.gz file to get the BWA binary and use this to index the (unzipped) FASTA file:

```
tar -xvf bin.tar.gz
cd references
../bin/bwa index ucsc.hg19.fasta
cd ..
```

All reference data need to be uploaded onto HDFS:

```
hdfs dfs -put ucsc.hg19.* /user/$USER/halvade/ref/
hdfs dfs -put dbsnp_138.hg19.vcf* /user/$USER/halvade/ref/dbsnp/
```


** Step 4: Configure Halvade **

Halvade comes with a diverse set of configurations, which can be found [here](https://halvade.readthedocs.io/en/latest/contents/options.html). In the `example.config` file, a set of basic options are provided. The default configurations in `example.config` are for a homogeneous 16-node Hadoop cluster with 128GB memory and 24 cores. Cypress is a heterogeneous Hadoop cluster with 16 nodes that have 256GB memory and 16 cores and 24 nodes that have 256GB memory and 20 cores. You can adjust the configurations in `example.config` and replace `<username>` with your username. 

```
N=16
M=128
C=24
B="/user/<username>/halvade/bin.tar.gz"
D="/user/<username>/halvade/ref/dbsnp/dbsnp_138.hg19.vcf"
R="/user/<username>/halvade/ref/ucsc.hg19"
I="/user/<username>/halvade/in/"
O="/user/<username>/halvade/out/"
smt
```

** Step 5: Running Halvade **
Now everything has been set and running Halvade can be done with this command:

```
python runHalvade.py example.config
```

When Halvade is finished, a vcf file will be created called `/user/<username>/halvade/out/merge/HalvadeCombined.vcf` which contains all called variants.



### Example: RNA-seq pipeline

 This example is based on the [Halvade RNA-seq variant calling Recipe](https://github.com/biointec/halvade/wiki/Recipe:-RNA-seq-with-Halvade-on-a-local-Hadoop-cluster). 
 
 The two files of the sample dataset, SK-MEL-5 experiment, can be copied from HDFS. This consists of two gzipped FASTQ files:

```
mkdir /scratch3/$USER/input_data
hdfs dfs -get /repository/halvade/rna/ENCFF005NLJ.fastq.gz /scratch3/$USER/input_data/
hdfs dfs -get /repository/halvade/rna/ENCFF635CQM.fastq.gz /scratch3/$USER/input_data/
```

The starting directory is the `~/halvade` directory where the binaries are located:

```
cd ~/halvade
```

** Step 1: Prepare FASTQ data into format readable by Halvade **

The input data needs to be preprocessed and stored onto HDFS, this is done with `HalvadeUploaderWithLibs.jar`:

The input data needs to be preprocessed and stored onto HDFS, this is done with HalvadeUploaderWithLibs.jar. The _bin.tar.gz_ still needs to be available on HDFS as it will be accessed in the distributed cache. For better performance it is advised to increase the Java heap memory for the hadoop command and revert it back after, run these commands:

```
export HADOOP_HEAPSIZE=16384
hdfs jar HalvadeUploaderWithLibs.jar -1 /scratch3/$USER/input_data/ENCFF005NLJ.fastq.gz -2 /scratch3/$USER/input_data/ENCFF635CQM.fastq.gz -O /user/$USER/halvade/in/ -t 8
```


** Step 2: Prepare reference data **

The reference consists of a FASTA file containing the human genome, an index and a dictionary file:

```
hdfs dfs -get /repository/halvade/references
cd references
gunzip ucsc.hg19*.gz
cd ..
```

For the BQSR step, GATK needs a dbSNP file:

```
hdfs dfs -get /repository/halvade/dbsnp
cd dbsnp
gunzip dbsnp_138.hg19*.gz
cd ..
```

The STAR index needs to be created. This can be done by untarring the bin.tar.gz file to get the STAR binary and use this to index the (unzipped) FASTA file:

```
tar -xvf bin.tar.gz
mkdir STAR_ref/
../bin/STAR --genomeDir STAR_ref/ --genomeFastaFiles references/ucsc.hg19.fasta --runMode genomeGenerate --runThreadN 8
cd ..
```

Note that this process needs at least 32 GBytes of RAM memory to complete successfully.

All reference data need to be uploaded onto HDFS:

```
hdfs dfs -put references/ucsc.hg19.* /user/$USER/halvade/ref/
hdfs dfs -put dbsnp/dbsnp_138.hg19.vcf* /user/$USER/halvade/ref/dbsnp/
hdfs dfs -put STAR_ref /usr/$USER/halvade/ref/
```

** Step 4: Configure Halvade **

Halvade comes with a diverse set of configurations, which can be found [here](https://halvade.readthedocs.io/en/latest/contents/options.html). In the `example.config` file, a set of basic options are provided. The default configurations in `example.config` are for a single node Hadoop cluster with 128GB memory and 24 cores. Cypress is a heterogeneous Hadoop cluster with 16 nodes that have 256GB memory and 16 cores and 24 nodes that have 256GB memory and 20 cores. You can adjust the configurations in `example.config` and replace `<username>` with your username. 

```
N=1
M=128
C=24
B="/user/<username>/halvade/bin.tar.gz"
D="/user/<username>/halvade/ref/dbsnp_138.hg19.vcf"
R="/user/<username>/halvade/ref/ucsc.hg19"
S="/user/<username>/halvade/ref/STAR_ref/"
I="/user/<username>/halvade/in/"
O="/user/<username>/halvade/out/"
smt
rna
P
```

** Step 5: Running Halvade **
Now everything has been set and running Halvade can be done with this command:

```
python runHalvade.py example.config
```

When Halvade is finished, a vcf file will be created called `/user/<username>/halvade/out/merge/HalvadeCombined.vcf` which contains all called variants.


