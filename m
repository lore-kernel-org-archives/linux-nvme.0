From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 2 Jan 2019 15:02:02 -0600
Subject: [PATCH V2 1/3] PCI/MSI: preference to returning -ENOSPC from
 pci_alloc_irq_vectors_affinity
In-Reply-To: <20190101052458.GA17588@ming.t460p>
References: <20181229032650.27256-1-ming.lei@redhat.com>
 <20181229032650.27256-2-ming.lei@redhat.com>
 <20181231220059.GI159477@google.com>
 <20190101052458.GA17588@ming.t460p>
Message-ID: <20190102210202.GC126384@google.com>

On Tue, Jan 01, 2019@01:24:59PM +0800, Ming Lei wrote:
> On Mon, Dec 31, 2018@04:00:59PM -0600, Bjorn Helgaas wrote:
> > On Sat, Dec 29, 2018@11:26:48AM +0800, Ming Lei wrote:
...
> > > Users of pci_alloc_irq_vectors_affinity() may try to reduce irq
> > > vectors and allocate vectors again in case that -ENOSPC is returned, such
> > > as NVMe, so we need to respect the current interface and give preference to
> > > -ENOSPC.
> > 
> > I thought the whole point of the (min_vecs, max_vecs) tuple was to
> > avoid this sort of "reduce and try again" iteration in the callers.
> 
> As Keith replied, in case of NVMe, we have to keep min_vecs same with
> max_vecs.

Keith said:
> The min/max vecs doesn't work correctly when using the irq_affinity
> nr_sets because rebalancing the set counts is driver specific. To
> get around that, drivers using nr_sets have to set min and max to
> the same value and handle the "reduce and try again".

Sorry I saw that, but didn't follow it at first.  After a little
archaeology, I see that 6da4b3ab9a6e ("genirq/affinity: Add support
for allocating interrupt sets") added nr_sets and some validation
tests (if affd.nr_sets, min_vecs == max_vecs) for using it in the API.

That's sort of a wart on the API, but I don't know if we should live
with it or try to clean it up somehow.

At the very least, this seems like something that could be documented
somewhere in Documentation/PCI/MSI-HOWTO.txt, which mentions
PCI_IRQ_AFFINITY, but doesn't cover struct irq_affinity or
pci_alloc_irq_vectors_affinity() at all, let alone this wrinkle about
affd.nr_sets/min_vecs/max_vecs.

Obviously that would not be part of *this* patch.

Bjorn
