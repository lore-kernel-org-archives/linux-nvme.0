From: zhangweiping@didichuxing.com (weiping zhang)
Date: Mon, 10 Jul 2017 16:00:43 +0800
Subject: [PATCH v3] nvme-pci: add module parameter for io queue depth
Message-ID: <20170710080043.GA5360@localhost.didichuxing.com>

Adjust io queue depth more easily, and make sure io queue depth >= 2.

Signed-off-by: weiping zhang <zhangweiping at didichuxing.com>
---
 drivers/nvme/host/pci.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 951042a..4fdee28 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -48,7 +48,6 @@
 
 #include "nvme.h"
 
-#define NVME_Q_DEPTH		1024
 #define NVME_AQ_DEPTH		256
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
@@ -66,6 +65,16 @@ static bool use_cmb_sqes = true;
 module_param(use_cmb_sqes, bool, 0644);
 MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
 
+static int io_queue_depth_set(const char *val, const struct kernel_param *kp);
+static const struct kernel_param_ops io_queue_depth_ops = {
+	.set = io_queue_depth_set,
+	.get = param_get_int,
+};
+
+static int io_queue_depth = 1024;
+module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 0644);
+MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2");
+
 static struct workqueue_struct *nvme_workq;
 
 struct nvme_dev;
@@ -110,6 +119,17 @@ struct nvme_dev {
 	dma_addr_t dbbuf_eis_dma_addr;
 };
 
+static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
+{
+	int n = 0, ret;
+
+	ret = kstrtoint(val, 10, &n);
+	if (ret != 0 || n < 2)
+		return -EINVAL;
+
+	return param_set_int(val, kp);
+}
+
 static inline unsigned int sq_idx(unsigned int qid, u32 stride)
 {
 	return qid * 2 * stride;
@@ -1730,7 +1750,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
 
-	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, NVME_Q_DEPTH);
+	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, io_queue_depth);
 	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);
 	dev->dbs = dev->bar + 4096;
 
-- 
2.9.4
