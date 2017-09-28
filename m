From: jsmart2021@gmail.com (James Smart)
Date: Thu, 28 Sep 2017 09:56:31 -0700
Subject: [PATCH] nvme_fc: avoid workqueue flush stalls
Message-ID: <20170928165631.16097-1-jsmart2021@gmail.com>

There's no need to wait for the full nvme_wq, which is now shared,
to flush. flush only the delete_work item.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index ac898571b1e5..2bd94de09b8a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2846,7 +2846,7 @@ nvme_fc_del_nvme_ctrl(struct nvme_ctrl *nctrl)
 	ret = __nvme_fc_del_ctrl(ctrl);
 
 	if (!ret)
-		flush_workqueue(nvme_wq);
+		flush_work(&ctrl->delete_work);
 
 	nvme_put_ctrl(&ctrl->ctrl);
 
-- 
2.13.1
