From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 26 Aug 2016 06:50:59 -0700
Subject: [PATCH WIP/RFC 5/6] nvme-rdma: add DELETING queue flag
In-Reply-To: <cover.1472219585.git.swise@opengridcomputing.com>
References: <cover.1472219585.git.swise@opengridcomputing.com>
Message-ID: <70e06b14c40d74d6a5de4fda4a5a6639e0ac4b7d.1472219586.git.swise@opengridcomputing.com>

From: Sagi Grimberg <sagi@grimberg.me>

When we get a surprise disconnect from the target we queue a periodic
reconnect (which is the sane thing to do...).

We only move the queues out of CONNECTED when we retry to reconnect (after
10 seconds in the default case) but we stop the blk queues immediately
so we are not bothered with traffic from now on. If delete() is kicking
off in this period the queues are still in CONNECTED state.

Part of the delete sequence is trying to issue ctrl shutdown if the
admin queue is CONNECTED (which it is!). This request is issued but
stuck in blk-mq waiting for the queues to start again. This might be
the one preventing us from forward progress...

The patch separates the queue flags to CONNECTED and DELETING. Now we
will move out of CONNECTED as soon as error recovery kicks in (before
stopping the queues) and DELETING is on when we start the queue deletion.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8be7b6c..b99d7fd 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -88,6 +88,7 @@ struct nvme_rdma_request {
 enum nvme_rdma_queue_flags {
 	NVME_RDMA_Q_CONNECTED = (1 << 0),
 	NVME_RDMA_IB_QUEUE_ALLOCATED = (1 << 1),
+	NVME_RDMA_Q_DELETING = (1 << 2),
 };
 
 struct nvme_rdma_queue {
@@ -618,7 +619,7 @@ static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
 
 static void nvme_rdma_stop_and_free_queue(struct nvme_rdma_queue *queue)
 {
-	if (!test_and_clear_bit(NVME_RDMA_Q_CONNECTED, &queue->flags))
+	if (test_and_set_bit(NVME_RDMA_Q_DELETING, &queue->flags))
 		return;
 	nvme_rdma_stop_queue(queue);
 	nvme_rdma_free_queue(queue);
@@ -771,8 +772,13 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
 			struct nvme_rdma_ctrl, err_work);
+	int i;
 
 	nvme_stop_keep_alive(&ctrl->ctrl);
+
+	for (i = 0; i < ctrl->queue_count; i++)
+		clear_bit(NVME_RDMA_Q_CONNECTED, &ctrl->queues[i].flags);
+
 	if (ctrl->queue_count > 1)
 		nvme_stop_queues(&ctrl->ctrl);
 	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
-- 
2.7.0
