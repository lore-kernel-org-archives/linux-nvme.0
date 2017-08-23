From: omri@excelero.com (Omri Mann)
Date: Wed, 23 Aug 2017 17:04:48 +0300
Subject: [PATCH] Add support for reservations to NVMeoF target
Message-ID: <1503497088-12775-1-git-send-email-omri@excelero.com>

---
 drivers/nvme/target/admin-cmd.c |  42 +++++
 drivers/nvme/target/core.c      |  24 +++
 drivers/nvme/target/io-cmd.c    | 365 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h     |  29 ++++
 4 files changed, 460 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index a53bb66..9695af7 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -156,6 +156,30 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		 * still claim to fully implement this mandatory log page.
 		 */
 		break;
+	case NVME_LOG_RESERVATION:
+		if (data_len < 16) {
+			status = NVME_SC_INTERNAL;
+			goto err;
+		}
+		mutex_lock(&req->sq->ctrl->lock);
+		req->sq->ctrl->rsrv_log_async_sent = false;
+		if (!list_empty(&req->sq->ctrl->rsrv_log)) {
+			struct nvmet_rsrv_log *p;
+
+			list_for_each_entry(p, &req->sq->ctrl->rsrv_log, link) {
+				if (++((u8 *)buf)[9] == 255)
+					break;
+			}
+			p = list_first_entry(&req->sq->ctrl->rsrv_log,
+					     struct nvmet_rsrv_log, link);
+			++req->sq->ctrl->rsrv_log_counter;
+			*(__le64 *)buf =
+				cpu_to_le64(&req->sq->ctrl->rsrv_log_counter);
+			((u8 *)buf)[8] = p->log_type;
+			*(__le32 *)(buf+12) = cpu_to_le32(p->nsid);
+		}
+		mutex_unlock(&req->sq->ctrl->lock);
+		break;
 	default:
 		BUG();
 	}
@@ -461,6 +485,15 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 		req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
 		nvmet_set_result(req, req->sq->ctrl->kato);
 		break;
+	case NVME_FEAT_HOST_ID:
+		status = nvmet_copy_from_sgl(req, 0, &req->sq->ctrl->host_id,
+						8);
+		break;
+	case NVME_FEAT_RESV_MASK:
+		req->sq->ctrl->rsrv_mask = req->cmd->common.cdw10[1];
+		break;
+	case NVME_FEAT_RESV_PERSIST:
+		break;
 	default:
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		break;
@@ -509,6 +542,14 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 	case NVME_FEAT_KATO:
 		nvmet_set_result(req, req->sq->ctrl->kato * 1000);
 		break;
+	case NVME_FEAT_HOST_ID:
+		status = nvmet_copy_to_sgl(req, 0, &req->sq->ctrl->host_id, 8);
+		break;
+	case NVME_FEAT_RESV_MASK:
+		nvmet_set_result(req, req->sq->ctrl->rsrv_mask);
+		break;
+	case NVME_FEAT_RESV_PERSIST:
+		break;
 	default:
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		break;
@@ -563,6 +604,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 		case NVME_LOG_ERROR:
 		case NVME_LOG_SMART:
 		case NVME_LOG_FW_SLOT:
+		case NVME_LOG_RESERVATION:
 			req->execute = nvmet_execute_get_log_page;
 			return 0;
 		}
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index f4b02bb..3cd0546 100644
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
+	rwlock_init(&ns->rsrv_lock);
 
 	ns->nsid = nsid;
 	ns->subsys = subsys;
@@ -846,6 +869,7 @@ static void nvmet_ctrl_free(struct kref *ref)
 	nvmet_stop_keep_alive_timer(ctrl);
 
 	mutex_lock(&subsys->lock);
+	nvmet_rsrv_remove_ctrl(ctrl);
 	list_del(&ctrl->subsys_entry);
 	mutex_unlock(&subsys->lock);
 
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 3b4d47a..4eb4182 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -16,6 +16,8 @@
 #include <linux/module.h>
 #include "nvmet.h"
 
+#define IEKEY	0x8	/* Ignore Existing Key */
+
 static void nvmet_bio_done(struct bio *bio)
 {
 	struct nvmet_req *req = bio->bi_private;
@@ -40,6 +42,57 @@ static void nvmet_inline_bio_init(struct nvmet_req *req)
 	bio_init(bio, req->inline_bvec, NVMET_MAX_INLINE_BIOVEC);
 }
 
+static inline bool nvmet_ctrl_same_host(struct nvmet_ctrl *ctrl1,
+					struct nvmet_ctrl *ctrl2)
+{
+	if (ctrl1 == NULL || ctrl2 == NULL)
+		return false;
+	if (ctrl1 == ctrl2)
+		return true;
+	if (ctrl1->host_id != 0 && ctrl1->host_id == ctrl2->host_id)
+		return true;
+	return false;
+}
+
+static struct nvmet_rsrv *nvmet_find_reservation(struct nvmet_req *req)
+{
+	struct nvmet_rsrv *p;
+
+	list_for_each_entry(p, &req->ns->rsrv_list, link) {
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
+	read_lock(&req->ns->rsrv_lock);
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
+	read_unlock(&req->ns->rsrv_lock);
+	return success;
+}
+
 static void nvmet_execute_rw(struct nvmet_req *req)
 {
 	int sg_cnt = req->sg_cnt;
@@ -196,6 +249,296 @@ static void nvmet_execute_write_zeroes(struct nvmet_req *req)
 	}
 }
 
+static void nvmet_execute_resv_register(struct nvmet_req *req)
+{
+	struct nvmet_rsrv *p;
+	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10[0]);
+	u16 status = NVME_SC_SUCCESS;
+	struct { u64 crkey, nrkey; } keys;
+
+	write_lock(&req->ns->rsrv_lock);
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
+			list_add_tail(&p->link, &req->ns->rsrv_list);
+		} else if (p->rkey != keys.nrkey) {
+			status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+		}
+		break;
+	case 1:	/* Unregister */
+		if (p == NULL || (!(cdw10 & IEKEY) && p->rkey != keys.crkey)) {
+			status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+			goto out;
+		}
+		list_del(&p->link);
+		if (list_empty(&req->ns->rsrv_list) ||
+		    nvmet_ctrl_same_host(req->ns->rsrv_ctrl, req->sq->ctrl)) {
+			req->ns->rsrv_type = 0;
+			req->ns->rsrv_ctrl = NULL;
+		}
+		kfree(p);
+		break;
+	case 2:	/* Replace */
+		if (!(cdw10 & IEKEY) && (p == NULL || p->rkey != keys.crkey)) {
+			status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+			goto out;
+		}
+		if (p == NULL) {
+			p = kzalloc(sizeof(*p), GFP_KERNEL);
+			p->ctrl = req->sq->ctrl;
+			list_add_tail(&p->link, &req->ns->rsrv_list);
+		}
+		p->rkey = keys.nrkey;
+		break;
+	default:
+		status = NVME_SC_BAD_ATTRIBUTES | NVME_SC_DNR;
+	}
+	if (status == NVME_SC_SUCCESS)
+		++req->ns->rsrv_gen;
+out:
+	write_unlock(&req->ns->rsrv_lock);
+	nvmet_req_complete(req, status);
+}
+
+static void nvmet_execute_resv_report(struct nvmet_req *req)
+{
+	union {
+		struct {
+			__le32	gen;
+			u8	rtype;
+			__le16	regctls;
+			u16	rsvd2;
+			u8	ptpls;
+			u8	rsvd14[14];
+		} __packed hdr;
+		struct {
+			__le16	cntlid;
+			u8	rcsts;
+			u8	rsvd5[5];
+			__le64	hostid;
+			__le64	rkey;
+		} __packed cntrl;
+	} u;
+	struct nvmet_rsrv *p;
+	u16 count = 0;
+	int index;
+	int buflen = 4*(le32_to_cpu(req->cmd->common.cdw10[0]) + 1);
+
+	BUILD_BUG_ON(sizeof(u) != 24);
+
+	memset(&u, 0, sizeof(u));
+	read_lock(&req->ns->rsrv_lock);
+	list_for_each_entry(p, &req->ns->rsrv_list, link)
+		++count;
+	u.hdr.gen = cpu_to_le32(req->ns->rsrv_gen);
+	u.hdr.rtype = req->ns->rsrv_type;
+	u.hdr.regctls = cpu_to_le16(count);
+	nvmet_copy_to_sgl(req, 0, &u, min(buflen, 24));
+	buflen -= 24;
+
+	memset(&u, 0, sizeof(u));
+	index = 1;
+	list_for_each_entry(p, &req->ns->rsrv_list, link) {
+		if (buflen <= 0)
+			break;
+		u.cntrl.cntlid = p->ctrl->cntlid;
+		if (req->ns->rsrv_type != 0 && (req->ns->rsrv_ctrl == NULL ||
+		    nvmet_ctrl_same_host(p->ctrl, req->ns->rsrv_ctrl)))
+			u.cntrl.rcsts = 1;
+		else
+			u.cntrl.rcsts = 0;
+		u.cntrl.hostid = p->ctrl->host_id;
+		u.cntrl.rkey = p->rkey;
+		nvmet_copy_to_sgl(req, 24*index, &u, min(buflen, 24));
+		++index;
+		buflen -= 24;
+	}
+
+	read_unlock(&req->ns->rsrv_lock);
+	nvmet_req_complete(req, NVME_SC_SUCCESS);
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
+	write_lock(&req->ns->rsrv_lock);
+	p = nvmet_find_reservation(req);
+	if (p == NULL) {
+		status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+		goto out;
+	}
+	if (!(cdw10 & IEKEY)) {
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
+				list_del(&p->link);
+				add_reservation_log_page(req->sq->ctrl, req->ns,
+							1);
+				kfree(p);
+			}
+		}
+		++req->ns->rsrv_gen;
+		break;
+	default:
+		status = NVME_SC_BAD_ATTRIBUTES | NVME_SC_DNR;
+		goto out;
+	}
+out:
+	write_unlock(&req->ns->rsrv_lock);
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
+	write_lock(&req->ns->rsrv_lock);
+	p = nvmet_find_reservation(req);
+	if (p == NULL) {
+		status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+		goto out;
+	}
+	if (!(cdw10 & IEKEY)) {
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
+			list_del(&p->link);
+			kfree(p);
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
+	write_unlock(&req->ns->rsrv_lock);
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
+		list_for_each_entry_safe(r, nr, &ns->rsrv_list, link) {
+			if (r->ctrl == ctrl) {
+				if (alt_ctrl != NULL)
+					r->ctrl = alt_ctrl;
+				else {
+					list_del(&r->link);
+					kfree(r);
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
+	}
+}
+
 u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
@@ -214,6 +557,8 @@ u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	switch (cmd->common.opcode) {
 	case nvme_cmd_read:
 	case nvme_cmd_write:
+		if (!nvmet_check_reservation(req))
+			return NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
 		req->execute = nvmet_execute_rw;
 		req->data_len = nvmet_rw_len(req);
 		return 0;
@@ -222,13 +567,33 @@ u16 nvmet_parse_io_cmd(struct nvmet_req *req)
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
index e3b244c..9ddaac4 100644
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
+	rwlock_t		rsrv_lock;
+	struct list_head	rsrv_list;
+	struct nvmet_ctrl	*rsrv_ctrl;
+	enum pr_type		rsrv_type;
+	u32			rsrv_gen;
 };
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
@@ -132,6 +139,12 @@ struct nvmet_ctrl {
 
 	char			subsysnqn[NVMF_NQN_FIELD_LEN];
 	char			hostnqn[NVMF_NQN_FIELD_LEN];
+
+	u64			host_id;
+	struct list_head	rsrv_log;
+	u64			rsrv_log_counter;
+	u32			rsrv_mask;
+	bool			rsrv_log_async_sent;
 };
 
 struct nvmet_subsys {
@@ -229,6 +242,18 @@ struct nvmet_req {
 	struct nvmet_fabrics_ops *ops;
 };
 
+struct nvmet_rsrv {
+	struct list_head	link;
+	struct nvmet_ctrl	*ctrl;
+	u64			rkey;
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
@@ -330,4 +355,8 @@ u16 nvmet_copy_from_sgl(struct nvmet_req *req, off_t off, void *buf,
 bool nvmet_host_allowed(struct nvmet_req *req, struct nvmet_subsys *subsys,
 		const char *hostnqn);
 
+void add_reservation_log_page(struct nvmet_ctrl *ctrl, struct nvmet_ns *ns,
+		int type);
+void nvmet_rsrv_remove_ctrl(struct nvmet_ctrl *ctrl);
+
 #endif /* _NVMET_H */
-- 
1.8.3.1
