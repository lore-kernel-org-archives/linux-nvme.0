From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Mon, 12 Feb 2018 20:57:24 +0800
Subject: [PATCH] nvme-pci: quiesce IO queues prior to disabling device HMB
 accesses
Message-ID: <1518440244-696-1-git-send-email-jianchao.w.wang@oracle.com>

Quiesce IO queues prior to disabling device HMB accesses. A controller
using HMB may relay on it to efficiently complete IO commands.

Reviewed-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ab9c195..4a7c420 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2186,7 +2186,11 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	if (!dead) {
 		if (shutdown)
 			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
+	}
+
+	nvme_stop_queues(&dev->ctrl);
 
+	if (!dead) {
 		/*
 		 * If the controller is still alive tell it to stop using the
 		 * host memory buffer.  In theory the shutdown / reset should
@@ -2195,11 +2199,6 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
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
