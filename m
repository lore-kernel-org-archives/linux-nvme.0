From: hare@suse.de (Hannes Reinecke)
Date: Mon, 16 Jul 2018 12:58:36 +0200
Subject: [PATCH 4/5] nvme-multipath: disable ANA support if parsing fails
In-Reply-To: <20180716105837.101125-1-hare@suse.de>
References: <20180716105837.101125-1-hare@suse.de>
Message-ID: <20180716105837.101125-5-hare@suse.de>

If we cannot parse the ANA log page we should just disable ANA
support altogether, otherwise we fail to connect to the controller
and we have no way of figuring out what went wrong.
And we should kill the WARN_ON() statements as we now have a valid
recovery strategy.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c | 71 ++++++++++++++++++++++++++++++-------------
 2 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e84eb938b952..16128f03ae37 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3392,7 +3392,7 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 		break;
 #ifdef CONFIG_NVME_MULTIPATH
 	case NVME_AER_NOTICE_ANA:
-		if (WARN_ON_ONCE(!ctrl->ana_log_buf))
+		if (!ctrl->ana_log_buf)
 			break;
 		queue_work(nvme_wq, &ctrl->ana_work);
 		break;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 5205f41c0f6c..3ba7a975fd2a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -72,7 +72,7 @@ void nvme_failover_req(struct request *req)
 		 */
 		set_bit(NVME_NS_ANA_PENDING, &ns->flags);
 		nvme_mpath_clear_current_path(ns);
-		if (!WARN_ON_ONCE(!ns->ctrl->ana_log_buf))
+		if (ns->ctrl->ana_log_buf)
 			queue_work(nvme_wq, &ns->ctrl->ana_work);
 		break;
 	default:
@@ -303,26 +303,41 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
 		u32 nr_nsids = le32_to_cpu(desc->nnsids);
 		size_t nsid_buf_size = nr_nsids * sizeof(__le32);
 
-		if (WARN_ON_ONCE(desc->grpid == 0))
+		if (desc->grpid == 0) {
+			dev_dbg(ctrl->device,
+				"ANA group %d: invalid grpid\n", i);
 			return -EINVAL;
-		if (WARN_ON_ONCE(le32_to_cpu(desc->grpid) > ctrl->anagrpmax))
-			return -EINVAL;
-		if (WARN_ON_ONCE(desc->state == 0))
+		}
+		if (le32_to_cpu(desc->grpid) > ctrl->anagrpmax) {
+			dev_dbg(ctrl->device,
+				"ANA group %d: grpid too large (%d, max %d)\n",
+				i, le32_to_cpu(desc->grpid), ctrl->anagrpmax);
 			return -EINVAL;
-		if (WARN_ON_ONCE(desc->state > NVME_ANA_CHANGE))
+		}
+		if (desc->state == 0 || desc->state > NVME_ANA_CHANGE) {
+			dev_dbg(ctrl->device,
+				"ANA group %d: invalid ANA state %d\n",
+				i, desc->state);
 			return -EINVAL;
+		}
 
 		offset += sizeof(*desc);
-		if (WARN_ON_ONCE(offset > ctrl->ana_log_size - nsid_buf_size))
+		if (offset > ctrl->ana_log_size - nsid_buf_size) {
+			dev_dbg(ctrl->device,
+				"ANA group %d: descriptor overflow\n", i);
 			return -EINVAL;
+		}
 
 		error = cb(ctrl, desc, data);
 		if (error)
 			return error;
 
 		offset += nsid_buf_size;
-		if (WARN_ON_ONCE(offset > ctrl->ana_log_size - sizeof(*desc)))
+		if (offset > ctrl->ana_log_size - sizeof(*desc)) {
+			dev_dbg(ctrl->device,
+				"ANA group %d: end of buffer reached\n", i);
 			return -EINVAL;
+		}
 	}
 
 	return 0;
@@ -353,12 +368,12 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
 	u32 nr_nsids = le32_to_cpu(desc->nnsids), n = 0;
+	u32 grpid = le32_to_cpu(desc->grpid);
 	unsigned *nr_change_groups = data;
 	struct nvme_ns *ns;
 
 	dev_info(ctrl->device, "ANA group %d: %s.\n",
-			le32_to_cpu(desc->grpid),
-			nvme_ana_state_names[desc->state]);
+			grpid, nvme_ana_state_names[desc->state]);
 
 	if (desc->state == NVME_ANA_CHANGE)
 		(*nr_change_groups)++;
@@ -375,16 +390,23 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 			break;
 	}
 	up_write(&ctrl->namespaces_rwsem);
-	WARN_ON_ONCE(n < nr_nsids);
+	if (n < nr_nsids)
+		dev_dbg(ctrl->device,
+			"ANA group %d: only found %d of %d namespaces\n",
+			grpid, n, nr_nsids);
 	return 0;
 }
 
 static int nvme_read_ana_log(struct nvme_ctrl *ctrl, bool groups_only)
 {
 	u32 nr_change_groups = 0;
-	int error;
+	int error = -ENXIO;
 
 	mutex_lock(&ctrl->ana_lock);
+	if (!ctrl->ana_log_buf) {
+		dev_warn(ctrl->device, "ANA disabled, skip reading ANA log\n");
+		goto out_unlock;
+	}
 	error = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_ANA,
 			groups_only ? NVME_ANA_LOG_RGO : 0,
 			ctrl->ana_log_buf, ctrl->ana_log_size, 0);
@@ -395,8 +417,10 @@ static int nvme_read_ana_log(struct nvme_ctrl *ctrl, bool groups_only)
 
 	error = nvme_parse_ana_log(ctrl, &nr_change_groups,
 			nvme_update_ana_state);
-	if (error)
+	if (error) {
+		dev_warn(ctrl->device, "Failed to parse ANA log: %d\n", error);
 		goto out_unlock;
+	}
 
 	/*
 	 * In theory we should have an ANATT timer per group as they might enter
@@ -472,10 +496,16 @@ static int nvme_set_ns_ana_state(struct nvme_ctrl *ctrl,
 
 void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
+	int ret = -ENXIO;
+
 	if (nvme_ctrl_use_ana(ns->ctrl)) {
 		mutex_lock(&ns->ctrl->ana_lock);
 		ns->ana_grpid = le32_to_cpu(id->anagrpid);
-		nvme_parse_ana_log(ns->ctrl, ns, nvme_set_ns_ana_state);
+		if (ns->ctrl->ana_log_buf)
+			ret = nvme_parse_ana_log(ns->ctrl, ns,
+						 nvme_set_ns_ana_state);
+		if (ret)
+			ns->ana_state = NVME_ANA_OPTIMIZED;
 		mutex_unlock(&ns->ctrl->ana_lock);
 	} else {
 		mutex_lock(&ns->head->lock);
@@ -533,16 +563,15 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	INIT_WORK(&ctrl->ana_work, nvme_ana_work);
 	ctrl->ana_log_buf = kmalloc(ctrl->ana_log_size, GFP_KERNEL);
 	if (!ctrl->ana_log_buf)
-		goto out;
+		return -ENOMEM;
 
 	error = nvme_read_ana_log(ctrl, true);
-	if (error)
-		goto out_free_ana_log_buf;
+	if (error) {
+		dev_err(ctrl->device, "disabling ANA support.\n");
+		kfree(ctrl->ana_log_buf);
+		ctrl->ana_log_buf = NULL;
+	}
 	return 0;
-out_free_ana_log_buf:
-	kfree(ctrl->ana_log_buf);
-out:
-	return -ENOMEM;
 }
 
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
-- 
2.12.3
