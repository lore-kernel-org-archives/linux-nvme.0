From: zhangweiping@didichuxing.com (weiping zhang)
Date: Sat, 8 Jul 2017 01:01:07 +0800
Subject: [PATCH v2] nvme-pci: add module parameter for io queue depth
Message-ID: <20170707170107.GA27803@localhost.didichuxing.com>

Adjust io queue depth more easily, and make sure io queue depth >= 2.

Signed-off-by: weiping zhang <zhangweiping at didichuxing.com>
---
 drivers/nvme/host/pci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 951042a..604533d2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -48,7 +48,6 @@
 
 #include "nvme.h"
 
-#define NVME_Q_DEPTH		1024
 #define NVME_AQ_DEPTH		256
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
@@ -66,6 +65,10 @@ static bool use_cmb_sqes = true;
 module_param(use_cmb_sqes, bool, 0644);
 MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
 
+static int io_queue_depth = 1024;
+module_param(io_queue_depth, int, 0644);
+MODULE_PARM_DESC(io_queue_depth, "set io queue depth");
+
 static struct workqueue_struct *nvme_workq;
 
 struct nvme_dev;
@@ -1703,6 +1706,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 {
 	u64 cap;
 	int result = -ENOMEM;
+	int q_depth;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	if (pci_enable_device_mem(pdev))
@@ -1730,7 +1734,9 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
 
-	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, NVME_Q_DEPTH);
+	/* io queue depth should >= 2 */
+	q_depth = max_t(int, io_queue_depth, 2);
+	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, q_depth);
 	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);
 	dev->dbs = dev->bar + 4096;
 
-- 
2.9.4
