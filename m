From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Sat, 10 Dec 2016 12:06:18 +0300
Subject: [patch] nvme-fabrics: correct some printk information
Message-ID: <20161210090618.GA11680@elgon.mountain>

We really don't care where "ctrl" is on the stack since we're just
returning soon what we want is the actual ctrl pointer itself.

Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 771e2e761872..e6395ed2f562 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2402,7 +2402,7 @@ enum blk_eh_timer_return
 
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: new ctrl: NQN \"%s\" (%p)\n",
-		ctrl->cnum, ctrl->ctrl.opts->subsysnqn, &ctrl);
+		ctrl->cnum, ctrl->ctrl.opts->subsysnqn, ctrl);
 
 	kref_get(&ctrl->ctrl.kref);
 
