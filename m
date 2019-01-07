From: keith.busch@intel.com (Keith Busch)
Date: Mon, 7 Jan 2019 09:24:06 -0700
Subject: [PATCH] nvme pci: fix nvme_setup_irqs()
In-Reply-To: <20190103013439.26700-1-ming.lei@redhat.com>
References: <20190103013439.26700-1-ming.lei@redhat.com>
Message-ID: <20190107162406.GB12916@localhost.localdomain>

On Thu, Jan 03, 2019@09:34:39AM +0800, Ming Lei wrote:
> When -ENOSPC is returned from pci_alloc_irq_vectors_affinity(),
> we still try to allocate multiple irq vectors again, so irq queues
> covers the admin queue actually. But we don't consider that, then
> number of the allocated irq vector may be same with sum of
> io_queues[HCTX_TYPE_DEFAULT] and io_queues[HCTX_TYPE_READ], this way
> is obviously wrong, and finally breaks nvme_pci_map_queues(), and
> warning from pci_irq_get_affinity() is triggered.
> 
> IRQ queues should cover admin queues, this patch makes this
> point explicitely in nvme_calc_io_queues().
> 
> We got severl boot failure internal report on aarch64, so please
> consider to fix it in v4.20.

I see what you saying with the inconsistent meaning for irq_queues, though
4.20 should be fine.

I hope we can make the irq sets easier to use in the future, but your
patch looks correct for the current interface.

Reviewed-by: Keith Busch <keith.busch at intel.com>
 
> Fixes: 6451fe73fa0f ("nvme: fix irq vs io_queue calculations")
> Cc: Keith Busch <keith.busch at intel.com>
> Cc: Jens Axboe <axboe at fb.com>
> Signed-off-by: Ming Lei <ming.lei at redhat.com>
