From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Wed, 10 Aug 2016 21:07:16 -0700
Subject: [PATCH RFC 2/4] nvme-rdma: fix sqsize/hsqsize/hrqsize per spec
In-Reply-To: <1470888438-823-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1470888438-823-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <1470888438-823-3-git-send-email-james_p_freyensee@linux.intel.com>

Per NVMe-over-Fabrics 1.0 spec, sqsize is represented as
a 0-based value.

Also per spec, the RDMA binding values shall be set
to sqsize, which makes hsqsize 0-based values.

Also per spec, but not very clear, is hrqsize is +1
of hsqsize.

Thus, the sqsize during NVMf connect() is now:

[root at fedora23-fabrics-host1 for-48]# dmesg
[  318.720645] nvme_fabrics: nvmf_connect_admin_queue(): sqsize for
admin queue: 31
[  318.720884] nvme nvme0: creating 16 I/O queues.
[  318.810114] nvme_fabrics: nvmf_connect_io_queue(): sqsize for i/o
queue: 127

Reported-by: Daniel Verkamp <daniel.verkamp at intel.com>
Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 drivers/nvme/host/rdma.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3e3ce2b..8be64f1 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1284,8 +1284,21 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
 
 	priv.recfmt = cpu_to_le16(NVME_RDMA_CM_FMT_1_0);
 	priv.qid = cpu_to_le16(nvme_rdma_queue_idx(queue));
-	priv.hrqsize = cpu_to_le16(queue->queue_size);
-	priv.hsqsize = cpu_to_le16(queue->queue_size);
+
+	/*
+	 * On one end, the fabrics spec is pretty clear that
+	 * hsqsize variables shall be set to the value of sqsize,
+	 * which is a 0-based number. What is confusing is the value for
+	 * hrqsize.  After clarification from NVMe spec committee member,
+	 * the minimum value of hrqsize is hsqsize+1.
+	 */
+	if (priv.qid == 0) {
+		priv.hsqsize = cpu_to_le16(queue->ctrl->ctrl.admin_sqsize);
+		priv.hrqsize = cpu_to_le16(queue->ctrl->ctrl.admin_sqsize+1);
+	} else {
+		priv.hsqsize = cpu_to_le16(queue->ctrl->ctrl.sqsize);
+		priv.hrqsize = cpu_to_le16(queue->ctrl->ctrl.sqsize+1);
+	}
 
 	ret = rdma_connect(queue->cm_id, &param);
 	if (ret) {
@@ -1907,7 +1920,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	spin_lock_init(&ctrl->lock);
 
 	ctrl->queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
-	ctrl->ctrl.sqsize = opts->queue_size;
+	ctrl->ctrl.sqsize = opts->queue_size-1;
 	ctrl->ctrl.kato = opts->kato;
 
 	ret = -ENOMEM;
-- 
2.7.4
