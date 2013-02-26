From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 26 Feb 2013 09:04:58 -0500
Subject: [PATCH 2/8] NVMe: Controller reset from user
In-Reply-To: <1361404365-18982-2-git-send-email-keith.busch@intel.com>
References: <1361404365-18982-1-git-send-email-keith.busch@intel.com>
 <1361404365-18982-2-git-send-email-keith.busch@intel.com>
Message-ID: <20130226140458.GE4530@linux.intel.com>

On Wed, Feb 20, 2013@04:52:39PM -0700, Keith Busch wrote:
> Allow a user to issue a controller reset. A reset does not delete the
> gendisks so that IO may continue, or the namespaces may be mounted. This
> may be done by a user if they need to reset the controller for any reason,
> like if it is required as part of an activate firmware operation.

> @@ -265,11 +266,18 @@ static void *cancel_cmdid(struct nvme_queue *nvmeq, int cmdid,
>  
>  static struct nvme_queue *get_nvmeq(struct nvme_dev *dev)
>  {
> -	return dev->queues[get_cpu() + 1];
> +	struct nvme_queue *nvmeq;
> +	spin_lock(&dev->dev_lock);
> +	nvmeq = dev->queues[get_cpu() + 1];
> +	if (nvmeq)
> +		atomic_inc(&nvmeq->busy);
> +	spin_unlock(&dev->dev_lock);
> +	return nvmeq;
>  }

OK, we can't do this.  Right now, submitting an I/O is entirely per-CPU
... this introduces cacheline contention for the dev_lock.  Even if it's
never contended, the cacheline has to be obtained from the other CPU,
so it'll be a major slowdown for large systems, and destroys scaling.

We have options to fix this.  Here are a few:

1. Use RCU.  You can find it documented in Documentation/RCU/ but the basic
idea is to use ordering to protect against future users of the queue, and
then wait for all existing users to be done with it before freeing it.

2. Avoid freeing the queue.  When resetting the controller, we don't
actually have to free the memory and then reallocate it; we can reprogram
the controller when it comes back up with the addresses that this memory
already has.  So what we could do is put a single bit in nvme_queue
... call it something like q_suspended, and check it thusly:

 static struct nvme_queue *get_nvmeq(struct nvme_dev *dev)
 {
-	return dev->queues[get_cpu() + 1];
+	struct nvme_queue *nvmeq = dev->queues[get_cpu() + 1];
+	if (nvmeq->q_suspended) {
+		put_cpu();
+		return NULL;
+ 	} else {
+ 		nvmeq->q_usage++;
+		return nvmeq;
+ 	}
 }

I think q_usage can be a simple variable at this point ... unless you
see a reason for it to be atomic?

> @@ -1630,6 +1660,108 @@ static void nvme_release_instance(struct nvme_dev *dev)
>  	spin_unlock(&dev_list_lock);
>  }
>  
> +static int nvme_shutdown_controller(struct nvme_dev *dev)
> +{
> +	int i;
> +	unsigned long timeout;
> +
> +	spin_lock(&dev_list_lock);
> +	list_del(&dev->node);
> +	spin_unlock(&dev_list_lock);
> +
> +	spin_lock(&dev->dev_lock);
> +	for (i = dev->queue_count; i < num_possible_cpus(); i++)
> +		dev->queues[i] = NULL;
> +	spin_unlock(&dev->dev_lock);
> +	nvme_free_queues(dev);
> +
> +	dev->ctrl_config |= NVME_CC_SHN_NORMAL;
> +	writel(dev->ctrl_config, &dev->bar->cc);
> +	timeout = HZ + jiffies;
> +
> +	while (!(readl(&dev->bar->csts) & NVME_CSTS_SHST_CMPLT)) {
> +		msleep(5);
> +		if (fatal_signal_pending(current))
> +			break;
> +		if (time_after(jiffies, timeout)) {
> +			dev_err(&dev->pci_dev->dev,
> +				"Device still ready; aborting shutdown\n");
> +			break;
> +		}
> +	}
> +
> +	pci_disable_msix(dev->pci_dev);
> +	iounmap(dev->bar);
> +	pci_disable_device(dev->pci_dev);
> +	pci_release_regions(dev->pci_dev);
> +
> +	return 0;
> +}
> +
> +static int nvme_restart_controller(struct nvme_dev *dev)
> +{
> +	int bars, result = -ENOMEM;
> +
> +	if (pci_enable_device_mem(dev->pci_dev))
> +		return -ENOMEM;
> +
> +	pci_set_master(dev->pci_dev);
> +	bars = pci_select_bars(dev->pci_dev, IORESOURCE_MEM);
> +	if (pci_request_selected_regions(dev->pci_dev, bars, "nvme"))
> +		goto disable_pci;
> +
> +	dma_set_mask(&dev->pci_dev->dev, DMA_BIT_MASK(64));
> +	dma_set_coherent_mask(&dev->pci_dev->dev, DMA_BIT_MASK(64));
> +	dev->entry[0].vector = dev->pci_dev->irq;
> +	dev->bar = ioremap(pci_resource_start(dev->pci_dev, 0), 8192);
> +	if (!dev->bar)
> +		goto disable;
> +
> +	result = nvme_configure_admin_queue(dev);
> +	if (result)
> +		goto unmap;
> +	dev->queue_count++;
> +
> +	spin_lock(&dev_list_lock);
> +	list_add(&dev->node, &dev_list);
> +	spin_unlock(&dev_list_lock);
> +
> +	result = nvme_setup_io_queues(dev);
> +	if (result)
> +		goto remove;
> +
> +	return 0;
> +
> + remove:
> +	nvme_dev_remove(dev);
> + unmap:
> +	iounmap(dev->bar);
> + disable:
> +	pci_release_regions(dev->pci_dev);
> + disable_pci:
> +	pci_disable_device(dev->pci_dev);
> +	return result;
> +}
> +
> +static int nvme_reset_controller(struct nvme_dev *dev)
> +{
> +	int ret = nvme_shutdown_controller(dev);
> +	if (ret)
> +		return ret;
> +	ret = nvme_restart_controller(dev);
> +	return ret;
> +}
> +
> +static ssize_t reset_controller(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct pci_dev  *pdev = container_of(dev, struct pci_dev, dev);
> +	struct nvme_dev *ndev = pci_get_drvdata(pdev);
> +	nvme_reset_controller(ndev);
> +	return count;
> +}
> +static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, reset_controller);
> +
>  static int __devinit nvme_probe(struct pci_dev *pdev,
>  						const struct pci_device_id *id)
>  {

The problem with this implementation of reset controller is that it
requires the controller to be sufficiently alive to process admin
commands.  I think we need reset controller to be able to work if the
admin queue is broken for some reason.  So just whacking the config
register, waiting for it to complete, then reprogramming the registers,
and resending all the admin init commands seems like the right move to me.
