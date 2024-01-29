Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D552C47422
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 06:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XG9oGJFCqyG0dOw0v3NJ62krFo8k37c1ilqTxbcdopk=; b=gZHymFjLzmGa0pTo78z03X1Z4w
	S0KV34083a8lNGUagjNm78t3udlig8bsdDvRImVDG7XA5IDQoEB6uLfx5B0uJM6/rpE8Gqn7sU9mY
	uzO2oDovLFwNpfGcr/eqSEonXe1EPSEpStTXyCQDbAVDKw19W6oAGx17UpXCfwM9RtxdBxIvZQzyW
	s9fapo6SLPEFFIvmHR69Y4petM1skqSegPm4K06JcG5pOfL5zgqwRqDWbq/cvUDOK/f8ig+sYbVrz
	BC048GhzCGIOyi0bQVO8mKWqfRXudQ2lcnIk7l7QaGnkdGP0/VLu0U66eUMUbLeEGw4lCfT450WeO
	hrVuyAvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rULJb-0000000BWcC-0CcK;
	Mon, 29 Jan 2024 06:40:19 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rULJV-0000000BWZy-2uil
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 06:40:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E6F0BCE1009;
	Mon, 29 Jan 2024 06:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821C4C433A6;
	Mon, 29 Jan 2024 06:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706510409;
	bh=yGOXNdFUmh97vEieQO1e22P/1HOFxzidh2yogNOFUr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BAqb49U4Vxx53iFAn9/E8l+Lhb8e3myVIQQ4eyBCYkGc7hDPJyPWMttx37VvjxMX1
	 PjHvx07zWs1HMxtxWSpUk0r+tg8HWXWPHg1HWibHXRuAo2uIAoDJkBlsK4gm+oAHoG
	 tmtZbnMSWC/ohmf0koU/16yNdxJEjxZK7fyb690sj6Zfc1GXen2lhTfYTuIrHwTlyV
	 4AFaCUTxUw9Ce9b34Q2OqhBJZ8lkxDoeElIxF0r2TrbXMIhRepOJYkEJfWTFuKWk84
	 cLa14E91NryOl242j1updtTOEyEB55SoSCN/ZeUNMKjz+wnGDOKtbF3scGRIoylkPc
	 xWOSTLRP1vTXg==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/3] nvme: simplify __nvme_submit_sync_cmd() calling conventions
Date: Mon, 29 Jan 2024 07:39:47 +0100
Message-Id: <20240129063948.3105-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240129063948.3105-1-hare@kernel.org>
References: <20240129063948.3105-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_224014_112071_A163FC91 
X-CRM114-Status: GOOD (  15.03  )
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

From: Hannes Reinecke <hare@suse.de>

Instead of having two arguments for 'flags' and 'at_head'
for __nvme_submit_sync_cmd() combine them into a single
'flags' argument and use function-specific values to
indicate what should be set within the function.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c    |  7 +++----
 drivers/nvme/host/core.c    | 19 ++++++++++++-------
 drivers/nvme/host/fabrics.c | 18 +++++++++++-------
 drivers/nvme/host/nvme.h    | 17 +++++++++++++++--
 4 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 9aa2325f9a98..fd026832d285 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -58,12 +58,12 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 			    void *data, size_t data_len, bool auth_send)
 {
 	struct nvme_command cmd = {};
-	blk_mq_req_flags_t flags = 0;
+	nvme_submit_flags_t flags = 0;
 	struct request_queue *q = ctrl->fabrics_q;
 	int ret;
 
 	if (qid != 0) {
-		flags |= BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED;
+		flags |= NVME_SUBMIT_NOWAIT | NVME_SUBMIT_RESERVED;
 		q = ctrl->connect_q;
 	}
 
@@ -80,8 +80,7 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 	}
 
 	ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len,
-				     qid == 0 ? NVME_QID_ANY : qid,
-				     0, flags);
+				     qid == 0 ? NVME_QID_ANY : qid, flags);
 	if (ret > 0)
 		dev_warn(ctrl->device,
 			"qid %d auth_send failed with status %d\n", qid, ret);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 50818dbcfa1a..9e140d9d9d48 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1049,15 +1049,20 @@ EXPORT_SYMBOL_NS_GPL(nvme_execute_rq, NVME_TARGET_PASSTHRU);
  */
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
-		int qid, int at_head, blk_mq_req_flags_t flags)
+		int qid, nvme_submit_flags_t flags)
 {
 	struct request *req;
 	int ret;
+	blk_mq_req_flags_t blk_flags = 0;
 
+	if (flags & NVME_SUBMIT_NOWAIT)
+		blk_flags |= BLK_MQ_REQ_NOWAIT;
+	if (flags & NVME_SUBMIT_RESERVED)
+		blk_flags |= BLK_MQ_REQ_RESERVED;
 	if (qid == NVME_QID_ANY)
-		req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
+		req = blk_mq_alloc_request(q, nvme_req_op(cmd), blk_flags);
 	else
-		req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), flags,
+		req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), blk_flags,
 						qid - 1);
 
 	if (IS_ERR(req))
@@ -1070,7 +1075,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 			goto out;
 	}
 
-	ret = nvme_execute_rq(req, at_head);
+	ret = nvme_execute_rq(req, flags & NVME_SUBMIT_AT_HEAD);
 	if (result && ret >= 0)
 		*result = nvme_req(req)->result;
  out:
@@ -1083,7 +1088,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, unsigned bufflen)
 {
 	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0);
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
@@ -1547,7 +1552,7 @@ static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 	c.features.dword11 = cpu_to_le32(dword11);
 
 	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res,
-			buffer, buflen, NVME_QID_ANY, 0, 0);
+			buffer, buflen, NVME_QID_ANY, 0);
 	if (ret >= 0 && result)
 		*result = le32_to_cpu(res.u32);
 	return ret;
@@ -2149,7 +2154,7 @@ static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t l
 	cmd.common.cdw11 = cpu_to_le32(len);
 
 	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
-			NVME_QID_ANY, 1, 0);
+			NVME_QID_ANY, NVME_SUBMIT_AT_HEAD);
 }
 
 static void nvme_configure_opal(struct nvme_ctrl *ctrl, bool was_suspended)
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index aa88606a44c4..2a4e4de794d5 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -180,7 +180,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -226,7 +226,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -271,7 +271,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.value = cpu_to_le64(val);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
@@ -450,8 +450,10 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		return -ENOMEM;
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res,
-			data, sizeof(*data), NVME_QID_ANY, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+			data, sizeof(*data), NVME_QID_ANY,
+			NVME_SUBMIT_AT_HEAD |
+			NVME_SUBMIT_NOWAIT |
+			NVME_SUBMIT_RESERVED);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
@@ -525,8 +527,10 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		return -ENOMEM;
 
 	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
-			data, sizeof(*data), qid, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+			data, sizeof(*data), qid,
+			NVME_SUBMIT_AT_HEAD |
+			NVME_SUBMIT_RESERVED |
+			NVME_SUBMIT_NOWAIT);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6092cc361837..f842e5e8694d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -825,12 +825,25 @@ static inline bool nvme_is_unique_nsid(struct nvme_ctrl *ctrl,
 		(ctrl->ctratt & NVME_CTRL_CTRATT_NVM_SETS);
 }
 
+/*
+ * Flags for __nvme_submit_sync_cmd()
+ */
+typedef __u32 __bitwise nvme_submit_flags_t;
+
+enum {
+	/* Insert request at the head of the queue */
+	NVME_SUBMIT_AT_HEAD  = (__force nvme_submit_flags_t)(1 << 0),
+	/* Set BLK_MQ_REQ_NOWAIT when allocating request */
+	NVME_SUBMIT_NOWAIT = (__force nvme_submit_flags_t)(1 << 1),
+	/* Set BLK_MQ_REQ_RESERVED when allocating request */
+	NVME_SUBMIT_RESERVED = (__force nvme_submit_flags_t)(1 << 2),
+};
+
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
-		int qid, int at_head,
-		blk_mq_req_flags_t flags);
+		int qid, nvme_submit_flags_t flags);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
-- 
2.35.3


