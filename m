From: keith.busch@intel.com (Keith Busch)
Date: Mon, 31 Dec 2018 15:41:02 -0700
Subject: [PATCH V2 1/3] PCI/MSI: preference to returning -ENOSPC from
 pci_alloc_irq_vectors_affinity
In-Reply-To: <20181231220059.GI159477@google.com>
References: <20181229032650.27256-1-ming.lei@redhat.com>
 <20181229032650.27256-2-ming.lei@redhat.com>
 <20181231220059.GI159477@google.com>
Message-ID: <20181231224102.GA5024@localhost.localdomain>

On Mon, Dec 31, 2018@04:00:59PM -0600, Bjorn Helgaas wrote:
> On Sat, Dec 29, 2018@11:26:48AM +0800, Ming Lei wrote:
> > Users of pci_alloc_irq_vectors_affinity() may try to reduce irq
> > vectors and allocate vectors again in case that -ENOSPC is returned, such
> > as NVMe, so we need to respect the current interface and give preference to
> > -ENOSPC.
> 
> I thought the whole point of the (min_vecs, max_vecs) tuple was to
> avoid this sort of "reduce and try again" iteration in the callers.

The min/max vecs doesn't work correctly when using the irq_affinity
nr_sets because rebalancing the set counts is driver specific. To get
around that, drivers using nr_sets have to set min and max to the same
value and handle the "reduce and try again".
