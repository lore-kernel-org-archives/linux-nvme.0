From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Sun, 11 Feb 2018 17:38:35 +0800
Subject: [PATCH 4/9] nvme-pci: quiesce IO queues prior to disabling device HMB
 accesses
In-Reply-To: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1518341920-1060-5-git-send-email-jianchao.w.wang@oracle.com>

Quiesce IO queues prior to disabling device HMB accesses. A controller
using HMB may relay on it to efficiently complete IO commands.

Reviewed-by: Keith Busch <keith.busch at intel.com>
Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6fe7af0..00cffed 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2186,7 +2186,10 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	if (!dead) {
 		if (shutdown)
 			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
+	}
+	nvme_stop_queues(&dev->ctrl);
 
+	if (!dead) {
 		/*
 		 * If the controller is still alive tell it to stop using the
 		 * host memory buffer.  In theory the shutdown / reset should
@@ -2195,11 +2198,6 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		 */
 		if (dev->host_mem_descs)
 			nvme_set_host_mem(dev, 0);
-
-	}
-	nvme_stop_queues(&dev->ctrl);
-
-	if (!dead) {
 		nvme_disable_io_queues(dev);
 		nvme_disable_admin_queue(dev, shutdown);
 	}
-- 
2.7.4
