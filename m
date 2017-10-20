From: keith.busch@intel.com (Keith Busch)
Date: Fri, 20 Oct 2017 16:19:20 -0600
Subject: [PATCHv2 1/5] nvme: Centralize AEN defines
In-Reply-To: <20171020221924.30659-1-keith.busch@intel.com>
References: <20171020221924.30659-1-keith.busch@intel.com>
Message-ID: <20171020221924.30659-2-keith.busch@intel.com>

All the transports were unnecessarilly duplicating the AEN request
accounting. This defines everything in one place.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c   |  2 +-
 drivers/nvme/host/fc.c     | 33 ++++++++++++---------------------
 drivers/nvme/host/nvme.h   |  1 -
 drivers/nvme/host/pci.c    | 12 +++---------
 drivers/nvme/host/rdma.c   | 14 +++-----------
 drivers/nvme/target/loop.c | 14 +++-----------
 include/linux/nvme.h       |  2 ++
 7 files changed, 24 insertions(+), 54 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7fae42d595d5..2b7fa9ba1e22 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2693,7 +2693,7 @@ EXPORT_SYMBOL_GPL(nvme_complete_async_event);
 
 void nvme_queue_async_events(struct nvme_ctrl *ctrl)
 {
-	ctrl->event_limit = NVME_NR_AERS;
+	ctrl->event_limit = NVME_AEN_COMMANDS;
 	queue_work(nvme_wq, &ctrl->async_event_work);
 }
 EXPORT_SYMBOL_GPL(nvme_queue_async_events);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index c6c903f1b172..e91e81d9f9fd 100644
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
@@ -165,7 +156,7 @@ struct nvme_fc_ctrl {
 	u32			iocnt;
 	wait_queue_head_t	ioabort_wait;
 
-	struct nvme_fc_fcp_op	aen_ops[NVME_FC_NR_AEN_COMMANDS];
+	struct nvme_fc_fcp_op	aen_ops[NVME_AEN_COMMANDS];
 
 	struct nvme_ctrl	ctrl;
 };
@@ -1322,7 +1313,7 @@ nvme_fc_abort_aen_ops(struct nvme_fc_ctrl *ctrl)
 	unsigned long flags;
 	int i, ret;
 
-	for (i = 0; i < NVME_FC_NR_AEN_COMMANDS; i++, aen_op++) {
+	for (i = 0; i < NVME_AEN_COMMANDS; i++, aen_op++) {
 		if (atomic_read(&aen_op->state) != FCPOP_STATE_ACTIVE)
 			continue;
 
@@ -1592,7 +1583,7 @@ nvme_fc_init_aen_ops(struct nvme_fc_ctrl *ctrl)
 	int i, ret;
 
 	aen_op = ctrl->aen_ops;
-	for (i = 0; i < NVME_FC_NR_AEN_COMMANDS; i++, aen_op++) {
+	for (i = 0; i < NVME_AEN_COMMANDS; i++, aen_op++) {
 		private = kzalloc(ctrl->lport->ops->fcprqst_priv_sz,
 						GFP_KERNEL);
 		if (!private)
@@ -1602,7 +1593,7 @@ nvme_fc_init_aen_ops(struct nvme_fc_ctrl *ctrl)
 		sqe = &cmdiu->sqe;
 		ret = __nvme_fc_init_request(ctrl, &ctrl->queues[0],
 				aen_op, (struct request *)NULL,
-				(AEN_CMDID_BASE + i));
+				(NVME_AQ_BLK_MQ_DEPTH + i));
 		if (ret) {
 			kfree(private);
 			return ret;
@@ -1615,7 +1606,7 @@ nvme_fc_init_aen_ops(struct nvme_fc_ctrl *ctrl)
 		memset(sqe, 0, sizeof(*sqe));
 		sqe->common.opcode = nvme_admin_async_event;
 		/* Note: core layer may overwrite the sqe.command_id value */
-		sqe->common.command_id = AEN_CMDID_BASE + i;
+		sqe->common.command_id = NVME_AQ_BLK_MQ_DEPTH + i;
 	}
 	return 0;
 }
@@ -1627,7 +1618,7 @@ nvme_fc_term_aen_ops(struct nvme_fc_ctrl *ctrl)
 	int i;
 
 	aen_op = ctrl->aen_ops;
-	for (i = 0; i < NVME_FC_NR_AEN_COMMANDS; i++, aen_op++) {
+	for (i = 0; i < NVME_AEN_COMMANDS; i++, aen_op++) {
 		if (!aen_op->fcp_req.private)
 			continue;
 
@@ -2185,7 +2176,7 @@ nvme_fc_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
 	bool terminating = false;
 	blk_status_t ret;
 
-	if (aer_idx > NVME_FC_NR_AEN_COMMANDS)
+	if (aer_idx > NVME_AEN_COMMANDS)
 		return;
 
 	spin_lock_irqsave(&ctrl->lock, flags);
@@ -2445,16 +2436,16 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	 * Create the admin queue
 	 */
 
-	nvme_fc_init_queue(ctrl, 0, NVME_FC_AQ_BLKMQ_DEPTH);
+	nvme_fc_init_queue(ctrl, 0, NVME_AQ_BLK_MQ_DEPTH);
 
 	ret = __nvme_fc_create_hw_queue(ctrl, &ctrl->queues[0], 0,
-				NVME_FC_AQ_BLKMQ_DEPTH);
+				NVME_AQ_BLK_MQ_DEPTH);
 	if (ret)
 		goto out_free_queue;
 
 	ret = nvme_fc_connect_admin_queue(ctrl, &ctrl->queues[0],
-				NVME_FC_AQ_BLKMQ_DEPTH,
-				(NVME_FC_AQ_BLKMQ_DEPTH / 4));
+				NVME_AQ_BLK_MQ_DEPTH,
+				(NVME_AQ_BLK_MQ_DEPTH / 4));
 	if (ret)
 		goto out_delete_hw_queue;
 
@@ -2854,7 +2845,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
 	ctrl->admin_tag_set.ops = &nvme_fc_admin_mq_ops;
-	ctrl->admin_tag_set.queue_depth = NVME_FC_AQ_BLKMQ_DEPTH;
+	ctrl->admin_tag_set.queue_depth = NVME_AQ_BLK_MQ_DEPTH - 1;
 	ctrl->admin_tag_set.reserved_tags = 2; /* fabric connect + Keep-Alive */
 	ctrl->admin_tag_set.numa_node = NUMA_NO_NODE;
 	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_fc_fcp_op) +
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cb9d93048f3d..331d91d5e191 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -300,7 +300,6 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 		bool send);
 
-#define NVME_NR_AERS	1
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res);
 void nvme_queue_async_events(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7e4d704ec198..52422c3a106f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -35,12 +35,6 @@
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
 
-/*
- * We handle AEN commands ourselves and don't even let the
- * block layer know about them.
- */
-#define NVME_AQ_BLKMQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AERS)
-
 #define SGES_PER_PAGE	(PAGE_SIZE / sizeof(struct nvme_sgl_desc))
 
 static int use_threaded_interrupts;
@@ -956,7 +950,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 	 * for them but rather special case them here.
 	 */
 	if (unlikely(nvmeq->qid == 0 &&
-			cqe->command_id >= NVME_AQ_BLKMQ_DEPTH)) {
+			cqe->command_id >= NVME_AQ_BLK_MQ_DEPTH)) {
 		nvme_complete_async_event(&nvmeq->dev->ctrl,
 				cqe->status, &cqe->result);
 		return;
@@ -1057,7 +1051,7 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl, int aer_idx)
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = nvme_admin_async_event;
-	c.common.command_id = NVME_AQ_BLKMQ_DEPTH + aer_idx;
+	c.common.command_id = NVME_AQ_BLK_MQ_DEPTH + aer_idx;
 
 	spin_lock_irq(&nvmeq->q_lock);
 	__nvme_submit_cmd(nvmeq, &c);
@@ -1528,7 +1522,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		 * Subtract one to leave an empty queue entry for 'Full Queue'
 		 * condition. See NVM-Express 1.2 specification, section 4.1.2.
 		 */
-		dev->admin_tagset.queue_depth = NVME_AQ_BLKMQ_DEPTH - 1;
+		dev->admin_tagset.queue_depth = NVME_AQ_BLK_MQ_DEPTH - 1;
 		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
 		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
 		dev->admin_tagset.cmd_size = nvme_pci_cmd_size(dev, false);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a5577e06a620..f35992b1c48b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -41,14 +41,6 @@
 
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
@@ -691,7 +683,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set = &ctrl->admin_tag_set;
 		memset(set, 0, sizeof(*set));
 		set->ops = &nvme_rdma_admin_mq_ops;
-		set->queue_depth = NVME_RDMA_AQ_BLKMQ_DEPTH;
+		set->queue_depth = NVME_AQ_BLK_MQ_DEPTH - 1;
 		set->reserved_tags = 2; /* connect + keep-alive */
 		set->numa_node = NUMA_NO_NODE;
 		set->cmd_size = sizeof(struct nvme_rdma_request) +
@@ -1319,7 +1311,7 @@ static void nvme_rdma_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
 
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->common.opcode = nvme_admin_async_event;
-	cmd->common.command_id = NVME_RDMA_AQ_BLKMQ_DEPTH;
+	cmd->common.command_id = NVME_AQ_BLK_MQ_DEPTH;
 	cmd->common.flags |= NVME_CMD_SGL_METABUF;
 	nvme_rdma_set_sg_null(cmd);
 
@@ -1381,7 +1373,7 @@ static int __nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc, int tag)
 	 * for them but rather special case them here.
 	 */
 	if (unlikely(nvme_rdma_queue_idx(queue) == 0 &&
-			cqe->command_id >= NVME_RDMA_AQ_BLKMQ_DEPTH))
+			cqe->command_id >= NVME_AQ_BLK_MQ_DEPTH))
 		nvme_complete_async_event(&queue->ctrl->ctrl, cqe->status,
 				&cqe->result);
 	else
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index c56354e1e4c6..fc2856943d89 100644
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
+			cqe->command_id >= NVME_AQ_BLK_MQ_DEPTH)) {
 		nvme_complete_async_event(&queue->ctrl->ctrl, cqe->status,
 				&cqe->result);
 	} else {
@@ -201,7 +193,7 @@ static void nvme_loop_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
 
 	memset(&iod->cmd, 0, sizeof(iod->cmd));
 	iod->cmd.common.opcode = nvme_admin_async_event;
-	iod->cmd.common.command_id = NVME_LOOP_AQ_BLKMQ_DEPTH;
+	iod->cmd.common.command_id = NVME_AQ_BLK_MQ_DEPTH;
 	iod->cmd.common.flags |= NVME_CMD_SGL_METABUF;
 
 	if (!nvmet_req_init(&iod->req, &queue->nvme_cq, &queue->nvme_sq,
@@ -357,7 +349,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 
 	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
 	ctrl->admin_tag_set.ops = &nvme_loop_admin_mq_ops;
-	ctrl->admin_tag_set.queue_depth = NVME_LOOP_AQ_BLKMQ_DEPTH;
+	ctrl->admin_tag_set.queue_depth = NVME_AQ_BLK_MQ_DEPTH - 1;
 	ctrl->admin_tag_set.reserved_tags = 2; /* connect + keep-alive */
 	ctrl->admin_tag_set.numa_node = NUMA_NO_NODE;
 	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_loop_iod) +
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 9310ce77d8e1..9a3878c2b2ad 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -90,6 +90,8 @@ enum {
 };
 
 #define NVME_AQ_DEPTH		32
+#define NVME_AEN_COMMANDS	1
+#define NVME_AQ_BLK_MQ_DEPTH	(NVME_AQ_DEPTH - NVME_AEN_COMMANDS)
 
 enum {
 	NVME_REG_CAP	= 0x0000,	/* Controller Capabilities */
-- 
2.13.6
