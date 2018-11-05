From: hare@suse.de (Hannes Reinecke)
Date: Mon,  5 Nov 2018 16:41:36 +0100
Subject: [PATCH] nvme: make ANA support independent on native nvme multipath
Message-ID: <20181105154136.142597-1-hare@suse.de>

NVMe native multipathing is an implementation detail on the host,
and ANA support is actually independent on that.
So we shouldn't check for native NVMe multipathing when trying to
evaluate whether ANA is supported; not doing so results in the
ANA sysfs attributes not to be present when the 'multipath=false'
module option is set.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 4944ffdf6831..f7efcaeb2d98 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -22,7 +22,7 @@ MODULE_PARM_DESC(multipath,
 
 inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 {
-	return multipath && ctrl->subsys && (ctrl->subsys->cmic & (1 << 3));
+	return ctrl->subsys && (ctrl->subsys->cmic & (1 << 3));
 }
 
 /*
-- 
2.16.4
