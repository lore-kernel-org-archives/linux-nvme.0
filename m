From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Tue, 20 Oct 2015 13:04:24 +0300
Subject: [PATCH 01/18] nvme: add missing unmaps in nvme_queue_rq
In-Reply-To: <1444975128-8768-2-git-send-email-hch@lst.de>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-2-git-send-email-hch@lst.de>
Message-ID: <562611A8.1060804@dev.mellanox.co.il>

On 10/16/2015 8:58 AM, Christoph Hellwig wrote:
> When we fail various metadata related operations in nvme_queue_rq we
> need to unmap the data SGL.
>
> Cc: stable at vger.kernel.org
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/pci.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 22d8375..2f05292 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -906,19 +906,28 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>   			goto retry_cmd;
>   		}
>   		if (blk_integrity_rq(req)) {
> -			if (blk_rq_count_integrity_sg(req->q, req->bio) != 1)
> +			if (blk_rq_count_integrity_sg(req->q, req->bio) != 1) {
> +				dma_unmap_sg(dev->dev, iod->sg, iod->nents,
> +						dma_dir);
>   				goto error_cmd;
> +			}
>
>   			sg_init_table(iod->meta_sg, 1);
>   			if (blk_rq_map_integrity_sg(
> -					req->q, req->bio, iod->meta_sg) != 1)
> +					req->q, req->bio, iod->meta_sg) != 1) {
> +				dma_unmap_sg(dev->dev, iod->sg, iod->nents,
> +						dma_dir);
>   				goto error_cmd;
> +			}

This is not related to the patch itself. But this condition seems bogus
to me. We passed meta_sg that consists of a single entry. If we
happened to map more than a single entry we're already in trouble as we
overrun meta_sg (modified the iod->sg pointer).

I think a WARN_ON_ONCE statement is more suitable here (which should
probably come as a separate patch).

Other than that, looks good to me:

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
