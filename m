From: kbusch@kernel.org (Keith Busch)
Date: Wed, 22 May 2019 14:09:18 -0600
Subject: [RFC PATCH] nvme: Ignore timeouts while a PCIe reset is pending
In-Reply-To: <20190522192656.GB5486@localhost.localdomain>
References: <20190522003741.26755-1-kenneth.heitke@intel.com>
 <20190522192656.GB5486@localhost.localdomain>
Message-ID: <20190522200918.GC5486@localhost.localdomain>

On Wed, May 22, 2019@01:26:57PM -0600, Keith Busch wrote:
> The disable reclaims all commands, including the ones it dispatches, so
> it sounds like you're talking about a race between the ones it dispatched
> and its timeout work. If so, we can just make sure commands sent during
> nvme_dev_disable never timeout, which are just the delete queue commands:
> 
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index f562154551ce..4678704c2138 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2210,7 +2210,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
>  	if (IS_ERR(req))
>  		return PTR_ERR(req);
>  
> -	req->timeout = ADMIN_TIMEOUT;
> +	req->timeout = UINT_MAX;
>  	req->end_io_data = nvmeq;
>  
>  	init_completion(&nvmeq->delete_done);
> --

I think we should do the above anyway, but it isn't going to help if
commands dispatched outside disabling timeout. This should fix that.
Note, we never needed to have a sync'ed reset on reset_done(), but
this makes it necessary.

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f562154551ce..3edb9d098eb8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1257,13 +1257,14 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	struct nvme_dev *dev = nvmeq->dev;
 	struct request *abort_req;
 	struct nvme_command cmd;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
 	/* If PCI error recovery process is happening, we cannot reset or
 	 * the recovery mechanism will surely fail.
 	 */
 	mb();
-	if (pci_channel_offline(to_pci_dev(dev->dev)))
+	if (pci_channel_offline(pdev) || pdev->block_cfg_access)
 		return BLK_EH_RESET_TIMER;
 
 	/*
@@ -2782,12 +2783,13 @@ static void nvme_reset_prepare(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 	nvme_dev_disable(dev, false);
+	nvme_sync_queues(&dev->ctrl);
 }
 
 static void nvme_reset_done(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-	nvme_reset_ctrl_sync(&dev->ctrl);
+	nvme_reset_ctrl(&dev->ctrl);
 }
 
 static void nvme_shutdown(struct pci_dev *pdev)
--
