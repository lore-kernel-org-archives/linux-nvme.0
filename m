Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5949CC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 07:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EgIJdSCa4on/je7loxYUhuf023JtKqTf9c4rcm8QOJ8=; b=bO/XfziazNi5vjBXI+cxzVwdFG
	MBIjdc8Kp0Fp2D8f1t43dhUGih09K4QcFPBJsbN1uNRC8qBr+OXA9jI+IwKBP6NGOyZS849E+rnru
	49THg78wkuKXoqpNyFApYk8VQwND0GdgG6QsHn21yhxZ9kYfH2LPDTaqKcLvzEOwf2N+XzCmJ81/d
	jkXoX75Q9wgcr3ksm4x9I8AND7xgbVIHUMYD6aMnskvmXEPNeBubOFDxMpaV+mEXM4YK41b6F7IQR
	1CSLi8uakac9VNTEH/PBl/WVVjBwQWX1UJfgamYbPus2DlZ0EPWM/1RyOxQPItDyaGUlBcw8l4e+I
	36uqmmKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8J3-008e84-LM; Wed, 02 Nov 2022 07:37:01 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8J1-008e5o-0u
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 07:37:00 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 38FD8338FD;
	Wed,  2 Nov 2022 07:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667374613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EgIJdSCa4on/je7loxYUhuf023JtKqTf9c4rcm8QOJ8=;
	b=kTkgQCORfQj/DllEJdf3nBwpMqqi6OU/iWbotCTbXQcqNTDfXAi6rxx8MABqJCQuAIAdHv
	6TyR9Unpiw4N4tdcRdj2fsnkiX21Vj53+91lvtyuq80rRk9NKR20rrNSUzoFF5pbOlfzQ4
	By9WGdYp7S7q3pNROnDd77jf5txS38Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667374613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EgIJdSCa4on/je7loxYUhuf023JtKqTf9c4rcm8QOJ8=;
	b=813X1oCXJcmKcwk1aEkTkLEJ3MGlg6vJ8cMTi+harL1+XlUj0qfczriXaxHLH97YkrtLfs
	tTqwrchjymmusbCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 2E6462C141;
	Wed,  2 Nov 2022 07:36:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 5060851AD6BE; Wed,  2 Nov 2022 08:36:52 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme: retry commands if DNR bit is not set
Date: Wed,  2 Nov 2022 08:36:50 +0100
Message-Id: <20221102073650.58245-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_003659_236471_A4DC0155 
X-CRM114-Status: GOOD (  19.38  )
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

Add a 'retries' argument to __nvme_submit_sync_cmd() to instruct
the function to retry the command if the DNR bit is not set in
the command result, and modify the authentication code to allow
for retries.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c    |  2 +-
 drivers/nvme/host/core.c    | 29 ++++++++++++++++++++++++-----
 drivers/nvme/host/fabrics.c | 10 +++++-----
 drivers/nvme/host/nvme.h    |  6 +++++-
 4 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index c8a6db7c4498..3b63aa155beb 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -69,7 +69,7 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 
 	ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len,
 				     qid == 0 ? NVME_QID_ANY : qid,
-				     0, flags);
+				     0, flags, nvme_max_retries);
 	if (ret > 0)
 		dev_warn(ctrl->device,
 			"qid %d auth_send failed with status %d\n", qid, ret);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dc4220600585..d0de1a85596a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -54,7 +54,7 @@ static unsigned char shutdown_timeout = 5;
 module_param(shutdown_timeout, byte, 0644);
 MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
 
-static u8 nvme_max_retries = 5;
+u8 nvme_max_retries = 5;
 module_param_named(max_retries, nvme_max_retries, byte, 0644);
 MODULE_PARM_DESC(max_retries, "max number of retries a command may have");
 
@@ -1016,7 +1016,7 @@ static int nvme_execute_rq(struct request *rq, bool at_head)
  */
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
-		int qid, int at_head, blk_mq_req_flags_t flags)
+		int qid, int at_head, blk_mq_req_flags_t flags, int retries)
 {
 	struct request *req;
 	int ret;
@@ -1030,6 +1030,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	nvme_init_request(req, cmd);
+	nvme_req(req)->retries = retries;
 
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
@@ -1037,8 +1038,18 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 			goto out;
 	}
 
+retry:
 	req->rq_flags |= RQF_QUIET;
 	ret = nvme_execute_rq(req, at_head);
+	if (ret > 0) {
+		struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
+
+		if (ctrl->kas)
+			ctrl->comp_seen = true;
+
+		if (retries-- && nvme_decide_disposition(req) != COMPLETE)
+			goto retry;
+	}
 	if (result && ret >= 0)
 		*result = nvme_req(req)->result;
  out:
@@ -1051,10 +1062,18 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, unsigned bufflen)
 {
 	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, 0, 0);
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
+int nvme_submit_sync_cmd_retry(struct request_queue *q,
+		struct nvme_command *cmd, void *buffer, unsigned bufflen)
+{
+	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen,
+			NVME_QID_ANY, 0, 0, nvme_max_retries);
+}
+EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd_retry);
+
 static u32 nvme_known_admin_effects(u8 opcode)
 {
 	switch (opcode) {
@@ -1500,7 +1519,7 @@ static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 	c.features.dword11 = cpu_to_le32(dword11);
 
 	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res,
-			buffer, buflen, NVME_QID_ANY, 0, 0);
+			buffer, buflen, NVME_QID_ANY, 0, 0, 0);
 	if (ret >= 0 && result)
 		*result = le32_to_cpu(res.u32);
 	return ret;
@@ -2195,7 +2214,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 	cmd.common.cdw11 = cpu_to_le32(len);
 
 	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
-			NVME_QID_ANY, 1, 0);
+			NVME_QID_ANY, 1, 0, 0);
 }
 EXPORT_SYMBOL_GPL(nvme_sec_submit);
 #endif /* CONFIG_BLK_SED_OPAL */
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ce27276f552d..f4bfbaf733e9 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -153,7 +153,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, 0, 0);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -199,7 +199,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, 0, 0);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -244,7 +244,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.value = cpu_to_le64(val);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, 0, 0);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
@@ -401,7 +401,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res,
 			data, sizeof(*data), NVME_QID_ANY, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, 0);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
@@ -480,7 +480,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 
 	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
 			data, sizeof(*data), qid, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, 0);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a29877217ee6..32d9dc2d957e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -47,6 +47,8 @@ extern struct workqueue_struct *nvme_wq;
 extern struct workqueue_struct *nvme_reset_wq;
 extern struct workqueue_struct *nvme_delete_wq;
 
+extern u8 nvme_max_retries;
+
 /*
  * List of workarounds for devices that required behavior not specified in
  * the standard.
@@ -811,10 +813,12 @@ static inline bool nvme_is_unique_nsid(struct nvme_ctrl *ctrl,
 
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
+int nvme_submit_sync_cmd_retry(struct request_queue *q,
+		struct nvme_command *cmd, void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
 		int qid, int at_head,
-		blk_mq_req_flags_t flags);
+		blk_mq_req_flags_t flags, int retries);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
-- 
2.35.3


