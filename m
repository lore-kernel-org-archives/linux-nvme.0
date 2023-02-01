Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74498C636D3
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Feb 2023 11:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kY6XhVobuxGtO1A9tnSSAdE0QJWVdUiFhQWiTuyJ0Lw=; b=voMY9ZVOsMqgh8qMHbXCDSMh28
	BKjc7GlXautBafjGxU5ENuzO0MXrERmO16BU2wIT1r4uzOjcJseZkvETMFF1yBCvw6k4koEa5fgY+
	rwLIgp63g6ph/qyWDso0xqJ/jQgTUO7+vuo2Mhov7X7fpCYS5XlMrvWzmzicCeKmT85esM8gyUqy4
	t9OnwGXYL+wsFrFTC9XNaMToYZfClB1g5krVGjVQ1YNCT9maiDGanFc8U/pK4Bn8Hsg9w29/Ye2rm
	Nkvc3pVtNHfCTrzsjkqtMj42t7x7DXY+TXJVeeSgum7OayMDUerpcNiDR/7VL1enqjdJQcpWg264L
	YIuRhsRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNBcy-00BatW-JQ; Wed, 01 Feb 2023 11:50:12 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNBcu-00BasW-U0
	for linux-nvme@lists.infradead.org; Wed, 01 Feb 2023 11:50:11 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 8444B33C4E;
	Wed,  1 Feb 2023 11:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675252203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kY6XhVobuxGtO1A9tnSSAdE0QJWVdUiFhQWiTuyJ0Lw=;
	b=cF0owAS6bLGezUx5km8hLmDm8sjbsMuHfGCIfxAfOmEAPtGOkO6xm7oa6tvJSQDbZsvbnn
	3BUJM7Obf5ik+AlmTiNf8ldMTN7d0icb9MNbq5wZTidKiPLC+9kW96HqubfrWpbdhIITAt
	P34MlD8VSBiurR79MQpseqS2KedQblM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675252203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kY6XhVobuxGtO1A9tnSSAdE0QJWVdUiFhQWiTuyJ0Lw=;
	b=PAjXQ68RmMdHSxN//E+cj7/6EJOF25sUyc3b//J5RS/s8jxUHDPvFz1rJdduU8oQ7cYE78
	v07aNmo76MMwMtDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 71F6D2C141;
	Wed,  1 Feb 2023 11:50:03 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 07D0251BC6CE; Wed,  1 Feb 2023 12:50:03 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme: retry commands if DNR bit is not set
Date: Wed,  1 Feb 2023 12:50:01 +0100
Message-Id: <20230201115001.57321-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230201_035009_155675_7879B401 
X-CRM114-Status: GOOD (  19.30  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a 'retry' argument to __nvme_submit_sync_cmd() to instruct
the function to not set the FAILFAST_DRIVER bit for the command,
causing it to be retried in nvme_decide_disposition() if the DNR
bit is not set in the command result.
And modify the authentication code to allow for retries.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c       |  2 +-
 drivers/nvme/host/core.c       | 18 ++++++++++--------
 drivers/nvme/host/fabrics.c    | 10 +++++-----
 drivers/nvme/host/ioctl.c      |  2 +-
 drivers/nvme/host/nvme.h       |  5 +++--
 drivers/nvme/host/pci.c        |  4 ++--
 drivers/nvme/target/passthru.c |  2 +-
 7 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 787537454f7f..cf4b12436a43 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -78,7 +78,7 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 
 	ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len,
 				     qid == 0 ? NVME_QID_ANY : qid,
-				     0, flags);
+				     0, flags, true);
 	if (ret > 0)
 		dev_warn(ctrl->device,
 			"qid %d auth_send failed with status %d\n", qid, ret);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f9af062f82f4..e7390e55ee14 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -663,7 +663,8 @@ static inline void nvme_clear_nvme_request(struct request *req)
 }
 
 /* initialize a passthrough request */
-void nvme_init_request(struct request *req, struct nvme_command *cmd)
+void nvme_init_request(struct request *req, struct nvme_command *cmd,
+		       bool retry)
 {
 	if (req->q->queuedata)
 		req->timeout = NVME_IO_TIMEOUT;
@@ -673,7 +674,8 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
 	/* passthru commands should let the driver set the SGL flags */
 	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
 
-	req->cmd_flags |= REQ_FAILFAST_DRIVER;
+	if (!retry)
+		req->cmd_flags |= REQ_FAILFAST_DRIVER;
 	if (req->mq_hctx->type == HCTX_TYPE_POLL)
 		req->cmd_flags |= REQ_POLLED;
 	nvme_clear_nvme_request(req);
@@ -1023,7 +1025,7 @@ EXPORT_SYMBOL_NS_GPL(nvme_execute_rq, NVME_TARGET_PASSTHRU);
  */
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
-		int qid, int at_head, blk_mq_req_flags_t flags)
+		int qid, int at_head, blk_mq_req_flags_t flags, bool retry)
 {
 	struct request *req;
 	int ret;
@@ -1036,7 +1038,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 
 	if (IS_ERR(req))
 		return PTR_ERR(req);
-	nvme_init_request(req, cmd);
+	nvme_init_request(req, cmd, retry);
 
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
@@ -1057,7 +1059,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, unsigned bufflen)
 {
 	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, 0, false);
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
@@ -1238,7 +1240,7 @@ static void nvme_keep_alive_work(struct work_struct *work)
 		nvme_reset_ctrl(ctrl);
 		return;
 	}
-	nvme_init_request(rq, &ctrl->ka_cmd);
+	nvme_init_request(rq, &ctrl->ka_cmd, false);
 
 	rq->timeout = ctrl->kato * HZ;
 	rq->end_io = nvme_keep_alive_end_io;
@@ -1515,7 +1517,7 @@ static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 	c.features.dword11 = cpu_to_le32(dword11);
 
 	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res,
-			buffer, buflen, NVME_QID_ANY, 0, 0);
+			buffer, buflen, NVME_QID_ANY, 0, 0, false);
 	if (ret >= 0 && result)
 		*result = le32_to_cpu(res.u32);
 	return ret;
@@ -2247,7 +2249,7 @@ static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t l
 	cmd.common.cdw11 = cpu_to_le32(len);
 
 	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
-			NVME_QID_ANY, 1, 0);
+			NVME_QID_ANY, 1, 0, false);
 }
 
 static void nvme_configure_opal(struct nvme_ctrl *ctrl, bool was_suspended)
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index bbaa04a0c502..c6d7c89939e0 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -153,7 +153,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, 0, false);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -199,7 +199,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, 0, false);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -244,7 +244,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.value = cpu_to_le64(val);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, 0, false);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
@@ -401,7 +401,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res,
 			data, sizeof(*data), NVME_QID_ANY, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, false);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
@@ -487,7 +487,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 
 	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
 			data, sizeof(*data), qid, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, false);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 723e7d5b778f..11f03a0696c2 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -154,7 +154,7 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 	req = blk_mq_alloc_request(q, nvme_req_op(cmd) | rq_flags, blk_flags);
 	if (IS_ERR(req))
 		return req;
-	nvme_init_request(req, cmd);
+	nvme_init_request(req, cmd, false);
 	nvme_req(req)->flags |= NVME_REQ_USERCMD;
 	return req;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1..efe043ed492a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -774,7 +774,8 @@ static inline enum req_op nvme_req_op(struct nvme_command *cmd)
 }
 
 #define NVME_QID_ANY -1
-void nvme_init_request(struct request *req, struct nvme_command *cmd);
+void nvme_init_request(struct request *req, struct nvme_command *cmd,
+		bool retry);
 void nvme_cleanup_cmd(struct request *req);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req);
 blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
@@ -816,7 +817,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
 		int qid, int at_head,
-		blk_mq_req_flags_t flags);
+		blk_mq_req_flags_t flags, bool retry);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6d0217c82f4a..9fbd3c1124e1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1382,7 +1382,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 		atomic_inc(&dev->ctrl.abort_limit);
 		return BLK_EH_RESET_TIMER;
 	}
-	nvme_init_request(abort_req, &cmd);
+	nvme_init_request(abort_req, &cmd, false);
 
 	abort_req->end_io = abort_endio;
 	abort_req->end_io_data = NULL;
@@ -2394,7 +2394,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	req = blk_mq_alloc_request(q, nvme_req_op(&cmd), BLK_MQ_REQ_NOWAIT);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
-	nvme_init_request(req, &cmd);
+	nvme_init_request(req, &cmd, false);
 
 	if (opcode == nvme_admin_delete_cq)
 		req->end_io = nvme_del_cq_end;
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 511c980d538d..2d51480ce02d 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -321,7 +321,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		status = NVME_SC_INTERNAL;
 		goto out_put_ns;
 	}
-	nvme_init_request(rq, req->cmd);
+	nvme_init_request(rq, req->cmd, false);
 
 	if (timeout)
 		rq->timeout = timeout;
-- 
2.35.3


