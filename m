From: jsmart2021@gmail.com (James Smart)
Date: Wed, 20 Jun 2018 07:44:12 -0700
Subject: [PATCH] nvme_fc: release io queues to allow fast fail
Message-ID: <20180620144412.19973-1-jsmart2021@gmail.com>

Rather than leaving io queues quiesced after tearing down an association,
restart them. This allows ios to be replayed, with fastfail ios terminating
and non-fastfail getting into loops of retry.

This follows rdma's lead.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b528a2f5826c..41d45a1b5c62 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2790,6 +2790,9 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	/* re-enable the admin_q so anything new can fast fail */
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 
+	/* resume the io queues so that things will fast fail */
+	nvme_start_queues(&ctrl->ctrl);
+
 	nvme_fc_ctlr_inactive_on_rport(ctrl);
 }
 
@@ -2804,9 +2807,6 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 	 * waiting for io to terminate
 	 */
 	nvme_fc_delete_association(ctrl);
-
-	/* resume the io queues so that things will fast fail */
-	nvme_start_queues(nctrl);
 }
 
 static void
-- 
2.13.1
