From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 14 Nov 2014 09:55:44 -0500
Subject: [PATCH] NVMe: Add rw_page support
In-Reply-To: <1415923538-18760-1-git-send-email-keith.busch@intel.com>
References: <1415923538-18760-1-git-send-email-keith.busch@intel.com>
Message-ID: <20141114145544.GE11522@wil.cx>

On Thu, Nov 13, 2014@05:05:38PM -0700, Keith Busch wrote:
> +static void pgrd_completion(struct nvme_queue *nvmeq, void *ctx,
> +						struct nvme_completion *cqe)
> +{
> +	struct request *req = ctx;
> +	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
> +	struct page *page = req->special;
> +	u16 status = le16_to_cpup(&cqe->status) >> 1;
> +
> +	dma_unmap_page(nvmeq->q_dmadev, cmd_rq->dma, PAGE_CACHE_SIZE, DMA_FROM_DEVICE);
> +	page_endio(page, READ, status != NVME_SC_SUCCESS);

The third parameter to page_endio() is supposed to be an errno.  This will
happen to work fine since anything other than 0 and -ENOSPC gets translated
to -EIO, but it'd be better to make this line:

	page_endio(page, READ, nvme_error_status(status));

> +static void pgwr_completion(struct nvme_queue *nvmeq, void *ctx,
> +						struct nvme_completion *cqe)
> +{
> +	struct request *req = ctx;
> +	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
> +	struct page *page = req->special;
> +	u16 status = le16_to_cpup(&cqe->status) >> 1;
> +
> +	dma_unmap_page(nvmeq->q_dmadev, cmd_rq->dma, PAGE_CACHE_SIZE, DMA_TO_DEVICE);
> +	page_endio(page, WRITE, status != NVME_SC_SUCCESS);

Here too.
