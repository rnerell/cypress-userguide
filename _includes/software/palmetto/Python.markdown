
[Python](http://python.org/) is available as a software module on Palmetto (modules `python/2.7.6` 
and `python/3.3.3`) and also available natively as an integral part of the Scientific Linux 6 OS.  
To invoke the Python interpreter in interactive mode, simply type the python command.

    [galen@user001 ~]$ which python
    /usr/bin/python

    [galen@user001 ~]$ python
    Python 2.6.6 (r266:84292, May 20 2011, 16:42:11) 
    [GCC 4.4.5 20110214 (Red Hat 4.4.5-6)] on linux2
    Type "help", "copyright", "credits" or "license" for more information.
    >>> 

Here, in interactive mode, I can use help('modules') to see a list of all modules that are available:

    >>> help('modules') 

    Please wait a moment while I gather a list of all available modules...

    BaseHTTPServer      ast                 imghdr              sha
    Bastion             asynchat            imp                 shelve
    CDROM               asyncore            importlib           shlex
    CGIHTTPServer       atexit              imputil             shutil
    Canvas              audiodev            inspect             signal
    ConfigParser        audioop             io                  site
    Cookie              base64              itertools           smtpd
    DLFCN               bdb                 json                smtplib
    Dialog              binascii            keyword             sndhdr
    DocXMLRPCServer     binhex              lib2to3             socket
    FileDialog          bisect              linecache           spwd
    FixTk               bsddb               linuxaudiodev       sqlite3
    HTMLParser          bz2                 locale              sre
    IN                  cPickle             logging             sre_compile
    MimeWriter          cProfile            macpath             sre_constants
    Queue               cStringIO           macurl2path         sre_parse
    ScrolledText        calendar            mailbox             ssl
    SimpleDialog        cgi                 mailcap             stat
    SimpleHTTPServer    cgitb               markupbase          statvfs
    SimpleXMLRPCServer  chunk               marshal             string
    SocketServer        cmath               math                stringold
    StringIO            cmd                 md5                 stringprep
    TYPES               code                mhlib               strop
    Tix                 codecs              mimetools           struct
    Tkconstants         codeop              mimetypes           subprocess
    Tkdnd               collections         mimify              sunau
    Tkinter             colorsys            mmap                sunaudio
    UserDict            commands            modulefinder        symbol
    UserList            compileall          multifile           symtable
    UserString          compiler            multiprocessing     sys
    _LWPCookieJar       contextlib          mutex               sysconfig
    _MozillaCookieJar   cookielib           netrc               syslog
    __builtin__         copy                new                 tabnanny
    __future__          copy_reg            nis                 tarfile
    _abcoll             crypt               nntplib             telnetlib
    _ast                csv                 ntpath              tempfile
    _bisect             ctypes              nturl2path          termios
    _bsddb              curses              numbers             test
    _codecs             datetime            numpy               textwrap
    _codecs_cn          dbhash              opcode              this
    _codecs_hk          dbm                 operator            thread
    _codecs_iso2022     decimal             optparse            threading
    _codecs_jp          difflib             os                  time
    _codecs_kr          dircache            os2emxpath          timeit
    _codecs_tw          dis                 ossaudiodev         tkColorChooser
    _collections        distutils           parser              tkCommonDialog
    _csv                doctest             pdb                 tkFileDialog
    _ctypes             dumbdbm             pickle              tkFont
    _ctypes_test        dummy_thread        pickletools         tkMessageBox
    _curses             dummy_threading     pipes               tkSimpleDialog
    _curses_panel       email               pkgutil             toaiff
    _elementtree        encodings           platform            token
    _functools          errno               plistlib            tokenize
    _hashlib            exceptions          popen2              trace
    _heapq              fcntl               poplib              traceback
    _hotshot            filecmp             posix               ttk
    _io                 fileinput           posixfile           tty
    _json               fnmatch             posixpath           turtle
    _locale             formatter           pprint              types
    _lsprof             fpformat            profile             unicodedata
    _multibytecodec     fractions           pstats              unittest
    _multiprocessing    ftplib              pty                 urllib
    _pyio               functools           pwd                 urllib2
    _random             future_builtins     py_compile          urlparse
    _socket             gc                  pyclbr              user
    _sqlite3            gdbm                pydoc               uu
    _sre                genericpath         pydoc_data          uuid
    _ssl                getopt              pyexpat             warnings
    _strptime           getpass             quopri              wave
    _struct             gettext             random              weakref
    _symtable           glob                re                  webbrowser
    _testcapi           grp                 readline            whichdb
    _threading_local    gzip                repr                wsgiref
    _tkinter            hashlib             resource            xdrlib
    _warnings           heapq               rexec               xml
    _weakref            hmac                rfc822              xmllib
    _weakrefset         hotshot             rlcompleter         xmlrpclib
    abc                 htmlentitydefs      robotparser         xxsubtype
    aifc                htmllib             runpy               zipfile
    antigravity         httplib             sched               zipimport
    anydbm              idlelib             select              zlib
    argparse            ihooks              sets                
    array               imaplib             sgmllib 


#### IPython: An enhanced Interactive Python

[IPython](http://ipython.org/) offers a combination of convenient shell features, special commands 
and a history mechanism for both input (command history) and output (results caching, similar to 
Mathematica). It is intended to be a fully compatible replacement for the standard Python interpreter, 
while offering vastly improved functionality and flexibility.

On Palmetto, after loading either the `python/2.7.6` or `python/3.3.3` module, type `ipython -h` to see 
the command line options available.

To open a separate IPython interactive window, enable X11 tunneling between your local workstation and 
an interactive job on Palmetto (see details here) and launch the IPython GUI with this command:

    [galen@user001 ~]$ ipython qtconsole --matplotlib inline

![IPython]({{site.data.main.palmetto_url}}/images/ipython.1.png)

#### Building Your Own Python

If you need to modify/customize Python, you must download, install, and customize your own 
build.  Below is an example of the steps that may be required to install Python in your `/home` 
directory.  Of course, you should read the instructions included with the specific version of 
Python you are installing.

    [galen@user001 ~]$ module add gcc/4.8.1

    [galen@user001 ~]$ tar -zxf Python-2.7.3.tgz 
    [galen@user001 ~]$ cd Python-2.7.3
    [galen@user001 Python-2.7.3]$ ./configure --prefix=/home/galen/python/2.7.3
    [galen@user001 Python-2.7.3]$ make
    [galen@user001 Python-2.7.3]$ make install 

Once you've installed your new build of Python, you'll need to configure your environment settings 
to use this new build.  Adding commands similar to these (below) at the end of your `~/.bashrc` file 
will take care of this:

    export LD_LIBRARY_PATH=/home/galen/python/2.7.3/lib:$LD_LIBRARY_PATH
    export LIBRARY_PATH=/home/galen/python/2.7.3/lib:$LIBRARY_PATH
    export C_INCLUDE_PATH=/home/galen/python/2.7.3/include:$C_INCLUDE_PATH
    export CPLUS_INCLUDE_PATH=/home/galen/python/2.7.3/include:$CPLUS_INCLUDE_PATH
    export PATH=/home/galen/python/2.7.3/bin:$PATH 

Now, you'll need to source your `/home/username/.bashrc` file (or just log-out and log-in again) 
and verify that your new build of python is in your `PATH`:

    [galen@user001 ~]$ source ~/.bashrc

    [galen@user001 ~]$ which python
    ~/python/2.7.3/bin/python

    [galen@user001 Python-2.7.3]$ python
    Python 2.7.3 (default, Apr 25 2012, 09:50:46) 
    [GCC 4.4.5 20110214 (Red Hat 4.4.5-6)] on linux2
    Type "help", "copyright", "credits" or "license" for more information.
    >>> 
 
#### Installing Modules for Your Build of Python

After installing your own build of Python, the next step might be to install specific Python 
modules.  Below is an example of downloading, building, and installing a Python module called NumPy:

    [galen@user001 ~]$ wget http://downloads.sourceforge.net/project/numpy/NumPy/1.6.1/numpy-1.6.1.tar.gz
    [galen@user001 ~]$ tar -zxf numpy-1.6.1.tar.gz
    [galen@user001 ~]$ cd numpy-1.6.1
    [galen@user001 numpy-1.6.1]$ python setup.py build
    [galen@user001 numpy-1.6.1]$ python setup.py install

Since I installed my build of Python in my `/home` directory, the system path is already set for 
searching in my local directories:

    >>> import sys
    >>> sys.path
    ['', '/home/galen/python/2.7.3/lib/python27.zip', '/home/galen/python/2.7.3/lib/python2.7', '/home/galen/python/2.7.3/lib/python2.7/plat-linux2', '/home/galen/python/2.7.3/lib/python2.7/lib-tk', '/home/galen/python/2.7.3/lib/python2.7/lib-old', '/home/galen/python/2.7.3/lib/python2.7/lib-dynload', '/home/galen/python/2.7.3/lib/python2.7/site-packages']

Now that I've installed NumPy, I can import it and I can see that it's installed in my 
`/home/galen/python/2.7.3/lib/python2.7/site-packages` directory:

    >>> import numpy
    >>> numpy.__file__
    '/home/galen/python/2.7.3/lib/python2.7/site-packages/numpy/__init__.pyc'


