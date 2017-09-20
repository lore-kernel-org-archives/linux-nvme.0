From: jsmart2021@gmail.com (James Smart)
Date: Wed, 20 Sep 2017 15:16:23 -0700
Subject: [PATCH] nvme_fc: fix iowait hang
Message-ID: <20170920221623.2509-1-jsmart2021@gmail.com>

Add missing iowait head initialization.
Fix irqsave vs irq

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index af075e998944..8182b1999f49 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2545,10 +2545,10 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	nvme_fc_abort_aen_ops(ctrl);
 
 	/* wait for all io that had to be aborted */
-	spin_lock_irqsave(&ctrl->lock, flags);
+	spin_lock_irq(&ctrl->lock);
 	wait_event_lock_irq(ctrl->ioabort_wait, ctrl->iocnt == 0, ctrl->lock);
 	ctrl->flags &= ~FCCTRL_TERMIO;
-	spin_unlock_irqrestore(&ctrl->lock, flags);
+	spin_unlock_irq(&ctrl->lock);
 
 	nvme_fc_term_aen_ops(ctrl);
 
@@ -2760,6 +2760,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	ctrl->rport = rport;
 	ctrl->dev = lport->dev;
 	ctrl->cnum = idx;
+	init_waitqueue_head(&ctrl->ioabort_wait);
 
 	get_device(ctrl->dev);
 	kref_init(&ctrl->ref);
-- 
2.13.1
