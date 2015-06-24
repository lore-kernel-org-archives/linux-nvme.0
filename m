From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 24 Jun 2015 05:21:58 -0700
Subject: [PATCHv2 2/2] NVMe: Use CMB for the SQ if available
In-Reply-To: <1435098787-13083-3-git-send-email-jonathan.derrick@intel.com>
References: <1435098787-13083-1-git-send-email-jonathan.derrick@intel.com>
 <1435098787-13083-3-git-send-email-jonathan.derrick@intel.com>
Message-ID: <20150624122158.GB14590@infradead.org>

> +++ b/drivers/block/nvme-core.c
> @@ -102,12 +102,16 @@ struct nvme_queue {
>  	struct nvme_dev *dev;
>  	char irqname[24];	/* nvme4294967295-65535\0 */
>  	spinlock_t q_lock;
> -	struct nvme_command *sq_cmds;
> +	union {
> +		struct nvme_command *sq_cmds;
> +		struct nvme_command __iomem *sq_cmds_io;
> +	};
>  	volatile struct nvme_completion *cqes;
>  	struct blk_mq_tags **tags;
>  	dma_addr_t sq_dma_addr;
>  	dma_addr_t cq_dma_addr;
>  	u32 __iomem *q_db;
> +	bool cmb_mapped;

If you remove the union you'll get better error checking because
using the wrong member won't work, and you can remove the cmb_mapped
flag and instead check for a non-NULL sq_cmds_io.

Otherwise this looks reasonable to me.

Note that I have a WIP patch to make all command submissions go through
nvme_queue_rq, in which case we might be able to get rid of the on-stack
cmds again.  But until that happens I think the refactoring in the first
patch is preferable to the earlier version.
