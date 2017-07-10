From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 09:22:33 +0300
Subject: [PATCH 06/12] nvme-rdma: reuse configure/destroy_admin_queue
In-Reply-To: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
References: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499667759-15965-7-git-send-email-sagi@grimberg.me>

No need to open-code it.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index a7cc06173ead..2d51badc4347 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -864,23 +864,8 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 			goto requeue;
 	}
 
-	nvme_rdma_stop_and_free_queue(&ctrl->queues[0]);
-
-	ret = blk_mq_reinit_tagset(&ctrl->admin_tag_set);
-	if (ret)
-		goto requeue;
-
-	ret = nvme_rdma_init_queue(ctrl, 0, NVME_AQ_DEPTH);
-	if (ret)
-		goto requeue;
-
-	ret = nvmf_connect_admin_queue(&ctrl->ctrl);
-	if (ret)
-		goto requeue;
-
-	set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags);
-
-	ret = nvme_enable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
+	nvme_rdma_destroy_admin_queue(ctrl, false);
+	ret = nvme_rdma_configure_admin_queue(ctrl, false);
 	if (ret)
 		goto requeue;
 
-- 
2.7.4
