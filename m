From: ming.lei@redhat.com (Ming Lei)
Date: Sun, 6 Jan 2019 10:56:45 +0800
Subject: [PATCHv2 2/4] nvme-pci: Distribute io queue types after creation
In-Reply-To: <20190104155324.GA12342@localhost.localdomain>
References: <20190103225033.11249-1-keith.busch@intel.com>
 <20190103225033.11249-3-keith.busch@intel.com>
 <20190104023121.GB31330@ming.t460p>
 <20190104072106.GA9948@ming.t460p>
 <20190104155324.GA12342@localhost.localdomain>
Message-ID: <20190106025643.GB20802@ming.t460p>

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

I think this kind of API style(two stages) is more clean, and
error-immune.

- pci_alloc_irq_vectors() is only for allocating irq vectors
- pci_set_irq_vectors_affnity() is for spreading affinity at will


Thanks,
Ming
