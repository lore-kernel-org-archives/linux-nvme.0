From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 19 Jul 2019 12:42:56 -0700
Subject: [PATCH] nvme-pci: fix probe and remove race
Message-ID: <20190719194256.23618-1-sagi@grimberg.me>

It is possible that nvme_remove() being ran concurrently with
nvme_reset_work(), with following sequence:

nvme_probe()
  nvme_init_ctrl()
    //set to NEW
  nvme_async_probe()
                                                      nvme_remove()
                                                        //can not change to
                                                        //DELETING from NEW
    nvme_reset_ctrl_sync()
        nvme_reset_ctrl()
          //change from NEW
          //to RESETTING
                                                       flush reset_work()
                                                       //not yet queued
          queue reset_work
            nvme_reset_work()
              ....                                     ....

With the above running concurrently, then it is possible to cause some
strange issues, like kernel crash with illegal memory accessing
or something like:
kernel: pci 0000:00:1f.0: can't enable device: BAR 0
 [mem 0xc0000000-0xc0003fff] not claimed

Fix this by waiting for the async probe to complete before allowing
remove to make forward progress.

Reported-by: Li Zhong <lizhongfs at gmail.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4b508d5e45cf..50061abe49c6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -127,6 +127,7 @@ struct nvme_dev {
 	dma_addr_t host_mem_descs_dma;
 	struct nvme_host_mem_buf_desc *host_mem_descs;
 	void **host_mem_desc_bufs;
+	async_cookie_t async_probe;
 };
 
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
@@ -2765,7 +2766,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
 	nvme_get_ctrl(&dev->ctrl);
-	async_schedule(nvme_async_probe, dev);
+	dev->async_probe = async_schedule(nvme_async_probe, dev);
 
 	return 0;
 
@@ -2810,6 +2811,8 @@ static void nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
+	/* wait for async probe to complete */
+	async_synchronize_cookie(dev->async_probe + 1);
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	pci_set_drvdata(pdev, NULL);
 
-- 
2.17.1
