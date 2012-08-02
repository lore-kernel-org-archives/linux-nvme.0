From: keith.busch@intel.com (Busch, Keith)
Date: Thu, 2 Aug 2012 18:51:35 +0000
Subject: [PATCH] Cancel outstanding IOs on queue deletion
In-Reply-To: <20120802175546.GD4325@linux.intel.com>
References: <20120802175546.GD4325@linux.intel.com>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B916291FB1@FMSMSX105.amr.corp.intel.com>

> -----Original Message-----
> From: linux-nvme-bounces at lists.infradead.org [mailto:linux-nvme-
> bounces at lists.infradead.org] On Behalf Of Matthew Wilcox
> Sent: Thursday, August 02, 2012 11:56 AM
> To: linux-nvme at lists.infradead.org
> Subject: [PATCH] Cancel outstanding IOs on queue deletion

>  static void nvme_free_queue(struct nvme_dev *dev, int qid)  {
>  	struct nvme_queue *nvmeq = dev->queues[qid];
>  	int vector = dev->entry[nvmeq->cq_vector].vector;
> 
> +	nvme_timeout_ios(nvmeq);
> +
>  	irq_set_affinity_hint(vector, NULL);
>  	free_irq(vector, nvmeq);
> 

nvme_timeout_ios cancels an io only if it has timed out, but I think you want to unconditionally cancel them out when freeing the queue. Also, should you hold the q_lock when calling this function?
