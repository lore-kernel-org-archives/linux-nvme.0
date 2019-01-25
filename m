From: ming.lei@redhat.com (Ming Lei)
Date: Fri, 25 Jan 2019 17:56:19 +0800
Subject: [PATCH 0/5] genirq/affinity: introduce .setup_affinity to
 support allocating interrupt sets
In-Reply-To: <20190125095347.17950-1-ming.lei@redhat.com>
References: <20190125095347.17950-1-ming.lei@redhat.com>
Message-ID: <20190125095617.GA17754@ming.t460p>

On Fri, Jan 25, 2019@05:53:42PM +0800, Ming Lei wrote:
> Hi,
> 
> The current support for allocating interrupt sets requires that same 'max_vec'
> and 'min_vec' is passed to pci_alloc_irq_vectors_affinity(), then driver has to
> try to allocate again and again until it succeeds.
> 
> This patch introduces .setup_affinity callback, and we can use it to
> re-caculate interrupt sets and build affinity for each set after
> irq vectors are allocated.
> 
> Turns out both genirq/affinity and nvme code get simplified a lot.
> 
> Please review and comment!
> 
> Ming Lei (5):
>   genirq/affinity: move allocation of 'node_to_cpumask' to
>     irq_build_affinity_masks
>   genirq/affinity: allow driver to setup managed IRQ's affinity
>   genirq/affinity: introduce irq_build_affinity()
>   nvme-pci: simplify nvme_setup_irqs() via .setup_affinity callback
>   genirq/affinity: remove support for allocating interrupt sets
> 
>  drivers/nvme/host/pci.c   |  97 +++++++++++++++++++++--------------------
>  drivers/pci/msi.c         |  14 ------
>  include/linux/interrupt.h |  42 ++++++++++++------
>  kernel/irq/affinity.c     | 108 ++++++++++++++++++++++++----------------------
>  4 files changed, 133 insertions(+), 128 deletions(-)

oops, forget to CC Keith.

Thanks,
Ming
