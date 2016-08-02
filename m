From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue,  2 Aug 2016 10:53:39 +0300
Subject: [PATCH v2 5/5] nvme-rdma: Make sure to shutdown the controller if we
 can
In-Reply-To: <1470124419-30405-1-git-send-email-sagi@grimberg.me>
References: <1470124419-30405-1-git-send-email-sagi@grimberg.me>
Message-ID: <1470124419-30405-6-git-send-email-sagi@grimberg.me>

Relying on ctrl state in nvme_rdma_shutdown_ctrl is wrong because
it will never be NVME_CTRL_LIVE (delete_ctrl or reset_ctrl invoked it).

Instead, check that the admin queue is connected. Note that it is safe
because we can never see a copmeting thread trying to destroy the admin
queue (reset or delete controller).

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f31915696421..ef821592b791 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1644,7 +1644,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl)
 		nvme_rdma_free_io_queues(ctrl);
 	}
 
-	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
+	if (test_bit(NVME_RDMA_Q_CONNECTED, &ctrl->queues[0].flags))
 		nvme_shutdown_ctrl(&ctrl->ctrl);
 
 	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
-- 
1.9.1
