From: kbusch@kernel.org (Keith Busch)
Date: Tue, 23 Jul 2019 14:46:43 -0600
Subject: [PATCH] nvme-pci: fix probe and remove race
In-Reply-To: <20190719194256.23618-1-sagi@grimberg.me>
References: <20190719194256.23618-1-sagi@grimberg.me>
Message-ID: <20190723204643.GC4002@localhost.localdomain>

On Fri, Jul 19, 2019@12:42:56PM -0700, Sagi Grimberg wrote:
> It is possible that nvme_remove() being ran concurrently with
> nvme_reset_work(), with following sequence:
> 
> nvme_probe()
>   nvme_init_ctrl()
>     //set to NEW
>   nvme_async_probe()
>                                                       nvme_remove()
>                                                         //can not change to
>                                                         //DELETING from NEW
>     nvme_reset_ctrl_sync()
>         nvme_reset_ctrl()
>           //change from NEW
>           //to RESETTING
>                                                        flush reset_work()
>                                                        //not yet queued
>           queue reset_work
>             nvme_reset_work()
>               ....                                     ....
> 
> With the above running concurrently, then it is possible to cause some
> strange issues, like kernel crash with illegal memory accessing
> or something like:
> kernel: pci 0000:00:1f.0: can't enable device: BAR 0
>  [mem 0xc0000000-0xc0003fff] not claimed
> 
> Fix this by waiting for the async probe to complete before allowing
> remove to make forward progress.
> 
> Reported-by: Li Zhong <lizhongfs at gmail.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

I still think we'd prefer not adding that async domain dependency and
relying on timeout to unstuck a hot-removal. So how about we schedule
the reset work in probe and have the async part just flush the reset
and scan work?

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index db160cee42ad..0c2c4b0c6655 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2695,7 +2695,7 @@ static void nvme_async_probe(void *data, async_cookie_t cookie)
 {
 	struct nvme_dev *dev = data;
 
-	nvme_reset_ctrl_sync(&dev->ctrl);
+	flush_work(&dev->ctrl.reset_work);
 	flush_work(&dev->ctrl.scan_work);
 	nvme_put_ctrl(&dev->ctrl);
 }
@@ -2761,6 +2761,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
+	nvme_reset_ctrl(&dev->ctrl);
 	nvme_get_ctrl(&dev->ctrl);
 	async_schedule(nvme_async_probe, dev);
 
--
