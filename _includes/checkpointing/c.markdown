
{% highlight cpp %}
volatile _Bool terminate = false;
{% endhighlight %}

{% highlight cpp %}
void sigterm(int signum)
{
   if(signum == SIGTERM)
      terminate = true;
}
{% endhighlight %}

{% highlight cpp %}
void save_checkpoint(char *chkpt_file, int iter, double *data, size_t count)
{
   FILE *f = fopen(chkpt_file, "w");
   fwrite(&iter, sizeof(int), 1, f);
   fwrite(data, sizeof(double), count, f);
   fclose(f);
}
{% endhighlight %}

{% highlight cpp %}
void load_checkpoint(char *chkpt_file, int *iter, double *data, size_t count)
{
   FILE *f = fopen(chkpt_file, "r");
   if(f) {
      fread(iter, sizeof(int), 1, f);
      fread(data, sizeof(double), count, f);
      fclose(f);
   }
}
{% endhighlight %}

{% highlight cpp %}
   snprintf(chkpt_file, PATH_MAX, "chkpt.%s", getenv("PBS_JOBID"));
   if(file_exists(chkpt_file)) {
      load_checkpoint(chkpt_file, &iter, vector, count);
   }
   else {
      // No checkpoint file found; initialize data
      memset(vector, sizeof(double) * count, 0);
      iter = 0;
   }
{% endhighlight %}

{% highlight cpp %}
   if(signal(SIGTERM, sigterm) == SIG_ERR)
      fprintf(stderr, "Cannot catch SIGTERM.  Checkpointing disabled.\n");
{% endhighlight %}

{% highlight cpp %}
   for(; iter < iterations; iter++) {
      if(terminate) {
         save_checkpoint(chkpt_file, iter, vector, count);
         break;
      }

      compute(vector, count);
   }
{% endhighlight %}
