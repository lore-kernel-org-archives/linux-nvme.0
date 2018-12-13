From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 13 Dec 2018 13:34:07 -0800
Subject: [PATCH v3 3/6] nvme-core: optionally poll sync commands
In-Reply-To: <20181213213410.9841-1-sagi@grimberg.me>
References: <20181213213410.9841-1-sagi@grimberg.me>
Message-ID: <20181213213410.9841-4-sagi@grimberg.me>

Pass poll bool to indicate that we need it to poll. This prepares us for
polling support in nvmf since connect is an I/O that will be queued
and has to be polled in order to complete. If poll is passed,
we call nvme_execute_rq_polled which sends the requests and polls
for its completion.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c    | 38 ++++++++++++++++++++++++++++++++-----
 drivers/nvme/host/fabrics.c | 10 +++++-----
 drivers/nvme/host/nvme.h    |  2 +-
 3 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 136512e8ba58..08f2c92602f4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -724,6 +724,31 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 }
 EXPORT_SYMBOL_GPL(nvme_setup_cmd);
 
+static void nvme_end_sync_rq(struct request *rq, blk_status_t error)
+{
+	struct completion *waiting = rq->end_io_data;
+
+	rq->end_io_data = NULL;
+	complete(waiting);
+}
+
+static void nvme_execute_rq_polled(struct request_queue *q,
+		struct gendisk *bd_disk, struct request *rq, int at_head)
+{
+	DECLARE_COMPLETION_ONSTACK(wait);
+
+	WARN_ON_ONCE(!test_bit(QUEUE_FLAG_POLL, &q->queue_flags));
+
+	rq->cmd_flags |= REQ_HIPRI;
+	rq->end_io_data = &wait;
+	blk_execute_rq_nowait(q, bd_disk, rq, at_head, nvme_end_sync_rq);
+
+	while (!completion_done(&wait)) {
+		blk_poll(q, request_to_qc_t(rq->mq_hctx, rq), true);
+		cond_resched();
+	}
+}
+
 /*
  * Returns 0 on success.  If the result is negative, it's a Linux error code;
  * if the result is positive, it's an NVM Express status code
@@ -731,7 +756,7 @@ EXPORT_SYMBOL_GPL(nvme_setup_cmd);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
 		unsigned timeout, int qid, int at_head,
-		blk_mq_req_flags_t flags)
+		blk_mq_req_flags_t flags, bool poll)
 {
 	struct request *req;
 	int ret;
@@ -748,7 +773,10 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 			goto out;
 	}
 
-	blk_execute_rq(req->q, NULL, req, at_head);
+	if (poll)
+		nvme_execute_rq_polled(req->q, NULL, req, at_head);
+	else
+		blk_execute_rq(req->q, NULL, req, at_head);
 	if (result)
 		*result = nvme_req(req)->result;
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
@@ -765,7 +793,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, unsigned bufflen)
 {
 	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, 0, false);
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
@@ -1084,7 +1112,7 @@ static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword
 	c.features.dword11 = cpu_to_le32(dword11);
 
 	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res,
-			buffer, buflen, 0, NVME_QID_ANY, 0, 0);
+			buffer, buflen, 0, NVME_QID_ANY, 0, 0, false);
 	if (ret >= 0 && result)
 		*result = le32_to_cpu(res.u32);
 	return ret;
@@ -1727,7 +1755,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 	cmd.common.cdw11 = cpu_to_le32(len);
 
 	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
-				      ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0);
+				      ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0, false);
 }
 EXPORT_SYMBOL_GPL(nvme_sec_submit);
 #endif /* CONFIG_BLK_SED_OPAL */
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 19ff0eae4582..d93a169f6403 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -159,7 +159,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, &res, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, 0, false);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -206,7 +206,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, &res, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, 0, false);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -252,7 +252,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.value = cpu_to_le64(val);
 
 	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, 0, false);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
@@ -406,7 +406,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 
 	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, &res,
 			data, sizeof(*data), 0, NVME_QID_ANY, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, false);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
@@ -468,7 +468,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 
 	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
 			data, sizeof(*data), 0, qid, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, false);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 39b52f4d9b24..2b36ac922596 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -447,7 +447,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
 		unsigned timeout, int qid, int at_head,
-		blk_mq_req_flags_t flags);
+		blk_mq_req_flags_t flags, bool poll);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
-- 
2.17.1
