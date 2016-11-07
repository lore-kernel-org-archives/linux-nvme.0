From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 7 Nov 2016 10:22:25 +0100
Subject: [PATCH v5 6/7] nvme-fabrics: Add target support for FC transport
In-Reply-To: <58201df5.VwHW5e3+1qgK/Why%jsmart2021@gmail.com>
References: <58201df5.VwHW5e3+1qgK/Why%jsmart2021@gmail.com>
Message-ID: <20161107092225.kub4sdnzy5uqgybe@linux-x5ow.site>

Hi James,

On Sun, Nov 06, 2016@10:23:49PM -0800, James Smart wrote:
> 
> Add nvme-fabrics target support for FC transport

[...]

> +static void
> +nvmet_fc_prep_fcp_iodlist(struct nvmet_fc_tgtport *tgtport,
> +				struct nvmet_fc_tgt_queue *queue)
> +{
> +	struct nvmet_fc_fcp_iod *fod = queue->fod;
> +	int i;
> +
> +	for (i = 0; i < queue->sqsize; fod++, i++) {
> +		INIT_WORK(&fod->work, nvmet_fc_handle_fcp_rqst_work);
> +		fod->tgtport = tgtport;
> +		fod->queue = queue;
> +		atomic_set(&fod->active, 0);

Hmm why exactly do you need atomics here? You're using fod->active as bool and
don't ever do a real atomic operation such as atomic_inc()
atomic_dev_and_test(), etc.. on it. Also you're never checking if fod->active
is actually 1 when you come here (and if it can't what's the point of it being
atomic in the first place)?

> +		list_add_tail(&fod->fcp_list, &queue->fod_list);
> +
> +		fod->rspdma = dma_map_single(
> +					tgtport->dev, &fod->rspiubuf,
> +					sizeof(fod->rspiubuf), DMA_TO_DEVICE);
> +		if (dma_mapping_error(tgtport->dev, fod->rspdma)) {
> +			list_del(&fod->fcp_list);
> +			for (fod--, i--; i >= 0; fod--, i--) {
> +				dma_unmap_single(tgtport->dev,
> +					fod->rspdma, sizeof(fod->rspiubuf),
> +					DMA_TO_DEVICE);
> +				fod->rspdma = 0L;
> +				list_del(&fod->fcp_list);
> +			}
> +
> +			return;
> +		}
> +	}
> +}

[...]

> +static struct nvmet_fc_fcp_iod *
> +nvmet_fc_alloc_fcp_iod(struct nvmet_fc_tgtport *tgtport,
> +			struct nvmet_fc_tgt_queue *queue)
> +{
> +	static struct nvmet_fc_fcp_iod *fod;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&tgtport->lock, flags);
> +	fod = list_first_entry_or_null(&queue->fod_list,
> +					struct nvmet_fc_fcp_iod, fcp_list);
> +	if (fod) {
> +		list_del(&fod->fcp_list);
> +		atomic_set(&fod->active, 1);
> +		atomic_set(&fod->aborted, 0);

Same goes for fod->aborted.

> +	}
> +	spin_unlock_irqrestore(&tgtport->lock, flags);
> +	return fod;
> +}

[...]

> +static void
> +nvmet_fc_abort_op(struct nvmet_fc_tgtport *tgtport,
> +				struct nvmefc_tgt_fcp_req *fcpreq)
> +{
> +	int ret;
> +
> +	fcpreq->op = NVMET_FCOP_ABORT;
> +	fcpreq->offset = 0;
> +	fcpreq->timeout = 0;
> +	fcpreq->transfer_length = 0;
> +	fcpreq->transferred_length = 0;
> +	fcpreq->fcp_error = 0;
> +	fcpreq->sg_cnt = 0;
> +
> +	ret = tgtport->ops->fcp_op(&tgtport->fc_target_port, fcpreq);
> +	if (ret)
> +		WARN_ON(1);
> +		/* should never reach here !! */

WARN_ON(ret)?

> +}
> +
> +

[...]


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
