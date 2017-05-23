From: hch@lst.de (Christoph Hellwig)
Date: Tue, 23 May 2017 11:37:35 +0200
Subject: [PATCH 3/7] genirq/affinity: factor out a irq_affinity_set helper
In-Reply-To: <alpine.DEB.2.20.1705212052000.3023@nanos>
References: <20170519085756.29742-1-hch@lst.de>
 <20170519085756.29742-4-hch@lst.de>
 <alpine.DEB.2.20.1705212052000.3023@nanos>
Message-ID: <20170523093735.GC23632@lst.de>

On Sun, May 21, 2017@09:03:06PM +0200, Thomas Gleixner wrote:
> > +{
> > +	struct irq_data *data = irq_desc_get_irq_data(desc);
> > +	struct irq_chip *chip = irq_data_get_irq_chip(data);
> > +	bool ret = false;
> > +
> > +	if (!irqd_can_move_in_process_context(data) && chip->irq_mask)
> 
> Using that inline directly will make this function useless on architectures
> which have GENERIC_PENDING_IRQS not set.
> 
> kernel/irq/manage.c has that wrapped. We need to move those wrappers to the
> internal header file, so that it gets compiled out on other platforms.

Ok, will do.
