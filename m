From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 19 Oct 2017 16:00:30 +0300
Subject: [PATCH v2 4.14-rc fix-regression] nvme-rdma: Fix possible double free
 in reconnect flow
Message-ID: <1508418030-23031-1-git-send-email-sagi@grimberg.me>

The fact that we free the async event buffer in
nvme_rdma_destroy_admin_queue can cause us to free it
more than once because this happens in every reconnect
attempt since commit 31fdf1840170. we rely on the queue
state flags DELETING to avoid this for other resources.

A more complete fix is to not destroy the admin/io queues
unconditionally on every reconnect attempt, but its a bit
more extensive and will go in the next release.

Fixes: 31fdf1840170 ("nvme-rdma: reuse configure/destroy_admin_queue")
Reported-by: Yi Zhang <yi.zhang at redhat.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 92a03ff5fb4d..ec22da478ba3 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -571,6 +571,11 @@ static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
 	if (test_and_set_bit(NVME_RDMA_Q_DELETING, &queue->flags))
 		return;
 
+	if(nvme_rdma_queue_idx(queue) == 0)
+		nvme_rdma_free_qe(queue->device->dev,
+			&queue->ctrl->async_event_sqe,
+			sizeof(struct nvme_command), DMA_TO_DEVICE);
+
 	nvme_rdma_destroy_queue_ib(queue);
 	rdma_destroy_id(queue->cm_id);
 }
@@ -739,8 +744,6 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
-	nvme_rdma_free_qe(ctrl->queues[0].device->dev, &ctrl->async_event_sqe,
-			sizeof(struct nvme_command), DMA_TO_DEVICE);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	if (remove) {
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
-- 
2.7.4
