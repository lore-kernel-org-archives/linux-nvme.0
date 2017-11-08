From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed,  8 Nov 2017 15:00:32 +0200
Subject: [PATCH 1/1] nvme-rdma: Fix memory leak during queue allocation
Message-ID: <1510146032-25434-1-git-send-email-maxg@mellanox.com>

In case nvme_rdma_wait_for_cm timeout expires before we get
an established or rejected event (rdma_connect succeeded) from
rdma_cm, we end up with leaking the ib resources for dedicated
queue.
This scenario can easily reproduced using traffic test during port
toggling.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0ebb539..fcb278a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -545,13 +545,16 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 	if (ret) {
 		dev_info(ctrl->ctrl.device,
 			"rdma_resolve_addr wait failed (%d).\n", ret);
-		goto out_destroy_cm_id;
+		goto out_destroy_queue_ib;
 	}
 
 	clear_bit(NVME_RDMA_Q_DELETING, &queue->flags);
 
 	return 0;
 
+out_destroy_queue_ib:
+	if (ret == -ETIMEDOUT)
+		nvme_rdma_destroy_queue_ib(queue);
 out_destroy_cm_id:
 	rdma_destroy_id(queue->cm_id);
 	return ret;
-- 
1.8.3.1
