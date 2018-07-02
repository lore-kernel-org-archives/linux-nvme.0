From: zhangweiping@didichuxing.com (Weiping Zhang)
Date: Tue, 3 Jul 2018 00:34:38 +0800
Subject: [PATCH v2] nvme: don't enable AEN if not supported
Message-ID: <20180702163437.GA2934@bogon.didichuxing.com>

Avoid excuting set_feature command if there is no supported bit in
Optional Asynchronous Events Supported (OAES).

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Weiping Zhang <zhangweiping at didichuxing.com>
---
Change since V1:
* Add extra variable supported_aens sugguested by Christoph.

 drivers/nvme/host/core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e541fe268bcf..5ff281cce2b9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1041,14 +1041,17 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
 static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 {
-	u32 result;
+	u32 result, supported_aens = ctrl->oaes & NVME_AEN_SUPPORTED;
 	int status;
 
-	status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT,
-			ctrl->oaes & NVME_AEN_SUPPORTED, NULL, 0, &result);
+	if (!supported_aens)
+		return;
+
+	status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT, supported_aens,
+			NULL, 0, &result);
 	if (status)
 		dev_warn(ctrl->device, "Failed to configure AEN (cfg %x)\n",
-			 ctrl->oaes & NVME_AEN_SUPPORTED);
+			 supported_aens);
 }
 
 static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
-- 
2.14.1
