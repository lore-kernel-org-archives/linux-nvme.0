From: zhangweiping@didichuxing.com (weiping zhang)
Date: Mon, 10 Jul 2017 16:46:59 +0800
Subject: [PATCH v4] nvme-pci: add module parameter for io queue depth
Message-ID: <20170710084659.GA6287@localhost.didichuxing.com>

Adjust io queue depth more easily, and make sure io queue depth >= 2.

Signed-off-by: weiping zhang <zhangweiping at didichuxing.com>
---
 drivers/nvme/host/pci.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 73fddf2..8470503 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -35,7 +35,6 @@
 
 #include "nvme.h"
 
-#define NVME_Q_DEPTH		1024
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
 
@@ -57,6 +56,16 @@ module_param(max_host_mem_size_mb, uint, 0444);
 MODULE_PARM_DESC(max_host_mem_size_mb,
 	"Maximum Host Memory Buffer (HMB) size per controller (in MiB)");
 
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
 struct nvme_dev;
 struct nvme_queue;
 
@@ -104,6 +113,17 @@ struct nvme_dev {
 	void **host_mem_desc_bufs;
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
@@ -1892,8 +1912,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	dev->ctrl.cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
 
-	dev->q_depth = min_t(int, NVME_CAP_MQES(dev->ctrl.cap) + 1,
-				NVME_Q_DEPTH);
+	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, io_queue_depth);
 	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
 	dev->dbs = dev->bar + 4096;
 
-- 
2.9.4
