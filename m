From: jsmart2021@gmail.com (James Smart)
Date: Mon, 22 May 2017 15:28:42 -0700
Subject: [PATCH v3 1/3] nvme_fc: replace ioabort msleep loop with completion
In-Reply-To: <20170522222844.22494-1-jsmart2021@gmail.com>
References: <20170522222844.22494-1-jsmart2021@gmail.com>
Message-ID: <20170522222844.22494-2-jsmart2021@gmail.com>

Per the recommendation by Sagi on:
http://lists.infradead.org/pipermail/linux-nvme/2017-April/009261.html

Wait for io aborts to complete wait converted from msleep look to
using a struct completion.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
This is the 3rd version of this patch: 
v2: removed unneeded inner braces
v3: converted to waitqueue and wait_event_lock_irq()

 drivers/nvme/host/fc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 14a009e43aa5..1ba693f7bdf0 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -167,6 +167,7 @@ struct nvme_fc_ctrl {
 	struct kref		ref;
 	u32			flags;
 	u32			iocnt;
+	wait_queue_head_t	ioabort_wait;
 
 	struct nvme_fc_fcp_op	aen_ops[NVME_FC_NR_AEN_COMMANDS];
 
@@ -1241,8 +1242,10 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
 
 	spin_lock_irqsave(&ctrl->lock, flags);
 	if (unlikely(op->flags & FCOP_FLAGS_TERMIO)) {
-		if (ctrl->flags & FCCTRL_TERMIO)
-			ctrl->iocnt--;
+		if (ctrl->flags & FCCTRL_TERMIO) {
+			if (!--ctrl->iocnt)
+				wake_up(&ctrl->ioabort_wait);
+		}
 	}
 	if (op->flags & FCOP_FLAGS_RELEASED)
 		complete_rq = true;
@@ -2479,11 +2482,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 
 	/* wait for all io that had to be aborted */
 	spin_lock_irqsave(&ctrl->lock, flags);
-	while (ctrl->iocnt) {
-		spin_unlock_irqrestore(&ctrl->lock, flags);
-		msleep(1000);
-		spin_lock_irqsave(&ctrl->lock, flags);
-	}
+	wait_event_lock_irq(ctrl->ioabort_wait, ctrl->iocnt == 0, ctrl->lock);
 	ctrl->flags &= ~FCCTRL_TERMIO;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
-- 
2.11.0
