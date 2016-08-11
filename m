From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 11 Aug 2016 14:22:38 -0700
Subject: [PATCH 4/5] nvme-fabrics: Add target FC transport support
In-Reply-To: <5792b91e.51+4Ind0/2MxGqHU%james.smart@broadcom.com>
References: <5792b91e.51+4Ind0/2MxGqHU%james.smart@broadcom.com>
Message-ID: <20160811212238.GG18013@infradead.org>

> +config NVME_TARGET_FC
> +	tristate "NVMe over Fabrics FC target driver"
> +	select NVME_TARGET

this should be a depends, NVME_TARGET is a user visible option.

> +		/* TODO: better to use dma_map_page() ?*/
> +		iod->rspdma = dma_map_single(tgtport->dev, iod->rspbuf,
> +						NVME_FC_MAX_LS_BUFFER_SIZE,
> +						DMA_TO_DEVICE);
> +		if (dma_mapping_error(tgtport->dev, iod->rspdma))
> +			goto out_fail;

Same comment as on the host side.

> +	queue->work_q = alloc_workqueue("ntfc%d.%d.%d", 0, 0,
> +				assoc->tgtport->fc_target_port.port_num,
> +				assoc->a_id, qid);

Do we really need a workqueue per queue?

> +static struct nvmet_fc_tgt_queue *
> +nvmet_fc_find_target_queue(struct nvmet_fc_tgtport *tgtport,
> +				u64 connection_id)
> +{
> +	struct nvmet_fc_tgt_assoc *assoc;
> +	u64 association_id = nvmet_fc_getassociationid(connection_id);
> +	u16 qid = nvmet_fc_getqueueid(connection_id);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&tgtport->lock, flags);
> +	list_for_each_entry(assoc, &tgtport->assoc_list, a_list) {
> +		if (association_id == assoc->association_id) {
> +			spin_unlock_irqrestore(&tgtport->lock, flags);
> +			return assoc->queues[qid];
> +		}
> +	}
> +	spin_unlock_irqrestore(&tgtport->lock, flags);
> +	return NULL;

No reference counting?

> +static struct nvmet_fc_tgt_assoc *
> +nvmet_fc_find_target_assoc(struct nvmet_fc_tgtport *tgtport,
> +				u64 association_id)
> +{
> +	struct nvmet_fc_tgt_assoc *assoc;
> +	struct nvmet_fc_tgt_assoc *ret = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&tgtport->lock, flags);
> +	list_for_each_entry(assoc, &tgtport->assoc_list, a_list) {
> +		if (association_id == assoc->association_id) {
> +			ret = assoc;
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&tgtport->lock, flags);
> +
> +	return ret;

Same here?
