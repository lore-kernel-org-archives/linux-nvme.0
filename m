From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 16 Feb 2019 00:00:29 +0100 (CET)
Subject: [patch V5 4/8] nvme-pci: Simplify interrupt allocation
In-Reply-To: <alpine.DEB.2.21.1902150053160.1646@nanos.tec.linutronix.de>
References: <20190214204755.819014197@linutronix.de>
 <20190214211759.699390983@linutronix.de> <20190214224136.GA18764@ming.t460p>
 <alpine.DEB.2.21.1902150053160.1646@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1902152242120.1683@nanos.tec.linutronix.de>

On Fri, 15 Feb 2019, Thomas Gleixner wrote:

> On Fri, 15 Feb 2019, Ming Lei wrote:
> > > +	 * If only one interrupt is available, combine write and read
> > > +	 * queues. If 'write_queues' is set, ensure it leaves room for at
> > > +	 * least one read queue.
> > > +	 */
> > > +	if (nrirqs == 1)
> > > +		nr_read_queues = 0;
> > > +	else if (write_queues >= nrirqs)
> > > +		nr_read_queues = nrirqs - 1;
> > > +	else
> > > +		nr_read_queues = nrirqs - write_queues;
> > > +
> > > +	dev->io_queues[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
> > > +	affd->set_size[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
> > > +	dev->io_queues[HCTX_TYPE_READ] = nr_read_queues;
> > > +	affd->set_size[HCTX_TYPE_READ] = nr_read_queues;
> > > +	affd->nr_sets = nr_read_queues ? 2 : 1;
> > >  }
> > 
> > .calc_sets is called only if more than .pre_vectors is available,
> > then dev->io_queues[HCTX_TYPE_DEFAULT] may not be set in case of
> > (nvecs == affd->pre_vectors + affd->post_vectors).
> 
> Hmm, good catch. The delta patch below should fix that, but I have to go
> through all the possible cases in pci_alloc_irq_vectors_affinity() once
> more with brain awake.

The existing logic in the driver is somewhat strange. If there is only a
single interrupt available, i.e. no separation of admin and I/O queue, then
dev->io_queues[HCTX_TYPE_DEFAULT] is still set to 1.

Now with the callback scheme (independent of my changes) that breaks in
various ways:

  1) irq_create_affinity_masks() bails out early:

	if (nvecs == affd->pre_vectors + affd->post_vectors)
		return NULL;

     So the callback won't be invoked and the last content of
     dev->io_queues is preserved. By chance this might end up with

	dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
	dev->io_queues[HCTX_TYPE_READ] = 0;

    but that does not happen by design.


 2) pci_alloc_irq_vectors_affinity() has the following flow:

    __pci_enable_msix_range()
      for (...) {
            __pci_enable_msix()
      }

    If that fails because MSIX is not supported, then the affinity
    spreading code has not been called yet and neither the callback.
    Now it goes on and tries MSI, which is the same as the above.

    When that fails because MSI is not supported, same situation as above
    and the code tries to allocate the legacy interrupt.

    Now with the initial initialization that case is covered, but not the
    following error case:

      Assume MSIX is enabled, but __pci_enable_msix() fails with -ENOMEM
      after having called irq_create_affinity_masks() and subsequently the
      callback with maxvecs.

      Then pci_alloc_irq_vectors_affinity() will try MSI and fail _BEFORE_
      the callback is invoked.

      The next step is to install the leagcy interrupt, but that does not
      invoke the affinity code and neither the callback.

      At the end dev->io_queues[*] are still initialized with the failed
      attempt of enabling MSIX based on maxvecs.

      Result: inconsistent state ...

I have an idea how to fix that, but that's again a task for brain being
awake. Will take care of that tomorrow morning.

Thanks,

	tglx


    


 


    
