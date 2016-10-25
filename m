From: hch@lst.de (Christoph Hellwig)
Date: Tue, 25 Oct 2016 18:09:38 +0200
Subject: [PATCH 1/2] nvme: introduce struct nvme_request
In-Reply-To: <1477411779-2993-1-git-send-email-hch@lst.de>
References: <1477411779-2993-1-git-send-email-hch@lst.de>
Message-ID: <1477411779-2993-2-git-send-email-hch@lst.de>

This adds a shared per-request structure for all NVMe I/O.  This structure
is embedded as the first member in all NVMe transport drivers request
private data and allows to implement common functionality between the
drivers.

The first use is to replace the current abuse of the SCSI command
passthrough fields in struct request for the NVMe command passthrough,
but it will grow a field more fields to allow implementing things
like common abort handlers in the future.

The passthrough commands are handled by having a pointer to the SQE
(struct nvme_command) in struct nvme_request, and the union of the
possible result fields, which had to be turned from an anonymous
into a named union for that purpose.  This avoids having to pass
a reference to a full CQE around and thus makes checking the result
a lot more lightweight.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c          | 28 +++++++++++++---------------
 drivers/nvme/host/fabrics.c       | 26 +++++++++++++-------------
 drivers/nvme/host/lightnvm.c      | 31 +++++++------------------------
 drivers/nvme/host/nvme.h          | 16 +++++++++++++++-
 drivers/nvme/host/pci.c           |  4 ++--
 drivers/nvme/host/rdma.c          | 11 +++--------
 drivers/nvme/target/core.c        |  8 ++++----
 drivers/nvme/target/fabrics-cmd.c | 14 +++++++-------
 drivers/nvme/target/loop.c        | 12 ++++++------
 drivers/nvme/target/nvmet.h       |  2 +-
 include/linux/nvme.h              | 10 +++++-----
 11 files changed, 76 insertions(+), 86 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 329381a..ae38a03 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -227,8 +227,7 @@ struct request *nvme_alloc_request(struct request_queue *q,
 
 	req->cmd_type = REQ_TYPE_DRV_PRIV;
 	req->cmd_flags |= REQ_FAILFAST_DRIVER;
-	req->cmd = (unsigned char *)cmd;
-	req->cmd_len = sizeof(struct nvme_command);
+	nvme_req(req)->cmd = cmd;
 
 	return req;
 }
@@ -327,7 +326,7 @@ int nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 	int ret = 0;
 
 	if (req->cmd_type == REQ_TYPE_DRV_PRIV)
-		memcpy(cmd, req->cmd, sizeof(*cmd));
+		memcpy(cmd, nvme_req(req)->cmd, sizeof(*cmd));
 	else if (req_op(req) == REQ_OP_FLUSH)
 		nvme_setup_flush(ns, cmd);
 	else if (req_op(req) == REQ_OP_DISCARD)
@@ -344,7 +343,7 @@ EXPORT_SYMBOL_GPL(nvme_setup_cmd);
  * if the result is positive, it's an NVM Express status code
  */
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-		struct nvme_completion *cqe, void *buffer, unsigned bufflen,
+		union nvme_result *result, void *buffer, unsigned bufflen,
 		unsigned timeout, int qid, int at_head, int flags)
 {
 	struct request *req;
@@ -355,7 +354,6 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		return PTR_ERR(req);
 
 	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
-	req->special = cqe;
 
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
@@ -364,6 +362,8 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	}
 
 	blk_execute_rq(req->q, NULL, req, at_head);
+	if (result)
+		*result = nvme_req(req)->result;
 	ret = req->errors;
  out:
 	blk_mq_free_request(req);
@@ -385,7 +385,6 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 		u32 *result, unsigned timeout)
 {
 	bool write = nvme_is_write(cmd);
-	struct nvme_completion cqe;
 	struct nvme_ns *ns = q->queuedata;
 	struct gendisk *disk = ns ? ns->disk : NULL;
 	struct request *req;
@@ -398,7 +397,6 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 		return PTR_ERR(req);
 
 	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
-	req->special = &cqe;
 
 	if (ubuffer && bufflen) {
 		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
@@ -453,7 +451,7 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 	blk_execute_rq(req->q, disk, req, 0);
 	ret = req->errors;
 	if (result)
-		*result = le32_to_cpu(cqe.result);
+		*result = le32_to_cpu(nvme_req(req)->result.u32);
 	if (meta && !ret && !write) {
 		if (copy_to_user(meta_buffer, meta, meta_len))
 			ret = -EFAULT;
@@ -602,7 +600,7 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned nsid,
 		      void *buffer, size_t buflen, u32 *result)
 {
 	struct nvme_command c;
-	struct nvme_completion cqe;
+	union nvme_result res;
 	int ret;
 
 	memset(&c, 0, sizeof(c));
@@ -610,10 +608,10 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned nsid,
 	c.features.nsid = cpu_to_le32(nsid);
 	c.features.fid = cpu_to_le32(fid);
 
-	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &cqe, buffer, buflen, 0,
+	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res, buffer, buflen, 0,
 			NVME_QID_ANY, 0, 0);
 	if (ret >= 0 && result)
-		*result = le32_to_cpu(cqe.result);
+		*result = le32_to_cpu(res.u32);
 	return ret;
 }
 
@@ -621,7 +619,7 @@ int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 		      void *buffer, size_t buflen, u32 *result)
 {
 	struct nvme_command c;
-	struct nvme_completion cqe;
+	union nvme_result res;
 	int ret;
 
 	memset(&c, 0, sizeof(c));
@@ -629,10 +627,10 @@ int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 	c.features.fid = cpu_to_le32(fid);
 	c.features.dword11 = cpu_to_le32(dword11);
 
-	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &cqe,
+	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res,
 			buffer, buflen, 0, NVME_QID_ANY, 0, 0);
 	if (ret >= 0 && result)
-		*result = le32_to_cpu(cqe.result);
+		*result = le32_to_cpu(res.u32);
 	return ret;
 }
 
@@ -1907,7 +1905,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl,
 		struct nvme_completion *cqe)
 {
 	u16 status = le16_to_cpu(cqe->status) >> 1;
-	u32 result = le32_to_cpu(cqe->result);
+	u32 result = le32_to_cpu(cqe->result.u32);
 
 	if (status == NVME_SC_SUCCESS || status == NVME_SC_ABORT_REQ) {
 		++ctrl->event_limit;
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5a3f008..68fb26b 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -161,7 +161,7 @@ EXPORT_SYMBOL_GPL(nvmf_get_subsysnqn);
 int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 {
 	struct nvme_command cmd;
-	struct nvme_completion cqe;
+	union nvme_result res;
 	int ret;
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -169,11 +169,11 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.fctype = nvme_fabrics_type_property_get;
 	cmd.prop_get.offset = cpu_to_le32(off);
 
-	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, &cqe, NULL, 0, 0,
+	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, &res, NULL, 0, 0,
 			NVME_QID_ANY, 0, 0);
 
 	if (ret >= 0)
-		*val = le64_to_cpu(cqe.result64);
+		*val = le64_to_cpu(res.u64);
 	if (unlikely(ret != 0))
 		dev_err(ctrl->device,
 			"Property Get error: %d, offset %#x\n",
@@ -207,7 +207,7 @@ EXPORT_SYMBOL_GPL(nvmf_reg_read32);
 int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 {
 	struct nvme_command cmd;
-	struct nvme_completion cqe;
+	union nvme_result res;
 	int ret;
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -216,11 +216,11 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.attrib = 1;
 	cmd.prop_get.offset = cpu_to_le32(off);
 
-	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, &cqe, NULL, 0, 0,
+	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, &res, NULL, 0, 0,
 			NVME_QID_ANY, 0, 0);
 
 	if (ret >= 0)
-		*val = le64_to_cpu(cqe.result64);
+		*val = le64_to_cpu(res.u64);
 	if (unlikely(ret != 0))
 		dev_err(ctrl->device,
 			"Property Get error: %d, offset %#x\n",
@@ -368,7 +368,7 @@ static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
 int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 {
 	struct nvme_command cmd;
-	struct nvme_completion cqe;
+	union nvme_result res;
 	struct nvmf_connect_data *data;
 	int ret;
 
@@ -400,16 +400,16 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
-	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, &cqe,
+	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, &res,
 			data, sizeof(*data), 0, NVME_QID_ANY, 1,
 			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
 	if (ret) {
-		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(cqe.result),
+		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
 		goto out_free_data;
 	}
 
-	ctrl->cntlid = le16_to_cpu(cqe.result16);
+	ctrl->cntlid = le16_to_cpu(res.u16);
 
 out_free_data:
 	kfree(data);
@@ -441,7 +441,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 {
 	struct nvme_command cmd;
 	struct nvmf_connect_data *data;
-	struct nvme_completion cqe;
+	union nvme_result res;
 	int ret;
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -459,11 +459,11 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
-	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &cqe,
+	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
 			data, sizeof(*data), 0, qid, 1,
 			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
 	if (ret) {
-		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(cqe.result),
+		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
 	}
 	kfree(data);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index f5e3011..1bfea86 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -146,14 +146,6 @@ struct nvme_nvm_command {
 	};
 };
 
-struct nvme_nvm_completion {
-	__le64	result;		/* Used by LightNVM to return ppa completions */
-	__le16	sq_head;	/* how much of this queue may be reclaimed */
-	__le16	sq_id;		/* submission queue that generated this entry */
-	__u16	command_id;	/* of the command which completed */
-	__le16	status;		/* did the command fail, and if so, why? */
-};
-
 #define NVME_NVM_LP_MLC_PAIRS 886
 struct nvme_nvm_lp_mlc {
 	__le16			num_pairs;
@@ -481,11 +473,8 @@ static inline void nvme_nvm_rqtocmd(struct request *rq, struct nvm_rq *rqd,
 static void nvme_nvm_end_io(struct request *rq, int error)
 {
 	struct nvm_rq *rqd = rq->end_io_data;
-	struct nvme_nvm_completion *cqe = rq->special;
-
-	if (cqe)
-		rqd->ppa_status = le64_to_cpu(cqe->result);
 
+	rqd->ppa_status = nvme_req(rq)->result;
 	nvm_end_io(rqd, error);
 
 	kfree(rq->cmd);
@@ -500,20 +489,18 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 	struct bio *bio = rqd->bio;
 	struct nvme_nvm_command *cmd;
 
-	rq = blk_mq_alloc_request(q, bio_data_dir(bio), 0);
-	if (IS_ERR(rq))
+	cmd = kzalloc(sizeof(struct nvme_nvm_command), GFP_KERNEL);
+	if (!cmd)
 		return -ENOMEM;
 
-	cmd = kzalloc(sizeof(struct nvme_nvm_command) +
-				sizeof(struct nvme_nvm_completion), GFP_KERNEL);
-	if (!cmd) {
-		blk_mq_free_request(rq);
+	rq = nvme_alloc_request(q, cmd, 0, NVME_QID_ANY);
+	if (IS_ERR(rq)) {
+		kfree(cmd);
 		return -ENOMEM;
 	}
+	req->cmd_flags &= ~REQ_FAILFAST_DRIVER;
 
-	rq->cmd_type = REQ_TYPE_DRV_PRIV;
 	rq->ioprio = bio_prio(bio);
-
 	if (bio_has_data(bio))
 		rq->nr_phys_segments = bio_phys_segments(q, bio);
 
@@ -522,10 +509,6 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 
 	nvme_nvm_rqtocmd(rq, rqd, ns, cmd);
 
-	rq->cmd = (unsigned char *)cmd;
-	rq->cmd_len = sizeof(struct nvme_nvm_command);
-	rq->special = cmd + 1;
-
 	rq->end_io_data = rqd;
 
 	blk_execute_rq_nowait(q, NULL, rq, 0, nvme_nvm_end_io);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d47f5a5..5e64957a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -79,6 +79,20 @@ enum nvme_quirks {
 	NVME_QUIRK_DELAY_BEFORE_CHK_RDY		= (1 << 3),
 };
 
+/*
+ * Common request structure for NVMe passthrough.  All drivers must have
+ * this structure as the first member of their request-private data.
+ */
+struct nvme_request {
+	struct nvme_command	*cmd;
+	union nvme_result	result;
+};
+
+static inline struct nvme_request *nvme_req(struct request *req)
+{
+	return blk_mq_rq_to_pdu(req);
+}
+
 /* The below value is the specific amount of delay needed before checking
  * readiness in case of the PCI_DEVICE(0x1c58, 0x0003), which needs the
  * NVME_QUIRK_DELAY_BEFORE_CHK_RDY quirk enabled. The value (in ms) was
@@ -278,7 +292,7 @@ int nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-		struct nvme_completion *cqe, void *buffer, unsigned bufflen,
+		union nvme_result *result, void *buffer, unsigned bufflen,
 		unsigned timeout, int qid, int at_head, int flags);
 int nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void __user *ubuffer, unsigned bufflen, u32 *result,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0955e9d..de8e050 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -140,6 +140,7 @@ struct nvme_queue {
  * allocated to store the PRP list.
  */
 struct nvme_iod {
+	struct nvme_request req;
 	struct nvme_queue *nvmeq;
 	int aborted;
 	int npages;		/* In the PRP list. 0 means small pool in use */
@@ -707,8 +708,7 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 		}
 
 		req = blk_mq_tag_to_rq(*nvmeq->tags, cqe.command_id);
-		if (req->cmd_type == REQ_TYPE_DRV_PRIV && req->special)
-			memcpy(req->special, &cqe, sizeof(cqe));
+		nvme_req(req)->result = cqe.result;
 		blk_mq_complete_request(req, le16_to_cpu(cqe.status) >> 1);
 
 	}
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5a83881..0b8a161 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -66,6 +66,7 @@ struct nvme_rdma_qe {
 
 struct nvme_rdma_queue;
 struct nvme_rdma_request {
+	struct nvme_request	req;
 	struct ib_mr		*mr;
 	struct nvme_rdma_qe	sqe;
 	struct ib_sge		sge[1 + NVME_RDMA_MAX_INLINE_SEGMENTS];
@@ -1117,13 +1118,10 @@ static void nvme_rdma_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
 static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 		struct nvme_completion *cqe, struct ib_wc *wc, int tag)
 {
-	u16 status = le16_to_cpu(cqe->status);
 	struct request *rq;
 	struct nvme_rdma_request *req;
 	int ret = 0;
 
-	status >>= 1;
-
 	rq = blk_mq_tag_to_rq(nvme_rdma_tagset(queue), cqe->command_id);
 	if (!rq) {
 		dev_err(queue->ctrl->ctrl.device,
@@ -1134,9 +1132,6 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 	}
 	req = blk_mq_rq_to_pdu(rq);
 
-	if (rq->cmd_type == REQ_TYPE_DRV_PRIV && rq->special)
-		memcpy(rq->special, cqe, sizeof(*cqe));
-
 	if (rq->tag == tag)
 		ret = 1;
 
@@ -1144,8 +1139,8 @@ static int nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 	    wc->ex.invalidate_rkey == req->mr->rkey)
 		req->mr->need_inval = false;
 
-	blk_mq_complete_request(rq, status);
-
+	req->req.result = cqe->result;
+	blk_mq_complete_request(rq, le16_to_cpu(cqe->status) >> 1);
 	return ret;
 }
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 6559d5a..c232552 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -617,7 +617,7 @@ u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
 	if (!subsys) {
 		pr_warn("connect request for invalid subsystem %s!\n",
 			subsysnqn);
-		req->rsp->result = IPO_IATTR_CONNECT_DATA(subsysnqn);
+		req->rsp->result.u32 = IPO_IATTR_CONNECT_DATA(subsysnqn);
 		return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 	}
 
@@ -638,7 +638,7 @@ u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
 
 	pr_warn("could not find controller %d for subsys %s / host %s\n",
 		cntlid, subsysnqn, hostnqn);
-	req->rsp->result = IPO_IATTR_CONNECT_DATA(cntlid);
+	req->rsp->result.u32 = IPO_IATTR_CONNECT_DATA(cntlid);
 	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 
 out:
@@ -700,7 +700,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	if (!subsys) {
 		pr_warn("connect request for invalid subsystem %s!\n",
 			subsysnqn);
-		req->rsp->result = IPO_IATTR_CONNECT_DATA(subsysnqn);
+		req->rsp->result.u32 = IPO_IATTR_CONNECT_DATA(subsysnqn);
 		goto out;
 	}
 
@@ -709,7 +709,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	if (!nvmet_host_allowed(req, subsys, hostnqn)) {
 		pr_info("connect by host %s for subsystem %s not allowed\n",
 			hostnqn, subsysnqn);
-		req->rsp->result = IPO_IATTR_CONNECT_DATA(hostnqn);
+		req->rsp->result.u32 = IPO_IATTR_CONNECT_DATA(hostnqn);
 		up_read(&nvmet_config_sem);
 		goto out_put_subsystem;
 	}
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 9a97ae6..f408819 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -69,7 +69,7 @@ static void nvmet_execute_prop_get(struct nvmet_req *req)
 		}
 	}
 
-	req->rsp->result64 = cpu_to_le64(val);
+	req->rsp->result.u64 = cpu_to_le64(val);
 	nvmet_req_complete(req, status);
 }
 
@@ -125,7 +125,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	d = kmap(sg_page(req->sg)) + req->sg->offset;
 
 	/* zero out initial completion result, assign values as needed */
-	req->rsp->result = 0;
+	req->rsp->result.u32 = 0;
 
 	if (c->recfmt != 0) {
 		pr_warn("invalid connect version (%d).\n",
@@ -138,7 +138,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		pr_warn("connect attempt for invalid controller ID %#x\n",
 			d->cntlid);
 		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
-		req->rsp->result = IPO_IATTR_CONNECT_DATA(cntlid);
+		req->rsp->result.u32 = IPO_IATTR_CONNECT_DATA(cntlid);
 		goto out;
 	}
 
@@ -155,7 +155,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 
 	pr_info("creating controller %d for NQN %s.\n",
 			ctrl->cntlid, ctrl->hostnqn);
-	req->rsp->result16 = cpu_to_le16(ctrl->cntlid);
+	req->rsp->result.u16 = cpu_to_le16(ctrl->cntlid);
 
 out:
 	kunmap(sg_page(req->sg));
@@ -173,7 +173,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	d = kmap(sg_page(req->sg)) + req->sg->offset;
 
 	/* zero out initial completion result, assign values as needed */
-	req->rsp->result = 0;
+	req->rsp->result.u32 = 0;
 
 	if (c->recfmt != 0) {
 		pr_warn("invalid connect version (%d).\n",
@@ -191,14 +191,14 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	if (unlikely(qid > ctrl->subsys->max_qid)) {
 		pr_warn("invalid queue id (%d)\n", qid);
 		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
-		req->rsp->result = IPO_IATTR_CONNECT_SQE(qid);
+		req->rsp->result.u32 = IPO_IATTR_CONNECT_SQE(qid);
 		goto out_ctrl_put;
 	}
 
 	status = nvmet_install_queue(ctrl, req);
 	if (status) {
 		/* pass back cntlid that had the issue of installing queue */
-		req->rsp->result16 = cpu_to_le16(ctrl->cntlid);
+		req->rsp->result.u16 = cpu_to_le16(ctrl->cntlid);
 		goto out_ctrl_put;
 	}
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index d5df77d..757e21a 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -36,6 +36,7 @@
 	(NVME_LOOP_AQ_DEPTH - NVME_LOOP_NR_AEN_COMMANDS)
 
 struct nvme_loop_iod {
+	struct nvme_request	nvme_req;
 	struct nvme_command	cmd;
 	struct nvme_completion	rsp;
 	struct nvmet_req	req;
@@ -112,10 +113,10 @@ static void nvme_loop_complete_rq(struct request *req)
 	blk_mq_end_request(req, error);
 }
 
-static void nvme_loop_queue_response(struct nvmet_req *nvme_req)
+static void nvme_loop_queue_response(struct nvmet_req *req)
 {
 	struct nvme_loop_iod *iod =
-		container_of(nvme_req, struct nvme_loop_iod, req);
+		container_of(req, struct nvme_loop_iod, req);
 	struct nvme_completion *cqe = &iod->rsp;
 
 	/*
@@ -128,11 +129,10 @@ static void nvme_loop_queue_response(struct nvmet_req *nvme_req)
 			cqe->command_id >= NVME_LOOP_AQ_BLKMQ_DEPTH)) {
 		nvme_complete_async_event(&iod->queue->ctrl->ctrl, cqe);
 	} else {
-		struct request *req = blk_mq_rq_from_pdu(iod);
+		struct request *rq = blk_mq_rq_from_pdu(iod);
 
-		if (req->cmd_type == REQ_TYPE_DRV_PRIV && req->special)
-			memcpy(req->special, cqe, sizeof(*cqe));
-		blk_mq_complete_request(req, le16_to_cpu(cqe->status) >> 1);
+		iod->nvme_req.result = cqe->result;
+		blk_mq_complete_request(rq, le16_to_cpu(cqe->status) >> 1);
 	}
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 76b6eed..f9c7644 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -238,7 +238,7 @@ static inline void nvmet_set_status(struct nvmet_req *req, u16 status)
 
 static inline void nvmet_set_result(struct nvmet_req *req, u32 result)
 {
-	req->rsp->result = cpu_to_le32(result);
+	req->rsp->result.u32 = cpu_to_le32(result);
 }
 
 /*
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 7676557..18ce9f7 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -949,11 +949,11 @@ struct nvme_completion {
 	/*
 	 * Used by Admin and Fabrics commands to return data:
 	 */
-	union {
-		__le16	result16;
-		__le32	result;
-		__le64	result64;
-	};
+	union nvme_result {
+		__le16	u16;
+		__le32	u32;
+		__le64	u64;
+	} result;
 	__le16	sq_head;	/* how much of this queue may be reclaimed */
 	__le16	sq_id;		/* submission queue that generated this entry */
 	__u16	command_id;	/* of the command which completed */
-- 
2.1.4
