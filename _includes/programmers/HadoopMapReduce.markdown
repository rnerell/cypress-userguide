Hadoop MapReduce is the default execution engine to support data processing and analytics on top of the Hadoop Distributed File System. Hadoop MapReduce implements libraries to enable the MapReduce programming model. While the standard language for developing Hadoop MapReduce applications is Java, Hadoop MapReduce also supports calling other executables/scripts as map/reduce/combiner/partitioner functions through [Hadoop Streaming](http://citi.clemson.edu/hadoop/pages/software.html#mapreduce) support. 

The basic anatomy of a Java Hadoop MapReduce application is as followed:

    import java.io.IOException;
    import java.util.*;

    import org.apache.hadoop.conf.*;
    import org.apache.hadoop.fs.*;
    import org.apache.hadoop.conf.*;
    import org.apache.hadoop.io.*;
    import org.apache.hadoop.mapreduce.*;
    import org.apache.hadoop.mapreduce.lib.input.*;
    import org.apache.hadoop.mapreduce.lib.output.*;
    import org.apache.hadoop.util.*;

    /* MAIN */
    public class WordCount extends Configured implements Tool {

      public static void main(String args[]) throws Exception {
        int res = ToolRunner.run(new WordCount(), args);
        System.exit(res);
      }

      public int run(String[] args) throws Exception {
        Path inputPath = new Path(args[0]);
        Path outputPath = new Path(args[1]);

        Configuration conf = getConf();
        Job job = new Job(conf, this.getClass().toString());

        FileInputFormat.setInputPaths(job, inputPath);
        FileOutputFormat.setOutputPath(job, outputPath);

        job.setJarByClass(WordCount.class);
        job.setInputFormatClass(TextInputFormat.class);
        job.setOutputFormatClass(TextOutputFormat.class);
        job.setMapOutputKeyClass(Text.class);
        job.setMapOutputValueClass(IntWritable.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);

        job.setMapperClass(Map.class);
        job.setCombinerClass(Reduce.class);
        job.setReducerClass(Reduce.class);

        return job.waitForCompletion(true) ? 0 : 1;
      }

      /* MAP */
      public static class Map extends Mapper<Object, Text, Text, IntWritable> {
        private Text word = new Text();

        public void map(Object key, Text value, Context context) throws IOException, InterruptedException {
          StringTokenizer tokenizer = new StringTokenizer(value.toString());
          while (tokenizer.hasMoreTokens()) {
            word.set(tokenizer.nextToken());
          context.write(word, new IntWritable(1));
        }
      }
    }
      /* REDUCE */    
      public static class Reduce extends Reducer<Text, IntWritable, Text, IntWritable>{
        public void reduce(Text key, Iterable<IntWritable> values, Context context) throws IOException, InterruptedException {
          int sum = 0;
          for (IntWritable value : values) {
            sum += value.get();
          }
          context.write(key, new IntWritable(sum));
        }
      }
    }

This is the classic WordCount example for Hadoop. In section **MAIN**, the configurations of the MapReduce job (application) are defined. Important configurations include InputFormatClass, OutputFormatClass, MapOutputKeyClass,MapOutputValueClass, OutputKeyClass, and OutputValueClass, as they define how the data will be recognized, intepreed, and transferred across logical instances of the Map and Reduce classes. Sections **MAP** and **REDUCE** implement the Map and Reduce functionalities, respectively. 

The goal of this WordCount application is to count the appearances of all unique words within a document (or a set of documents). The standard TextInputFormat of Hadoop MapReduce will read data from distributed blocks one line at a time. As seen from **MAP**, each line is read in as the *value* variable. *Value* is then split into individual word, and **MAP** emits the (word, 1) Key/Value pair to the **REDUCE** stage. To support communication among the distributed instances of the Map and Reduce classes, Hadoop MapReduce implements a set of serialized types to support the base types. Examples of these serialized types include Text for String, IntWritable for int, DoubleWritable for double, etc. 

        public void map(Object key, Text value, Context context) throws IOException, InterruptedException {
          StringTokenizer tokenizer = new StringTokenizer(value.toString());
          while (tokenizer.hasMoreTokens()) {
            word.set(tokenizer.nextToken());
          context.write(word, new IntWritable(1));
        }


Prior the **REDUCE** stage, the pairs with the same **key** (which means these are counts for the same **word**) are groupped together into a iterable list (Java Iterable class). Each list is reduced using a summation operation, thus produces the total count of appearances for each unique word. 

        public void reduce(Text key, Iterable<IntWritable> values, Context context) throws IOException, InterruptedException {
          int sum = 0;
          for (IntWritable value : values) {
            sum += value.get();
          }
          context.write(key, new IntWritable(sum));


The parallelization for Hadoop MapReduce can happen at both the Map stage and the Reduce stage. For Map, instances of the map function are deployed across the cluster, and they will process the local data stored on individual machines (bring computation to the data). While the resulting Key/Value pairs must be **shuffled** to bring the pairs with the same key together, the communication cost as well as Reduction performanec can be improved by scaling the number of Reduce objects (decreasing the number of unique Keys each Reduce object processes).

It is possible to customized (override) many of Hadoop MapReduce default functionalities. These customizations include input formats for complex data such as JSON, XML, or HDF5, serialized type for Java object beyond the basic types, preliminary reduction for the mapping stage to reduce network communication, and customized partition algorithms to determine how the keys are distributed across the reducers. 

Hadoop MapReduce requires the application to be compiled and packaged as a jar file for execution. Below is a simple bash script called *compile.sh* that will help with this process on Cypress:

    #!/bin/bash
    classname=$1
    sourcefile="$classname.java"
    jarfile="$classname.jar"

    rm -Rf classes
    rm $jarfile
    mkdir classes

    export HADOOP_HOME="/usr/hdp/current/"
    export HADOOP_COMMON_HOME="${HADOOP_HOME}/hadoop-client"
    export HADOOP_MAPRED_HOME="${HADOOP_HOME}/hadoop-mapreduce-client"
    export YARN_HOME="${HADOOP_HOME}/share/hadoop/yarn-client"
    export JAVA_HOME="/usr/lib/jvm/java-1.7.0-openjdk.x86_64"

    echo "Compiling ..."
    javac -cp "$HADOOP_COMMON_HOME/*:$HADOOP_MAPRED_HOME/*" -d classes $sourcefile

    echo "Creating jar ..."
    jar -cvf $jarfile -C classes/ .

This script takes a single argument, the class name of the main application class:

    ./compile.sh WordCount

To submit and run the application on Cypress:

    yarn jar WordCount.jar WordCount /user/lngo/complete-shakespeare.txt /user/lngo/outputWordCount/
 
It is important to note that the paths provided in the previous *yarn* call are HDFS paths and not local path. Also, the */user/lngo/outputWordCount* must not exist prior to this call. It is possible to incorporate this check into the Java source code.

The contents of the output directory after a successful execution:

    [lngo@resourcemgr hadoop-userguide]$ hdfs dfs -ls /user/lngo/outputWordCount
    Found 2 items
    -rw-r--r--   2 lngo hdfs          0 2016-03-16 09:57 /user/lngo/outputWordCount/_SUCCESS
    -rw-r--r--   2 lngo hdfs     721220 2016-03-16 09:57 /user/lngo/outputWordCount/part-r-00000

Partial content of the ouput files part-r-00000:

    [lngo@resourcemgr hadoop-userguide]$ hdfs dfs -tail /user/lngo/outputWordCount/part-r-00000
    u'll    102
    you're  15
    you'st  1
    you,    1428
    you-    45
    you--   1
    you--you        1
    you-I   1
    you-he  1
    you-often       1
    you-pray        1
    you-that        1
    you-well,       1
    you-wondrous    1
    you.    811
    you.'   4
    you.-   5
    you:    29
    you;    261
    you?    259
    you?'   3

  

