From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 10 Feb 2019 17:30:41 +0100 (CET)
Subject: [PATCH 2/5] genirq/affinity: allow driver to setup managed IRQ's
 affinity
In-Reply-To: <20190125095347.17950-3-ming.lei@redhat.com>
References: <20190125095347.17950-1-ming.lei@redhat.com>
 <20190125095347.17950-3-ming.lei@redhat.com>
Message-ID: <alpine.DEB.2.21.1902101723400.8784@nanos.tec.linutronix.de>

Ming,

On Fri, 25 Jan 2019, Ming Lei wrote:

> This patch introduces callback of .setup_affinity into 'struct
> irq_affinity', so that:

Please see Documentation/process/submitting-patches.rst. Search for 'This
patch' ....

> 
> 1) allow drivers to customize the affinity for managed IRQ, for
> example, now NVMe has special requirement for read queues & poll
> queues

That's nothing new and already handled today.

> 2) 6da4b3ab9a6e9 ("genirq/affinity: Add support for allocating interrupt sets")
> makes pci_alloc_irq_vectors_affinity() a bit difficult to use for
> allocating interrupt sets: 'max_vecs' is required to same with 'min_vecs'.

So it's a bit difficult, but you fail to explain why it's not sufficient.

> With this patch, driver can implement their own .setup_affinity to
> customize the affinity, then the above thing can be solved easily.

Well, I don't really understand what is solved easily and you are merily
describing the fact that the new callback allows drivers to customize
something. What's the rationale? If it's just the 'bit difficult' part,
then what is the reason for not making the core functionality easier to use
instead of moving stuff into driver space again?

NVME is not special and all this achieves is that all drivers writers will
claim that their device is special and needs its own affinity setter
routine. The whole point of having the generic code is to exactly avoid
that. If it has shortcomings, then they need to be addressed, but not
worked around with random driver callbacks.

Thanks,

	tglx
