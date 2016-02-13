From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 13 Feb 2016 01:58:51 -0800
Subject: [PATCH 1/2] NVMe: Lock out shutdown during pci init
In-Reply-To: <1455231626-7166-1-git-send-email-keith.busch@intel.com>
References: <1455231626-7166-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160213095851.GA15206@infradead.org>

On Thu, Feb 11, 2016@04:00:25PM -0700, Keith Busch wrote:
> An unexpected driver unbind needs to be prevented from unmapping the
> pci nvme registers while they're being initialized.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/pci.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 1b0e447..24a7972 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1927,13 +1927,19 @@ static void nvme_reset_work(struct work_struct *work)
>  
>  	set_bit(NVME_CTRL_RESETTING, &dev->flags);
>  
> +	/*
> +	 * Lock out shutdown so an unexpected driver removal won't unmap
> +	 * registers while reset work is setting them up.
> +	 */
> +	mutex_lock(&dev->shutdown_lock);
>  	result = nvme_dev_map(dev);
>  	if (result)
> -		goto out;
> +		goto out_unlock;
>  
>  	result = nvme_configure_admin_queue(dev);
>  	if (result)
> -		goto out;
> +		goto out_unlock;
> +	mutex_unlock(&dev->shutdown_lock);

Seems like we should be holding the lock over the call
to nvme_dev_disable to get protection for the whole execution,
e.g. by adding a __nvme_dev_disable variant that expects the lock
to be held.

Maybe it's also worth renaming shutdown_lock to register_mutex
or similar to better document what it protects.

>  
>  	nvme_init_queue(dev->queues[0], 0);
>  	result = nvme_alloc_admin_tags(dev);
> @@ -1970,6 +1976,8 @@ static void nvme_reset_work(struct work_struct *work)
>  	clear_bit(NVME_CTRL_RESETTING, &dev->flags);
>  	return;
>  
> + out_unlock:
> +	mutex_unlock(&dev->shutdown_lock);
>   out:
>  	nvme_remove_dead_ctrl(dev, result);
>  }
> -- 
> 2.6.2.307.g37023ba
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
---end quoted text---
