From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Fri,  5 Aug 2016 17:54:10 -0700
Subject: [PATCH 1/2] nvme-rdma: tell fabrics layer admin queue depth
In-Reply-To: <1470444851-7459-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1470444851-7459-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <1470444851-7459-2-git-send-email-james_p_freyensee@linux.intel.com>

Upon admin queue connect(), the rdma qp was being
set based on NVMF_AQ_DEPTH.  However, the fabrics layer was
using the sqsize field value set for I/O queues for the admin
queue, which through the nvme layer and rdma layer off-whack:

root at fedora23-fabrics-host1 nvmf]# dmesg
[ 3507.798642] nvme_fabrics: nvmf_connect_admin_queue():admin sqsize
being sent is: 128
[ 3507.798858] nvme nvme0: creating 16 I/O queues.
[ 3507.896407] nvme nvme0: new ctrl: NQN "nullside-nqn", addr
192.168.1.3:4420

Thus, to have a different admin queue value (which the fabrics
spec states the minimum depth for a fabrics admin queue is 32 via
the ASQSZ definition), we need also a new variable to hold
the sqsize for admin fabrics queue.

Reported-by: Daniel Verkamp <daniel.verkamp at intel.com>
Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 drivers/nvme/host/fabrics.c |  2 +-
 drivers/nvme/host/nvme.h    |  1 +
 drivers/nvme/host/rdma.c    | 18 ++++++++++++++++--
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index dc99676..f81d937 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -363,7 +363,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	cmd.connect.opcode = nvme_fabrics_command;
 	cmd.connect.fctype = nvme_fabrics_type_connect;
 	cmd.connect.qid = 0;
-	cmd.connect.sqsize = cpu_to_le16(ctrl->sqsize);
+	cmd.connect.sqsize = cpu_to_le16(ctrl->admin_sqsize);
 	/*
 	 * Set keep-alive timeout in seconds granularity (ms * 1000)
 	 * and add a grace period for controller kato enforcement
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ab18b78..32577a7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -137,6 +137,7 @@ struct nvme_ctrl {
 	struct delayed_work ka_work;
 
 	/* Fabrics only */
+	u16 admin_sqsize;
 	u16 sqsize;
 	u32 ioccsz;
 	u32 iorcsz;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3e3ce2b..ff44167 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1284,8 +1284,13 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
 
 	priv.recfmt = cpu_to_le16(NVME_RDMA_CM_FMT_1_0);
 	priv.qid = cpu_to_le16(nvme_rdma_queue_idx(queue));
-	priv.hrqsize = cpu_to_le16(queue->queue_size);
-	priv.hsqsize = cpu_to_le16(queue->queue_size);
+	if (priv.qid == 0) {
+		priv.hrqsize = cpu_to_le16(queue->ctrl->ctrl.admin_sqsize);
+		priv.hsqsize = cpu_to_le16(queue->ctrl->ctrl.admin_sqsize);
+	} else {
+		priv.hrqsize = cpu_to_le16(queue->queue_size);
+		priv.hsqsize = cpu_to_le16(queue->queue_size);
+	}
 
 	ret = rdma_connect(queue->cm_id, &param);
 	if (ret) {
@@ -1907,6 +1912,15 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	spin_lock_init(&ctrl->lock);
 
 	ctrl->queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
+
+	/* as nvme_rdma_configure_admin_queue() is setting the rdma's
+	 * internal submission queue to a different value other
+	 * than opts->queue_size, we need to make sure the
+	 * fabric layer uses that value upon an
+	 * NVMeoF admin connect() and not default to the more
+	 * common I/O queue size value (sqsize, opts->queue_size).
+	 */
+	ctrl->ctrl.admin_sqsize = NVMF_AQ_DEPTH-1;
 	ctrl->ctrl.sqsize = opts->queue_size;
 	ctrl->ctrl.kato = opts->kato;
 
-- 
2.7.4
