From: nitzanc@mellanox.com (Nitzan Carmi)
Date: Wed, 12 Dec 2018 06:55:00 +0000
Subject: [PATCH 1/2] nvme: Introduce nvme_is_aen_req function
Message-ID: <20181212065501.21580-1-nitzanc@mellanox.com>

From: Israel Rukshin <israelr@mellanox.com>

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/nvme.h | 5 +++++
 drivers/nvme/host/pci.c  | 3 +--
 drivers/nvme/host/rdma.c | 4 ++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 081cbdcce880..8330f41991ad 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -407,6 +407,11 @@ static inline void nvme_put_ctrl(struct nvme_ctrl *ctrl)
 	put_device(ctrl->device);
 }
 
+static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
+{
+	return (!qid && command_id >= NVME_AQ_BLK_MQ_DEPTH);
+}
+
 void nvme_complete_rq(struct request *req);
 void nvme_cancel_request(struct request *req, void *data, bool reserved);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c33bb201b884..04af49f2643f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -891,8 +891,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	 * aborts.  We don't even bother to allocate a struct request
 	 * for them but rather special case them here.
 	 */
-	if (unlikely(nvmeq->qid == 0 &&
-			cqe->command_id >= NVME_AQ_BLK_MQ_DEPTH)) {
+	if (unlikely(nvme_is_aen_req(nvmeq->qid, cqe->command_id))) {
 		nvme_complete_async_event(&nvmeq->dev->ctrl,
 				cqe->status, &cqe->result);
 		return;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index ab6ec7295bf9..a9eed697505e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1481,8 +1481,8 @@ static int __nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc, int tag)
 	 * aborts.  We don't even bother to allocate a struct request
 	 * for them but rather special case them here.
 	 */
-	if (unlikely(nvme_rdma_queue_idx(queue) == 0 &&
-			cqe->command_id >= NVME_AQ_BLK_MQ_DEPTH))
+	if (unlikely(nvme_is_aen_req(nvme_rdma_queue_idx(queue),
+				     cqe->command_id)))
 		nvme_complete_async_event(&queue->ctrl->ctrl, cqe->status,
 				&cqe->result);
 	else
-- 
2.14.3
