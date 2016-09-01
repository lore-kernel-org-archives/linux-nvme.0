From: keith.busch@intel.com (Keith Busch)
Date: Thu, 1 Sep 2016 10:24:10 -0400
Subject: [PATCH 4/7] blk-mq: allow the driver to pass in an affinity mask
In-Reply-To: <20160901084624.GC4115@lst.de>
References: <1472468013-29936-1-git-send-email-hch@lst.de>
 <1472468013-29936-5-git-send-email-hch@lst.de>
 <20160831163852.GB5598@localhost.localdomain>
 <20160901084624.GC4115@lst.de>
Message-ID: <20160901142410.GA10903@localhost.localdomain>

On Thu, Sep 01, 2016@10:46:24AM +0200, Christoph Hellwig wrote:
> On Wed, Aug 31, 2016@12:38:53PM -0400, Keith Busch wrote:
> > This can't be right. We have a single affinity mask for the entire
> > set, but what I think we want is an one affinity mask for each
> > nr_io_queues. The irq_create_affinity_mask should then create an array
> > of cpumasks based on nr_vecs..
> 
> Nah, this is Thomas' creating abuse of the cpumask type.  Every bit set
> in the affinity_mask means this is a cpu we allocate a vector / queue to.

Yeah, I gathered that's what it was providing, but that's just barely
not enough information to do something useful. The CPUs that aren't set
have to use a previously assigned vector/queue, but which one?
