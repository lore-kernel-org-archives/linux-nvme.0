From: m.mizuma@jp.fujitsu.com (Masayoshi Mizuma)
Date: Mon, 4 Jul 2016 17:33:20 +0900
Subject: [PATCH] nvme: add a module parameter to change queue depth
Message-ID: <577A1F50.4070502@jp.fujitsu.com>

This patch adds "q_depth_limit" as a module parameter. nvme_queue->q_depth
is set below q_depth_limit.

while loop at __nvme_process_cq() sometimes takes long time and
the loop is under IRQ context, so system slow down and hardlockup
may occur because of the loop.

The while loop runs nvme_queue->q_depth times and the q_depth is set
by the following (NVME_Q_DEPTH is 1024).

 dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, NVME_Q_DEPTH);

To reduce the times of the loop, the q_depth_limit is useful.

In addition, this patch moves the temporary fix for the Apple controller
into the new function, get_q_depth().

Signed-off-by: Masayoshi Mizuma <m.mizuma at jp.fujitsu.com>
---
 drivers/nvme/host/pci.c | 46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index befac5b..8581c41 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -63,6 +63,10 @@ static bool use_cmb_sqes = true;
 module_param(use_cmb_sqes, bool, 0644);
 MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
 
+static int q_depth_limit = NVME_Q_DEPTH;
+module_param(q_depth_limit, int, S_IRUGO);
+MODULE_PARM_DESC(q_depth_limit, "queue depth is set below this value");
+
 static struct workqueue_struct *nvme_workq;
 
 struct nvme_dev;
@@ -1613,6 +1617,35 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	return 0;
 }
 
+static int get_q_depth(struct nvme_dev *dev, u64 cap)
+{
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	int q_depth;
+	int cap_mqes = NVME_CAP_MQES(cap) + 1;
+
+	/*
+	 * Sanity check for q_depth_limit. q_depth_limit can be set
+	 * between 1 to MQES capability.
+	 */
+	if (q_depth_limit <= 0)
+		q_depth_limit = 1;
+
+	q_depth = min_t(int, cap_mqes, q_depth_limit);
+
+	/*
+	 * Temporary fix for the Apple controller found in the MacBook8,1 and
+	 * some MacBook7,1 to avoid controller resets and data loss.
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_APPLE && pdev->device == 0x2001) {
+		q_depth = 2;
+		dev_warn(dev->dev, "detected Apple NVMe controller, set queue depth=%d to work around controller resets\n",
+			q_depth);
+	} else
+		dev_info(dev->dev, "queue depth=%d\n", q_depth);
+
+	return q_depth;
+}
+
 static int nvme_pci_enable(struct nvme_dev *dev)
 {
 	u64 cap;
@@ -1650,21 +1683,10 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
 
-	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, NVME_Q_DEPTH);
+	dev->q_depth = get_q_depth(dev, cap);
 	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);
 	dev->dbs = dev->bar + 4096;
 
-	/*
-	 * Temporary fix for the Apple controller found in the MacBook8,1 and
-	 * some MacBook7,1 to avoid controller resets and data loss.
-	 */
-	if (pdev->vendor == PCI_VENDOR_ID_APPLE && pdev->device == 0x2001) {
-		dev->q_depth = 2;
-		dev_warn(dev->dev, "detected Apple NVMe controller, set "
-			"queue depth=%u to work around controller resets\n",
-			dev->q_depth);
-	}
-
 	if (readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 2))
 		dev->cmb = nvme_map_cmb(dev);
 
-- 
1.8.3.1
