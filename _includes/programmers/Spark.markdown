Run the following maven command to create a standard maven project and hit Enter to select default for all questions:

    module load maven/3.2.1
    mvn archetype:generate -DgroupId=edu.clemson.sites.citi -DartifactId=spark-example

Next, change your current directory into spark-example

    cd spark-example 
    
The default **pom.xml** file has the following contents:

    <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchem-instance"
      xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
      <modelVersion>4.0.0</modelVersion>
      <groupId>edu.clemson.sites.citi</groupId>
      <artifactId>spark-example</artifactId>
      <version>1.0-SNAPSHOT</version>
      <packaging>jar</packaging>

      <name>spark-example</name>
      <url>http://maven.apache.org</url>

      <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
      </properties>

      <dependencies>
        <dependency>
          <groupId>junit</groupId>
          <artifactId>junit</artifactId>
          <version>3.8.1</version>
          <scope>test</scope>
        </dependency>
      </dependencies>
    </project>

To ensure that supporting libraries are downloaded for the project, we need to
provide Maven with the following information:
- Where are the repositories for libraries dependencies? In this case, we want
the Hortonworks repository so that all Hadoop-based supporting libraries are
consistent with Cypress' infrastructure
- Which are the required dependencies? For this example, we want to have
Spark's supporting libraries.

The resulting **pom.xml** will have the following content: 

    <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
        <modelVersion>4.0.0</modelVersion>
        <groupId>edu.clemson.sites.citi</groupId>
        <artifactId>spark-example</artifactId>
        <version>1.0-SNAPSHOT</version>
        <packaging>jar</packaging>
        
        <name>spark-example</name>
        <url>https://www.palmetto.clemson.edu/cypress/pages/programmers.html</url>

        <properties>
            <java.version>1.8</java.version>
            <hadoop.version>2.7.1.2.4.2.0-258</hadoop.version>
            <spark.core.version>spark-core_2.11</spark.core.version>
            <spark.version>1.6.2</spark.version>
            <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        </properties>

        <repositories>
            <repository>
                <id>hortonworks</id>
                <url>http://repo.hortonworks.com/content/groups/public</url>
            </repository>
        </repositories>

        <dependencies>
            <dependency>
                <groupId>org.apache.hadoop</groupId>
                <artifactId>hadoop-client</artifactId>
                <version>${hadoop.version}</version>
            </dependency>
            <dependency>
                <groupId>junit</groupId>
                <artifactId>junit</artifactId>
                <version>3.8.1</version>
                <scope>test</scope>
            </dependency>
            <dependency>
                <groupId>org.apache.hadoop</groupId>
                <artifactId>hadoop-common</artifactId>
                <version>${hadoop.version}</version>
            </dependency>
            <dependency>
                <groupId>org.apache.hadoop</groupId>
                <artifactId>hadoop-hdfs</artifactId>
                <version>${hadoop.version}</version>
            </dependency>
            <dependency>
                <groupId>org.apache.spark</groupId>
                <artifactId>${spark.core.version}</artifactId>
                <version>${spark.version}</version>
            </dependency>
        </dependencies>

        <build>
            <outputDirectory>target/classes</outputDirectory>
            <testOutputDirectory>target/test-classes</testOutputDirectory>
            <!-- override pluginManagement section in parent -->
            <pluginManagement>
                <plugins>
                    <plugin>
                        <groupId>org.apache.maven.plugins</groupId>
                        <artifactId>maven-assembly-plugin</artifactId>
                        <version>2.6</version>
                    </plugin>
                    <plugin>
                        <groupId>org.apache.maven.plugins</groupId>
                        <artifactId>maven-dependency-plugin</artifactId>
                        <version>2.10</version>
                    </plugin>
                    <plugin>
                        <groupId>org.apache.maven.plugins</groupId>
                        <artifactId>maven-release-plugin</artifactId>
                        <version>2.5.3</version>
                    </plugin>
                    <plugin>
                        <groupId>org.apache.maven.plugins</groupId>
                        <artifactId>maven-site-plugin</artifactId>
                        <version>3.5.1</version>
                    </plugin>
                </plugins>
            </pluginManagement>
            <plugins>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-compiler-plugin</artifactId>
                    <version>3.5.1</version>
                    <configuration>
                        <source>${java.version}</source>
                        <target>${java.version}</target>
                    </configuration>
                </plugin>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-deploy-plugin</artifactId>
                    <version>2.8.2</version>
                </plugin>           
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-assembly-plugin</artifactId>
                    <configuration>
                        <descriptorRefs>
                            <descriptorRef>jar-with-dependencies</descriptorRef>
                        </descriptorRefs>
                        <archive>
                            <index>true</index>
                        </archive>
                        <attach>false</attach>
                    </configuration>
                    <executions>
                        <execution>
                            <phase>package</phase>
                            <goals>
                                <goal>single</goal>
                            </goals>
                        </execution>
                    </executions>
                </plugin>     
            </plugins>
        </build>
    </project>
    
  
The *properties* tag allows you to specify versions of relevant software as values, and the XML tags associated with these
values can be used as variable (beginning with chacracter **\$**) throughout the **pom.xml** file. This way, as Cypress (or 
any other infrastructure that you wish the application to run on) changes the software versions, you can easily rebuild the 
application only by editting these properties. 

The *repositories* tag specifies the repositories from which the dependencies are downloaded. 

The *dependencies* tag specifies the dependencies, which are required libraries for the application. 

The *build* tag specifies the plugins for Maven to enable an automated compilation and packaging of your application. 

The actual source code for this example is saved as **WordCount.java** under the **./src/main/java/edu/clemson/sites/citi/** directory path. The **./src/main/java** represents the required directory structure for source codes in Maven, and the **edu/clemson/sites/citi** represents the directory structure for the example's packaging. To build and deploy these packages, we first run:

    mvn package

This successful execution of this command will compile and create two jar files: 

- spark-example-1.0-SNAPSHOT.jar  
- spark-example-1.0-SNAPSHOT-jar-with-dependencies.jar

The *spark-example-1.0-SNAPSHOT.jar* contains the application itself without any supporting library. This is sufficient to run on Cypress. If you were to run your application elsewhere, or if you want to use external libraries that are not immediately available on Cypress, *spark-example-1.0-SNAPSHOT-jar-with-dependencies.jar* is the file that you want to use. To execute this jar file on Cypress, run the following:

    spark-submit --class edu.clemson.sites.citi.WordCount --master yarn --deploy-mode client target/spark-example-1.0-SNAPSHOT.jar /repository/complete-shakespeare.txt sparkWordCount

The resulting count of words from this execution is stored in the **sparkWordCount** directory on HDFS. The content of this directory can be viewed by running:

    hdfs dfs -ls sparkWordCount