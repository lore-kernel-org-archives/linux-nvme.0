From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 11 Feb 2019 11:54:00 +0800
Subject: [PATCH 2/5] genirq/affinity: allow driver to setup managed IRQ's
 affinity
In-Reply-To: <alpine.DEB.2.21.1902101723400.8784@nanos.tec.linutronix.de>
References: <20190125095347.17950-1-ming.lei@redhat.com>
 <20190125095347.17950-3-ming.lei@redhat.com>
 <alpine.DEB.2.21.1902101723400.8784@nanos.tec.linutronix.de>
Message-ID: <20190211035358.GA8638@ming.t460p>

Hello Thomas,

On Sun, Feb 10, 2019@05:30:41PM +0100, Thomas Gleixner wrote:
> Ming,
> 
> On Fri, 25 Jan 2019, Ming Lei wrote:
> 
> > This patch introduces callback of .setup_affinity into 'struct
> > irq_affinity', so that:
> 
> Please see Documentation/process/submitting-patches.rst. Search for 'This
> patch' ....

Sorry for that, because I am not a native English speaker and it looks a bit
difficult for me to understand the subtle difference.

> 
> > 
> > 1) allow drivers to customize the affinity for managed IRQ, for
> > example, now NVMe has special requirement for read queues & poll
> > queues
> 
> That's nothing new and already handled today.
> 
> > 2) 6da4b3ab9a6e9 ("genirq/affinity: Add support for allocating interrupt sets")
> > makes pci_alloc_irq_vectors_affinity() a bit difficult to use for
> > allocating interrupt sets: 'max_vecs' is required to same with 'min_vecs'.
> 
> So it's a bit difficult, but you fail to explain why it's not sufficient.

The introduced limit is that 'max_vecs' has to be same with 'min_vecs' for
pci_alloc_irq_vectors_affinity() wrt. NVMe's use case since commit
6da4b3ab9a6e9, then NVMe has to deal with irq vectors allocation failure in
the awkward way of retrying.

And the topic has been discussed in the following links:

https://marc.info/?l=linux-pci&m=154655595615575&w=2
https://marc.info/?l=linux-pci&m=154646930922174&w=2

Bjorn and Keith thought this usage/interface is a bit awkward because the passed
'min_vecs' should have avoided driver's retrying.

For NVMe, when irq vectors are run out of from pci_alloc_irq_vectors_affinity(),
the requested number has to be decreased and retry until it succeeds, then the
allocated irq vectors has to be re-distributed among the whole irq sets. Turns
out the re-distribution need driver's knowledge, that is why the callback is
introduced.

> 
> > With this patch, driver can implement their own .setup_affinity to
> > customize the affinity, then the above thing can be solved easily.
> 
> Well, I don't really understand what is solved easily and you are merily
> describing the fact that the new callback allows drivers to customize
> something. What's the rationale? If it's just the 'bit difficult' part,
> then what is the reason for not making the core functionality easier to use
> instead of moving stuff into driver space again?

Another solution mentioned in previous discussion is to split building & setting up
affinities from allocating irq vectors, but one big problem is that allocating
'irq_desc' needs the affinity mask for figuring out 'node', see alloc_descs().

> 
> NVME is not special and all this achieves is that all drivers writers will

I mean that NVMe is the only user of irq sets.

> claim that their device is special and needs its own affinity setter
> routine. The whole point of having the generic code is to exactly avoid
> that. If it has shortcomings, then they need to be addressed, but not
> worked around with random driver callbacks.

Understood.

Thanks,
Ming
