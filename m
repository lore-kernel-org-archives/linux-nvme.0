From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 7 Jun 2018 11:46:53 +0300
Subject: [PATCH 4/6] nvme-pci: Remove HMB teardown on reset
In-Reply-To: <20180606141309.19389-5-keith.busch@intel.com>
References: <20180606141309.19389-1-keith.busch@intel.com>
 <20180606141309.19389-5-keith.busch@intel.com>
Message-ID: <948d3ec4-20a6-d691-685b-5b85447bbf5f@grimberg.me>


> The controller is required to disable its host memory buffer use on
> controller reset.

You mean clearing controller enable?

  We don't need to submit an admin command to delete it,
> so this patch skips sending that command so we don't need to worry about
> handling a timeout.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>   drivers/nvme/host/pci.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index ed9fac721b8c..3a92eb8ffb36 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2215,14 +2215,6 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>   	nvme_stop_queues(&dev->ctrl);
>   
>   	if (!dead && dev->ctrl.queue_count > 0) {
> -		/*
> -		 * If the controller is still alive tell it to stop using the
> -		 * host memory buffer.  In theory the shutdown / reset should
> -		 * make sure that it doesn't access the host memoery anymore,
> -		 * but I'd rather be safe than sorry..
> -		 */
> -		if (dev->host_mem_descs)
> -			nvme_set_host_mem(dev, 0);
>   		nvme_disable_io_queues(dev);
>   		nvme_disable_admin_queue(dev, shutdown);
>   	}
> 
