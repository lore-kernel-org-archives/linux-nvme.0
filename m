From: hch@lst.de (Christoph Hellwig)
Date: Wed, 25 Jan 2017 09:46:11 +0100
Subject: [PATCH] nvme-fc: use blk_rq_nr_phys_segments
In-Reply-To: <1484841357-17539-1-git-send-email-hch@lst.de>
References: <1484841357-17539-1-git-send-email-hch@lst.de>
Message-ID: <20170125084611.GA15731@lst.de>

Folks, can I get a review fore this?

Without it we'll reliably crash on a discard on nvme-fc, so we
should get this into 4.10.

On Thu, Jan 19, 2017@04:55:57PM +0100, Christoph Hellwig wrote:
> Without this deallocate won't work properly due to the mismatch
> of the bio/request size and the actual payload size.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/fc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index fcc9dcf..e65041c 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1663,13 +1663,13 @@ nvme_fc_map_data(struct nvme_fc_ctrl *ctrl, struct request *rq,
>  		return 0;
>  
>  	freq->sg_table.sgl = freq->first_sgl;
> -	ret = sg_alloc_table_chained(&freq->sg_table, rq->nr_phys_segments,
> -			freq->sg_table.sgl);
> +	ret = sg_alloc_table_chained(&freq->sg_table,
> +			blk_rq_nr_phys_segments(rq), freq->sg_table.sgl);
>  	if (ret)
>  		return -ENOMEM;
>  
>  	op->nents = blk_rq_map_sg(rq->q, rq, freq->sg_table.sgl);
> -	WARN_ON(op->nents > rq->nr_phys_segments);
> +	WARN_ON(op->nents > blk_rq_nr_phys_segments(rq));
>  	dir = (rq_data_dir(rq) == WRITE) ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
>  	freq->sg_cnt = fc_dma_map_sg(ctrl->lport->dev, freq->sg_table.sgl,
>  				op->nents, dir);
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
---end quoted text---
