From: keith.busch@intel.com (Keith Busch)
Date: Wed, 13 May 2015 14:12:10 +0000 (UTC)
Subject: [PATCH] block:Change the function, nvme_alloc_queue to use
 -ENOMEM for when failing memory allocations
In-Reply-To: <1431474691-30469-1-git-send-email-xerofoify@gmail.com>
References: <1431474691-30469-1-git-send-email-xerofoify@gmail.com>
Message-ID: <alpine.LNX.2.00.1505131408540.15930@localhost.lm.intel.com>

On Tue, 12 May 2015, Nicholas Krause wrote:
> This changes the function,nvme_alloc_queue to use the kernel code,
> -ENOMEM for when failing to allocate the memory required for the
> nvme_queue structure pointer,nvme in order to correctly return
> to the caller the correct reason for this function's failing.

Nak! Look at what the callers are checking for upon return.

> Signed-off-by: Nicholas Krause <xerofoify at gmail.com>
> ---
> drivers/block/nvme-core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index 85b8036..e2eac1e 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -1387,7 +1387,7 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
> 	struct device *dmadev = &dev->pci_dev->dev;
> 	struct nvme_queue *nvmeq = kzalloc(sizeof(*nvmeq), GFP_KERNEL);
> 	if (!nvmeq)
> -		return NULL;
> +		return -ENOMEM;
>
> 	nvmeq->cqes = dma_zalloc_coherent(dmadev, CQ_SIZE(depth),
> 					  &nvmeq->cq_dma_addr, GFP_KERNEL);
