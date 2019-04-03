From: hare@suse.de (Hannes Reinecke)
Date: Thu,  4 Apr 2019 00:41:57 +0200
Subject: [PATCH 1/2] nvme-multipath: avoid crash on invalid subsystem cntlid
 enumeration
In-Reply-To: <20190403224158.58106-1-hare@suse.de>
References: <20190403224158.58106-1-hare@suse.de>
Message-ID: <20190403224158.58106-2-hare@suse.de>

A process holding an open reference to a removed disk prevents it
from completing deletion, so its name continues to exist. A subsequent
gendisk creation may have the same cntlid which risks collision when
using that for the name. Use the unique ctrl->instance instead.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f0716f6ce41f..2551264ef2b5 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -31,7 +31,7 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 		sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
 	} else if (ns->head->disk) {
 		sprintf(disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
-				ctrl->cntlid, ns->head->instance);
+				ctrl->instance, ns->head->instance);
 		*flags = GENHD_FL_HIDDEN;
 	} else {
 		sprintf(disk_name, "nvme%dn%d", ctrl->subsys->instance,
-- 
2.16.4
