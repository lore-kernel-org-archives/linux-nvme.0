From: keith.busch@intel.com (Keith Busch)
Date: Thu, 30 Mar 2017 13:33:24 -0400
Subject: [PATCH v6 RFC] nvme: improve performance for virtual NVMe devices
In-Reply-To: <1490633408-27529-1-git-send-email-helen.koike@collabora.com>
References: <1490329423-17152-1-git-send-email-helen.koike@collabora.com>
 <1490633408-27529-1-git-send-email-helen.koike@collabora.com>
Message-ID: <20170330173324.GH20181@localhost.localdomain>

On Mon, Mar 27, 2017@01:50:08PM -0300, Helen Koike wrote:
> changes since v5:
> 	- remove anonymous dbbuf struct in struct nvme_dev and struct nvme_queue
> 	- use inline functions for sq_idx and cq_idx instead of macros
> 	- add a warning when nvme_dbbuf_set fails
> 	- remove comment "Borrowed from vring_need_event"
> 	- change formatting of the parameters in nvme_write_doorbell
> 	- don't fail nvme_reset_work if nvme_dbbuf_dma_alloc fails
> 	- remove nvme_write_doorbell_{sq,cq} wrappers
> 	- in nvme_write_doorbell(), call writel last

I'm pretty much okay with this. The only thing I'd change is to call
nvme_dbbuf_dma_free only when we're unbinding so that we don't have to
reallocate it on a every controller reset:
 
> +static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
> +{
> +	unsigned int mem_size = nvme_dbbuf_size(dev->db_stride);

	if (dev->dbbuf_dbs)
		return 0;

> +
> +	dev->dbbuf_dbs = dma_alloc_coherent(dev->dev, mem_size,
> +					    &dev->dbbuf_dbs_dma_addr,
> +					    GFP_KERNEL);
> +	if (!dev->dbbuf_dbs)
> +		return -ENOMEM;
> +	dev->dbbuf_eis = dma_alloc_coherent(dev->dev, mem_size,
> +					    &dev->dbbuf_eis_dma_addr,
> +					    GFP_KERNEL);
> +	if (!dev->dbbuf_eis) {
> +		dma_free_coherent(dev->dev, mem_size,
> +				  dev->dbbuf_dbs, dev->dbbuf_dbs_dma_addr);
> +		dev->dbbuf_dbs = NULL;
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}

> @@ -1066,6 +1187,7 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
>  	nvmeq->q_depth = depth;
>  	nvmeq->qid = qid;
>  	nvmeq->cq_vector = -1;
> +	nvme_dbbuf_init(dev, nvmeq, qid);
>  	dev->queues[qid] = nvmeq;
>  	dev->queue_count++;

Remove the above since it's duplicated in nvme_init_queue.

> @@ -1700,6 +1825,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  		nvme_disable_admin_queue(dev, shutdown);
>  	}
>  	nvme_pci_disable(dev);
> +	nvme_dbbuf_dma_free(dev);

And move this to nvme_pci_free_ctrl().
