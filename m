From: hare@suse.de (Hannes Reinecke)
Date: Tue, 19 Feb 2019 13:13:58 +0100
Subject: [PATCH 2/2] nvme: protect against race condition in nvme_validate_ns()
In-Reply-To: <20190219121358.57975-1-hare@suse.de>
References: <20190219121358.57975-1-hare@suse.de>
Message-ID: <20190219121358.57975-3-hare@suse.de>

When subsystems are rapidly reconfigured (or sending out several AENs)
we might end up in a situation where several instances of nvme_scan_work()
are running. Each of which might be trying to register the same nsid,
so nvme_find_get_ns() in nvme_validate_ns() will return 0 for both,
resulting in a crash in nvme_alloc_ns() as both are registering a
gendisk with the same name.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9c6f6a4db60a..7cf710e8d98d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3216,7 +3216,7 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
 
 static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
-	struct nvme_ns *ns;
+	struct nvme_ns *ns, *tmp;
 	struct gendisk *disk;
 	struct nvme_id_ns *id;
 	char disk_name[DISK_NAME_LEN];
@@ -3286,6 +3286,15 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	}
 
 	down_write(&ctrl->namespaces_rwsem);
+	list_for_each_entry(tmp, &ctrl->namespaces, list) {
+		if (nsid == tmp->head->ns_id) {
+			up_write(&ctrl->namespaces_rwsem);
+			dev_warn(ctrl->device,
+				 "Duplicate ns %d, rescanning", nsid);
+			ret = -EAGAIN;
+			goto out_put_disk;
+		}
+	}
 	list_add_tail(&ns->list, &ctrl->namespaces);
 	up_write(&ctrl->namespaces_rwsem);
 
@@ -3343,14 +3352,19 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns;
+	int ret;
 
+rescan:
 	ns = nvme_find_get_ns(ctrl, nsid);
 	if (ns) {
 		if (ns->disk && revalidate_disk(ns->disk))
 			nvme_ns_remove(ns);
 		nvme_put_ns(ns);
-	} else
-		nvme_alloc_ns(ctrl, nsid);
+	} else {
+		ret = nvme_alloc_ns(ctrl, nsid);
+		if (ret == -EAGAIN)
+			goto rescan;
+	}
 }
 
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
-- 
2.16.4
