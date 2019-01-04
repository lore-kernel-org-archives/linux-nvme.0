From: hch@lst.de (Christoph Hellwig)
Date: Fri, 4 Jan 2019 19:17:26 +0100
Subject: [PATCHv2 2/4] nvme-pci: Distribute io queue types after creation
In-Reply-To: <20190104155324.GA12342@localhost.localdomain>
References: <20190103225033.11249-1-keith.busch@intel.com>
 <20190103225033.11249-3-keith.busch@intel.com>
 <20190104023121.GB31330@ming.t460p> <20190104072106.GA9948@ming.t460p>
 <20190104155324.GA12342@localhost.localdomain>
Message-ID: <20190104181726.GA25730@lst.de>

On Fri, Jan 04, 2019@08:53:24AM -0700, Keith Busch wrote:
> On Fri, Jan 04, 2019@03:21:07PM +0800, Ming Lei wrote:
> > Thinking about the patch further: after pci_alloc_irq_vectors_affinity()
> > is returned, queue number for non-polled queues can't be changed at will,
> > because we have to make sure to spread all CPUs on each queue type, and
> > the mapping has been fixed by pci_alloc_irq_vectors_affinity() already.
> > 
> > So looks the approach in this patch may be wrong.
> 
> That's a bit of a problem, and not a new one. We always had to allocate
> vectors before creating IRQ driven CQ's, but the vector affinity is
> created before we know if the queue-pair can be created. Should the
> queue creation fail, there may be CPUs that don't have a queue.
> 
> Does this mean the pci msi API is wrong? It seems like we'd need to
> initially allocate vectors without PCI_IRQ_AFFINITY, then have the
> kernel set affinity only after completing the queue-pair setup.

We can't just easily do that, as we want to allocate the memory for
the descriptors on the correct node.  But we can just free the
vectors and try again if we have to.
