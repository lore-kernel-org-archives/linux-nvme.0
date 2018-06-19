From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 19 Jun 2018 15:34:12 +0300
Subject: [PATCH 4/7] nvme-rdma: unquiesce queues when deleting the controller
In-Reply-To: <20180619123415.25077-1-sagi@grimberg.me>
References: <20180619123415.25077-1-sagi@grimberg.me>
Message-ID: <20180619123415.25077-5-sagi@grimberg.me>

If the controller is going away, we need to unquiesce the io
queues so that all pending request can fail gracefully before
moving forward with controller deletion.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 15e897ac2506..edf63cd106ff 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1741,10 +1741,12 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 		nvme_rdma_destroy_io_queues(ctrl, shutdown);
 	}
 
-	if (shutdown)
+	if (shutdown) {
+		nvme_start_queues(&ctrl->ctrl);
 		nvme_shutdown_ctrl(&ctrl->ctrl);
-	else
+	} else {
 		nvme_disable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
+	}
 
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
-- 
2.14.1
