From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Wed,  3 Jan 2018 02:07:41 +0800
Subject: [PATCH] nvme: check ctrl.tagset before start ns scan
Message-ID: <1514916461-8696-1-git-send-email-jianchao.w.wang@oracle.com>

ctrl.tagset maybe NULL due to failure of io queue setup or blk-mq
tagset allocation in nvme_reset_work. Then panic would come up.
To fix this, just add ctrl.tagset check in nvme_scan_work.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1e46e60..1ed593d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3071,7 +3071,7 @@ static void nvme_scan_work(struct work_struct *work)
 	struct nvme_id_ctrl *id;
 	unsigned nn;
 
-	if (ctrl->state != NVME_CTRL_LIVE)
+	if ((ctrl->state != NVME_CTRL_LIVE) || !ctrl->tagset)
 		return;
 
 	if (nvme_identify_ctrl(ctrl, &id))
-- 
2.7.4
