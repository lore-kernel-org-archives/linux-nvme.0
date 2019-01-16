From: hare@suse.de (Hannes Reinecke)
Date: Wed, 16 Jan 2019 09:00:03 +0100
Subject: [PATCH] nvme: handle static ANA groups correctly
Message-ID: <20190116080003.3643-1-hare@suse.de>

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
 drivers/nvme/host/multipath.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index df4b3a6db51b..d6c9d9e343a5 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -379,6 +379,24 @@ static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
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
@@ -393,8 +411,15 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	if (desc->state == NVME_ANA_CHANGE)
 		(*nr_change_groups)++;
 
-	if (!nr_nsids)
+	if (!nr_nsids) {
+		if (ctrl->anacap & (1 << 6)) {
+			down_write(&ctrl->namespaces_rwsem);
+			list_for_each_entry(ns, &ctrl->namespaces, list)
+				nvme_update_grp_ana_state(desc, ns);
+			up_write(&ctrl->namespaces_rwsem);
+		}
 		return 0;
+	}
 
 	down_write(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
@@ -415,6 +440,8 @@ static int nvme_read_ana_log(struct nvme_ctrl *ctrl, bool groups_only)
 	int error;
 
 	mutex_lock(&ctrl->ana_lock);
+	if (ctrl->anacap & (1 << 6))
+		groups_only = true;
 	error = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_ANA,
 			groups_only ? NVME_ANA_LOG_RGO : 0,
 			ctrl->ana_log_buf, ctrl->ana_log_size, 0);
-- 
2.16.4
