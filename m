From: zhangweiping@didichuxing.com (Weiping Zhang)
Date: Sun, 1 Jul 2018 21:08:20 +0800
Subject: [PATCH] nvme: don't enable AEN if not supported
Message-ID: <20180701130815.GA36597@bogon.didichuxing.com>

Avoid excuting set_feature command if there is no supported bit in
Optional Asynchronous Events Supported (OAES).

Signed-off-by: Weiping Zhang <zhangweiping at didichuxing.com>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e541fe268bcf..d38e2016ffaa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1044,6 +1044,9 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 	u32 result;
 	int status;
 
+	if (!(ctrl->oaes & NVME_AEN_SUPPORTED))
+		return;
+
 	status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT,
 			ctrl->oaes & NVME_AEN_SUPPORTED, NULL, 0, &result);
 	if (status)
-- 
2.14.1
