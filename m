From: hare@suse.de (Hannes Reinecke)
Date: Fri, 29 Mar 2019 10:57:54 +0100
Subject: [PATCH] nvme-multipath: avoid crash on invalid subsystem cntlid
 enumeration
Message-ID: <20190329095754.109653-1-hare@suse.de>

The controller ID is supposed to be unique for each subsystem;
however, if it _isn't_ we will crash when calling device_add_disk()
for the namespaces.
While this surely is an error on the subsystem side we really shouldn't
crash. So simply use the 'instance' number when generating the disk
name to avoid this issue.

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
