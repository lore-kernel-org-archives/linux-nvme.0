From: jonathan.derrick@intel.com (Derrick, Jonathan)
Date: Fri, 16 Aug 2019 16:57:32 +0000
Subject: [PATCH V5 2/2] genirq/affinity: Spread vectors on node
 according to nr_cpu ratio
In-Reply-To: <20190816155353.GA6883@localhost.localdomain>
References: <20190816022849.14075-1-ming.lei@redhat.com>
 <20190816022849.14075-3-ming.lei@redhat.com>
 <20190816155353.GA6883@localhost.localdomain>
Message-ID: <3bdaa2bbd7b7c7e4cd15bee6f8df074df1fc1077.camel@intel.com>

On Fri, 2019-08-16@09:53 -0600, Keith Busch wrote:
> On Thu, Aug 15, 2019@07:28:49PM -0700, Ming Lei wrote:
> > Now __irq_build_affinity_masks() spreads vectors evenly per node, and
> > all vectors may not be spread in case that each numa node has different
> > CPU number, then the warning in irq_build_affinity_masks() can
> > be triggered.
> > 
> > Improve current spreading algorithm by assigning vectors according to
> > the ratio of node's nr_cpu to nr_remaining_cpus, meantime running the
> > assignment from smaller nodes to bigger nodes to guarantee that every
> > active node gets allocated at least one vector, then we can avoid
> > cross-node spread in normal situation.
> > 
> > Meantime the reported warning can be fixed.
> > 
> > Another big goodness is that the spread approach becomes more fair if
> > node has different CPU number.
> > 
> > For example, on the following machine:
> > 	[root at ktest-01 ~]# lscpu
> > 	...
> > 	CPU(s):              16
> > 	On-line CPU(s) list: 0-15
> > 	Thread(s) per core:  1
> > 	Core(s) per socket:  8
> > 	Socket(s):           2
> > 	NUMA node(s):        2
> > 	...
> > 	NUMA node0 CPU(s):   0,1,3,5-9,11,13-15
> > 	NUMA node1 CPU(s):   2,4,10,12
> > 
> > When driver requests to allocate 8 vectors, the following spread can
> > be got:
> > 	irq 31, cpu list 2,4
> > 	irq 32, cpu list 10,12
> > 	irq 33, cpu list 0-1
> > 	irq 34, cpu list 3,5
> > 	irq 35, cpu list 6-7
> > 	irq 36, cpu list 8-9
> > 	irq 37, cpu list 11,13
> > 	irq 38, cpu list 14-15
> > 
> > Without this patch, kernel warning is triggered on above situation, and
> > allocation result was supposed to be 4 vectors for each node.
> > 
> > Cc: Christoph Hellwig <hch at lst.de>
> > Cc: Keith Busch <kbusch at kernel.org>
> > Cc: linux-nvme at lists.infradead.org,
> > Cc: Jon Derrick <jonathan.derrick at intel.com>
> > Cc: Jens Axboe <axboe at kernel.dk>
> > Reported-by: Jon Derrick <jonathan.derrick at intel.com>
> > Signed-off-by: Ming Lei <ming.lei at redhat.com>
> 
> I had every intention to thoroughly test this on imbalanced node
> configurations, but that's not going to happen anytime soon. It looks
> correct to me, so I'll append my review here.
> 
I can only test this with 2 nodes but I have varied nr_cpus as well as
using different devices with fewer and more vectors than CPUs. Spread
looks good.

Thank you

Reviewed-by: Jon Derrick <jonathan.derrick at intel.com>


[snip]
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 3278 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190816/898025fa/attachment.bin>
