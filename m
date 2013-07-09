From: keith.busch@intel.com (Keith Busch)
Date: Tue,  9 Jul 2013 14:20:40 -0600
Subject: [PATCHv4 4/5] NVMe: Use normal shutdown
In-Reply-To: <1373401241-20259-1-git-send-email-keith.busch@intel.com>
References: <1373401241-20259-1-git-send-email-keith.busch@intel.com>
Message-ID: <1373401241-20259-5-git-send-email-keith.busch@intel.com>

The NVMe spec recommends using the shutdown normal sequence when safely
taking the controller offline instead of hitting CC.EN on the next
start-up to reset the controller. The spec recommends a minimum of 1
second for the shutdown complete. This patch waits 2 seconds to be on
the safe side.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   26 ++++++++++++++++++++++++++
 include/linux/nvme.h      |    2 ++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 0d28015..1af943d 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1223,6 +1223,30 @@ static int nvme_enable_ctrl(struct nvme_dev *dev, u64 cap)
 	return nvme_wait_ready(dev, cap, true);
 }
 
+static int nvme_shutdown_ctrl(struct nvme_dev *dev)
+{
+	unsigned long timeout;
+	u32 cc;
+
+	cc = (readl(&dev->bar->cc) & ~NVME_CC_SHN_MASK) | NVME_CC_SHN_NORMAL;
+	writel(cc, &dev->bar->cc);
+
+	timeout = 2 * HZ + jiffies;
+	while ((readl(&dev->bar->csts) & NVME_CSTS_SHST_MASK) !=
+							NVME_CSTS_SHST_CMPLT) {
+		msleep(100);
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		if (time_after(jiffies, timeout)) {
+			dev_err(&dev->pci_dev->dev,
+				"Device shutdown incomplete; abort shutdown\n");
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
 static int nvme_configure_admin_queue(struct nvme_dev *dev)
 {
 	int result;
@@ -1959,6 +1983,8 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 	list_del_init(&dev->node);
 	spin_unlock(&dev_list_lock);
 
+	if (dev->bar)
+		nvme_shutdown_ctrl(dev);
 	nvme_dev_unmap(dev);
 }
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 8d00415..946771f 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -53,6 +53,7 @@ enum {
 	NVME_CC_SHN_NONE	= 0 << 14,
 	NVME_CC_SHN_NORMAL	= 1 << 14,
 	NVME_CC_SHN_ABRUPT	= 2 << 14,
+	NVME_CC_SHN_MASK	= 3 << 14,
 	NVME_CC_IOSQES		= 6 << 16,
 	NVME_CC_IOCQES		= 4 << 20,
 	NVME_CSTS_RDY		= 1 << 0,
@@ -60,6 +61,7 @@ enum {
 	NVME_CSTS_SHST_NORMAL	= 0 << 2,
 	NVME_CSTS_SHST_OCCUR	= 1 << 2,
 	NVME_CSTS_SHST_CMPLT	= 2 << 2,
+	NVME_CSTS_SHST_MASK	= 3 << 2,
 };
 
 #define NVME_VS(major, minor)	(major << 16 | minor)
-- 
1.7.0.4
