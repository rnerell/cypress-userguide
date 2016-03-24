
Testing....

{% for purchase in site.data.hardware.purchases %}
<h3>Phase {{purchase.id}}</h3>
<ul>
<li><strong>Purchase date:</strong> {{purchase.date}}
<li><strong>Node model:</strong> {{purchase.make}} {{purchase.model}}
<li><strong>Processor:</strong> {{purchase.processor}}
<li><strong>Memory:</strong> {{purchase.memory}}
<li><strong>Accelerator:</strong> <a href="{{purchase.accelerator.link}}">{{purchase.accelerator.display}}</a>
<li><strong>Interconnect:</strong> <a href="{{purchase.interconnect.link}}">{{purchase.interconnect.display}}</a>
<li><strong>Ethernet:</strong> {{purchase.ethernet}} Gbps
<li><strong>Purchase Info:</strong> {{purchase.total}} phase {{purchase.id}} nodes were added to Palmetto; {{purchase.sold}} were sold to faculty
<li><strong>Top500</strong>: Listed at #{{purchase.rank}}, at a benchmark of {{purchase.tflops}} TFLOPS
</ul>
{% endfor %}

Faculty/staff can purchase Palmetto nodes through what's commonly called a "condo" model where resource 
owners are buying preemption units accessed through the use of a dedicated owner job queue that is 
associated with the resources purchased. Preemption units give an owner's job the ability to (1) preempt 
general workq jobs in order to acquire requested compute resources, (2) prevent the owner's job from being 
preempted by other owner's jobs, and (3) run for up to 336 hours (2 weeks).

An owner of Palmetto compute resources can request that any Clemson students, faculty, or staff be added to 
that owner's dedicated job queue. An owner can also setup VisitorID accounts for external collaborators 
that will enable those external collaborators to log-in to Palmetto and run jobs using the owner's job 
queue. Please note: these external collaborators will be limited to using only the resources purchased by 
the owner - they will not have access to the general workq which is exclusively for Clemson students, 
faculty, and staff.

![Palmetto Nodes]({{site.data.main.palmetto_url}}/images/nx360M5.jpg)

The node configuration currently available for purchase is:
    
* [Dell C4130](http://www.dell.com/us/business/p/poweredge-c4130/pd) compute node

* 2 x [Intel Xeon E5-2680v3](http://ark.intel.com/products/81908/Intel-Xeon-Processor-E5-2680-v3-30M-Cache-2_50-GHz) "Haswell" @2.5 GHz (for a total of 24 cores)

* 2 x [NVIDIA Tesla K40c](http://www.techpowerup.com/gpudb/2505/tesla-k40c.html) GPU accelerators 

* 128 GB DDR4 RAM

* 2 x 1 TB local hard drives

* On-board 10 Gbps Ethernet NIC

* [InfiniBand FDR 56 Gbps](http://www.mellanox.com/page/products_dyn?product_family=142&mtag=connect_ib) network card

Resource ownership duration is 4 years.

The node price for Clemson faculty/staff is  $7,648.08  (current as of September 2015 - price and 
availability are subject to change). The node price for external entities is negotiated.

**NOTE:**  the node price includes costs and administration work associated with Ethernet and InfiniBand 
switching, physical housing (racking), power, and cooling. The node price does not include additional 
expense for the GPU accelerators which are included with all of our nodes - the cost of 
this additional hardware is covered by CCIT.

