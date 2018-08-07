From: hare@suse.de (Hannes Reinecke)
Date: Tue,  7 Aug 2018 12:43:42 +0200
Subject: [PATCH] nvme: fixup crash on failed discovery
Message-ID: <20180807104342.44367-1-hare@suse.de>

When the initial discovery fails the subsystem hasn't been setup,
and we'll encounter a kernel oops during shutdown.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 420efcda33d9..c1f41aa879c1 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -24,7 +24,7 @@ MODULE_PARM_DESC(multipath,
 
 inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 {
-	return multipath && (ctrl->subsys->cmic & (1 << 3));
+	return multipath && ctrl->subsys && (ctrl->subsys->cmic & (1 << 3));
 }
 
 /*
-- 
2.12.3
