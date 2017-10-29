From: hch@lst.de (Christoph Hellwig)
Date: Sun, 29 Oct 2017 10:44:27 +0200
Subject: [PATCH 1/5] nvme-fc: avoid workqueue flush stalls
In-Reply-To: <20171029084431.8702-1-hch@lst.de>
References: <20171029084431.8702-1-hch@lst.de>
Message-ID: <20171029084431.8702-2-hch@lst.de>

From: James Smart <jsmart2021@gmail.com>

There's no need to wait for the full nvme_wq, which is now shared,
to flush. flush only the delete_work item.

Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Sagi Grimberg <sgi at grimberg.me>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b600c07803cf..50cc17e99475 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2693,7 +2693,7 @@ nvme_fc_del_nvme_ctrl(struct nvme_ctrl *nctrl)
 	nvme_get_ctrl(&ctrl->ctrl);
 	ret = __nvme_fc_del_ctrl(ctrl);
 	if (!ret)
-		flush_workqueue(nvme_wq);
+		flush_work(&ctrl->delete_work);
 	nvme_put_ctrl(&ctrl->ctrl);
 
 	return ret;
-- 
2.14.2
