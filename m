From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue,  1 Jan 2019 15:37:18 +0200
Subject: [PATCH 1/1] nvme-pci: check that sqid match in nvme cqe
Message-ID: <1546349838-5126-1-git-send-email-maxg@mellanox.com>

This patch protects against faulty drives (e.g: a drive might send
the completion on a wrong msix).

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5a0bf6a..ab7ff34 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -983,6 +983,13 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	volatile struct nvme_completion *cqe = &nvmeq->cqes[idx];
 	struct request *req;
 
+	if (unlikely(le16_to_cpu(cqe->sq_id) != nvmeq->qid)) {
+		dev_warn(nvmeq->dev->ctrl.device,
+			 "got completion on sqid %d instead of sqid %d\n",
+			 nvmeq->qid, le16_to_cpu(cqe->sq_id));
+		return;
+	}
+
 	if (unlikely(cqe->command_id >= nvmeq->q_depth)) {
 		dev_warn(nvmeq->dev->ctrl.device,
 			"invalid id %d completed on queue %d\n",
-- 
1.8.3.1
