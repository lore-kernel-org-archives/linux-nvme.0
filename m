From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Fri, 12 Aug 2016 17:04:48 -0700
Subject: [PATCH v1 1/5] fabrics: define admin sqsize min default, per spec
In-Reply-To: <1471046692-15978-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1471046692-15978-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <1471046692-15978-2-git-send-email-james_p_freyensee@linux.intel.com>

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

Thus, to have a different admin queue value, we use
NVMF_AQ_DEPTH for connect() and RDMA private data
as the minimum depth specified in the NVMe-over-Fabrics 1.0 spec.

Reported-by: Daniel Verkamp <daniel.verkamp at intel.com>
Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 drivers/nvme/host/fabrics.c |  9 ++++++++-
 drivers/nvme/host/rdma.c    | 13 +++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index dc99676..020302c 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -363,7 +363,14 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	cmd.connect.opcode = nvme_fabrics_command;
 	cmd.connect.fctype = nvme_fabrics_type_connect;
 	cmd.connect.qid = 0;
-	cmd.connect.sqsize = cpu_to_le16(ctrl->sqsize);
+
+	/*
+	 * fabrics spec sets a minimum of depth 32 for admin queue,
+	 * so set the queue with this depth always until
+	 * justification otherwise.
+	 */
+	cmd.connect.sqsize = cpu_to_le16(NVMF_AQ_DEPTH - 1);
+
 	/*
 	 * Set keep-alive timeout in seconds granularity (ms * 1000)
 	 * and add a grace period for controller kato enforcement
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3e3ce2b..168cd23 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1284,8 +1284,17 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
 
 	priv.recfmt = cpu_to_le16(NVME_RDMA_CM_FMT_1_0);
 	priv.qid = cpu_to_le16(nvme_rdma_queue_idx(queue));
-	priv.hrqsize = cpu_to_le16(queue->queue_size);
-	priv.hsqsize = cpu_to_le16(queue->queue_size);
+	/*
+	 * set the admin queue depth to the minimum size
+	 * specified by the Fabrics standard.
+	 */
+	if (priv.qid == 0) {
+		priv.hrqsize = cpu_to_le16(NVMF_AQ_DEPTH - 1);
+		priv.hsqsize = cpu_to_le16(NVMF_AQ_DEPTH - 1);
+	} else {
+		priv.hrqsize = cpu_to_le16(queue->queue_size);
+		priv.hsqsize = cpu_to_le16(queue->queue_size);
+	}
 
 	ret = rdma_connect(queue->cm_id, &param);
 	if (ret) {
-- 
2.7.4
