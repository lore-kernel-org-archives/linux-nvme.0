From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 18 Sep 2018 18:16:37 +0800
Subject: [PATCH 0/3] blk-mq: allow to unfreeze queue when io isn't drained
In-Reply-To: <20180918101310.13154-1-ming.lei@redhat.com>
References: <20180918101310.13154-1-ming.lei@redhat.com>
Message-ID: <20180918101636.GA13212@ming.t460p>

On Tue, Sep 18, 2018@06:13:07PM +0800, Ming Lei wrote:
> Hi,
> 
> The 1st patch introduces percpu_ref_resurge() for implementing
> blk_mq_unfreeze_queue_no_drain_io().
> 
> The 2nd patch introdces blk_mq_unfreeze_queue_no_drain_io() for
> cases in which queue can be unfreeze without draininig IO.
> 
> The 3rd patch applies blk_mq_unfreeze_queue_no_drain_io() to
> NVMe PCI timeout, so that IO hang may be avoided inside
> nvme_reset_work() when new IO timeout is triggered. 
> 
> Part of idea is from Jianchao's early work:
> 
> https://marc.info/?l=linux-kernel&m=153612052611020&w=2
> 
> Ming Lei (3):
>   lib/percpu-refcount: introduce percpu_ref_resurge()
>   blk-mq: introduce blk_mq_unfreeze_queue_no_drain_io
>   nvme: don't drain IO in nvme_reset_work()
> 
>  block/blk-mq.c                  | 25 ++++++++++++++--
>  drivers/nvme/host/core.c        | 12 +++++---
>  drivers/nvme/host/nvme.h        |  2 +-
>  drivers/nvme/host/pci.c         |  3 +-
>  include/linux/blk-mq.h          |  1 +
>  include/linux/percpu-refcount.h |  1 +
>  lib/percpu-refcount.c           | 63 ++++++++++++++++++++++++++++++++++-------
>  7 files changed, 87 insertions(+), 20 deletions(-)
> 
> Cc: Tejun Heo <tj at kernel.org>
> Cc: Jianchao Wang <jianchao.w.wang at oracle.com>
> Cc: Kent Overstreet <kent.overstreet at gmail.com>
> Cc: linux-block at vger.kernel.org
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: linux-nvme at lists.infradead.org
> Cc: Keith Busch <keith.busch at intel.com>
> 

Ooops, there is one extra patch missed.

Please ignore this series.

Thanks,
Ming
