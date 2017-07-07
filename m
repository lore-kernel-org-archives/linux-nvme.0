From: keith.busch@intel.com (Keith Busch)
Date: Fri,  7 Jul 2017 12:22:58 -0400
Subject: [PATCH 4/7] nvme: Centralize blk-mq tag and AEN counts
In-Reply-To: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
Message-ID: <1499444581-28268-5-git-send-email-keith.busch@intel.com>

All the drivers were duplicating AEN accounting, yet they all depend on
the core to use the exact same settings of a single AEN to be deducted
from the tagset depth. This patch moves admin queue command accounting
to the core.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/fc.c     | 17 ++++-------------
 drivers/nvme/host/nvme.h   |  1 -
 drivers/nvme/host/pci.c    |  6 ------
 drivers/nvme/host/rdma.c   | 14 +++-----------
 drivers/nvme/target/loop.c | 14 +++-----------
 include/linux/nvme.h       |  7 +++++++
 6 files changed, 17 insertions(+), 42 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 26a3c5d..753761c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -30,15 +30,6 @@
 /* *************************** Data Structures/Defines ****************** */
 
 
-/*
- * We handle AEN commands ourselves and don't even let the
- * block layer know about them.
- */
-#define NVME_FC_NR_AEN_COMMANDS	1
-#define NVME_FC_AQ_BLKMQ_DEPTH	\
-	(NVME_AQ_DEPTH - NVME_FC_NR_AEN_COMMANDS)
-#define AEN_CMDID_BASE		(NVME_FC_AQ_BLKMQ_DEPTH + 1)
-
 enum nvme_fc_queue_flags {
 	NVME_FC_Q_CONNECTED = (1 << 0),
 };
@@ -1463,7 +1454,7 @@ nvme_fc_init_aen_op(struct nvme_fc_ctrl *ctrl)
 	sqe = &cmdiu->sqe;
 	ret = __nvme_fc_init_request(ctrl, &ctrl->queues[0],
 			&ctrl->aen_op, (struct request *)NULL,
-			AEN_CMDID_BASE);
+			NVME_AQ_BLKMQ_DEPTH);
 	if (ret) {
 		kfree(private);
 		return ret;
@@ -1475,7 +1466,7 @@ nvme_fc_init_aen_op(struct nvme_fc_ctrl *ctrl)
 
 	memset(sqe, 0, sizeof(*sqe));
 	sqe->common.opcode = nvme_admin_async_event;
-	sqe->common.command_id = AEN_CMDID_BASE;
+	sqe->common.command_id = NVME_AQ_BLKMQ_DEPTH;
 
 	return 0;
 }
@@ -2025,7 +2016,7 @@ nvme_fc_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
 	unsigned long flags;
 	bool terminating = false;
 
-	if (aer_idx > NVME_FC_NR_AEN_COMMANDS)
+	if (aer_idx > NVME_NR_AERS)
 		return;
 
 	spin_lock_irqsave(&ctrl->lock, flags);
@@ -2689,7 +2680,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
 	ctrl->admin_tag_set.ops = &nvme_fc_admin_mq_ops;
-	ctrl->admin_tag_set.queue_depth = NVME_FC_AQ_BLKMQ_DEPTH - 1;
+	ctrl->admin_tag_set.queue_depth = NVME_AQ_BLKMQ_DEPTH - 1;
 	ctrl->admin_tag_set.reserved_tags = 2; /* fabric connect + Keep-Alive */
 	ctrl->admin_tag_set.numa_node = NUMA_NO_NODE;
 	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_fc_fcp_op) +
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8f2a168..0510a33 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -291,7 +291,6 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 		bool send);
 
-#define NVME_NR_AERS	1
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res);
 void nvme_queue_async_events(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 882ed36..6bd49b2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -39,12 +39,6 @@
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
 
-/*
- * We handle AEN commands ourselves and don't even let the
- * block layer know about them.
- */
-#define NVME_AQ_BLKMQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AERS)
-
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index da04df1..8d811f4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -42,14 +42,6 @@
 
 #define NVME_RDMA_MAX_INLINE_SEGMENTS	1
 
-/*
- * We handle AEN commands ourselves and don't even let the
- * block layer know about them.
- */
-#define NVME_RDMA_NR_AEN_COMMANDS      1
-#define NVME_RDMA_AQ_BLKMQ_DEPTH       \
-	(NVME_AQ_DEPTH - NVME_RDMA_NR_AEN_COMMANDS)
-
 struct nvme_rdma_device {
 	struct ib_device       *dev;
 	struct ib_pd	       *pd;
@@ -1116,7 +1108,7 @@ static void nvme_rdma_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
 
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->common.opcode = nvme_admin_async_event;
-	cmd->common.command_id = NVME_RDMA_AQ_BLKMQ_DEPTH;
+	cmd->common.command_id = NVME_AQ_BLKMQ_DEPTH;
 	cmd->common.flags |= NVME_CMD_SGL_METABUF;
 	nvme_rdma_set_sg_null(cmd);
 
@@ -1178,7 +1170,7 @@ static int __nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc, int tag)
 	 * for them but rather special case them here.
 	 */
 	if (unlikely(nvme_rdma_queue_idx(queue) == 0 &&
-			cqe->command_id >= NVME_RDMA_AQ_BLKMQ_DEPTH))
+			cqe->command_id == NVME_AQ_BLKMQ_DEPTH))
 		nvme_complete_async_event(&queue->ctrl->ctrl, cqe->status,
 				&cqe->result);
 	else
@@ -1542,7 +1534,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 
 	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
 	ctrl->admin_tag_set.ops = &nvme_rdma_admin_mq_ops;
-	ctrl->admin_tag_set.queue_depth = NVME_RDMA_AQ_BLKMQ_DEPTH;
+	ctrl->admin_tag_set.queue_depth = NVME_AQ_BLKMQ_DEPTH - 1;
 	ctrl->admin_tag_set.reserved_tags = 2; /* connect + keep-alive */
 	ctrl->admin_tag_set.numa_node = NUMA_NO_NODE;
 	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_rdma_request) +
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 717ed7d..336e46e 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -23,14 +23,6 @@
 
 #define NVME_LOOP_MAX_SEGMENTS		256
 
-/*
- * We handle AEN commands ourselves and don't even let the
- * block layer know about them.
- */
-#define NVME_LOOP_NR_AEN_COMMANDS	1
-#define NVME_LOOP_AQ_BLKMQ_DEPTH	\
-	(NVME_AQ_DEPTH - NVME_LOOP_NR_AEN_COMMANDS)
-
 struct nvme_loop_iod {
 	struct nvme_request	nvme_req;
 	struct nvme_command	cmd;
@@ -113,7 +105,7 @@ static void nvme_loop_queue_response(struct nvmet_req *req)
 	 * for them but rather special case them here.
 	 */
 	if (unlikely(nvme_loop_queue_idx(queue) == 0 &&
-			cqe->command_id >= NVME_LOOP_AQ_BLKMQ_DEPTH)) {
+			cqe->command_id >= NVME_AQ_BLKMQ_DEPTH)) {
 		nvme_complete_async_event(&queue->ctrl->ctrl, cqe->status,
 				&cqe->result);
 	} else {
@@ -201,7 +193,7 @@ static void nvme_loop_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
 
 	memset(&iod->cmd, 0, sizeof(iod->cmd));
 	iod->cmd.common.opcode = nvme_admin_async_event;
-	iod->cmd.common.command_id = NVME_LOOP_AQ_BLKMQ_DEPTH;
+	iod->cmd.common.command_id = NVME_AQ_BLKMQ_DEPTH;
 	iod->cmd.common.flags |= NVME_CMD_SGL_METABUF;
 
 	if (!nvmet_req_init(&iod->req, &queue->nvme_cq, &queue->nvme_sq,
@@ -357,7 +349,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 
 	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
 	ctrl->admin_tag_set.ops = &nvme_loop_admin_mq_ops;
-	ctrl->admin_tag_set.queue_depth = NVME_LOOP_AQ_BLKMQ_DEPTH;
+	ctrl->admin_tag_set.queue_depth = NVME_AQ_BLKMQ_DEPTH - 1;
 	ctrl->admin_tag_set.reserved_tags = 2; /* connect + keep-alive */
 	ctrl->admin_tag_set.numa_node = NUMA_NO_NODE;
 	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 6b8ee9e..a253977 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -89,6 +89,13 @@ enum {
 
 #define NVME_AQ_DEPTH		32
 
+/*
+ * We handle AEN commands ourselves and don't even let the
+ * block layer know about them.
+ */
+#define NVME_NR_AERS	1
+#define NVME_AQ_BLKMQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AERS)
+
 enum {
 	NVME_REG_CAP	= 0x0000,	/* Controller Capabilities */
 	NVME_REG_VS	= 0x0008,	/* Version */
-- 
2.5.5
