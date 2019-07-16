From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 16 Jul 2019 16:22:59 +1000
Subject: [PATCH 3/3] nvme: Add support for Apple 2018+ models
In-Reply-To: <20190716060623.GC29414@lst.de>
References: <20190716004649.17799-1-benh@kernel.crashing.org>
 <20190716004649.17799-3-benh@kernel.crashing.org>
 <20190716060623.GC29414@lst.de>
Message-ID: <00c4f41415c94e18dce0e8a3ff60991edc3aba9d.camel@kernel.crashing.org>

On Tue, 2019-07-16@08:06 +0200, Christoph Hellwig wrote:
> 
> >  /*
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 54b35ea4af88..ab2358137419 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2080,6 +2080,9 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
> >  	dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
> >  	dev->io_queues[HCTX_TYPE_READ] = 0;
> >  
> > +	if (dev->ctrl.quirks & NVME_QUIRK_SINGLE_VECTOR)
> > +		irq_queues = 1;
> > +
> >  	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
> >  			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
> 
> Callin pci_alloc_irq_vectors_affinity in this case seems a bit
> pointless, but if this works for you I'd rather keep it as-is for now
> if this works for you.

It seems to work and it's simpler that way. The original patch was
grabbing all the interrupts then hacking the queues to all use vector 0
(well there's only one IO queue). The above is a bit cleaner imho.

Cheers,
Ben.
