From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 24 Oct 2017 15:25:22 +0300
Subject: [PATCH 3/3] nvme-loop: Check if queue is ready in queue_rq
In-Reply-To: <1508847922-26699-1-git-send-email-sagi@grimberg.me>
References: <1508847922-26699-1-git-send-email-sagi@grimberg.me>
Message-ID: <1508847922-26699-4-git-send-email-sagi@grimberg.me>

In case the queue is not LIVE (fully functional
and connected in the nvmf level), we cannot
allow any commands other than connect to pass
through.

Add a new queue state flag NVME_LOOP_Q_LIVE which is
set after nvmf connect and cleared in queue teardown.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/loop.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index c56354e1e4c6..0ddc7a06858a 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -61,10 +61,15 @@ static inline struct nvme_loop_ctrl *to_loop_ctrl(struct nvme_ctrl *ctrl)
 	return container_of(ctrl, struct nvme_loop_ctrl, ctrl);
 }
 
+enum nvme_loop_queue_flags {
+	NVME_LOOP_Q_LIVE	= 0,
+};
+
 struct nvme_loop_queue {
 	struct nvmet_cq		nvme_cq;
 	struct nvmet_sq		nvme_sq;
 	struct nvme_loop_ctrl	*ctrl;
+	unsigned long		flags;
 };
 
 static struct nvmet_port *nvmet_loop_port;
@@ -153,6 +158,14 @@ nvme_loop_timeout(struct request *rq, bool reserved)
 	return BLK_EH_HANDLED;
 }
 
+static inline blk_status_t nvme_loop_is_ready(struct nvme_loop_queue *queue,
+		struct request *rq)
+{
+	if (unlikely(!test_bit(NVME_LOOP_Q_LIVE, &queue->flags)))
+		return nvmf_check_init_req(&queue->ctrl->ctrl, rq);
+	return BLK_STS_OK;
+}
+
 static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
 {
@@ -162,6 +175,10 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_loop_iod *iod = blk_mq_rq_to_pdu(req);
 	blk_status_t ret;
 
+	ret = nvme_loop_is_ready(queue, req);
+	if (unlikely(ret))
+		return ret;
+
 	ret = nvme_setup_cmd(ns, req, &iod->cmd);
 	if (ret)
 		return ret;
@@ -275,6 +292,7 @@ static const struct blk_mq_ops nvme_loop_admin_mq_ops = {
 
 static void nvme_loop_destroy_admin_queue(struct nvme_loop_ctrl *ctrl)
 {
+	clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags);
 	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
 	blk_cleanup_queue(ctrl->ctrl.admin_q);
 	blk_mq_free_tag_set(&ctrl->admin_tag_set);
@@ -305,8 +323,10 @@ static void nvme_loop_destroy_io_queues(struct nvme_loop_ctrl *ctrl)
 {
 	int i;
 
-	for (i = 1; i < ctrl->ctrl.queue_count; i++)
+	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
+		clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[i].flags);
 		nvmet_sq_destroy(&ctrl->queues[i].nvme_sq);
+	}
 }
 
 static int nvme_loop_init_io_queues(struct nvme_loop_ctrl *ctrl)
@@ -346,6 +366,7 @@ static int nvme_loop_connect_io_queues(struct nvme_loop_ctrl *ctrl)
 		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
 		if (ret)
 			return ret;
+		set_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[i].flags);
 	}
 
 	return 0;
@@ -388,6 +409,8 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	if (error)
 		goto out_cleanup_queue;
 
+	set_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags);
+
 	error = nvmf_reg_read64(&ctrl->ctrl, NVME_REG_CAP, &ctrl->ctrl.cap);
 	if (error) {
 		dev_err(ctrl->ctrl.device,
-- 
2.7.4
