From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Fri,  5 Aug 2016 17:54:11 -0700
Subject: [PATCH 2/2] nvme-rdma: sqsize/hsqsize/hrqsize is 0-based val
In-Reply-To: <1470444851-7459-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1470444851-7459-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <1470444851-7459-3-git-send-email-james_p_freyensee@linux.intel.com>

Per NVMe-over-Fabrics 1.0 spec, sqsize is represented as
a 0-based value.

Also per spec, the RDMA binding values shall be set
to sqsize, which makes hsqsize and hrqsize 0-based values.

Thus, the sqsize at the NVMe Fabrics level is now:

[root at fedora23-fabrics-host1 for-48]# dmesg
[  318.720645] nvme_fabrics: nvmf_connect_admin_queue(): sqsize for
admin queue: 31
[  318.720884] nvme nvme0: creating 16 I/O queues.
[  318.810114] nvme_fabrics: nvmf_connect_io_queue(): sqsize for i/o
queue: 127

Reported-by: Daniel Verkamp <daniel.verkamp at intel.com>
Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 drivers/nvme/host/rdma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index ff44167..6300b10 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1288,8 +1288,8 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
 		priv.hrqsize = cpu_to_le16(queue->ctrl->ctrl.admin_sqsize);
 		priv.hsqsize = cpu_to_le16(queue->ctrl->ctrl.admin_sqsize);
 	} else {
-		priv.hrqsize = cpu_to_le16(queue->queue_size);
-		priv.hsqsize = cpu_to_le16(queue->queue_size);
+		priv.hrqsize = cpu_to_le16(queue->ctrl->ctrl.sqsize);
+		priv.hsqsize = cpu_to_le16(queue->ctrl->ctrl.sqsize);
 	}
 
 	ret = rdma_connect(queue->cm_id, &param);
@@ -1921,7 +1921,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	 * common I/O queue size value (sqsize, opts->queue_size).
 	 */
 	ctrl->ctrl.admin_sqsize = NVMF_AQ_DEPTH-1;
-	ctrl->ctrl.sqsize = opts->queue_size;
+	ctrl->ctrl.sqsize = opts->queue_size-1;
 	ctrl->ctrl.kato = opts->kato;
 
 	ret = -ENOMEM;
-- 
2.7.4
