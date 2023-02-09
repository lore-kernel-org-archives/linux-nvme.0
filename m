Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3022FC61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 14:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=45Ui2nMrGKJ5+F0Klsm1QPU5hB8CSUmjN/anJ3GkZlU=; b=kEDCYUfsc9qHOx43DPLM3sswqN
	w/A4bcmsbXLY7G2TEePzWL6UWK7YxA4NjbHYmTRDxepKL/txWrJst7RB7LKPMhQeWu69M2wNg7l6C
	XttU6FQ72qQBvzTs7TFEVttlaEDGLqAcD/BzKCoJIztGMHBUFxW6JdD/snxfZAinYhEtYorP2eZGC
	3TtWtj2A6IjjaKTTOqFiWZDHLnf7xgU0sTlPBWH0FJX0XPkcHpYiAZf9ldJBW7zBfigZaHtWqHtdF
	xNgp1vTit4gp0dGTt8sXXvH0iwVedSYkxX+HcVxJFUhNnbrnxHvoN94giK45tPyH1zzOgnfIZ+PBA
	FtlCrGMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ84c-0020rf-Oe; Thu, 09 Feb 2023 14:38:54 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ84F-0020et-9I
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 14:38:34 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id C756A5CAAA;
	Thu,  9 Feb 2023 14:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675953509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=45Ui2nMrGKJ5+F0Klsm1QPU5hB8CSUmjN/anJ3GkZlU=;
	b=t311i/CYjEZ70ekBpB4slZkJHCA0w2zkSexsiuLJKDrX53qYSP99Dbd3Xkw4ize0LZGUS/
	Jycpfjx8VcR1LqpoG65gl/eOMy5hgFEmqKEIT+YMtkAiYjAl5I2hSpuVuU6x6eSA6bwS3J
	YQowE86pBiMn/qjYxs0mikfhd1h7l+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675953509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=45Ui2nMrGKJ5+F0Klsm1QPU5hB8CSUmjN/anJ3GkZlU=;
	b=QRcL1bcUH0GKvWWgMkLAu/ODCiuFQD1RlZQSQ4r8qQn3ZaXjdWIXSMp+hnidUDogHsdPZP
	y1NIdPjajyzYYyBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id AAAFD2C143;
	Thu,  9 Feb 2023 14:38:29 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 91C3C51BD138; Thu,  9 Feb 2023 15:38:29 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/5] nvme: split __nvme_submit_sync_cmd()
Date: Thu,  9 Feb 2023 15:38:16 +0100
Message-Id: <20230209143820.118097-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230209143820.118097-1-hare@suse.de>
References: <20230209143820.118097-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_063831_660101_5E6C941A 
X-CRM114-Status: GOOD (  18.90  )
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

Split a nvme_alloc_request() function from __nvme_submit_sync_cmd()
to reduce the number of arguments.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c       |  9 +++--
 drivers/nvme/host/core.c       | 60 ++++++++++++++++++++++------------
 drivers/nvme/host/fabrics.c    | 44 ++++++++++++++++++-------
 drivers/nvme/host/nvme.h       |  8 ++---
 drivers/nvme/host/pci.c        |  8 ++---
 drivers/nvme/target/passthru.c |  3 +-
 6 files changed, 85 insertions(+), 47 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 787537454f7f..05d02ab229f7 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -62,6 +62,7 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 	struct nvme_command cmd = {};
 	blk_mq_req_flags_t flags = nvme_auth_flags_from_qid(qid);
 	struct request_queue *q = nvme_auth_queue_from_qid(ctrl, qid);
+	struct request *req;
 	int ret;
 
 	cmd.auth_common.opcode = nvme_fabrics_command;
@@ -76,9 +77,11 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 		cmd.auth_receive.al = cpu_to_le32(data_len);
 	}
 
-	ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len,
-				     qid == 0 ? NVME_QID_ANY : qid,
-				     0, flags);
+	req = nvme_alloc_request(q, &cmd, qid == 0 ? NVME_QID_ANY : qid, flags);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	ret = __nvme_submit_sync_cmd(req, NULL, data, data_len, 0);
 	if (ret > 0)
 		dev_warn(ctrl->device,
 			"qid %d auth_send failed with status %d\n", qid, ret);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d1c9402389f9..ad2bcb412944 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1017,29 +1017,35 @@ int nvme_execute_rq(struct request *rq, bool at_head)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_execute_rq, NVME_TARGET_PASSTHRU);
 
-/*
- * Returns 0 on success.  If the result is negative, it's a Linux error code;
- * if the result is positive, it's an NVM Express status code
- */
-int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-		union nvme_result *result, void *buffer, unsigned bufflen,
-		int qid, int at_head, blk_mq_req_flags_t flags)
+struct request *nvme_alloc_request(struct request_queue *q,
+				   struct nvme_command *cmd, int qid,
+				   blk_mq_req_flags_t flags)
 {
 	struct request *req;
-	int ret;
 
 	if (qid == NVME_QID_ANY)
 		req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
 	else
 		req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), flags,
 						qid - 1);
+	if (!IS_ERR(req))
+		nvme_init_request(req, cmd);
 
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-	nvme_init_request(req, cmd);
+	return req;
+}
+EXPORT_SYMBOL_GPL(nvme_alloc_request);
+
+/*
+ * Returns 0 on success.  If the result is negative, it's a Linux error code;
+ * if the result is positive, it's an NVM Express status code
+ */
+int __nvme_submit_sync_cmd(struct request *req, union nvme_result *result,
+			   void *buffer, unsigned bufflen, int at_head)
+{
+	int ret;
 
 	if (buffer && bufflen) {
-		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
+		ret = blk_rq_map_kern(req->q, req, buffer, bufflen, GFP_KERNEL);
 		if (ret)
 			goto out;
 	}
@@ -1056,8 +1062,13 @@ EXPORT_SYMBOL_GPL(__nvme_submit_sync_cmd);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, unsigned bufflen)
 {
-	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen,
-			NVME_QID_ANY, 0, 0);
+	struct request *req;
+
+	req = nvme_alloc_request(q, cmd, NVME_QID_ANY, 0);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	return __nvme_submit_sync_cmd(req, NULL, buffer, bufflen, 0);
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
@@ -1199,15 +1210,14 @@ static void nvme_keep_alive_work(struct work_struct *work)
 		return;
 	}
 
-	rq = blk_mq_alloc_request(ctrl->admin_q, nvme_req_op(&ctrl->ka_cmd),
-				  BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd, NVME_QID_ANY,
+				BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
 	if (IS_ERR(rq)) {
 		/* allocation failure, reset the controller */
 		dev_err(ctrl->device, "keep-alive failed: %ld\n", PTR_ERR(rq));
 		nvme_reset_ctrl(ctrl);
 		return;
 	}
-	nvme_init_request(rq, &ctrl->ka_cmd);
 
 	rq->timeout = ctrl->kato * HZ;
 	rq->end_io = nvme_keep_alive_end_io;
@@ -1475,6 +1485,7 @@ static int nvme_ns_info_from_id_cs_indep(struct nvme_ctrl *ctrl,
 static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 		unsigned int dword11, void *buffer, size_t buflen, u32 *result)
 {
+	struct request *req;
 	union nvme_result res = { 0 };
 	struct nvme_command c = { };
 	int ret;
@@ -1483,8 +1494,11 @@ static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 	c.features.fid = cpu_to_le32(fid);
 	c.features.dword11 = cpu_to_le32(dword11);
 
-	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res,
-			buffer, buflen, NVME_QID_ANY, 0, 0);
+	req = nvme_alloc_request(dev->admin_q, &c, NVME_QID_ANY, 0);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	ret = __nvme_submit_sync_cmd(req, &res, buffer, buflen, 0);
 	if (ret >= 0 && result)
 		*result = le32_to_cpu(res.u32);
 	return ret;
@@ -2206,6 +2220,7 @@ static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t l
 {
 	struct nvme_ctrl *ctrl = data;
 	struct nvme_command cmd = { };
+	struct request *req;
 
 	if (send)
 		cmd.common.opcode = nvme_admin_security_send;
@@ -2215,8 +2230,11 @@ static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t l
 	cmd.common.cdw10 = cpu_to_le32(((u32)secp) << 24 | ((u32)spsp) << 8);
 	cmd.common.cdw11 = cpu_to_le32(len);
 
-	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
-			NVME_QID_ANY, 1, 0);
+	req = nvme_alloc_request(ctrl->admin_q, &cmd, NVME_QID_ANY, 0);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	return __nvme_submit_sync_cmd(req, NULL, buffer, len, 1);
 }
 
 static void nvme_configure_opal(struct nvme_ctrl *ctrl, bool was_suspended)
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index bbaa04a0c502..914784b611a2 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -144,6 +144,7 @@ EXPORT_SYMBOL_GPL(nvmf_get_address);
  */
 int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 {
+	struct request *req;
 	struct nvme_command cmd = { };
 	union nvme_result res;
 	int ret;
@@ -152,8 +153,11 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.fctype = nvme_fabrics_type_property_get;
 	cmd.prop_get.offset = cpu_to_le32(off);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+	req = nvme_alloc_request(ctrl->fabrics_q, &cmd, NVME_QID_ANY, 0);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	ret = __nvme_submit_sync_cmd(req, &res, NULL, 0, 0);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -189,6 +193,7 @@ EXPORT_SYMBOL_GPL(nvmf_reg_read32);
  */
 int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 {
+	struct request *req;
 	struct nvme_command cmd = { };
 	union nvme_result res;
 	int ret;
@@ -198,8 +203,11 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.attrib = 1;
 	cmd.prop_get.offset = cpu_to_le32(off);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+	req = nvme_alloc_request(ctrl->fabrics_q, &cmd, NVME_QID_ANY, 0);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	ret = __nvme_submit_sync_cmd(req, &res, NULL, 0, 0);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -234,6 +242,7 @@ EXPORT_SYMBOL_GPL(nvmf_reg_read64);
  */
 int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 {
+	struct request *req;
 	struct nvme_command cmd = { };
 	int ret;
 
@@ -243,8 +252,11 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.offset = cpu_to_le32(off);
 	cmd.prop_set.value = cpu_to_le64(val);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+	req = nvme_alloc_request(ctrl->fabrics_q, &cmd, NVME_QID_ANY, 0);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	ret = __nvme_submit_sync_cmd(req, NULL, NULL, 0, 0);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
@@ -374,6 +386,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	struct nvme_command cmd = { };
 	union nvme_result res;
 	struct nvmf_connect_data *data;
+	struct request *req;
 	int ret;
 	u32 result;
 
@@ -399,9 +412,12 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res,
-			data, sizeof(*data), NVME_QID_ANY, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+	req = nvme_alloc_request(ctrl->fabrics_q, &cmd, NVME_QID_ANY,
+				 BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	ret = __nvme_submit_sync_cmd(req, &res, data, sizeof(*data), 1);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
@@ -465,6 +481,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	struct nvme_command cmd = { };
 	struct nvmf_connect_data *data;
 	union nvme_result res;
+	struct request *req;
 	int ret;
 	u32 result;
 
@@ -485,9 +502,12 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
-	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
-			data, sizeof(*data), qid, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+	req = nvme_alloc_request(ctrl->fabrics_q, &cmd, NVME_QID_ANY,
+				 BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	ret = __nvme_submit_sync_cmd(req, &res, data, sizeof(*data), 1);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1..9b4b3bb69e27 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -813,10 +813,10 @@ static inline bool nvme_is_unique_nsid(struct nvme_ctrl *ctrl,
 
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
-int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-		union nvme_result *result, void *buffer, unsigned bufflen,
-		int qid, int at_head,
-		blk_mq_req_flags_t flags);
+struct request *nvme_alloc_request(struct request_queue *q,
+		struct nvme_command *cmd, int qid, blk_mq_req_flags_t flags);
+int __nvme_submit_sync_cmd(struct request *req, union nvme_result *result,
+		void *buffer, unsigned bufflen, int at_head);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a331fbfa9a66..94dcc9b65fec 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1376,13 +1376,12 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 		 nvme_get_opcode_str(nvme_req(req)->cmd->common.opcode),
 		 nvmeq->qid);
 
-	abort_req = blk_mq_alloc_request(dev->ctrl.admin_q, nvme_req_op(&cmd),
-					 BLK_MQ_REQ_NOWAIT);
+	abort_req = nvme_alloc_request(dev->ctrl.admin_q, &cmd,
+			NVME_QID_ANY, BLK_MQ_REQ_NOWAIT);
 	if (IS_ERR(abort_req)) {
 		atomic_inc(&dev->ctrl.abort_limit);
 		return BLK_EH_RESET_TIMER;
 	}
-	nvme_init_request(abort_req, &cmd);
 
 	abort_req->end_io = abort_endio;
 	abort_req->end_io_data = NULL;
@@ -2391,10 +2390,9 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	cmd.delete_queue.opcode = opcode;
 	cmd.delete_queue.qid = cpu_to_le16(nvmeq->qid);
 
-	req = blk_mq_alloc_request(q, nvme_req_op(&cmd), BLK_MQ_REQ_NOWAIT);
+	req = nvme_alloc_request(q, &cmd, NVME_QID_ANY, BLK_MQ_REQ_NOWAIT);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
-	nvme_init_request(req, &cmd);
 
 	if (opcode == nvme_admin_delete_cq)
 		req->end_io = nvme_del_cq_end;
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 511c980d538d..aae6d5bb4fd8 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -316,12 +316,11 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		timeout = nvmet_req_subsys(req)->admin_timeout;
 	}
 
-	rq = blk_mq_alloc_request(q, nvme_req_op(req->cmd), 0);
+	rq = nvme_alloc_request(q, req->cmd, NVME_QID_ANY, 0);
 	if (IS_ERR(rq)) {
 		status = NVME_SC_INTERNAL;
 		goto out_put_ns;
 	}
-	nvme_init_request(rq, req->cmd);
 
 	if (timeout)
 		rq->timeout = timeout;
-- 
2.35.3


