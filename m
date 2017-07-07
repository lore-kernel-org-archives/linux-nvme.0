From: zhangweiping@didichuxing.com (weiping zhang)
Date: Fri, 7 Jul 2017 17:05:47 +0800
Subject: [PATCH] nvme-pci: add module parameter for io queue depth
Message-ID: <20170707090547.GA2420@localhost.didichuxing.com>

Adjust io queue depth more easily.

Signed-off-by: weiping zhang <zhangweiping at didichuxing.com>
---
 drivers/nvme/host/pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 951042a..f1ac0f8 100644
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
@@ -1730,7 +1733,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
 
-	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, NVME_Q_DEPTH);
+	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, io_queue_depth);
 	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);
 	dev->dbs = dev->bar + 4096;
 
-- 
2.9.4
