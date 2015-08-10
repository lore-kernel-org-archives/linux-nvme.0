From: keith.busch@intel.com (Keith Busch)
Date: Mon, 10 Aug 2015 15:20:40 -0600
Subject: [RESEND PATCH 1/2] NVMe: Add nvme subsystem reset support
Message-ID: <1439241641-3444-1-git-send-email-keith.busch@intel.com>

Controllers part of an NVMe subsystem may be reset by any other controller
in the subsystem. If the device is capable of subsystem resets, this
patch adds detection for such events and performs appropriate controller
initialization upon subsystem reset detection.

The register bit is a RW1C type, so the driver needs to write a 1 to the
status bit to clear the subsystem reset occured bit during initialization.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   11 ++++++++++-
 include/linux/nvme.h      |    3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7e9dd11..4e19c8a 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1696,6 +1696,12 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 		page_shift = dev_page_max;
 	}
 
+	dev->subsystem = readl(&dev->bar->vs) >= NVME_VS(1, 1) ?
+						NVME_CAP_NSSRC(cap) : 0;
+
+	if (dev->subsystem && (readl(&dev->bar->csts) & NVME_CSTS_NSSRO))
+		writel(NVME_CSTS_NSSRO, &dev->bar->csts);
+
 	result = nvme_disable_ctrl(dev, cap);
 	if (result < 0)
 		return result;
@@ -2020,7 +2026,10 @@ static int nvme_kthread(void *data)
 		spin_lock(&dev_list_lock);
 		list_for_each_entry_safe(dev, next, &dev_list, node) {
 			int i;
-			if (readl(&dev->bar->csts) & NVME_CSTS_CFS) {
+			u32 csts = readl(&dev->bar->csts);
+
+			if ((dev->subsystem && (csts & NVME_CSTS_NSSRO)) ||
+							csts & NVME_CSTS_CFS) {
 				if (work_busy(&dev->reset_work))
 					continue;
 				list_del_init(&dev->node);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c0d94ed..a566b41 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -37,6 +37,7 @@ struct nvme_bar {
 #define NVME_CAP_MQES(cap)	((cap) & 0xffff)
 #define NVME_CAP_TIMEOUT(cap)	(((cap) >> 24) & 0xff)
 #define NVME_CAP_STRIDE(cap)	(((cap) >> 32) & 0xf)
+#define NVME_CAP_NSSRC(cap)	(((cap) >> 36) & 0x1)
 #define NVME_CAP_MPSMIN(cap)	(((cap) >> 48) & 0xf)
 #define NVME_CAP_MPSMAX(cap)	(((cap) >> 52) & 0xf)
 
@@ -55,6 +56,7 @@ enum {
 	NVME_CC_IOCQES		= 4 << 20,
 	NVME_CSTS_RDY		= 1 << 0,
 	NVME_CSTS_CFS		= 1 << 1,
+	NVME_CSTS_NSSRO		= 1 << 4,
 	NVME_CSTS_SHST_NORMAL	= 0 << 2,
 	NVME_CSTS_SHST_OCCUR	= 1 << 2,
 	NVME_CSTS_SHST_CMPLT	= 2 << 2,
@@ -97,6 +99,7 @@ struct nvme_dev {
 	char serial[20];
 	char model[40];
 	char firmware_rev[8];
+	bool subsystem;
 	u32 max_hw_sectors;
 	u32 stripe_size;
 	u32 page_size;
-- 
1.7.10.4
