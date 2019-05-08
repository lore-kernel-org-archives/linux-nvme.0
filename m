From: hch@lst.de (Christoph Hellwig)
Date: Wed,  8 May 2019 09:55:08 +0200
Subject: [PATCH,
 RFC 2/2] nvme: validate cntlid during controller initialisation
In-Reply-To: <20190508075508.28552-1-hch@lst.de>
References: <20190508075508.28552-1-hch@lst.de>
Message-ID: <20190508075508.28552-2-hch@lst.de>

The CNTLID value is required to be unique, and we do rely on this
for correct operation. So reject any controller for which a non-unique
CNTLID has been detected.

Based on a patch from Hannes Reinecke.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 41 +++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4f4ffcce7416..ce258cbdc642 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2341,18 +2341,33 @@ static const struct attribute_group *nvme_subsys_attrs_groups[] = {
 	NULL,
 };
 
-static int nvme_active_ctrls(struct nvme_subsystem *subsys)
+static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
+		struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
-	int count = 0;
-	struct nvme_ctrl *ctrl;
+	struct nvme_ctrl *tmp;
 
-	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
-		if (ctrl->state != NVME_CTRL_DELETING &&
-		    ctrl->state != NVME_CTRL_DEAD)
-			count++;
+	list_for_each_entry(tmp, &subsys->ctrls, subsys_entry) {
+		if (ctrl->state == NVME_CTRL_DELETING ||
+		    ctrl->state == NVME_CTRL_DEAD)
+			continue;
+
+		if (tmp->cntlid == ctrl->cntlid) {
+			dev_err(ctrl->device,
+				"Duplicate cntlid %u, rejecting\n",
+				ctrl->cntlid);
+			return false;
+		}
+
+		if ((id->cmic & (1 << 1)) ||
+		    (ctrl->opts && ctrl->opts->discovery_nqn))
+		    	continue;
+
+		dev_err(ctrl->device,
+			"Subsystem does not support multiple controllers\n");
+		return false;
 	}
 
-	return count;
+	return true;
 }
 
 static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
@@ -2395,15 +2410,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		__nvme_release_subsystem(subsys);
 		subsys = found;
 
-		/*
-		 * Verify that the subsystem actually supports multiple
-		 * controllers, else bail out.
-		 */
-		if (!(ctrl->opts && ctrl->opts->discovery_nqn) &&
-		    nvme_active_ctrls(found) && !(id->cmic & (1 << 1))) {
-			dev_err(ctrl->device,
-				"ignoring ctrl due to duplicate subnqn (%s).\n",
-				subsys->subnqn);
+		if (!nvme_validate_cntlid(subsys, ctrl, id)) {
 			ret = -EINVAL;
 			goto out_put_subsystem;
 		}
-- 
2.20.1
