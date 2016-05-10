From: keith.busch@intel.com (Keith Busch)
Date: Tue, 10 May 2016 11:27:09 -0400
Subject: [PATCH 2/2] nvme: switch to use pci_alloc_irq_vectors
In-Reply-To: <1462457096-19795-3-git-send-email-hch@lst.de>
References: <1462457096-19795-1-git-send-email-hch@lst.de>
 <1462457096-19795-3-git-send-email-hch@lst.de>
Message-ID: <20160510152708.GB21151@localhost.localdomain>

On Thu, May 05, 2016@04:04:56PM +0200, Christoph Hellwig wrote:
> -static void nvme_set_irq_hints(struct nvme_dev *dev)
> -{
> -	struct nvme_queue *nvmeq;
> -	int i;
> -
> -	for (i = 0; i < dev->online_queues; i++) {
> -		nvmeq = dev->queues[i];
> -
> -		if (!nvmeq->tags || !(*nvmeq->tags))
> -			continue;
> -
> -		irq_set_affinity_hint(dev->entry[nvmeq->cq_vector].vector,
> -					blk_mq_tags_cpumask(*nvmeq->tags));
> -	}
> -}

The above doesn't merge with linux-block/for-next since the scanning was
moved to core. If this is going through linux-pci, then it merges fine,
but someone will have to fix this later.

Otherwise, looks good.

Acked-by: Keith Busch <keith.busch at intel.com>
