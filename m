From: hare@suse.de (Hannes Reinecke)
Date: Thu, 26 Jul 2018 12:55:54 +0200
Subject: [PATCH] nvme: Register for ANA AEN
Message-ID: <20180726105554.80437-1-hare@suse.de>

We need to register for ANA AENs as we rely on them for our ANA implementation.
Patch is relative to hch nvme-ana tree.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3b96ace1f86d..99910497acdc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1042,6 +1042,10 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 	u32 supported = ctrl->oaes & NVME_AEN_SUPPORTED, result;
 	int status;
 
+#ifdef CONFIG_NVME_MULTIPATH
+	if (ctrl->subsys->cmic & (1 << 3))
+		supported |= NVME_AEN_CFG_ANA_CHANGE;
+#endif
 	status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT, supported, NULL,
 			0, &result);
 	if (status)
-- 
2.12.3
