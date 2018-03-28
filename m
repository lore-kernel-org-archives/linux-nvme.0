From: mr.nuke.me@gmail.com (Alex G.)
Date: Wed, 28 Mar 2018 16:02:01 -0500
Subject: [PATCH] nvme-pci: Skip queue deletion if there are no queues
In-Reply-To: <20180328202240.GK13039@localhost.localdomain>
References: <20180328180419.16129-1-keith.busch@intel.com>
 <e872954fedc943c08ef11451679d5a2c@AUSX13MPS305.AMER.DELL.COM>
 <d5c52e3e-977d-7f44-bd7d-4ec5b82d39c1@gmail.com>
 <20180328202240.GK13039@localhost.localdomain>
Message-ID: <a799ef7c-22af-24c2-8c14-bc5d0672bdeb@gmail.com>

On 03/28/2018 03:22 PM, Keith Busch wrote:
> On Wed, Mar 28, 2018@03:13:37PM -0500, Alex G. wrote:
>> Which branch am I supposed to be using to test this? It doesn't apply to
>> mainline.
> 
> This is targeted to the 4.17 staging trees (sorry, this doesn't seem to
> be a good 4.16 candidate this late in the game). This should apply on
> linux-block for-4.17/block here:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-4.17/block

Then I should probably test with that.
Tested-by: Alex Gagniuc <Alex_Gagniuc at Dellteam.com>

So I see the check is really meant to protect dereferencing
&dev->queues[0] in nvme_disable_admin_queue(). My previous comment is
still valid then. Successfully tested this approach as well.

Thanks for the quick turn-around.

Alex

> 
> A 4.16 port would would like this:
> 
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b6f43b738f03..2459067d208b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2194,7 +2194,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  	 * Give the controller a chance to complete all entered requests if
>  	 * doing a safe shutdown.
>  	 */
> -	if (!dead) {
> +	if (!dead && dev->ctrl.queue_count > 0) {
>  		if (shutdown)
>  			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
>  
> --
> 
