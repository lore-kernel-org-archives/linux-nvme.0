From: agordeev@redhat.com (Alexander Gordeev)
Date: Mon, 4 Jul 2016 11:35:28 +0200
Subject: [PATCH 11/13] blk-mq: allow the driver to pass in an affinity mask
In-Reply-To: <20160704083849.GA3585@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-12-git-send-email-hch@lst.de>
 <20160704081540.GA2783@agordeev.lab.eng.brq.redhat.com>
 <20160704083849.GA3585@lst.de>
Message-ID: <20160704093527.GB2783@agordeev.lab.eng.brq.redhat.com>

On Mon, Jul 04, 2016@10:38:49AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 04, 2016@10:15:41AM +0200, Alexander Gordeev wrote:
> > On Tue, Jun 14, 2016@09:59:04PM +0200, Christoph Hellwig wrote:
> > > +static int blk_mq_create_mq_map(struct blk_mq_tag_set *set,
> > > +		const struct cpumask *affinity_mask)
> > > +{
> > > +	int queue = -1, cpu = 0;
> > > +
> > > +	set->mq_map = kzalloc_node(sizeof(*set->mq_map) * nr_cpu_ids,
> > > +			GFP_KERNEL, set->numa_node);
> > > +	if (!set->mq_map)
> > > +		return -ENOMEM;
> > > +
> > > +	if (!affinity_mask)
> > > +		return 0;	/* map all cpus to queue 0 */
> > > +
> > > +	/* If cpus are offline, map them to first hctx */
> > > +	for_each_online_cpu(cpu) {
> > > +		if (cpumask_test_cpu(cpu, affinity_mask))
> > > +			queue++;
> > 
> > CPUs missing in an affinity mask are mapped to hctxs. Is that intended?
> 
> Yes - each CPU needs to be mapped to some hctx, otherwise we can't
> submit I/O from that CPU.
> 
> > > +		if (queue > 0)
> > 
> > Why this check?
> > 
> > > +			set->mq_map[cpu] = queue;
> 
> mq_map is initialized to zero already, so we don't really need the
> assignment for queue 0.  The reason why this check exists is because
> we start with queue = -1 and we never want to assignment -1 to mq_map.

Would this read better then?

	int queue = 0;

	...

	/* If cpus are offline, map them to first hctx */
	for_each_online_cpu(cpu) {
		set->mq_map[cpu] = queue;
		if (cpumask_test_cpu(cpu, affinity_mask))
			queue++;
	}
