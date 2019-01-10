From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 10 Jan 2019 08:51:25 +0800
Subject: [PATCH] nvme pci: fix nvme_setup_irqs()
In-Reply-To: <20190107162406.GB12916@localhost.localdomain>
References: <20190103013439.26700-1-ming.lei@redhat.com>
 <20190107162406.GB12916@localhost.localdomain>
Message-ID: <20190110005124.GA27711@ming.t460p>

On Mon, Jan 07, 2019@09:24:06AM -0700, Keith Busch wrote:
> On Thu, Jan 03, 2019@09:34:39AM +0800, Ming Lei wrote:
> > When -ENOSPC is returned from pci_alloc_irq_vectors_affinity(),
> > we still try to allocate multiple irq vectors again, so irq queues
> > covers the admin queue actually. But we don't consider that, then
> > number of the allocated irq vector may be same with sum of
> > io_queues[HCTX_TYPE_DEFAULT] and io_queues[HCTX_TYPE_READ], this way
> > is obviously wrong, and finally breaks nvme_pci_map_queues(), and
> > warning from pci_irq_get_affinity() is triggered.
> > 
> > IRQ queues should cover admin queues, this patch makes this
> > point explicitely in nvme_calc_io_queues().
> > 
> > We got severl boot failure internal report on aarch64, so please
> > consider to fix it in v4.20.
> 
> I see what you saying with the inconsistent meaning for irq_queues, though
> 4.20 should be fine.
> 
> I hope we can make the irq sets easier to use in the future, but your

Yeah, I agree the current API isn't easy to use for irq sets, and we
need to improve this.

> patch looks correct for the current interface.
> 
> Reviewed-by: Keith Busch <keith.busch at intel.com>

Thanks!

Christoph, what do you think of this patch?

Thanks,
Ming
