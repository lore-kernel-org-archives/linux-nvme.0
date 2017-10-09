From: jsmart2021@gmail.com (James Smart)
Date: Mon,  9 Oct 2017 13:39:44 -0700
Subject: [PATCH v3] nvme_fc: fix iowait hang
Message-ID: <20171009203944.3541-1-jsmart2021@gmail.com>

Add missing iowait head initialization.
Fix irqsave vs irq: wait_event_lock_irq() doesn't do irq save/restore

Fixes: 36715cf4b366 ("nvme_fc: replace ioabort msleep loop with completion?)
Cc: <stable at vger.kernel.org> # 4.13
Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani at cavium.com>
Tested-by: Himanshu Madhani <himanshu.madhani at cavium.com>
---
v3:
 no changes to patch. Added stable reference and -by's from Himanshu

 drivers/nvme/host/fc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b8e0822127c1..1075488a81d6 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2601,10 +2601,10 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	nvme_fc_abort_aen_ops(ctrl);
 
 	/* wait for all io that had to be aborted */
-	spin_lock_irqsave(&ctrl->lock, flags);
+	spin_lock_irq(&ctrl->lock);
 	wait_event_lock_irq(ctrl->ioabort_wait, ctrl->iocnt == 0, ctrl->lock);
 	ctrl->flags &= ~FCCTRL_TERMIO;
-	spin_unlock_irqrestore(&ctrl->lock, flags);
+	spin_unlock_irq(&ctrl->lock);
 
 	nvme_fc_term_aen_ops(ctrl);
 
@@ -2816,6 +2816,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	ctrl->rport = rport;
 	ctrl->dev = lport->dev;
 	ctrl->cnum = idx;
+	init_waitqueue_head(&ctrl->ioabort_wait);
 
 	get_device(ctrl->dev);
 	kref_init(&ctrl->ref);
-- 
2.13.1
