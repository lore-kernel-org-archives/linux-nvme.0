From: shan.hai@oracle.com (Shan Hai)
Date: Fri, 21 Dec 2018 14:04:12 +0800
Subject: [PATCH 1/2] nvme-pci: add module param for io queue number
Message-ID: <1545372253-28025-1-git-send-email-shan.hai@oracle.com>

The num_possible_cpus() number of io queues by default would cause
irq vector shortage problem on a large system when hotplugging cpus,
add a module parameter to set number of io queues according to the
system configuration to fix the issue.

Signed-off-by: Shan Hai <shan.hai at oracle.com>
---
 drivers/nvme/host/pci.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c33bb20..0d60451 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -64,6 +64,16 @@ MODULE_PARM_DESC(sgl_threshold,
 		"Use SGLs when average request segment size is larger or equal to "
 		"this size. Use 0 to disable SGLs.");
 
+static int io_queue_number_set(const char *val, const struct kernel_param *kp);
+static const struct kernel_param_ops io_queue_number_ops = {
+	.set = io_queue_number_set,
+	.get = param_get_uint,
+};
+
+static unsigned int io_queue_number = UINT_MAX;
+module_param_cb(io_queue_number, &io_queue_number_ops, &io_queue_number, 0644);
+MODULE_PARM_DESC(io_queue_number, "set io queue number, should >= 2");
+
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp);
 static const struct kernel_param_ops io_queue_depth_ops = {
 	.set = io_queue_depth_set,
@@ -123,6 +133,17 @@ struct nvme_dev {
 	void **host_mem_desc_bufs;
 };
 
+static int io_queue_number_set(const char *val, const struct kernel_param *kp)
+{
+	unsigned int n = 0, ret;
+
+	ret = kstrtouint(val, 10, &n);
+	if (ret != 0 || n < 2)
+		return -EINVAL;
+
+	return param_set_uint(val, kp);
+}
+
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
 {
 	int n = 0, ret;
-- 
2.7.4
