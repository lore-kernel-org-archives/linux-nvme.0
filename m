From: hch@lst.de (Christoph Hellwig)
Date: Sat, 21 Oct 2017 10:06:19 +0200
Subject: [PATCHv2 1/5] nvme: Centralize AEN defines
In-Reply-To: <20171020221924.30659-2-keith.busch@intel.com>
References: <20171020221924.30659-1-keith.busch@intel.com>
 <20171020221924.30659-2-keith.busch@intel.com>
Message-ID: <20171021080619.GB20906@lst.de>

> +	ctrl->event_limit = NVME_AEN_COMMANDS;

Can we keep the NR_? E.g. NVME_NR_AEN_COMMANDS?

> +	struct nvme_fc_fcp_op	aen_ops[NVME_AEN_COMMANDS];
>  
>  	struct nvme_ctrl	ctrl;
>  };
> @@ -1322,7 +1313,7 @@ nvme_fc_abort_aen_ops(struct nvme_fc_ctrl *ctrl)
>  	unsigned long flags;
>  	int i, ret;
>  
> -	for (i = 0; i < NVME_FC_NR_AEN_COMMANDS; i++, aen_op++) {
> +	for (i = 0; i < NVME_AEN_COMMANDS; i++, aen_op++) {
>  		if (atomic_read(&aen_op->state) != FCPOP_STATE_ACTIVE)
>  			continue;

Kill the array and loop?

> -	ctrl->admin_tag_set.queue_depth = NVME_FC_AQ_BLKMQ_DEPTH;
> +	ctrl->admin_tag_set.queue_depth = NVME_AQ_BLK_MQ_DEPTH - 1;

Shouldn't the -1 be factored into NVME_AQ_BLK_MQ_DEPTH?  Either way
I think we need some constant for it, and move the explanation for it
from the PCI driver to the core somehow.
