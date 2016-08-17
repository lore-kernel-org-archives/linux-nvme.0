From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Wed, 17 Aug 2016 15:00:27 -0700
Subject: [PATCH v4 3/4] nvme-rdma: fix sqsize/hsqsize per spec
In-Reply-To: <1471471228-15818-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1471471228-15818-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <1471471228-15818-4-git-send-email-james_p_freyensee@linux.intel.com>

Per NVMe-over-Fabrics 1.0 spec, sqsize is represented as
a 0-based value.

Also per spec, the RDMA binding values shall be set
to sqsize, which makes hsqsize 0-based values.

Thus, the sqsize during NVMf connect() is now:

[root at fedora23-fabrics-host1 for-48]# dmesg
[  318.720645] nvme_fabrics: nvmf_connect_admin_queue(): sqsize for
admin queue: 31
[  318.720884] nvme nvme0: creating 16 I/O queues.
[  318.810114] nvme_fabrics: nvmf_connect_io_queue(): sqsize for i/o
queue: 127

Finally, current interpretation implies hrqsize is 1's based
so set it appropriately.

Reported-by: Daniel Verkamp <daniel.verkamp at intel.com>
Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 drivers/nvme/host/rdma.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 31eb12b..72056f1 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -649,7 +649,8 @@ static int nvme_rdma_init_io_queues(struct nvme_rdma_ctrl *ctrl)
 	int i, ret;
 
 	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = nvme_rdma_init_queue(ctrl, i, ctrl->ctrl.sqsize);
+		ret = nvme_rdma_init_queue(ctrl, i,
+					   ctrl->ctrl.opts->queue_size);
 		if (ret) {
 			dev_info(ctrl->ctrl.device,
 				"failed to initialize i/o queue: %d\n", ret);
@@ -1292,8 +1293,13 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
 		priv.hrqsize = cpu_to_le16(NVMF_AQ_DEPTH);
 		priv.hsqsize = cpu_to_le16(NVMF_AQ_DEPTH - 1);
 	} else {
+		/*
+		 * current interpretation of the fabrics spec
+		 * is at minimum you make hrqsize sqsize+1, or a
+		 * 1's based representation of sqsize.
+		 */
 		priv.hrqsize = cpu_to_le16(queue->queue_size);
-		priv.hsqsize = cpu_to_le16(queue->queue_size);
+		priv.hsqsize = cpu_to_le16(queue->ctrl->ctrl.sqsize);
 	}
 
 	ret = rdma_connect(queue->cm_id, &param);
@@ -1818,7 +1824,7 @@ static int nvme_rdma_create_io_queues(struct nvme_rdma_ctrl *ctrl)
 
 	memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
 	ctrl->tag_set.ops = &nvme_rdma_mq_ops;
-	ctrl->tag_set.queue_depth = ctrl->ctrl.sqsize;
+	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
 	ctrl->tag_set.reserved_tags = 1; /* fabric connect */
 	ctrl->tag_set.numa_node = NUMA_NO_NODE;
 	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
@@ -1916,7 +1922,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	spin_lock_init(&ctrl->lock);
 
 	ctrl->queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
-	ctrl->ctrl.sqsize = opts->queue_size;
+	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
 	ret = -ENOMEM;
-- 
2.7.4
