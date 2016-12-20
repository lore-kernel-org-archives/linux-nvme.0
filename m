From: james.smart@broadcom.com (James Smart)
Date: Tue, 20 Dec 2016 11:06:08 -0800
Subject: [PATCH] nvme_fc: correct some printk information
Message-ID: <58598120.KPCQ7Dt0Hi3/w3aQ%james.smart@broadcom.com>


Dan Carpenters's tool caught a pointer reference - should have been
just ptr, not &ptr.

Don't bother. Remove the pointer value in the printf. Its irrelevant.

-- james

Signed-off-by: James Smart <james.smart at broadcom.com>
Reported-by: Dan Carpenter <dan.carpenter at oracle.com>
---
 drivers/nvme/host/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 771e2e7..827c2b5 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2401,8 +2401,8 @@ __nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	WARN_ON_ONCE(!changed);
 
 	dev_info(ctrl->ctrl.device,
-		"NVME-FC{%d}: new ctrl: NQN \"%s\" (%p)\n",
-		ctrl->cnum, ctrl->ctrl.opts->subsysnqn, &ctrl);
+		"NVME-FC{%d}: new ctrl: NQN \"%s\"\n",
+		ctrl->cnum, ctrl->ctrl.opts->subsysnqn);
 
 	kref_get(&ctrl->ctrl.kref);
 
-- 
2.5.0
