From: hare@suse.de (Hannes Reinecke)
Date: Fri,  3 May 2019 14:26:42 +0200
Subject: [PATCHv2 2/2] nvme: validate cntlid during controller initialisation
In-Reply-To: <20190503122642.59317-1-hare@suse.de>
References: <20190503122642.59317-1-hare@suse.de>
Message-ID: <20190503122642.59317-3-hare@suse.de>

From: Hannes Reinecke <hare@suse.com>

The CNTLID value is required to be unique, and we do rely on this
for correct operation. So reject any controller for which a non-unique
CNTLID has been detected.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cd16d98d1f1a..b0396135f097 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2358,6 +2358,25 @@ static int nvme_active_ctrls(struct nvme_subsystem *subsys)
 	return count;
 }
 
+static bool nvme_duplicate_cntlid(struct nvme_subsystem *subsys,
+				  struct nvme_ctrl *ctrl)
+{
+	struct nvme_ctrl *tmp;
+	bool ret = false;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(tmp, &subsys->ctrls, subsys_entry) {
+		if (tmp == ctrl)
+			continue;
+		if (tmp->cntlid == ctrl->cntlid) {
+			ret = true;
+			break;
+		}
+	}
+	mutex_unlock(&subsys->lock);
+	return ret;
+}
+
 static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
 	struct nvme_subsystem *subsys, *found;
@@ -2408,6 +2427,14 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 			ret = -EINVAL;
 			goto out_unlock;
 		}
+		if (nvme_duplicate_cntlid(found, ctrl)) {
+			dev_err(ctrl->device,
+				"Duplicate cntlid %u, rejecting\n",
+				ctrl->cntlid);
+			nvme_put_subsystem(found);
+			ret = -EINVAL;
+			goto out_unlock;
+		}
 
 		__nvme_release_subsystem(subsys);
 		subsys = found;
-- 
2.16.4
