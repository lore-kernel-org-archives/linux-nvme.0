From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 16 May 2019 10:43:30 +0800
Subject: [PATCH 1/6] nvme-pci: Fix controller freeze wait disabling
In-Reply-To: <20190515163625.21776-1-keith.busch@intel.com>
References: <20190515163625.21776-1-keith.busch@intel.com>
Message-ID: <20190516024329.GA16342@ming.t460p>

On Wed, May 15, 2019@10:36:20AM -0600, Keith Busch wrote:
> If a controller disabling didn't start a freeze, like when we disable
> whilst in the connecting state, don't wait for freeze to complete.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/pci.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 2a8708c9ac18..d4e442160048 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2376,7 +2376,7 @@ static void nvme_pci_disable(struct nvme_dev *dev)
>  
>  static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  {
> -	bool dead = true;
> +	bool dead = true, freeze = false;
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  
>  	mutex_lock(&dev->shutdown_lock);
> @@ -2384,8 +2384,10 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  		u32 csts = readl(dev->bar + NVME_REG_CSTS);
>  
>  		if (dev->ctrl.state == NVME_CTRL_LIVE ||
> -		    dev->ctrl.state == NVME_CTRL_RESETTING)
> +		    dev->ctrl.state == NVME_CTRL_RESETTING) {
> +			freeze = true;
>  			nvme_start_freeze(&dev->ctrl);
> +		}
>  		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
>  			pdev->error_state  != pci_channel_io_normal);
>  	}
> @@ -2394,10 +2396,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  	 * Give the controller a chance to complete all entered requests if
>  	 * doing a safe shutdown.
>  	 */
> -	if (!dead) {
> -		if (shutdown)
> -			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
> -	}
> +	if (!dead && shutdown && freeze)
> +		nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
>  
>  	nvme_stop_queues(&dev->ctrl);
>  

Looks fine:

Reviewed-by: Ming Lei <ming.lei at rehda.com>


Thanks,
Ming
