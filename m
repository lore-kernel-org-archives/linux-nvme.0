From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 13 Aug 2019 17:26:52 +0800
Subject: [PATCH V2 2/3] genirq/affinity: Spread vectors on node according
 to nr_cpu ratio
In-Reply-To: <20190813074112.GA8610@ming.t460p>
References: <20190812095709.25623-1-ming.lei@redhat.com>
 <20190812095709.25623-3-ming.lei@redhat.com>
 <20190812152718.GA32550@localhost.localdomain>
 <20190813074112.GA8610@ming.t460p>
Message-ID: <20190813092651.GA30205@ming.t460p>

On Tue, Aug 13, 2019@03:41:12PM +0800, Ming Lei wrote:
> On Mon, Aug 12, 2019@09:27:18AM -0600, Keith Busch wrote:
> > On Mon, Aug 12, 2019@05:57:08PM +0800, Ming Lei wrote:
> > > Now __irq_build_affinity_masks() spreads vectors evenly per node, and
> > > all vectors may not be spread in case that each numa node has different
> > > CPU number, then the following warning in irq_build_affinity_masks() can
> > > be triggered:
> > > 
> > > 	if (nr_present < numvecs)
> > > 		WARN_ON(nr_present + nr_others < numvecs);
> > > 
> > > Improve current spreading algorithm by assigning vectors according to
> > > the ratio of node's nr_cpu to nr_remaining_cpus, meantime running the
> > > assignment from smaller nodes to bigger nodes to guarantee that every
> > > active node gets allocated at least one vector, then we can avoid
> > > cross-node spread.
> > > 
> > > Meantime the reported warning can be fixed.
> > > 
> > > Another big goodness is that the spread approach becomes more fair if
> > > node has different CPU number.
> > > 
> > > For example, on the following machine:
> > > 	[root at ktest-01 ~]# lscpu
> > > 	...
> > > 	CPU(s):              16
> > > 	On-line CPU(s) list: 0-15
> > > 	Thread(s) per core:  1
> > > 	Core(s) per socket:  8
> > > 	Socket(s):           2
> > > 	NUMA node(s):        2
> > > 	...
> > > 	NUMA node0 CPU(s):   0,1,3,5-9,11,13-15
> > > 	NUMA node1 CPU(s):   2,4,10,12
> > > 
> > > When driver requests to allocate 8 vectors, the following spread can
> > > be got:
> > > 	irq 31, cpu list 2,4
> > > 	irq 32, cpu list 10,12
> > > 	irq 33, cpu list 0-1
> > > 	irq 34, cpu list 3,5
> > > 	irq 35, cpu list 6-7
> > > 	irq 36, cpu list 8-9
> > > 	irq 37, cpu list 11,13
> > > 	irq 38, cpu list 14-15
> > > 
> > > Without this patch, kernel warning is triggered on above situation, and
> > > allocation result was supposed to be 4 vectors for each node.
> > > 
> > > Cc: Christoph Hellwig <hch at lst.de>
> > > Cc: Keith Busch <kbusch at kernel.org>
> > > Cc: linux-nvme at lists.infradead.org,
> > > Cc: Jon Derrick <jonathan.derrick at intel.com>
> > > Cc: Jens Axboe <axboe at kernel.dk>
> > > Reported-by: Jon Derrick <jonathan.derrick at intel.com>
> > > Signed-off-by: Ming Lei <ming.lei at redhat.com>
> > > ---
> > >  kernel/irq/affinity.c | 141 +++++++++++++++++++++++++++++++++++-------
> > >  1 file changed, 117 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> > > index c7cca942bd8a..927dcbe80482 100644
> > > --- a/kernel/irq/affinity.c
> > > +++ b/kernel/irq/affinity.c
> > > @@ -7,6 +7,7 @@
> > >  #include <linux/kernel.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/cpu.h>
> > > +#include <linux/sort.h>
> > >  
> > >  static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
> > >  				unsigned int cpus_per_vec)
> > > @@ -94,6 +95,87 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
> > >  	return nodes;
> > >  }
> > >  
> > > +struct node_nr_vectors {
> > > +	unsigned n;
> > > +
> > > +	union {
> > > +		unsigned nvectors;
> > > +		unsigned ncpus;
> > > +	};
> > > +};
> > > +
> > > +static int ncpus_cmp_func(const void *l, const void *r)
> > > +{
> > > +	const struct node_nr_vectors *ln = l;
> > > +	const struct node_nr_vectors *rn = r;
> > > +
> > > +	if (ln->ncpus < rn->ncpus)
> > > +		return -1;
> > > +	if (ln->ncpus > rn->ncpus)
> > > +		return 1;
> > > +	return 0;
> > 
> > You can collapse these to one line:
> > 
> > 	return ln->ncpus - rn->ncpus;
> 
> OK.
> 
> > 
> > > +}
> > > +
> > > +static void alloc_nodes_vectors(unsigned int numvecs,
> > > +				const cpumask_var_t *node_to_cpumask,
> > > +				const struct cpumask *cpu_mask,
> > > +				const nodemask_t nodemsk,
> > > +				struct cpumask *nmsk,
> > > +				struct node_nr_vectors *node_vectors)
> > > +{
> > > +	unsigned remaining_ncpus = 0;
> > > +	unsigned n;
> > > +
> > > +	for (n = 0; n < nr_node_ids; n++) {
> > > +		node_vectors[n].n = n;
> > > +		node_vectors[n].ncpus = UINT_MAX;
> > > +	}
> > > +
> > > +	for_each_node_mask(n, nodemsk) {
> > > +		unsigned ncpus;
> > > +
> > > +		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
> > > +		ncpus = cpumask_weight(nmsk);
> > > +
> > > +		if (!ncpus)
> > > +			continue;
> > > +		remaining_ncpus += ncpus;
> > > +		node_vectors[n].ncpus = ncpus;
> > > +	}
> > > +
> > > +	sort(node_vectors, nr_node_ids, sizeof(node_vectors[0]),
> > > +	     ncpus_cmp_func, NULL);
> > > +
> > > +	/*
> > > +	 * Allocate vectors for each node according to the ratio of this
> > > +	 * node's nr_cpus to remaining un-assigned ncpus. 'numvecs' is
> > > +	 * bigger than number of active numa nodes. Always start the
> > > +	 * allocation from the node with minimized nr_cpus.
> > > +	 *
> > > +	 * This way guarantees that each active node gets allocated at
> > > +	 * least one vector, and the theory is simple: over-allocation
> > > +	 * is only done when this node is assigned by one vector, so
> > > +	 * other nodes will be allocated >= 1 vector, since 'numvecs' is
> > > +	 * bigger than number of numa nodes.
> > > +	 */
> > > +	for (n = 0; n < nr_node_ids; n++) {
> > > +		unsigned nvectors, ncpus;
> > > +
> > > +		if (node_vectors[n].ncpus == UINT_MAX)
> > > +			continue;
> > > +
> > > +		WARN_ON_ONCE(numvecs == 0);
> > > +
> > > +		ncpus = node_vectors[n].ncpus;
> > > +		nvectors = max_t(unsigned, 1,
> > > +				 numvecs * ncpus / remaining_ncpus);
> > > +
> > > +		node_vectors[n].nvectors = nvectors;
> > > +		remaining_ncpus -= ncpus;
> > > +		numvecs -= nvectors;
> > > +	}
> > 
> > This looks good to me.
> > 
> > > +}
> > > +
> > >  static int __irq_build_affinity_masks(unsigned int startvec,
> > >  				      unsigned int numvecs,
> > >  				      unsigned int firstvec,
> > > @@ -102,10 +184,11 @@ static int __irq_build_affinity_masks(unsigned int startvec,
> > >  				      struct cpumask *nmsk,
> > >  				      struct irq_affinity_desc *masks)
> > >  {
> > > -	unsigned int n, nodes, cpus_per_vec, extra_vecs, done = 0;
> > > +	unsigned int i, n, nodes, cpus_per_vec, extra_vecs, done = 0;
> > >  	unsigned int last_affv = firstvec + numvecs;
> > >  	unsigned int curvec = startvec;
> > >  	nodemask_t nodemsk = NODE_MASK_NONE;
> > > +	struct node_nr_vectors *node_vectors;
> > >  
> > >  	if (!cpumask_weight(cpu_mask))
> > >  		return 0;
> > > @@ -126,8 +209,23 @@ static int __irq_build_affinity_masks(unsigned int startvec,
> > >  		return numvecs;
> > >  	}
> > >  
> > > -	for_each_node_mask(n, nodemsk) {
> > > -		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
> > > +	node_vectors = kcalloc(nr_node_ids,
> > > +			       sizeof(struct node_nr_vectors),
> > > +			       GFP_KERNEL);
> > > +	if (!node_vectors)
> > > +		return 0;
> > 
> > I think we need to get this -ENOMEM condition back to the caller and
> > have that condition handled.
> 
> Good point.
> 
> > 
> > > @@ -165,13 +250,21 @@ static int __irq_build_affinity_masks(unsigned int startvec,
> > >  			}
> > >  			irq_spread_init_one(&masks[curvec].mask, nmsk,
> > >  						cpus_per_vec);
> > > +			/*
> > > +			 * alloc_nodes_vectors() is intelligent enough to
> > > +			 * allocate vectors on all nodes, so wrapping
> > > +			 * shouldn't be triggered usually. However, if it
> > > +			 * happens when allocated vectors is bigger than
> > > +			 * node's CPU number becasue of round down, wraps
> > > +			 * to the first vector allocated for this node, then
> > > +			 * cross-node spread can be avoided.
> > > +			 */
> > > +			if (curvec >= last_affv)
> > > +				curvec -= v;
> > 
> > Could you explain again how this could happen? The round-down should mean we
> > apply a vector to more CPUs so that the number of vectors applied to a
> > node wthin the loop should never require wrapping to hit all those CPUs.
> > And if that's true, the check should probably be a warn because it
> > should never happen.
> 
> You are right.
> 
> We should simply spread from the 1st vector for this node if there is
> more vectors not done.

oops, the above approach is wrong, same with V3.

It should happen on just the node with max CPU count, then we can't
go ahead. There are more vectors than CPU count on this node, all
vectors have to be spread, each CPU can be assigned to only one vector.

However, can't observe such problem at all, I need to think about if
it is possible from viewpoint of math.


thanks,
Ming
