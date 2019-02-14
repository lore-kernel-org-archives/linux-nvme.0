From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 15 Feb 2019 00:55:53 +0100 (CET)
Subject: [patch V5 4/8] nvme-pci: Simplify interrupt allocation
In-Reply-To: <20190214224136.GA18764@ming.t460p>
References: <20190214204755.819014197@linutronix.de>
 <20190214211759.699390983@linutronix.de> <20190214224136.GA18764@ming.t460p>
Message-ID: <alpine.DEB.2.21.1902150053160.1646@nanos.tec.linutronix.de>

On Fri, 15 Feb 2019, Ming Lei wrote:
> > +	 * If only one interrupt is available, combine write and read
> > +	 * queues. If 'write_queues' is set, ensure it leaves room for at
> > +	 * least one read queue.
> > +	 */
> > +	if (nrirqs == 1)
> > +		nr_read_queues = 0;
> > +	else if (write_queues >= nrirqs)
> > +		nr_read_queues = nrirqs - 1;
> > +	else
> > +		nr_read_queues = nrirqs - write_queues;
> > +
> > +	dev->io_queues[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
> > +	affd->set_size[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
> > +	dev->io_queues[HCTX_TYPE_READ] = nr_read_queues;
> > +	affd->set_size[HCTX_TYPE_READ] = nr_read_queues;
> > +	affd->nr_sets = nr_read_queues ? 2 : 1;
> >  }
> 
> .calc_sets is called only if more than .pre_vectors is available,
> then dev->io_queues[HCTX_TYPE_DEFAULT] may not be set in case of
> (nvecs == affd->pre_vectors + affd->post_vectors).

Hmm, good catch. The delta patch below should fix that, but I have to go
through all the possible cases in pci_alloc_irq_vectors_affinity() once
more with brain awake.

Thanks,

	tglx

8<---------------------

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2092,6 +2092,10 @@ static int nvme_setup_irqs(struct nvme_d
 	}
 	dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
 
+	/* Initialize for the single interrupt case */
+	dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
+	dev->io_queues[HCTX_TYPE_READ] = 0;
+
 	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
 			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
 }
