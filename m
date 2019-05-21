From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Wed, 22 May 2019 01:04:09 +0900
Subject: [PATCH v2 4/4] nvme-pci: support thermal zone
In-Reply-To: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1558454649-28783-5-git-send-email-akinobu.mita@gmail.com>

This enables to use thermal zone interfaces for NVMe
temperature sensors.

Cc: Zhang Rui <rui.zhang at intel.com>
Cc: Eduardo Valentin <edubezval at gmail.com>
Cc: Daniel Lezcano <daniel.lezcano at linaro.org>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Minwoo Im <minwoo.im.dev at gmail.com>
Cc: Kenneth Heitke <kenneth.heitke at intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni at wdc.com>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
* v2
- Call nvme_thermal_zones_unregister() earlier than the last reference
  release

 drivers/nvme/host/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 04084b9..108b022 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2555,6 +2555,10 @@ static void nvme_reset_work(struct work_struct *work)
 		dev->ctrl.opal_dev = NULL;
 	}
 
+	result = nvme_thermal_zones_register(&dev->ctrl);
+	if (result < 0)
+		goto out;
+
 	if (dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP) {
 		result = nvme_dbbuf_dma_alloc(dev);
 		if (result)
@@ -2833,6 +2837,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	flush_work(&dev->ctrl.reset_work);
 	nvme_stop_ctrl(&dev->ctrl);
 	nvme_remove_namespaces(&dev->ctrl);
+	nvme_thermal_zones_unregister(&dev->ctrl);
 	nvme_dev_disable(dev, true, false);
 	nvme_release_cmb(dev);
 	nvme_free_host_mem(dev);
-- 
2.7.4
