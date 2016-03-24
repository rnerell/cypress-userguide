
This example uses `pickle`, Python's builtin serialization library.  This library has a very
simple interface, but in general, is much slower than other options. If you find that
you are unable to generate a checkpoint file within the 30-second window, see 
[this article](http://www.benfrederickson.com/dont-pickle-your-data) for information
about these faster alternatives.

{% highlight python %}
import signal, pickle
{% endhighlight %}

{% highlight python %}
terminate = False
{% endhighlight %}

{% highlight python %}
def sigterm(signum, frame):
   if signum == signal.SIGTERM:
      global terminate
      terminate = True
{% endhighlight %}

{% highlight python %}
chkpt_file = "chkpt.%s" % os.environ['PBS_JOBID']
if os.path.exists(chkpt_file):
  start_iter,vector = pickle.load(open(chkpt_file, "r"))
else:
  start_iter = 0
  vector = [ 0, ] * count
{% endhighlight %}

{% highlight python %}
signal.signal(signal.SIGTERM, sigterm)
{% endhighlight %}

{% highlight python %}
for iter in xrange(start_iter, 1000):
  if terminate:
    pickle.dump((iter,vector), open(chkpt_file, "w"))
    print "Checkpoint saved to %s" % chkpt_file
    break

  compute(vector)
{% endhighlight %}
  

