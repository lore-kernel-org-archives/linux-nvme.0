From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 21 Jan 2016 17:32:44 +0100
Subject: [PATCH v3] NVMe: init nvme queue before enabling irq
In-Reply-To: <1453376445-23391-1-git-send-email-mail_weber_wang@163.com>
References: <1453376445-23391-1-git-send-email-mail_weber_wang@163.com>
Message-ID: <20160121163244.GT2742@c203.arch.suse.de>

On Thu, Jan 21, 2016@06:40:45AM -0500, Wenbo Wang wrote:
> From: Wenbo Wang <wenbo.wang at memblaze.com>
> 
> [v3] Do request irq in nvme_init_queue() to handle request irq failures
> 
> There is one problem with the original patch. Since init queue happens
> before request irq, online_queue might be left increased if request irq
> fails. This version merges request irq into nvme_init_queue() because:
> 1. It solves the online_queue counting issue if request irq fails.
> 2. nvme_init_queue() is always followed by request irq, this change
>    simplifies code.
> 
> This version also solves another possible race condition by moving
> adminq free irq before iounmap.
> 
> [v2] Remove duplicate init code in nvme_alloc_queue()
> 
> During reset process, the nvme_dev->bar (ioremapped) may change,
> so nvmeq->q_db shall be also updated by nvme_init_queue().
> 
> [v1]
> 
> Currently nvmeq irq is enabled before queue init, so a spurious
> interrupt triggered nvme_process_cq may access nvmeq->q_db just
> before it is updated, this could cause kernel panic.
> 
> Signed-off-by: Wenbo Wang <wenbo.wang at memblaze.com>
> Reviewed-by: Wenwei Tao <wenwei.tao at memblaze.com>
> CC: stable at vger.kernel.org
> ---
>  drivers/nvme/host/pci.c | 38 ++++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index f5c0e26..11e7cb6 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1529,9 +1529,6 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
>  	snprintf(nvmeq->irqname, sizeof(nvmeq->irqname), "nvme%dq%d",
>  			dev->instance, qid);
>  	spin_lock_init(&nvmeq->q_lock);
> -	nvmeq->cq_head = 0;
> -	nvmeq->cq_phase = 1;
> -	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
>  	nvmeq->q_depth = depth;
>  	nvmeq->qid = qid;
>  	nvmeq->cq_vector = -1;
> @@ -1562,8 +1559,9 @@ static int queue_request_irq(struct nvme_dev *dev, struct nvme_queue *nvmeq,
>  				IRQF_SHARED, name, nvmeq);
>  }
>  
> -static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
> +static int nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
>  {
> +	int result;
>  	struct nvme_dev *dev = nvmeq->dev;
>  
>  	spin_lock_irq(&nvmeq->q_lock);
> @@ -1574,6 +1572,16 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
>  	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
>  	dev->online_queues++;
>  	spin_unlock_irq(&nvmeq->q_lock);
> +
> +	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
> +
> +	if (result) {
> +		spin_lock_irq(&nvmeq->q_lock);
> +		nvmeq->cq_vector = -1;
> +		dev->online_queues--;
> +		spin_unlock_irq(&nvmeq->q_lock);
> +	}
> +	return result;
>  }
>  
>  static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
> @@ -1590,11 +1598,15 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
>  	if (result < 0)
>  		goto release_cq;
>  
> -	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
> +	/*
> +	 * Init queue door bell ioremap address before enabling irq, if not,
> +	 * a spurious interrupt triggered nvme_process_cq may access invalid
> +	 * address
> +	 */
> +	result = nvme_init_queue(nvmeq, qid);
>  	if (result < 0)
>  		goto release_sq;
>  
> -	nvme_init_queue(nvmeq, qid);
>  	return result;
>  
>   release_sq:
> @@ -1790,11 +1802,9 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
>  		goto free_nvmeq;
>  
>  	nvmeq->cq_vector = 0;
> -	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
> -	if (result) {
> -		nvmeq->cq_vector = -1;
> +	result = nvme_init_queue(nvmeq, 0);
> +	if (result)
>  		goto free_nvmeq;
> -	}
>  
>  	return result;
>  
> @@ -2446,6 +2456,9 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>  			nvme_release_cmb(dev);
>  	}
>  
> +	/* Deregister the admin queue's interrupt */
> +	free_irq(dev->entry[0].vector, adminq);
> +
>  	size = db_bar_size(dev, nr_io_queues);
>  	if (size > 8192) {
>  		iounmap(dev->bar);
> @@ -2461,9 +2474,6 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>  		adminq->q_db = dev->dbs;
>  	}
>  
> -	/* Deregister the admin queue's interrupt */
> -	free_irq(dev->entry[0].vector, adminq);
> -
>  	/*
>  	 * If we enable msix early due to not intx, disable it again before
>  	 * setting up the full range we need.
> @@ -2496,6 +2506,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>  	result = queue_request_irq(dev, adminq, adminq->irqname);
>  	if (result) {
>  		adminq->cq_vector = -1;
> +		dev->online_queues--;
>  		goto free_queues;
>  	}
>  
> @@ -3164,7 +3175,6 @@ static void nvme_probe_work(struct work_struct *work)
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

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
