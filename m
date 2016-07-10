From: hch@lst.de (Christoph Hellwig)
Date: Sun, 10 Jul 2016 05:41:44 +0200
Subject: [PATCH 11/13] blk-mq: allow the driver to pass in an affinity mask
In-Reply-To: <20160704093527.GB2783@agordeev.lab.eng.brq.redhat.com>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-12-git-send-email-hch@lst.de>
 <20160704081540.GA2783@agordeev.lab.eng.brq.redhat.com>
 <20160704083849.GA3585@lst.de>
 <20160704093527.GB2783@agordeev.lab.eng.brq.redhat.com>
Message-ID: <20160710034144.GA15720@lst.de>

On Mon, Jul 04, 2016@11:35:28AM +0200, Alexander Gordeev wrote:
> > mq_map is initialized to zero already, so we don't really need the
> > assignment for queue 0.  The reason why this check exists is because
> > we start with queue = -1 and we never want to assignment -1 to mq_map.
> 
> Would this read better then?
> 
> 	int queue = 0;
> 
> 	...
> 
> 	/* If cpus are offline, map them to first hctx */
> 	for_each_online_cpu(cpu) {
> 		set->mq_map[cpu] = queue;
> 		if (cpumask_test_cpu(cpu, affinity_mask))
> 			queue++;

It would read better, but I don't think it's actually correct.
We'd still assign the 'old' queue to the cpu that is set in the affinity
mask.
