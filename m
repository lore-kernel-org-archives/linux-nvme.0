From: hare@suse.de (Hannes Reinecke)
Date: Fri, 17 May 2019 13:29:12 +0200
Subject: [PATCH] nvme-multipath: handle ANA log parse failures gracefully
Message-ID: <20190517112912.47055-1-hare@suse.de>

When we're failing to parse the ANA log the ana log buffer will
not be allocated, causing a crash in nvme_mpath_add_disk().
This makes debugging impossible as no connection will be established,
and one cannot check why parsing failed.
So this patch will be emitting a warning for this situation, and
set the path to OPTIMIZED.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 499acf07d61a..9e67462541f1 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -373,6 +373,8 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
 	int error, i;
 
 	lockdep_assert_held(&ctrl->ana_lock);
+	if (!ctrl->ana_log_buf)
+		return -EINVAL;
 
 	for (i = 0; i < le16_to_cpu(ctrl->ana_log_buf->ngrps); i++) {
 		struct nvme_ana_group_desc *desc = base + offset;
@@ -583,17 +585,19 @@ static int nvme_set_ns_ana_state(struct nvme_ctrl *ctrl,
 
 void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
+	mutex_lock(&ns->ctrl->ana_lock);
 	if (nvme_ctrl_use_ana(ns->ctrl)) {
-		mutex_lock(&ns->ctrl->ana_lock);
 		ns->ana_grpid = le32_to_cpu(id->anagrpid);
-		nvme_parse_ana_log(ns->ctrl, ns, nvme_set_ns_ana_state);
-		mutex_unlock(&ns->ctrl->ana_lock);
-	} else {
-		mutex_lock(&ns->head->lock);
-		ns->ana_state = NVME_ANA_OPTIMIZED; 
-		nvme_mpath_set_live(ns);
-		mutex_unlock(&ns->head->lock);
+		if (!nvme_parse_ana_log(ns->ctrl, ns, nvme_set_ns_ana_state))
+			goto out_unlock;
+		dev_warn(ns->ctrl->device,
+			 "Failed to parse ANA log, set to OPTIMIZED\n");
 	}
+	ns->ana_state = NVME_ANA_OPTIMIZED;
+	nvme_mpath_set_live(ns);
+
+out_unlock:
+	mutex_unlock(&ns->ctrl->ana_lock);
 }
 
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
-- 
2.16.4
