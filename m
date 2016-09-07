From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Tue, 06 Sep 2016 17:07:22 -0700
Subject: [PATCH] nvme: Don't suspend admin queue that wasn't created
In-Reply-To: <1473194353-2472-1-git-send-email-krisman@linux.vnet.ibm.com>
References: <1473194353-2472-1-git-send-email-krisman@linux.vnet.ibm.com>
Message-ID: <1473206842.8256.19.camel@linux.intel.com>

On Tue, 2016-09-06@17:39 -0300, Gabriel Krisman Bertazi wrote:
> This fixes a regression in my previous commit c21377f8366c ("nvme:
> Suspend all queues before deletion"), which provoked an Oops in the
> removal path when removing a device that became IO incapable very
> early
> at probe (i.e. after a failed EEH recovery).
> 
> Turns out, if the error occurred very early at the probe path, before
> even configuring the admin queue, we might try to suspend the
> uninitialized admin queue, accessing bad memory.
> 
> Fixes: c21377f8366c ("nvme: Suspend all queues before deletion")
> Signed-off-by: Gabriel Krisman Bertazi <krisman at linux.vnet.ibm.com>
> ---
> ?drivers/nvme/host/pci.c | 7 ++++++-
> ?1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8dcf5a960951..be84a84a40f7 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1693,7 +1693,12 @@ static void nvme_dev_disable(struct nvme_dev
> *dev, bool shutdown)
> ?		nvme_suspend_queue(dev->queues[i]);
> ?
> ?	if (csts & NVME_CSTS_CFS || !(csts & NVME_CSTS_RDY)) {
> -		nvme_suspend_queue(dev->queues[0]);
> +		/* A device might become IO incapable very soon
> during
> +		?* probe, before the admin queue is configured.
> Thus,
> +		?* queue_count can be 0 here.
> +		?*/
> +		if (dev->queue_count)
> +			nvme_suspend_queue(dev->queues[0]);

Looks like ?a good fix to me.

Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
