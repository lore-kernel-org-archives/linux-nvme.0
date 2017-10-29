From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 29 Oct 2017 14:21:01 +0200
Subject: [PATCH 1/2] nvme-rdma: reuse nvme_delete_ctrl when reconnect attempts
 expire
Message-ID: <1509279662-32169-1-git-send-email-sagi@grimberg.me>

instead of just queueing delete work

Reported-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 4f8a249a2c12..5e95a9860f35 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -912,7 +912,7 @@ static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 				ctrl->ctrl.opts->reconnect_delay * HZ);
 	} else {
 		dev_info(ctrl->ctrl.device, "Removing controller...\n");
-		queue_work(nvme_wq, &ctrl->ctrl.delete_work);
+		nvme_delete_ctrl(&ctrl->ctrl);
 	}
 }
 
-- 
2.7.4
