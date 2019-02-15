From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 15 Feb 2019 10:52:51 +0100 (CET)
Subject: [patch V5 4/8] nvme-pci: Simplify interrupt allocation
In-Reply-To: <868syhs8tn.wl-marc.zyngier@arm.com>
References: <20190214204755.819014197@linutronix.de>
 <20190214211759.699390983@linutronix.de> <868syhs8tn.wl-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.21.1902151051470.1646@nanos.tec.linutronix.de>

On Fri, 15 Feb 2019, Marc Zyngier wrote:
> On Thu, 14 Feb 2019 20:47:59 +0000,
> Thomas Gleixner <tglx@linutronix.de> wrote:
> >  drivers/nvme/host/pci.c |  108 ++++++++++++------------------------------------
> >  1 file changed, 28 insertions(+), 80 deletions(-)
> > 
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2041,41 +2041,32 @@ static int nvme_setup_host_mem(struct nv
> >  	return ret;
> >  }
> >  
> > -/* irq_queues covers admin queue */
> > -static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
> > +/*
> > + * nirqs is the number of interrupts available for write and read
> > + * queues. The core already reserved an interrupt for the admin queue.
> > + */
> > +static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
> >  {
> > -	unsigned int this_w_queues = write_queues;
> > -
> > -	WARN_ON(!irq_queues);
> > -
> > -	/*
> > -	 * Setup read/write queue split, assign admin queue one independent
> > -	 * irq vector if irq_queues is > 1.
> > -	 */
> > -	if (irq_queues <= 2) {
> > -		dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
> > -		dev->io_queues[HCTX_TYPE_READ] = 0;
> > -		return;
> > -	}
> > +	struct nvme_dev *dev = affd->priv;
> > +	unsigned int nr_read_queues;
> >  
> >  	/*
> > -	 * If 'write_queues' is set, ensure it leaves room for at least
> > -	 * one read queue and one admin queue
> > -	 */
> > -	if (this_w_queues >= irq_queues)
> > -		this_w_queues = irq_queues - 2;
> > -
> > -	/*
> > -	 * If 'write_queues' is set to zero, reads and writes will share
> > -	 * a queue set.
> > -	 */
> > -	if (!this_w_queues) {
> > -		dev->io_queues[HCTX_TYPE_DEFAULT] = irq_queues - 1;
> > -		dev->io_queues[HCTX_TYPE_READ] = 0;
> > -	} else {
> > -		dev->io_queues[HCTX_TYPE_DEFAULT] = this_w_queues;
> > -		dev->io_queues[HCTX_TYPE_READ] = irq_queues - this_w_queues - 1;
> > -	}
> > +	 * If only one interrupt is available, combine write and read
> > +	 * queues. If 'write_queues' is set, ensure it leaves room for at
> > +	 * least one read queue.
> 
> [Full disclaimer: I only have had two coffees this morning, and it is
> only at the fourth that my brain is able to kick in...]
> 
> I don't know much about NVME, but I feel like there is a small
> disconnect between the code and the above comment, which says "leave
> room for at least one read queue"...
> 
> > +	 */
> > +	if (nrirqs == 1)
> > +		nr_read_queues = 0;
> > +	else if (write_queues >= nrirqs)
> > +		nr_read_queues = nrirqs - 1;
> 
> ... while this seem to ensure that we carve out one write queue out of
> the irq set. It looks like a departure from the original code, which
> would set nr_read_queues to 1 in that particular case.

Bah. right you are.
