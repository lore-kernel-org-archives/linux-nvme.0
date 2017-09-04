From: omri@excelero.com (Omri Mann)
Date: Mon,  4 Sep 2017 15:59:47 +0300
Subject: [PATCH] nvmet: Add support for reservations.
Message-ID: <1504529987-27343-1-git-send-email-omri@excelero.com>

Signed-off-by: Omri Mann <omri at excelero.com>
---
 drivers/nvme/target/admin-cmd.c   |  48 +++++
 drivers/nvme/target/core.c        |  24 +++
 drivers/nvme/target/fabrics-cmd.c |   2 +-
 drivers/nvme/target/io-cmd.c      | 414 ++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h       |  29 +++
 include/linux/nvme.h              |  30 ++-
 6 files changed, 545 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 3e1a255..fb88dd5 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -107,6 +107,35 @@ static u16 nvmet_get_smart_log(struct nvmet_req *req,
 	return status;
 }
 
+static u16 nvmet_get_rsrv_log(struct nvmet_req *req,
+		struct nvme_reservation_log *rlog)
+{
+	u16 status = NVME_SC_SUCCESS;
+	int remaining;
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_rsrv_log *p;
+
+	mutex_lock(&ctrl->lock);
+	ctrl->rsrv_log_async_sent = false;
+	if (!list_empty(&ctrl->rsrv_log)) {
+		remaining = 0;
+		list_for_each_entry(p, &ctrl->rsrv_log, link) {
+			if (++remaining == 256)
+				break;
+		}
+		rlog->num_avail = remaining - 1;
+		p = list_first_entry(&ctrl->rsrv_log,
+					struct nvmet_rsrv_log, link);
+		++ctrl->rsrv_log_counter;
+		rlog->count = cpu_to_le64(ctrl->rsrv_log_counter);
+		rlog->type = p->log_type;
+		rlog->nsid = cpu_to_le32(p->nsid);
+	}
+	mutex_unlock(&ctrl->lock);
+
+	return status;
+}
+
 static void nvmet_execute_get_log_page(struct nvmet_req *req)
 {
 	struct nvme_smart_log *smart_log;
@@ -156,6 +185,13 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		 * still claim to fully implement this mandatory log page.
 		 */
 		break;
+	case NVME_LOG_RESERVATION:
+		if (data_len != sizeof(struct nvme_reservation_log)) {
+			status = NVME_SC_INTERNAL;
+			goto err;
+		}
+		status = nvmet_get_rsrv_log(req, buf);
+		break;
 	default:
 		BUG();
 	}
@@ -456,6 +492,12 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 	case NVME_FEAT_HOST_ID:
 		status = NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
 		break;
+	case NVME_FEAT_RESV_MASK:
+		req->sq->ctrl->rsrv_mask =
+			le32_to_cpu(req->cmd->common.cdw10[1]);
+		break;
+	case NVME_FEAT_RESV_PERSIST:
+		break;
 	default:
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		break;
@@ -511,6 +553,11 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 			status = nvmet_copy_to_sgl(req, 0,
 			req->sq->ctrl->hostid, sizeof(req->sq->ctrl->hostid));
 		break;
+	case NVME_FEAT_RESV_MASK:
+		nvmet_set_result(req, req->sq->ctrl->rsrv_mask);
+		break;
+	case NVME_FEAT_RESV_PERSIST:
+		break;
 	default:
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		break;
@@ -565,6 +612,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 		case NVME_LOG_ERROR:
 		case NVME_LOG_SMART:
 		case NVME_LOG_FW_SLOT:
+		case NVME_LOG_RESERVATION:
 			req->execute = nvmet_execute_get_log_page;
 			return 0;
 		}
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 7c23eaf..3904d7e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -126,6 +126,27 @@ static void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 	schedule_work(&ctrl->async_event_work);
 }
 
+void add_reservation_log_page(struct nvmet_ctrl *ctrl,
+		struct nvmet_ns *ns, int type)
+{
+	struct nvmet_rsrv_log *p;
+
+	if (ctrl->rsrv_mask & (1 << type))
+		return;
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (p == NULL)
+		return;
+	p->nsid = ns->nsid;
+	p->log_type = type;
+	mutex_lock(&ctrl->lock);
+	list_add_tail(&p->link, &ctrl->rsrv_log);
+	mutex_unlock(&ctrl->lock);
+	if (!ctrl->rsrv_log_async_sent) {
+		ctrl->rsrv_log_async_sent = true;
+		nvmet_add_async_event(ctrl, 6, 0, NVME_LOG_RESERVATION);
+	}
+}
+
 int nvmet_register_transport(struct nvmet_fabrics_ops *ops)
 {
 	int ret = 0;
@@ -377,6 +398,8 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 
 	INIT_LIST_HEAD(&ns->dev_link);
 	init_completion(&ns->disable_done);
+	INIT_LIST_HEAD(&ns->rsrv_list);
+	mutex_init(&ns->rsrv_lock);
 
 	ns->nsid = nsid;
 	ns->subsys = subsys;
@@ -847,6 +870,7 @@ static void nvmet_ctrl_free(struct kref *ref)
 	nvmet_stop_keep_alive_timer(ctrl);
 
 	mutex_lock(&subsys->lock);
+	nvmet_rsrv_remove_ctrl(ctrl);
 	list_del(&ctrl->subsys_entry);
 	mutex_unlock(&subsys->lock);
 
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 40c8682..a13624f 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -154,7 +154,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 				  le32_to_cpu(c->kato), &ctrl);
 	if (status)
 		goto out;
-	memcpy(ctrl->hostid, d->hostid, sizeof(ctrl->hostid));
+	memcpy(ctrl->hostid, &d->hostid, sizeof(ctrl->hostid));
 
 	status = nvmet_install_queue(ctrl, req);
 	if (status) {
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 0d4c23d..376cd8c 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -40,6 +40,60 @@ static void nvmet_inline_bio_init(struct nvmet_req *req)
 	bio_init(bio, req->inline_bvec, NVMET_MAX_INLINE_BIOVEC);
 }
 
+static inline bool nvmet_ctrl_same_host(struct nvmet_ctrl *ctrl1,
+					struct nvmet_ctrl *ctrl2)
+{
+	static const u8 zero[sizeof(ctrl1->hostid)] = {0};
+
+	if (ctrl1 == NULL || ctrl2 == NULL)
+		return false;
+	if (ctrl1 == ctrl2)
+		return true;
+	if (memcmp(ctrl1->hostid, ctrl2->hostid, sizeof(ctrl1->hostid)) != 0)
+		return false;
+	if (memcmp(ctrl1->hostid, zero, sizeof(ctrl1->hostid)) == 0)
+		return false;
+	return true;
+}
+
+static struct nvmet_rsrv *nvmet_find_reservation(struct nvmet_req *req)
+{
+	struct nvmet_rsrv *p;
+
+	list_for_each_entry_rcu(p, &req->ns->rsrv_list, link) {
+		if (nvmet_ctrl_same_host(p->ctrl, req->sq->ctrl))
+			return p;
+	}
+	return NULL;
+}
+
+static bool nvmet_check_reservation(struct nvmet_req *req)
+{
+	bool success = true;
+
+	rcu_read_lock();
+	switch (req->ns->rsrv_type) {
+	case PR_WRITE_EXCLUSIVE:
+		if (req->cmd->rw.opcode == nvme_cmd_read)
+			goto out;
+	case PR_EXCLUSIVE_ACCESS:
+		success = nvmet_ctrl_same_host(req->ns->rsrv_ctrl,
+						req->sq->ctrl);
+		goto out;
+	case PR_WRITE_EXCLUSIVE_REG_ONLY:
+	case PR_WRITE_EXCLUSIVE_ALL_REGS:
+		if (req->cmd->rw.opcode == nvme_cmd_read)
+			goto out;
+	case PR_EXCLUSIVE_ACCESS_REG_ONLY:
+	case PR_EXCLUSIVE_ACCESS_ALL_REGS:
+		success = (nvmet_find_reservation(req) != NULL);
+	default:
+		goto out;
+	}
+out:
+	rcu_read_unlock();
+	return success;
+}
 static void nvmet_execute_rw(struct nvmet_req *req)
 {
 	int sg_cnt = req->sg_cnt;
@@ -196,6 +250,342 @@ static void nvmet_execute_write_zeroes(struct nvmet_req *req)
 	}
 }
 
+
+static void nvmet_execute_resv_register(struct nvmet_req *req)
+{
+	struct nvmet_rsrv *p;
+	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10[0]);
+	u16 status = NVME_SC_SUCCESS;
+	struct { u64 crkey, nrkey; } keys;
+
+	mutex_lock(&req->ns->rsrv_lock);
+	status = nvmet_copy_from_sgl(req, 0, &keys, sizeof(keys));
+	if (status)
+		goto out;
+	p = nvmet_find_reservation(req);
+	switch (cdw10 & 0x7) {
+	case 0:	/* Register */
+		if (p == NULL) {
+			p = kzalloc(sizeof(*p), GFP_KERNEL);
+			p->ctrl = req->sq->ctrl;
+			p->rkey = keys.nrkey;
+			list_add_tail_rcu(&p->link, &req->ns->rsrv_list);
+		} else if (p->rkey != keys.nrkey) {
+			status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+		}
+		break;
+	case 1:	/* Unregister */
+		if (p == NULL ||
+			(!(cdw10 & NVME_IEKEY) && p->rkey != keys.crkey)) {
+			status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+			goto out;
+		}
+		list_del_rcu(&p->link);
+		if (list_empty(&req->ns->rsrv_list) ||
+		    nvmet_ctrl_same_host(req->ns->rsrv_ctrl, req->sq->ctrl)) {
+			req->ns->rsrv_type = 0;
+			req->ns->rsrv_ctrl = NULL;
+		}
+		kfree_rcu(p, rcu_head);
+		break;
+	case 2:	/* Replace */
+		if (!(cdw10 & NVME_IEKEY) &&
+				(p == NULL || p->rkey != keys.crkey)) {
+			status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+			goto out;
+		}
+		if (p == NULL) {
+			p = kzalloc(sizeof(*p), GFP_KERNEL);
+			p->ctrl = req->sq->ctrl;
+			list_add_tail_rcu(&p->link, &req->ns->rsrv_list);
+		}
+		p->rkey = keys.nrkey;
+		break;
+	default:
+		status = NVME_SC_BAD_ATTRIBUTES | NVME_SC_DNR;
+	}
+	if (status == NVME_SC_SUCCESS)
+		++req->ns->rsrv_gen;
+out:
+	mutex_unlock(&req->ns->rsrv_lock);
+	nvmet_req_complete(req, status);
+}
+
+static u16 nvmet_execute_resv_report_short(struct nvmet_req *req)
+{
+	struct nvme_reservation_status stat;
+	typeof(stat.regctl_ds[0]) regctl;
+	struct nvmet_rsrv *p;
+	u16 count = 0;
+	int index;
+	size_t buflen = 4*(le32_to_cpu(req->cmd->common.cdw10[0]) + 1);
+
+	if (!req->ns)
+		return NVME_SC_INVALID_NS | NVME_SC_DNR;
+	memset(&stat, 0, sizeof(stat));
+	mutex_lock(&req->ns->rsrv_lock);
+	list_for_each_entry(p, &req->ns->rsrv_list, link)
+		++count;
+	stat.gen = cpu_to_le32(req->ns->rsrv_gen);
+	stat.rtype = req->ns->rsrv_type;
+	stat.regctl[0] = count & 0xff;
+	stat.regctl[1] = count >> 8;
+	stat.ptpls = 0;
+	nvmet_copy_to_sgl(req, 0, &stat, min(sizeof(stat), buflen));
+
+	memset(&regctl, 0, sizeof(regctl));
+	index = 1;
+	list_for_each_entry(p, &req->ns->rsrv_list, link) {
+		if (sizeof(regctl)*(index+1) > buflen)
+			break;
+		regctl.cntlid = p->ctrl->cntlid;
+		if (req->ns->rsrv_type != 0 && (req->ns->rsrv_ctrl == NULL ||
+		    nvmet_ctrl_same_host(p->ctrl, req->ns->rsrv_ctrl)))
+			regctl.rcsts = 1;
+		else
+			regctl.rcsts = 0;
+		memcpy(&regctl.hostid, p->ctrl->hostid, sizeof(regctl.hostid));
+		regctl.rkey = p->rkey;
+		nvmet_copy_to_sgl(req, sizeof(regctl)*index, &regctl,
+				sizeof(regctl));
+		++index;
+	}
+	mutex_unlock(&req->ns->rsrv_lock);
+
+	return NVME_SC_SUCCESS;
+}
+
+static u16 nvmet_execute_resv_report_ext(struct nvmet_req *req)
+{
+	struct nvme_reservation_status_ext stat;
+	typeof(stat.regctl_eds[0]) regctl;
+	struct nvmet_rsrv *p;
+	u16 count = 0;
+	int index;
+	size_t buflen = 4*(le32_to_cpu(req->cmd->common.cdw10[0]) + 1);
+
+	if (!req->ns)
+		return NVME_SC_INVALID_NS | NVME_SC_DNR;
+	memset(&stat, 0, sizeof(stat));
+	mutex_lock(&req->ns->rsrv_lock);
+	list_for_each_entry(p, &req->ns->rsrv_list, link)
+		++count;
+	stat.gen = cpu_to_le32(req->ns->rsrv_gen);
+	stat.rtype = req->ns->rsrv_type;
+	stat.regctl[0] = count & 0xff;
+	stat.regctl[1] = count >> 8;
+	stat.ptpls = 0;
+	nvmet_copy_to_sgl(req, 0, &stat, min(sizeof(stat), buflen));
+
+	memset(&regctl, 0, sizeof(regctl));
+	index = 1;
+	list_for_each_entry(p, &req->ns->rsrv_list, link) {
+		if (sizeof(regctl)*(index+1) > buflen)
+			break;
+		regctl.cntlid = p->ctrl->cntlid;
+		if (req->ns->rsrv_type != 0 && (req->ns->rsrv_ctrl == NULL ||
+		    nvmet_ctrl_same_host(p->ctrl, req->ns->rsrv_ctrl)))
+			regctl.rcsts = 1;
+		else
+			regctl.rcsts = 0;
+		memcpy(&regctl.hostid, p->ctrl->hostid, sizeof(regctl.hostid));
+		regctl.rkey = p->rkey;
+		nvmet_copy_to_sgl(req, sizeof(regctl)*index, &regctl,
+				sizeof(regctl));
+		++index;
+	}
+	mutex_unlock(&req->ns->rsrv_lock);
+
+	return NVME_SC_SUCCESS;
+}
+
+static void nvmet_execute_resv_report(struct nvmet_req *req)
+{
+	u16 status;
+
+	if (le32_to_cpu(req->cmd->common.cdw10[1]) & 1)
+		status = nvmet_execute_resv_report_ext(req);
+	else
+		status = nvmet_execute_resv_report_short(req);
+	nvmet_req_complete(req, status);
+}
+
+static void nvmet_execute_resv_acquire(struct nvmet_req *req)
+{
+	struct nvmet_rsrv *p, *nextp;
+	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10[0]);
+	u16 status = NVME_SC_SUCCESS;
+	u64 crkey;
+	u64 prkey;
+
+	mutex_lock(&req->ns->rsrv_lock);
+	p = nvmet_find_reservation(req);
+	if (p == NULL) {
+		status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+		goto out;
+	}
+	if (!(cdw10 & NVME_IEKEY)) {
+		status = nvmet_copy_from_sgl(req, 0, &crkey, sizeof(crkey));
+		if (status)
+			goto out;
+		if (p->rkey != crkey) {
+			status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+			goto out;
+		}
+	}
+	switch (cdw10 & 0x7) {
+	case 0:		/* Aquire */
+		if (req->ns->rsrv_type != 0 &&
+		    (req->ns->rsrv_type != ((cdw10 >> 8) & 0xff) ||
+		    !nvmet_ctrl_same_host(req->ns->rsrv_ctrl, req->sq->ctrl))) {
+			status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+			goto out;
+		}
+		req->ns->rsrv_type = (cdw10 >> 8) & 0xff;
+		if (req->ns->rsrv_type != PR_WRITE_EXCLUSIVE_ALL_REGS &&
+		    req->ns->rsrv_type != PR_EXCLUSIVE_ACCESS_ALL_REGS)
+			req->ns->rsrv_ctrl = req->sq->ctrl;
+		else
+			req->ns->rsrv_ctrl = NULL;
+		break;
+	case 2:	/* Preempt and Abort */
+		/* We cannot abort, so we will sync the device to make sure
+		 * all pending I/Os are done before we return
+		 */
+	case 1:		/* Preempt */
+		status = nvmet_copy_from_sgl(req, 8, &prkey, sizeof(prkey));
+		if (status)
+			goto out;
+		list_for_each_entry_safe(p, nextp, &req->ns->rsrv_list, link) {
+			if (p->rkey == prkey) {
+				list_del_rcu(&p->link);
+				add_reservation_log_page(req->sq->ctrl, req->ns,
+							1);
+				kfree_rcu(p, rcu_head);
+			}
+		}
+		++req->ns->rsrv_gen;
+		break;
+	default:
+		status = NVME_SC_BAD_ATTRIBUTES | NVME_SC_DNR;
+		goto out;
+	}
+out:
+	mutex_unlock(&req->ns->rsrv_lock);
+	if ((cdw10 & 0x7) == 2 && status == NVME_SC_SUCCESS)
+		sync_blockdev(req->ns->bdev);		/* Preempt and abort */
+	nvmet_req_complete(req, status);
+}
+
+static void nvmet_execute_resv_release(struct nvmet_req *req)
+{
+	struct nvmet_rsrv *p;
+	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10[0]);
+	u16 status;
+	u64 crkey;
+
+	mutex_lock(&req->ns->rsrv_lock);
+	p = nvmet_find_reservation(req);
+	if (p == NULL) {
+		status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+		goto out;
+	}
+	if (!(cdw10 & NVME_IEKEY)) {
+		status = nvmet_copy_from_sgl(req, 0, &crkey, sizeof(crkey));
+		if (status)
+			goto out;
+		if (p->rkey != crkey) {
+			status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+			goto out;
+		}
+	}
+	if ((cdw10 & 0x7) == 0) {	/* Relase */
+		if (req->ns->rsrv_type == 0) {
+			status = NVME_SC_SUCCESS;
+			goto out;
+		}
+		if (((cdw10 >> 8) & 0xff) != req->ns->rsrv_type) {
+			status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+			goto out;
+		}
+		if (req->ns->rsrv_type != PR_WRITE_EXCLUSIVE_ALL_REGS &&
+		    req->ns->rsrv_type != PR_EXCLUSIVE_ACCESS_ALL_REGS &&
+		    !nvmet_ctrl_same_host(req->ns->rsrv_ctrl, req->sq->ctrl)) {
+			/* We are not the reservation holders,
+			 * silently ignore relase request.
+			 */
+			status = NVME_SC_SUCCESS;
+			goto out;
+		}
+	} else if ((cdw10 & 0x7) == 1) { /* Clear */
+		while (!list_empty(&req->ns->rsrv_list)) {
+			p = list_first_entry(&req->ns->rsrv_list,
+					struct nvmet_rsrv, link);
+			if (!nvmet_ctrl_same_host(p->ctrl, req->sq->ctrl)) {
+				/* Registration Preempted notification */
+				add_reservation_log_page(p->ctrl, req->ns, 1);
+			}
+			list_del_rcu(&p->link);
+			kfree_rcu(p, rcu_head);
+		}
+		++req->ns->rsrv_gen;
+	} else {
+		status = NVME_SC_BAD_ATTRIBUTES | NVME_SC_DNR;
+		goto out;
+	}
+	if (req->ns->rsrv_type != PR_WRITE_EXCLUSIVE &&
+	    req->ns->rsrv_type != PR_EXCLUSIVE_ACCESS) {
+		list_for_each_entry(p, &req->ns->rsrv_list, link) {
+			if (!nvmet_ctrl_same_host(p->ctrl, req->sq->ctrl)) {
+				/* Reservation Released notification */
+				add_reservation_log_page(p->ctrl, req->ns, 2);
+			}
+		}
+	}
+	req->ns->rsrv_type = 0;
+	req->ns->rsrv_ctrl = NULL;
+out:
+	mutex_unlock(&req->ns->rsrv_lock);
+	nvmet_req_complete(req, status);
+}
+
+void nvmet_rsrv_remove_ctrl(struct nvmet_ctrl *ctrl)
+{
+	struct nvmet_subsys *subsys = ctrl->subsys;
+	struct nvmet_ctrl *c, *alt_ctrl = NULL;
+	struct nvmet_ns *ns;
+	struct nvmet_rsrv *r, *nr;
+
+	list_for_each_entry(c, &subsys->ctrls, subsys_entry) {
+		if (c != ctrl && nvmet_ctrl_same_host(c, ctrl)) {
+			alt_ctrl = c;
+			break;
+		}
+	}
+	list_for_each_entry(ns, &subsys->namespaces, dev_link) {
+		mutex_lock(&ns->rsrv_lock);
+		list_for_each_entry_safe(r, nr, &ns->rsrv_list, link) {
+			if (r->ctrl == ctrl) {
+				if (alt_ctrl != NULL)
+					r->ctrl = alt_ctrl;
+				else {
+					list_del_rcu(&r->link);
+					kfree_rcu(r, rcu_head);
+				}
+			}
+		}
+		if (list_empty(&ns->rsrv_list)) {
+			ns->rsrv_ctrl = NULL;
+			ns->rsrv_type = 0;
+		} else if (ns->rsrv_ctrl == ctrl) {
+			ns->rsrv_ctrl = alt_ctrl;
+			if (alt_ctrl == NULL)
+				ns->rsrv_type = 0;
+		}
+		mutex_unlock(&ns->rsrv_lock);
+	}
+}
+
 u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
@@ -214,21 +604,45 @@ u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	switch (cmd->common.opcode) {
 	case nvme_cmd_read:
 	case nvme_cmd_write:
+		if (!nvmet_check_reservation(req))
+			return NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
 		req->execute = nvmet_execute_rw;
 		req->data_len = nvmet_rw_len(req);
 		return 0;
 	case nvme_cmd_flush:
+		if (!nvmet_check_reservation(req))
+			return NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
 		req->execute = nvmet_execute_flush;
 		req->data_len = 0;
 		return 0;
 	case nvme_cmd_dsm:
+		if (!nvmet_check_reservation(req))
+			return NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
 		req->execute = nvmet_execute_dsm;
 		req->data_len = (le32_to_cpu(cmd->dsm.nr) + 1) *
 			sizeof(struct nvme_dsm_range);
 		return 0;
 	case nvme_cmd_write_zeroes:
+		if (!nvmet_check_reservation(req))
+			return NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
 		req->execute = nvmet_execute_write_zeroes;
 		return 0;
+	case nvme_cmd_resv_register:
+		req->execute = nvmet_execute_resv_register;
+		req->data_len = 16;
+		return 0;
+	case nvme_cmd_resv_report:
+		req->execute = nvmet_execute_resv_report;
+		req->data_len = 4*(le32_to_cpu(cmd->common.cdw10[0])+1);
+		return 0;
+	case nvme_cmd_resv_acquire:
+		req->execute = nvmet_execute_resv_acquire;
+		req->data_len = 16;
+		return 0;
+	case nvme_cmd_resv_release:
+		req->execute = nvmet_execute_resv_release;
+		req->data_len = 8;
+		return 0;
 	default:
 		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
 		       req->sq->qid);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 918c557..bcf3eec 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -26,6 +26,7 @@
 #include <linux/configfs.h>
 #include <linux/rcupdate.h>
 #include <linux/blkdev.h>
+#include <linux/pr.h>
 
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
@@ -57,6 +58,12 @@ struct nvmet_ns {
 	struct config_group	group;
 
 	struct completion	disable_done;
+
+	struct mutex		rsrv_lock;
+	struct list_head	rsrv_list;
+	struct nvmet_ctrl	*rsrv_ctrl;
+	enum pr_type		rsrv_type;
+	u32			rsrv_gen;
 };
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
@@ -134,6 +141,11 @@ struct nvmet_ctrl {
 
 	char			subsysnqn[NVMF_NQN_FIELD_LEN];
 	char			hostnqn[NVMF_NQN_FIELD_LEN];
+
+	struct list_head	rsrv_log;
+	u64			rsrv_log_counter;
+	u32			rsrv_mask;
+	bool			rsrv_log_async_sent;
 };
 
 struct nvmet_subsys {
@@ -231,6 +243,19 @@ struct nvmet_req {
 	struct nvmet_fabrics_ops *ops;
 };
 
+struct nvmet_rsrv {
+	struct list_head	link;
+	struct nvmet_ctrl	*ctrl;
+	u64			rkey;
+	struct rcu_head		rcu_head;
+};
+
+struct nvmet_rsrv_log {
+	struct list_head	link;
+	u32			nsid;
+	u8			log_type;
+};
+
 static inline void nvmet_set_status(struct nvmet_req *req, u16 status)
 {
 	req->rsp->status = cpu_to_le16(status << 1);
@@ -332,4 +357,8 @@ u16 nvmet_copy_from_sgl(struct nvmet_req *req, off_t off, void *buf,
 bool nvmet_host_allowed(struct nvmet_req *req, struct nvmet_subsys *subsys,
 		const char *hostnqn);
 
+void add_reservation_log_page(struct nvmet_ctrl *ctrl, struct nvmet_ns *ns,
+		int type);
+void nvmet_rsrv_remove_ctrl(struct nvmet_ctrl *ctrl);
+
 #endif /* _NVMET_H */
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 05560c2..bcf9184 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -393,6 +393,15 @@ struct nvme_fw_slot_info_log {
 	__u8			rsvd64[448];
 };
 
+struct nvme_reservation_log {
+	__le64			count;
+	__u8			type;
+	__u8			num_avail;
+	__u16			rsvd2;
+	__le32			nsid;
+	__u8			rsvd48[48];
+};
+
 enum {
 	NVME_SMART_CRIT_SPARE		= 1 << 0,
 	NVME_SMART_CRIT_TEMPERATURE	= 1 << 1,
@@ -432,7 +441,7 @@ struct nvme_reservation_status {
 	__u8	regctl[2];
 	__u8	resv5[2];
 	__u8	ptpls;
-	__u8	resv10[13];
+	__u8	resv10[14];
 	struct {
 		__le16	cntlid;
 		__u8	rcsts;
@@ -442,6 +451,24 @@ struct nvme_reservation_status {
 	} regctl_ds[];
 };
 
+struct nvme_reservation_status_ext {
+	__le32	gen;
+	__u8	rtype;
+	__u8	regctl[2];
+	__u8	resv5[2];
+	__u8	ptpls;
+	__u8	resv10[14];
+	__u8	resv24[40];
+	struct {
+		__le16	cntlid;
+		__u8	rcsts;
+		__u8	resv3[5];
+		__le64	rkey;
+		__u8	hostid[16];
+		__u8	resv32[32];
+	} regctl_eds[];
+};
+
 enum nvme_async_event_type {
 	NVME_AER_TYPE_ERROR	= 0,
 	NVME_AER_TYPE_SMART	= 1,
@@ -709,6 +736,7 @@ enum {
 	NVME_FWACT_REPL		= (0 << 3),
 	NVME_FWACT_REPL_ACTV	= (1 << 3),
 	NVME_FWACT_ACTV		= (2 << 3),
+	NVME_IEKEY		= (1 << 3),
 };
 
 struct nvme_identify {
-- 
1.8.3.1
