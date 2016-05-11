From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 11 May 2016 11:25:16 +0200
Subject: [PATH v2] NVMe: init nvme queue before enabling irq
In-Reply-To: <1453286915-18814-1-git-send-email-mail_weber_wang@163.com>
References: <1453286915-18814-1-git-send-email-mail_weber_wang@163.com>
Message-ID: <e41c65a6b6637ef16f7f11ac147a9466@suse.de>

On 2016-01-20 11:48, Wenbo Wang wrote:
> From: Wenbo Wang <wenbo.wang at memblaze.com>
> 
> During reset process, the nvme_dev->bar (ioremapped) may change,
> so nvmeq->q_db shall be also updated by nvme_init_queue().
> 
> Currently nvmeq irq is enabled before queue init, so a spurious
> interrupt triggered nvme_process_cq may access nvmeq->q_db just
> before it is updated, this could cause kernel panic.
> 
> Signed-off-by: Wenbo Wang <wenbo.wang at memblaze.com>
> Reviewed-by: Wenwei Tao <wenwei.tao at memblaze.com>
> ---
>  drivers/nvme/host/pci.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index f5c0e26..3371c18 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1529,9 +1529,6 @@ static struct nvme_queue
> *nvme_alloc_queue(struct nvme_dev *dev, int qid,
>  	snprintf(nvmeq->irqname, sizeof(nvmeq->irqname), "nvme%dq%d",
>  			dev->instance, qid);
>  	spin_lock_init(&nvmeq->q_lock);
> -	nvmeq->cq_head = 0;
> -	nvmeq->cq_phase = 1;
> -	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
>  	nvmeq->q_depth = depth;
>  	nvmeq->qid = qid;
>  	nvmeq->cq_vector = -1;
> @@ -1590,11 +1587,17 @@ static int nvme_create_queue(struct nvme_queue
> *nvmeq, int qid)
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
> @@ -1789,6 +1792,8 @@ static int nvme_configure_admin_queue(struct
> nvme_dev *dev)
>  	if (result)
>  		goto free_nvmeq;
> 
> +	nvme_init_queue(nvmeq, 0);
> +
>  	nvmeq->cq_vector = 0;
>  	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
>  	if (result) {
> @@ -3164,7 +3169,6 @@ static void nvme_probe_work(struct work_struct 
> *work)
>  		goto disable;
>  	}
> 
> -	nvme_init_queue(dev->queues[0], 0);
>  	result = nvme_alloc_admin_tags(dev);
>  	if (result)
>  		goto disable;

What ever happened to this patch?
I can easily reproduce the bug using
while [ true ]; do rmmod nvme nvme_core; modprobe nvme; done
