From: willy@linux.intel.com (Matthew Wilcox)
Date: Mon, 30 Dec 2013 08:46:07 -0500
Subject: [PATCH RFC 2/5] NVMe: Basic NVMe device hotplug support
In-Reply-To: <1388399240-13828-3-git-send-email-santoshsy@gmail.com>
References: <1388399240-13828-1-git-send-email-santoshsy@gmail.com>
 <1388399240-13828-3-git-send-email-santoshsy@gmail.com>
Message-ID: <20131230134607.GH4945@linux.intel.com>

On Mon, Dec 30, 2013@03:57:17PM +0530, Santosh Y wrote:
> +config BLK_DEV_NVME_HP
> +	bool "Enable hotplug support"
> +	depends on BLK_DEV_NVME && HOTPLUG_PCI_PCIE
> +	default n
> +	help
> +	  If you say Y here, the driver will support hotplug feature.
> +	  Hotplug only works if the PCIe slot is hotplug capable.
> +

No.  There is no such thing as "enable hotplug support".  All devices
are at least theoretically hotpluggable, and I'm not papering over bugs
with this kind of config option.

> @@ -383,10 +403,19 @@ static void bio_completion(struct nvme_dev *dev, void *ctx,
>  		nvme_end_io_acct(bio, iod->start_time);
>  	}
>  	nvme_free_iod(dev, iod);
> -	if (status)
> -		bio_endio(bio, -EIO);
> -	else
> +	if (status) {
> +#ifdef CONFIG_BLK_DEV_NVME_HP
> +		if ((status & 0xff) == NVME_SC_INVALID_NS) {
> +			bio_endio(bio, -ENODEV);
> +		} else if ((status & 0xff) == NVME_SC_NS_NOT_READY) {
> +			bio->bi_rw |= REQ_FAILFAST_DRIVER;

Umm.
        __REQ_FAILFAST_DRIVER,  /* no driver retries of driver errors */
You seem to be using this to mean the exact opposite, "Do a retry".

> +			nvme_requeue_bio(dev, bio);
> +		} else
> +#endif
> +			bio_endio(bio, -EIO);
> +	} else {
>  		bio_endio(bio, 0);
> +	}
>  }
>  
>  /* length is in bytes.  gfp flags indicates whether we may sleep. */
> @@ -722,6 +751,10 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
>  	if ((bio->bi_rw & REQ_FLUSH) && !psegs)
>  		return nvme_submit_flush(nvmeq, ns, cmdid);
>  
> +#ifdef CONFIG_BLK_DEV_NVME_HP
> +	if (bio->bi_rw & REQ_FAILFAST_DRIVER)
> +		mdelay(100);
> +#endif
>  	control = 0;
>  	if (bio->bi_rw & REQ_FUA)
>  		control |= NVME_RW_FUA;
> @@ -814,10 +847,26 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
>  
>  static void nvme_make_request(struct request_queue *q, struct bio *bio)
>  {
> -	struct nvme_ns *ns = q->queuedata;
> -	struct nvme_queue *nvmeq = get_nvmeq(ns->dev);
> +	struct nvme_ns *ns = NULL;
> +	struct nvme_queue *nvmeq = NULL;
>  	int result = -EBUSY;
>  
> +	if (likely(q && q->queuedata))
> +		ns = q->queuedata;
> +	if (unlikely(!ns)) {
> +		bio_endio(bio, -ENODEV);
> +		return;
> +	}

This confuses me.  You just checked that q->queuedata was != NULL, now
you're checking that it still wasn't NULL with no barriers or anything
between.  What are you trying to guard against here?

> +#ifdef CONFIG_BLK_DEV_NVME_HP
> +	if (test_bit(NVME_HOT_REM, &ns->dev->hp_flag) ||
> +		!(bio->bi_bdev->bd_disk->flags & GENHD_FL_UP)) {
> +		bio_endio(bio, -ENODEV);
> +		return;
> +	}
> +#endif
> +	nvmeq = get_nvmeq(ns->dev);
> +
>  	if (!nvmeq) {
>  		put_nvmeq(NULL);
>  		bio_endio(bio, -EIO);
> @@ -1120,6 +1169,12 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
>  			.status = cpu_to_le16(NVME_SC_ABORT_REQ << 1),
>  		};
>  
> +#ifdef CONFIG_BLK_DEV_NVME_HP
> +		if (test_bit(NVME_HOT_REM, &nvmeq->dev->hp_flag)) {
> +			cqe.status |= (NVME_SC_INVALID_NS << 1);
> +			info[cmdid].timeout = jiffies - NVME_IO_TIMEOUT;
> +		}
> +#endif
>  		if (timeout && !time_after(now, info[cmdid].timeout))
>  			continue;
>  		if (info[cmdid].ctx == CMD_CTX_CANCELLED)
> @@ -1205,7 +1260,7 @@ static void nvme_disable_queue(struct nvme_dev *dev, int qid)
>  
>  	/* Don't tell the adapter to delete the admin queue.
>  	 * Don't tell a removed adapter to delete IO queues. */
> -	if (qid && readl(&dev->bar->csts) != -1) {
> +	if (qid && !nvme_check_surprise_removal(dev)) {

This isn't really "check surprise removal", it's "nvme_is_present(dev)".

>  		adapter_delete_sq(dev, qid);
>  		adapter_delete_cq(dev, qid);
>  	}
> @@ -1724,6 +1779,13 @@ static void nvme_resubmit_bios(struct nvme_queue *nvmeq)
>  		struct bio *bio = bio_list_pop(&nvmeq->sq_cong);
>  		struct nvme_ns *ns = bio->bi_bdev->bd_disk->private_data;
>  
> +#ifdef CONFIG_BLK_DEV_NVME_HP
> +		if (test_bit(NVME_HOT_REM, &ns->dev->hp_flag) ||
> +			!(bio->bi_bdev->bd_disk->flags & GENHD_FL_UP)) {
> +			bio_endio(bio, -ENODEV);
> +			continue;
> +		}
> +#endif
>  		if (bio_list_empty(&nvmeq->sq_cong))
>  			remove_wait_queue(&nvmeq->sq_full,
>  							&nvmeq->sq_cong_wait);
> @@ -1746,7 +1808,8 @@ static int nvme_kthread(void *data)
>  		spin_lock(&dev_list_lock);
>  		list_for_each_entry_safe(dev, next, &dev_list, node) {
>  			int i;
> -			if (readl(&dev->bar->csts) & NVME_CSTS_CFS &&
> +			if (!nvme_check_surprise_removal(dev) &&
> +				readl(&dev->bar->csts) & NVME_CSTS_CFS &&
>  							dev->initialized) {
>  				if (work_busy(&dev->reset_work))
>  					continue;
> @@ -2082,7 +2145,7 @@ static int nvme_dev_map(struct nvme_dev *dev)
>  	dev->bar = ioremap(pci_resource_start(pdev, 0), 8192);
>  	if (!dev->bar)
>  		goto disable;
> -	if (readl(&dev->bar->csts) == -1) {
> +	if (nvme_check_surprise_removal(dev)) {
>  		result = -ENODEV;
>  		goto unmap;
>  	}
> @@ -2265,7 +2328,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
>  	list_del_init(&dev->node);
>  	spin_unlock(&dev_list_lock);
>  
> -	if (!dev->bar || (dev->bar && readl(&dev->bar->csts) == -1)) {
> +	if (!dev->bar || (dev->bar && nvme_check_surprise_removal(dev))) {
>  		for (i = dev->queue_count - 1; i >= 0; i--) {
>  			struct nvme_queue *nvmeq = dev->queues[i];
>  			nvme_suspend_queue(nvmeq);
> @@ -2534,6 +2597,12 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	dev->initialized = 1;
>  	kref_init(&dev->kref);
> +
> +#ifdef CONFIG_BLK_DEV_NVME_HP
> +	if (!pdev->is_added)
> +		dev_info(&pdev->dev,
> +			"Device 0x%x is on-line\n", pdev->device);
> +#endif
>  	return 0;
>  
>   remove:
> @@ -2556,6 +2625,16 @@ static void nvme_remove(struct pci_dev *pdev)
>  {
>  	struct nvme_dev *dev = pci_get_drvdata(pdev);
>  
> +#ifdef CONFIG_BLK_DEV_NVME_HP
> +	if (!pdev || !dev)
> +		return;

!pdev can't possibly happen, or we crashed on the previous line.

> +	if (nvme_check_surprise_removal(dev)) {
> +		set_bit(NVME_HOT_REM, &dev->hp_flag);
> +		dev_info(&pdev->dev,
> +			"Surprise removal of device 0x%x\n", pdev->device);
> +	}
> +	pci_dev_get(pdev);
> +#endif
>  	pci_set_drvdata(pdev, NULL);
>  	flush_work(&dev->reset_work);
>  	misc_deregister(&dev->miscdev);
> @@ -2565,6 +2644,9 @@ static void nvme_remove(struct pci_dev *pdev)
>  	nvme_release_instance(dev);
>  	nvme_release_prp_pools(dev);
>  	kref_put(&dev->kref, nvme_free_dev);
> +#ifdef CONFIG_BLK_DEV_NVME_HP
> +	pci_dev_put(pdev);

I'm pretty sure you don't need to bump the refcount up and down during
this function.  Look at the caller, pci_stop_dev().  That dereferences
the pci_dev after calling ->remove.  Any bug you could possibly fix by
playing with the reference count here is only going to be hit there when
it sets is_added to 0.
