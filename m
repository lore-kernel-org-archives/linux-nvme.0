From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Sep 2016 10:46:24 +0200
Subject: [PATCH 4/7] blk-mq: allow the driver to pass in an affinity mask
In-Reply-To: <20160831163852.GB5598@localhost.localdomain>
References: <1472468013-29936-1-git-send-email-hch@lst.de>
 <1472468013-29936-5-git-send-email-hch@lst.de>
 <20160831163852.GB5598@localhost.localdomain>
Message-ID: <20160901084624.GC4115@lst.de>

On Wed, Aug 31, 2016@12:38:53PM -0400, Keith Busch wrote:
> This can't be right. We have a single affinity mask for the entire
> set, but what I think we want is an one affinity mask for each
> nr_io_queues. The irq_create_affinity_mask should then create an array
> of cpumasks based on nr_vecs..

Nah, this is Thomas' creating abuse of the cpumask type.  Every bit set
in the affinity_mask means this is a cpu we allocate a vector / queue to.
