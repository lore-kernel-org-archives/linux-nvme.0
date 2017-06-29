From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 29 Jun 2017 14:09:11 +0300
Subject: [PATCH 6/7] nvme-loop: update tagset nr_hw_queues after
 reconnecting/resetting
In-Reply-To: <1498734552-14845-1-git-send-email-sagi@grimberg.me>
References: <1498734552-14845-1-git-send-email-sagi@grimberg.me>
Message-ID: <1498734552-14845-7-git-send-email-sagi@grimberg.me>

We might have more/less queues once we reconnect/reset. For
example due to cpu going online/offline

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 568ed8625696..3d51341e62ee 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -508,6 +508,9 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 	if (ret)
 		goto out_destroy_io;
 
+	blk_mq_update_nr_hw_queues(&ctrl->tag_set,
+			ctrl->ctrl.queue_count - 1);
+
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
 	WARN_ON_ONCE(!changed);
 
-- 
2.7.4
