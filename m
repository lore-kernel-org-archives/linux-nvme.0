From: Alex_Gagniuc@Dellteam.com (Alex_Gagniuc@Dellteam.com)
Date: Wed, 30 Jan 2019 17:22:01 +0000
Subject: [PATCH] nvme-pci: Fix rapid add remove sequence
References: <20190124014611.8643-1-keith.busch@intel.com>
Message-ID: <a916083e58d04ffb8435c5bc84e7f04f@ausx13mps317.AMER.DELL.COM>

On 1/23/19 7:47 PM, Keith Busch wrote:
> A surprise removal may fail to tear down request queues if it is racing
> with the initial asynchronous probe. If that happens, the remove path
> won't see the queue resources to tear down, and the controller reset
> path may create a new request queue on a removed device, but will not
> be able to make forward progress, deadlocking the pci removal.
> 
> Protect setting up non-blocking resources from a shutdown by holding the
> same mutex, and transition to the CONNECTING state after these resources
> are initialized so the probe path may see the dead controller state
> before dispatching new IO.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202081
> Reported-by: Alex Gagniuc <Alex_Gagniuc at Dellteam.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Tested-by: Alex Gagniuc <mr.nuke.me at gmail.com>

> ---
>   drivers/nvme/host/pci.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 9bc585415d9b..022ea1ee63f8 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2557,16 +2557,7 @@ static void nvme_reset_work(struct work_struct *work)
>   	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
>   		nvme_dev_disable(dev, false);
>   
> -	/*
> -	 * Introduce CONNECTING state from nvme-fc/rdma transports to mark the
> -	 * initializing procedure here.
> -	 */
> -	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_CONNECTING)) {
> -		dev_warn(dev->ctrl.device,
> -			"failed to mark controller CONNECTING\n");
> -		goto out;
> -	}
> -
> +	mutex_lock(&dev->shutdown_lock);
>   	result = nvme_pci_enable(dev);
>   	if (result)
>   		goto out;
> @@ -2585,6 +2576,17 @@ static void nvme_reset_work(struct work_struct *work)
>   	 */
>   	dev->ctrl.max_hw_sectors = NVME_MAX_KB_SZ << 1;
>   	dev->ctrl.max_segments = NVME_MAX_SEGS;
> +	mutex_unlock(&dev->shutdown_lock);
> +
> +	/*
> +	 * Introduce CONNECTING state from nvme-fc/rdma transports to mark the
> +	 * initializing procedure here.
> +	 */
> +	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_CONNECTING)) {
> +		dev_warn(dev->ctrl.device,
> +			"failed to mark controller CONNECTING\n");
> +		goto out;
> +	}
>   
>   	result = nvme_init_identify(&dev->ctrl);
>   	if (result)
> 
