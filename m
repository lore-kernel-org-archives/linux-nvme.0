From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 28 May 2019 13:01:07 -0700
Subject: [RFC PATCH] nvme: allowing transition from NVME_CTRL_NEW to
 NVME_CTRL_DELETING
In-Reply-To: <20190527040159.3631-1-lizhongfs@gmail.com>
References: <20190527040159.3631-1-lizhongfs@gmail.com>
Message-ID: <305425a3-a815-7842-85ec-eb4275d39780@grimberg.me>


> It is possible that nvme_remove() being ran concurrently with
> nvme_reset_work(), with following sequence:
> 
> nvme_probe()
>    nvme_init_ctrl()
>      //set to NEW
>    nvme_async_probe()
>                                                        nvme_remove()
>                                                          //can not change to
>                                                          //DELETING from NEW
>      nvme_reset_ctrl_sync()
>          nvme_reset_ctrl()
>            //change from NEW
>            //to RESETTING
>                                                         flush reset_work()
>                                                         //not yet queued
>            queue reset_work
>              nvme_reset_work()
>                ....                                     ....
> 
> With the above running concurrently, then it is possible to cause some
> strange issues, like kernel crash with illegal memory accessing
> or something like:
> kernel: pci 0000:00:1f.0: can't enable device: BAR 0
>   [mem 0xc0000000-0xc0003fff] not claimed
> 

How about making nvme_remove syncing the async probe?
Something like this:
--
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2a8708c9ac18..33408ffa4ba3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -131,6 +131,7 @@ struct nvme_dev {
         dma_addr_t host_mem_descs_dma;
         struct nvme_host_mem_buf_desc *host_mem_descs;
         void **host_mem_desc_bufs;
+       async_cookie_t async_probe;
  };

  static int io_queue_depth_set(const char *val, const struct 
kernel_param *kp)
@@ -2759,7 +2760,7 @@ static int nvme_probe(struct pci_dev *pdev, const 
struct pci_device_id *id)
         dev_info(dev->ctrl.device, "pci function %s\n", 
dev_name(&pdev->dev));

         nvme_get_ctrl(&dev->ctrl);
-       async_schedule(nvme_async_probe, dev);
+       dev->async_probe = async_schedule(nvme_async_probe, dev);

         return 0;

@@ -2804,6 +2805,7 @@ static void nvme_remove(struct pci_dev *pdev)
  {
         struct nvme_dev *dev = pci_get_drvdata(pdev);

+       async_synchronize_cookie(dev->async_probe);
         nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
         pci_set_drvdata(pdev, NULL);
--
