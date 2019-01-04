From: ming.lei@redhat.com (Ming Lei)
Date: Fri, 4 Jan 2019 10:31:22 +0800
Subject: [PATCHv2 2/4] nvme-pci: Distribute io queue types after creation
In-Reply-To: <20190103225033.11249-3-keith.busch@intel.com>
References: <20190103225033.11249-1-keith.busch@intel.com>
 <20190103225033.11249-3-keith.busch@intel.com>
Message-ID: <20190104023121.GB31330@ming.t460p>

On Thu, Jan 03, 2019@03:50:31PM -0700, Keith Busch wrote:
> The dev->io_queues types were set based on the results of the nvme set
> feature "number of queues" and the IRQ allocation. This result does not
> mean we're going to successfully allocate and create those IO queues,
> though. A failure there will cause blk-mq to have NULL hctx's because the
> map's nr_hw_queues accounts for more queues than were actually created.
> 
> Adjust the io_queue types after we've created them when we have less than
> originally desired.
> 
> Fixes: 3b6592f70ad7b ("nvme: utilize two queue maps, one for reads and one for writes")
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/pci.c | 46 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 98332d0a80f0..1481bb6d9c42 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1733,6 +1733,30 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
>  	return result;
>  }
>  
> +static void nvme_distribute_queues(struct nvme_dev *dev, unsigned int io_queues)
> +{
> +	unsigned int irq_queues, this_p_queues = dev->io_queues[HCTX_TYPE_POLL],
> +		     this_w_queues = dev->io_queues[HCTX_TYPE_DEFAULT];
> +
> +	if (!io_queues) {
> +		dev->io_queues[HCTX_TYPE_POLL] = 0;
> +		dev->io_queues[HCTX_TYPE_DEFAULT] = 0;
> +		dev->io_queues[HCTX_TYPE_READ] = 0;
> +		return;
> +	}
> +
> +	if (this_p_queues >= io_queues)
> +		this_p_queues = io_queues - 1;
> +	irq_queues = io_queues - this_p_queues;
> +
> +	if (this_w_queues > irq_queues)
> +		this_w_queues = irq_queues;
> +
> +	dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
> +	dev->io_queues[HCTX_TYPE_DEFAULT] = this_w_queues;
> +	dev->io_queues[HCTX_TYPE_READ] = irq_queues - this_w_queues;
> +}
> +
>  static int nvme_create_io_queues(struct nvme_dev *dev)
>  {
>  	unsigned i, max, rw_queues;
> @@ -1761,6 +1785,13 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
>  			break;
>  	}
>  
> +	/*
> +	 * If we've created less than expected io queues, redistribute the
> +	 * dev->io_queues[] types accordingly.
> +	 */
> +	if (dev->online_queues - 1 != dev->max_qid)
> +		nvme_distribute_queues(dev, dev->online_queues - 1);
> +
>  	/*
>  	 * Ignore failing Create SQ/CQ commands, we can continue with less
>  	 * than the desired amount of queues, and even a controller without
> @@ -2185,11 +2216,6 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>  	result = max(result - 1, 1);
>  	dev->max_qid = result + dev->io_queues[HCTX_TYPE_POLL];
>  
> -	dev_info(dev->ctrl.device, "%d/%d/%d default/read/poll queues\n",
> -					dev->io_queues[HCTX_TYPE_DEFAULT],
> -					dev->io_queues[HCTX_TYPE_READ],
> -					dev->io_queues[HCTX_TYPE_POLL]);
> -
>  	/*
>  	 * Should investigate if there's a performance win from allocating
>  	 * more queues than interrupt vectors; it might allow the submission
> @@ -2203,7 +2229,15 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>  		return result;
>  	}
>  	set_bit(NVMEQ_ENABLED, &adminq->flags);
> -	return nvme_create_io_queues(dev);
> +	result = nvme_create_io_queues(dev);
> +
> +	if (!result)
> +		dev_info(dev->ctrl.device, "%d/%d/%d default/read/poll queues\n",
> +					dev->io_queues[HCTX_TYPE_DEFAULT],
> +					dev->io_queues[HCTX_TYPE_READ],
> +					dev->io_queues[HCTX_TYPE_POLL]);
> +	return result;
> +
>  }
>  
>  static void nvme_del_queue_end(struct request *req, blk_status_t error)
> -- 
> 2.14.4
> 

This way should be better given it covers irq allocation failure and
queue creating/initialization failure.

Reviewed-by: Ming Lei <ming.lei at redhat.com>

Thanks,
Ming
