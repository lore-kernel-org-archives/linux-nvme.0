From: mr.nuke.me@gmail.com (Alex G.)
Date: Wed, 28 Mar 2018 15:13:37 -0500
Subject: [PATCH] nvme-pci: Skip queue deletion if there are no queues
In-Reply-To: <e872954fedc943c08ef11451679d5a2c@AUSX13MPS305.AMER.DELL.COM>
References: <20180328180419.16129-1-keith.busch@intel.com>
 <e872954fedc943c08ef11451679d5a2c@AUSX13MPS305.AMER.DELL.COM>
Message-ID: <d5c52e3e-977d-7f44-bd7d-4ec5b82d39c1@gmail.com>

Hi Keith,

> User reported controller always retains CSTS.RDY to 1, which fails
> controller disabling when resetting the controller. This is also before
> the admin queue is allocated, and trying to disable an unallocated queue
> results in a NULL dereference.
> 
> Reported-by: Alex Gagniuc <Alex_Gagniuc at Dellteam.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index cef5ce851a92..b110eac1d0e6 100644

Which branch am I supposed to be using to test this? It doesn't apply to
mainline.

> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2200,7 +2200,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  
>  	nvme_stop_queues(&dev->ctrl);
>  
> -	if (!dead) {
> +	if (!dead && dev->ctrl.queue_count > 0) {

Is this around the calls to nvme_disable_io_queues() and
nvme_disable_admin_queue()?
Coming as an outsider with limited experience regarding the nvme driver
it seems it might be more robust to move this check to
nvme_disable_admin_queue().

Alex

>  		/*
>  		 * If the controller is still alive tell it to stop using the
>  		 * host memory buffer.  In theory the shutdown / reset should
> 
