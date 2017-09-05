From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue,  5 Sep 2017 13:59:17 +0300
Subject: [PATCH 3/3] nvmet-rdma: add module parameter for SRQ size
In-Reply-To: <1504609157-3004-1-git-send-email-maxg@mellanox.com>
References: <1504609157-3004-1-git-send-email-maxg@mellanox.com>
Message-ID: <1504609157-3004-4-git-send-email-maxg@mellanox.com>

Adjust SRQ size according to the expected load. Make sure the
size is >= 256 to avoid lack of resources.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/rdma.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1b52080..34868ad 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -134,6 +134,16 @@ struct nvmet_rdma_device {
 module_param_named(use_srq, nvmet_rdma_use_srq, bool, 0444);
 MODULE_PARM_DESC(use_srq, "Use shared receive queue.");
 
+static int srq_size_set(const char *val, const struct kernel_param *kp);
+static const struct kernel_param_ops srq_size_ops = {
+	.set = srq_size_set,
+	.get = param_get_int,
+};
+
+static int nvmet_rdma_srq_size = 4095;
+module_param_cb(srq_size, &srq_size_ops, &nvmet_rdma_srq_size, 0644);
+MODULE_PARM_DESC(srq_size, "set Shared Receive Queue (SRQ) size, should >= 256 (default: 4095)");
+
 static DEFINE_IDA(nvmet_rdma_queue_ida);
 static LIST_HEAD(nvmet_rdma_queue_list);
 static DEFINE_MUTEX(nvmet_rdma_queue_mutex);
@@ -150,6 +160,17 @@ struct nvmet_rdma_device {
 
 static struct nvmet_fabrics_ops nvmet_rdma_ops;
 
+static int srq_size_set(const char *val, const struct kernel_param *kp)
+{
+	int n = 0, ret;
+
+	ret = kstrtoint(val, 10, &n);
+	if (ret != 0 || n < 256)
+		return -EINVAL;
+
+	return param_set_int(val, kp);
+}
+
 /* XXX: really should move to a generic header sooner or later.. */
 static inline u32 get_unaligned_le24(const u8 *p)
 {
@@ -825,7 +846,7 @@ static int nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev, int index)
 	if (!nsrq)
 		return -ENOMEM;
 
-	srq_size = 4095;	/* XXX: tune */
+	srq_size = nvmet_rdma_srq_size;
 
 	srq_attr.attr.max_wr = srq_size;
 	srq_attr.attr.max_sge = 2;
-- 
1.7.1
