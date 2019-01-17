From: hare@suse.de (Hannes Reinecke)
Date: Thu, 17 Jan 2019 08:38:54 +0100
Subject: [PATCHv2] nvme: handle static ANA groups correctly
Message-ID: <20190117073854.40462-1-hare@suse.de>

Bit 6 in the ANACAP field signals that the group ID won't change
while the controller is attached.
The ANA parsing code tries to optimize for this case by only allocating
space for the ANA log header, omitting the group descriptors as they
won't change.
However, the code for processing the ANA log page always assumes the
entire log page, and hence gets the parsing wrong if the group
descriptors are missing.
This patch updates the parsing code to handle ANA log pages with only
the headers correctly.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index df4b3a6db51b..5e54c43a5e42 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -25,6 +25,8 @@ inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 	return multipath && ctrl->subsys && (ctrl->subsys->cmic & (1 << 3));
 }
 
+#define nvme_static_ana_grps(ctrl) ((ctrl)->anacap & (1 << 6))
+
 /*
  * If multipathing is enabled we need to always use the subsystem instance
  * number for numbering our devices to avoid conflicts between subsystems that
@@ -379,6 +381,24 @@ static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
 	mutex_unlock(&ns->head->lock);
 }
 
+static void nvme_update_grp_ana_state(struct nvme_ana_group_desc *desc,
+		struct nvme_ns *ns)
+{
+	enum nvme_ana_state old;
+
+	mutex_lock(&ns->head->lock);
+	if (ns->ana_grpid == le32_to_cpu(desc->grpid)) {
+		old = ns->ana_state;
+		ns->ana_state = desc->state;
+		clear_bit(NVME_NS_ANA_PENDING, &ns->flags);
+
+		if (nvme_state_is_live(ns->ana_state) &&
+		    !nvme_state_is_live(old))
+			nvme_mpath_set_live(ns);
+	}
+	mutex_unlock(&ns->head->lock);
+}
+
 static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
@@ -393,8 +413,15 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	if (desc->state == NVME_ANA_CHANGE)
 		(*nr_change_groups)++;
 
-	if (!nr_nsids)
+	if (!nr_nsids) {
+		if (nvme_static_ana_grps(ctrl)) {
+			down_write(&ctrl->namespaces_rwsem);
+			list_for_each_entry(ns, &ctrl->namespaces, list)
+				nvme_update_grp_ana_state(desc, ns);
+			up_write(&ctrl->namespaces_rwsem);
+		}
 		return 0;
+	}
 
 	down_write(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
@@ -415,6 +442,8 @@ static int nvme_read_ana_log(struct nvme_ctrl *ctrl, bool groups_only)
 	int error;
 
 	mutex_lock(&ctrl->ana_lock);
+	if (nvme_static_ana_grps(ctrl))
+		groups_only = true;
 	error = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_ANA,
 			groups_only ? NVME_ANA_LOG_RGO : 0,
 			ctrl->ana_log_buf, ctrl->ana_log_size, 0);
@@ -545,7 +574,7 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	timer_setup(&ctrl->anatt_timer, nvme_anatt_timeout, 0);
 	ctrl->ana_log_size = sizeof(struct nvme_ana_rsp_hdr) +
 		ctrl->nanagrpid * sizeof(struct nvme_ana_group_desc);
-	if (!(ctrl->anacap & (1 << 6)))
+	if (!nvme_static_ana_grps(ctrl))
 		ctrl->ana_log_size += ctrl->max_namespaces * sizeof(__le32);
 
 	if (ctrl->ana_log_size > ctrl->max_hw_sectors << SECTOR_SHIFT) {
-- 
2.16.4
