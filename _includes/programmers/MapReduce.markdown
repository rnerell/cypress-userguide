The MapReduce programming paradigm represents an algorithm approach in interacting with massive data sets. Ideally, these data sets are distributed in block-based fashion(e.g., Hadoop Distributed File System) across a cluster of computers. At a glance, MapReduce, together with underlying data distribution scheme, are somewhat similar to MPI's scatter/reduce combintation. 

It is important to distinguish between the MapReduce programming paradigm itself and programming libraries that implement the paradigm using different approaches. The application of the MapReduce programming paradigm was first introduced and popularized by Google's seminal paper [1]. Subsequently, Hadoop MapReduce [2] is the first open-source implementation for the architecture presented in the Google's paper. Apache Spark [3] is the next generation big data processing engine which perform the MapReduce operations on the distributed objects kept in memory. This results in a performance improvement of several order of magnitudes over the standard Hadoop MapReduce. 

There are two core functions in MapReduce programming paradigm: Map and Reduce. 

#### Map
Map is a function that is applied to every individual elements of a collection. For example, given the following function:

    int square(x) {
      return x * x;
    }

A mapping of this function on array [1,2,3,4] will return [1,4,9,16]. 

#### Reduce
Reduce is a function which, when performed on a list, will fold/reduce this list into a single value (or a smaller subset of values). For example:

    Reduce [1,2,3,4] using sum returns a value of 10.
    Reduce [1,2,3,4] for all values less than 3 returns set [1,2].

[1] Dean, Jeffrey, and Sanjay Ghemawat. "MapReduce: simplified data processing on large clusters." Communications of the ACM 51.1 (2008): 107-113.

[2] Bhandarkar, Milind. "MapReduce programming with Apache Hadoop." Parallel & Distributed Processing (IPDPS), 2010 IEEE International Symposium on. IEEE, 2010.

[3] Zaharia, Matei, et al. "Spark: Cluster Computing with Working Sets." HotCloud 10 (2010): 10-10. 
