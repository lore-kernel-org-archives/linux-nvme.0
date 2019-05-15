From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Thu, 16 May 2019 00:17:17 +0900
Subject: [PATCH 2/2] nvme-pci: support thermal zone
In-Reply-To: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1557933437-4693-3-git-send-email-akinobu.mita@gmail.com>

This enables to use thermal zone interfaces for NVMe
temperature sensors.

Cc: Zhang Rui <rui.zhang at intel.com>
Cc: Eduardo Valentin <edubezval at gmail.com>
Cc: Daniel Lezcano <daniel.lezcano at linaro.org>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
 drivers/nvme/host/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fad5395..88a25dc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2470,6 +2470,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	if (dev->ctrl.admin_q)
 		blk_put_queue(dev->ctrl.admin_q);
 	kfree(dev->queues);
+	nvme_thermal_zones_unregister(&dev->ctrl);
 	free_opal_dev(dev->ctrl.opal_dev);
 	mempool_destroy(dev->iod_mempool);
 	kfree(dev);
@@ -2553,6 +2554,10 @@ static void nvme_reset_work(struct work_struct *work)
 		dev->ctrl.opal_dev = NULL;
 	}
 
+	result = nvme_thermal_zones_register(&dev->ctrl);
+	if (result < 0)
+		goto out;
+
 	if (dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP) {
 		result = nvme_dbbuf_dma_alloc(dev);
 		if (result)
-- 
2.7.4
