From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Thu, 25 Jan 2018 15:55:16 +0800
Subject: [PATCVH v2] nvme/pci: Suspend queues after deleting them
In-Reply-To: <20180124215512.17976-1-keith.busch@intel.com>
References: <20180124215512.17976-1-keith.busch@intel.com>
Message-ID: <d6cc5947-dd88-7810-b4c5-18e3282345a1@oracle.com>

Hi Keith

Thanks for your patch.

Test ok with looping reset controller and fio.
Host: ThinkCentre-M910s
Target: INTEL SSDPEKKR128G7


Thanks
Jianchao

On 01/25/2018 05:55 AM, Keith Busch wrote:
> The driver had been abusing the cq_vector state to know if new submissions
> were safe, but that was before we could quiesce blk-mq. If the controller
> happens to get an interrupt through while we're suspending those queues,
> 'no irq handler' warnings may occur.
> 
> This patch will disable the interrupts only after the queues are deleted.
> 
> Reported-by: Jianchao Wang <jianchao.w.wang at oracle.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> v1 -> v2:
> 
>   Forgot to subtract 1 from the online queues. It happened to pass the
>   test, but still not correct.
> 
>  drivers/nvme/host/pci.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c46c239cc1ff..e2342d365d3c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1324,9 +1324,6 @@ static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
>  {
>  	struct nvme_queue *nvmeq = &dev->queues[0];
>  
> -	if (nvme_suspend_queue(nvmeq))
> -		return;
> -
>  	if (shutdown)
>  		nvme_shutdown_ctrl(&dev->ctrl);
>  	else
> @@ -2011,9 +2008,9 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
>  	return 0;
>  }
>  
> -static void nvme_disable_io_queues(struct nvme_dev *dev, int queues)
> +static void nvme_disable_io_queues(struct nvme_dev *dev)
>  {
> -	int pass;
> +	int pass, queues = dev->online_queues - 1;
>  	unsigned long timeout;
>  	u8 opcode = nvme_admin_delete_sq;
>  
> @@ -2164,7 +2161,7 @@ static void nvme_pci_disable(struct nvme_dev *dev)
>  
>  static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  {
> -	int i, queues;
> +	int i;
>  	bool dead = true;
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  
> @@ -2199,21 +2196,13 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  	}
>  	nvme_stop_queues(&dev->ctrl);
>  
> -	queues = dev->online_queues - 1;
> -	for (i = dev->ctrl.queue_count - 1; i > 0; i--)
> -		nvme_suspend_queue(&dev->queues[i]);
> -
> -	if (dead) {
> -		/* A device might become IO incapable very soon during
> -		 * probe, before the admin queue is configured. Thus,
> -		 * queue_count can be 0 here.
> -		 */
> -		if (dev->ctrl.queue_count)
> -			nvme_suspend_queue(&dev->queues[0]);
> -	} else {
> -		nvme_disable_io_queues(dev, queues);
> +	if (!dead) {
> +		nvme_disable_io_queues(dev);
>  		nvme_disable_admin_queue(dev, shutdown);
>  	}
> +	for (i = dev->ctrl.queue_count - 1; i >= 0; i--)
> +		nvme_suspend_queue(&dev->queues[i]);
> +
>  	nvme_pci_disable(dev);
>  
>  	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
> 
