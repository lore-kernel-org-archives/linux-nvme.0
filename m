From: wenbo.wang@memblaze.com (Wenbo Wang)
Date: Wed, 20 Jan 2016 09:45:50 +0000
Subject: [PATCH] NVMe: init nvme queue before enabling irq
In-Reply-To: <20160120090931.GO2742@c203.arch.suse.de>
References: <1453265860-31080-1-git-send-email-mail_weber_wang@163.com>
 <20160120090931.GO2742@c203.arch.suse.de>
Message-ID: <BJXPR01MB199909E00F32CCC29F15C43E0C20@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>

> If it can cause a kernel panic shouldn't it go through stable then as well?

Sorry, not quite understand this comment.
The "reset process" is the nvme device reset process (performed by nvme_reset_work()) triggered by device fail condition.
During normal boot up, nvmeq door bell is initialized in nvme_alloc_queue() which happens before enabling irq, so there is no error.
During nvme device reset process, nvme_alloc_queue() is skipped and the race condition exists.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Johannes Thumshirn
Sent: Wednesday, January 20, 2016 5:10 PM
To: Wenbo Wang
Cc: keith.busch at intel.com; axboe at fb.com; Wenbo Wang; Wenwei.Tao; linux-kernel at vger.kernel.org; linux-nvme at lists.infradead.org
Subject: Re: [PATCH] NVMe: init nvme queue before enabling irq

On Tue, Jan 19, 2016@11:57:40PM -0500, Wenbo Wang wrote:
> During reset process, the nvme_dev->bar (ioremapped) may change, so 
> nvmeq->q_db shall be also updated by nvme_init_queue().
> 
> Currently nvmeq irq is enabled before queue init, so a spurious 
> interrupt triggered nvme_process_cq may access nvmeq->q_db just before 
> it is updated, this could cause kernel panic.

If it can cause a kernel panic shouldn't it go through stable then as well?

> 
> Signed-off-by: Wenbo Wang <wenbo.wang at memblaze.com>
> Reviewed-by: Wenwei Tao <wenwei.tao at memblaze.com>
> ---
>  drivers/nvme/host/pci.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index 
> f5c0e26..df55f28 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1590,11 +1590,17 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
>  	if (result < 0)
>  		goto release_cq;
>  
> +	/*
> +	 * Init queue door bell ioremap address before enabling irq, if not,
> +	 * a spurious interrupt triggered nvme_process_cq may access invalid
> +	 * address
> +	 */
> +	nvme_init_queue(nvmeq, qid);
> +
>  	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
>  	if (result < 0)
>  		goto release_sq;
>  
> -	nvme_init_queue(nvmeq, qid);
>  	return result;
>  
>   release_sq:
> @@ -1789,6 +1795,8 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
>  	if (result)
>  		goto free_nvmeq;
>  
> +	nvme_init_queue(nvmeq, 0);
> +
>  	nvmeq->cq_vector = 0;
>  	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
>  	if (result) {
> @@ -3164,7 +3172,6 @@ static void nvme_probe_work(struct work_struct *work)
>  		goto disable;
>  	}
>  
> -	nvme_init_queue(dev->queues[0], 0);
>  	result = nvme_alloc_admin_tags(dev);
>  	if (result)
>  		goto disable;
> --
> 1.8.3.1
> 
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Other than that

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton HRB 21284 (AG N?rnberg) Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
