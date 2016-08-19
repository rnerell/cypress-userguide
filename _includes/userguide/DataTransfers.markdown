Management of Cypress data, including upload to and download from HDFS, has to be done from **dsciu001**. The dsciu001 node is configured to have access to other file systems used with Palmetto:
- */home*
- */scratch1*
- */scratch2*
- etc.

You might already have some data stored on those other file systems, so remember: ONLY **dsciu001** is configured to allow you to move data between HDFS and the other file systems mentioned above.

The general syntax for file and directory management on Cypress is as followed:

    hdfs dfs command [genericOptions] [commandOptions]

The commands and commandOptions are similar to those of a Linux file system:

    [username@dsciu001 ~]$ hdfs dfs
    Usage: hadoop fs [generic options]
        [-appendToFile <localsrc> ... <dst>]
        [-cat [-ignoreCrc] <src> ...]
        [-checksum <src> ...]
        [-chgrp [-R] GROUP PATH...]
        [-chmod [-R] <MODE[,MODE]... | OCTALMODE> PATH...]
        [-chown [-R] [OWNER][:[GROUP]] PATH...]
        [-copyFromLocal [-f] [-p] [-l] <localsrc> ... <dst>]
        [-copyToLocal [-p] [-ignoreCrc] [-crc] <src> ... <localdst>]
        [-count [-q] [-h] [-v] [-t [<storage type>]] <path> ...]
        [-cp [-f] [-p | -p[topax]] <src> ... <dst>]
        [-createSnapshot <snapshotDir> [<snapshotName>]]
        [-deleteSnapshot <snapshotDir> <snapshotName>]
        [-df [-h] [<path> ...]]
        [-du [-s] [-h] <path> ...]
        [-expunge]
        [-find <path> ... <expression> ...]
        [-get [-p] [-ignoreCrc] [-crc] <src> ... <localdst>]
        [-getfacl [-R] <path>]
        [-getfattr [-R] {-n name | -d} [-e en] <path>]
        [-getmerge [-nl] <src> <localdst>]
        [-help [cmd ...]]
        [-ls [-d] [-h] [-R] [<path> ...]]
        [-mkdir [-p] <path> ...]
        [-moveFromLocal <localsrc> ... <dst>]
        [-moveToLocal <src> <localdst>]
        [-mv <src> ... <dst>]
        [-put [-f] [-p] [-l] <localsrc> ... <dst>]
        [-renameSnapshot <snapshotDir> <oldName> <newName>]
        [-rm [-f] [-r|-R] [-skipTrash] [-safely] <src> ...]
        [-rmdir [--ignore-fail-on-non-empty] <dir> ...]
        [-setfacl [-R] [{-b|-k} {-m|-x <acl_spec>} <path>]|[--set <acl_spec> <path>]]
        [-setfattr {-n name [-v value] | -x name} <path>]
        [-setrep [-R] [-w] <rep> <path> ...]
        [-stat [format] <path> ...]
        [-tail [-f] <file>]
        [-test -[defsz] <path>]
        [-text [-ignoreCrc] <src> ...]
        [-touchz <path> ...]
        [-truncate [-w] <length> <path> ...]
        [-usage [cmd ...]]
    Generic options supported are
      -conf <configuration file>     specify an application configuration file
      -D <property=value>            use value for given property
      -fs <local|namenode:port>      specify a namenode
      -jt <local|resourcemanager:port>    specify a ResourceManager
      -files <comma separated list of files>    specify comma separated files to be copied to the map reduce cluster
      -libjars <comma separated list of jars>    specify comma separated jar files to include in the classpath.
      -archives <comma separated list of archives>    specify comma separated archives to be unarchived on the compute machines.
    The general command line syntax is bin/hadoop command [genericOptions] [commandOptions]
