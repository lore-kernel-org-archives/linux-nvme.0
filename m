From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 18 Apr 2016 10:30:18 +0200 (CEST)
Subject: [PATCH 7/8] pci: spread interrupt vectors in pci_alloc_irq_vectors
In-Reply-To: <1460770552-31260-8-git-send-email-hch@lst.de>
References: <1460770552-31260-1-git-send-email-hch@lst.de>
 <1460770552-31260-8-git-send-email-hch@lst.de>
Message-ID: <alpine.DEB.2.11.1604181026290.3941@nanos>

On Fri, 15 Apr 2016, Christoph Hellwig wrote:
> Set the affinity_mask before allocating vectors.  And for now we also
> need a little hack after allocation, hopefully someone smarter than me
> can move this into the core code.
> 
>  
> +	/* XXX: this should really move into the core IRQ allocation code.. */
> +	if (vecs > 1) {
> +		for (i = 0; i < vecs; i++)
> +			irq_program_affinity(irqs[i]);

No. We don't want to do that at allocation time. The problem here is that we
set the IRQF_NOBALANCING flag for the allocated interrupts and therefor the
affinity is not set from request_irq(). We'll fix it there.

Thanks,

	tglx
