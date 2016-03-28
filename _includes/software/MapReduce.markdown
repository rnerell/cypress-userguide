Application-related interactions between users and Cypress are often done though YARN, Cypress' default ResourceManager. The most common interactions include submitting applications to YARN and inquiring about the status of the applications. The generic syntax is:

    yarn COMMAND --loglevel loglevel [generic_options] [command_options]

The **--loglevel** flag represents the level of details in logging operations. Starting from the least to the most verbose, we have FATAL, ERROR, WARN, INFO, DEBUG, and TRACE. Default level is INFO. 

generic_options | Description |
----------------|-------------|
`-archives <comma separated list of archives>` | Specify archives to be unarchived on the compute machines. Applies only to job |
`-conf <configuration file>` | Specify an application configuration file |
`-D <property>=<value>` | Use value for a given property | 
`-files <comma separated list of files>` | Specify files to be copied to the cluster. Applies only to job |
`-jt <local> or <resourcemanager:port>` | Specify a ResourceManager. Applies only to job |
`-libjars <comma separated list of jars>` | Specify the jar files to include in the classpath. Applies only to job.

#### COMMAND: jar
Run a jar file as an application on Cypress. Usage:

    yarn jar <jar file> [mainClass] args ...

Typically, YARN applications are written in Java and bundled into jar files to be executed. However, Hadoop also supports the execution of non-Java applications via the Hadoop Streaming utility. This utility allows you to use any executable or scripts as the mapper and/or the reducer for a YARN application. Usage:

    yarn jar /usr/hdp/current/hadoop-mapreduce-client/hadoop-streaming.jar [generic_options] [streaming_options]

streaming_options | Optional/Required | Description |
------------------|-------------------|-------------|
`-input directoryname or filename` | Required | Input location for mapper |
`-output directoryname` | Required | Output location for reducer |
`-mapper executable or JavaClassName` | Required | Mapper executable |
`-reducer executable or JavaClassName` | Required | Reducer executable |
`-file filename` | Optional |  Make the mapper, reducer, or combiner executable available locally on the compute nodes |
`-inputformat JavaClassName` | Optional | Class you supply should return key/value pairs of Text class. If not specified, TextInputFormat is used as the default |
`-outputformat JavaClassName` | Optional | Class you supply should take key/value pairs of Text class. If not specified, TextOutputformat is used as the default |
`-partitioner JavaClassName` | Optional | Class that determines which reduce a key is sent to |
`-combiner executable or JavaClassName` | Optional | Combiner executable for map output |
`-cmdenv name=value` | Optional | Pass environment variable to streaming commands |
`-inputreader JavaClassName` | Optional | For backwards-compatibility: specifies a record reader class (instead of an input format class) |
`-verbose` | Optional | Verbose output |
`-lazyOutput` | Optional | Create output lazily. For example, if the output format is based on FileOutputFormat, the output file is created only on the first call to Context.write |
`-numReduceTasks` | Optional | Specify the number of reducers |
`-mapdebug` | Optional | Script to call when map task fails |
`-reducedebug` | Optional | Script to call when reduce task fails |
#### COMMAND: application
Provides application reports or kill applications.  

command_options | Description |
--------|-------|
`-appStates <States` | List applications based on input comma-separated list of states: ALL, NEW, NEW_SAVING, SUBMITTED, ACCEPTED, RUNNING, FINISHED, FAILED, KILLED |
`-appTypes <Types>` | List applications based on input comma-separated list of application types |
`-list` | List all applications |
`-kill <ApplicationId>` | Kills the application |
`-status <ApplicationId>` | Prints the status of the application |

#### COMMAND: classpath
Prints the classpath needed to get the Hadoop jar and the required libraries

#### COMMAND: logs
Dumps the container logs. Usage:

    yarn logs -applicationId <application id> [options]

command_options | Description |
--------|-------|
`-applicationId <applcation id>` | Specify an application id | 
`-appOwner <AppOwner>` | Owner of the app |
`containerId <containerId>` | Containter ID. Must be specified if node address is specified |
`-nodeAddress <NodeAddress>` | Address of the node to get the log from, in the form nodename:port. Must be specified if containedId is specified |


#### COMMAND: queue
Prints queue information

command_options | Description |
--------|-------|
`-help` | Help |
`-status <QueueName>` | Prints the status of the queue |


