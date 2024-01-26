Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CE3C47422
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jan 2024 06:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=y2Mtofs0uu+bPOMx60JWaWa6xkXrerVP/ziJFQET7Eo=; b=ti1ZGKGvEzJji5fQ07BAX7afGT
	M4O6lyrAdTMOe+siGfy9wbdpg8skgwLc9zy4OTGQRM6kLj1CyB5poBQV+Eh4eg+AxeCmCgy6thIJl
	9mjtqlqLPv2lluC/Fi6ASv7Ivr+GmbLuPLc5aP3FH+NuQ2ZF8BHlEvYHK91O8Ubap9pnVmgG/pasS
	Lo5gB7lh5yWATmPLiBTn+LW6kebuyKEFAgsopqaRU7djNmu22XiCgfqazuchhe0Od5P5//8xVhmWy
	IrA+ts+EL0h4EJOTLL3uOpo1yFtZKcnL8cQlwVXi1XFX4+Jmo9BQwsy5F/L+jGmdwVtq1HfKxhGfy
	9DzqWiVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTFqD-00000003GIV-3oUG;
	Fri, 26 Jan 2024 06:37:29 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTFq3-00000003GI3-41zs
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jan 2024 06:37:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E2148623D9;
	Fri, 26 Jan 2024 06:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7917C433C7;
	Fri, 26 Jan 2024 06:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706251038;
	bh=NDq55P4dKDxT9JGYnQ+k8Gs/5c1LBaG13s7BpO5q7nQ=;
	h=From:To:Cc:Subject:Date:From;
	b=H4iPgSy4nj9IwCFjKOm6yTojKsUTilOe95nFfdH0pwQvvv9NinlRhK/Gv5i6y2SMX
	 pLX8H/wkKBTeP5KzSlCO+QHlrE/zOb4xiLRKQMq84WjosFuySpc7tEio93ayp0RKjT
	 m9YmGAJa7W41eepElxBCG0hpltGKCm4kxlnXI34RL+PVJWbQ43uJIoKmwOHhnmKB/X
	 kTYe+51FY92F7rhTR58hacWOyGUYcGs4FHlFE2bqM4ch0I6xOLPhhKVG3n09WMJExw
	 Fr6fjxY+6Q8209MboEKuTCUSXMfE0Z//azC8QJLiPLNXX+aBRfz8qnkYSF6iqLT3M1
	 QWxIaEUDmmsVQ==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Martin George <marting@netapp.com>
Subject: [PATCHv2] nvme: enable retries for authentication commands
Date: Fri, 26 Jan 2024 07:37:09 +0100
Message-Id: <20240126063709.123814-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_223720_136172_BA4B1AD4 
X-CRM114-Status: GOOD (  15.68  )
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

Authentication commands are normal NVMe commands, and as such
can return a status where NVME_SC_DNR is not set, indicating
that the command should be retried.
This patch combines the two arguments 'at_head' and 'flags' from
__nvme_submit_sync_cmd() into a new 'nvme_submit_flags_t' argument,
and enables retries by setting NVME_SUBMIT_RETRY.

Reported-by: Martin George <marting@netapp.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c    |  8 ++++----
 drivers/nvme/host/core.c    | 21 ++++++++++++++-------
 drivers/nvme/host/fabrics.c | 18 +++++++++++-------
 drivers/nvme/host/nvme.h    | 12 ++++++++++--
 4 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 35a460cfb4bf..25e3f13f488d 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -50,7 +50,8 @@ struct nvme_dhchap_queue_context {
 static struct workqueue_struct *nvme_auth_wq;
 
 #define nvme_auth_flags_from_qid(qid) \
-	(qid == 0) ? 0 : BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED
+	(qid == 0) ? NVME_SUBMIT_RETRY : \
+	NVME_SUBMIT_RETRY | NVME_SUBMIT_NOWAIT | NVME_SUBMIT_RESERVED
 #define nvme_auth_queue_from_qid(ctrl, qid) \
 	(qid == 0) ? (ctrl)->fabrics_q : (ctrl)->connect_q
 
@@ -64,7 +65,7 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 			    void *data, size_t data_len, bool auth_send)
 {
 	struct nvme_command cmd = {};
-	blk_mq_req_flags_t flags = nvme_auth_flags_from_qid(qid);
+	nvme_submit_flags_t flags = nvme_auth_flags_from_qid(qid);
 	struct request_queue *q = nvme_auth_queue_from_qid(ctrl, qid);
 	int ret;
 
@@ -81,8 +82,7 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 	}
 
 	ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len,
-				     qid == 0 ? NVME_QID_ANY : qid,
-				     0, flags);
+				     qid == 0 ? NVME_QID_ANY : qid, flags);
 	if (ret > 0)
 		dev_warn(ctrl->device,
 			"qid %d auth_send failed with status %d\n", qid, ret);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 376efb310eb2..bf1b85866ce9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1049,20 +1049,27 @@ EXPORT_SYMBOL_NS_GPL(nvme_execute_rq, NVME_TARGET_PASSTHRU);
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
 		return PTR_ERR(req);
 	nvme_init_request(req, cmd);
+	if (flags & NVME_SUBMIT_RETRY)
+		req->cmd_flags &= ~REQ_FAILFAST_DRIVER;
 
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
@@ -1070,7 +1077,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 			goto out;
 	}
 
-	ret = nvme_execute_rq(req, at_head);
+	ret = nvme_execute_rq(req, flags & NVME_SUBMIT_AT_HEAD);
 	if (result && ret >= 0)
 		*result = nvme_req(req)->result;
  out:
@@ -1083,7 +1090,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, unsigned bufflen)
 {
 	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0);
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
@@ -1547,7 +1554,7 @@ static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 	c.features.dword11 = cpu_to_le32(dword11);
 
 	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res,
-			buffer, buflen, NVME_QID_ANY, 0, 0);
+			buffer, buflen, NVME_QID_ANY, NVME_SUBMIT_RETRY);
 	if (ret >= 0 && result)
 		*result = le32_to_cpu(res.u32);
 	return ret;
@@ -2149,7 +2156,7 @@ static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t l
 	cmd.common.cdw11 = cpu_to_le32(len);
 
 	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
-			NVME_QID_ANY, 1, 0);
+			NVME_QID_ANY, NVME_SUBMIT_AT_HEAD);
 }
 
 static void nvme_configure_opal(struct nvme_ctrl *ctrl, bool was_suspended)
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 8140d8166c3e..38b60025649d 100644
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
@@ -526,8 +528,10 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
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
index 396e6e72b6a3..ad0414e433a1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -824,12 +824,20 @@ static inline bool nvme_is_unique_nsid(struct nvme_ctrl *ctrl,
 		(ctrl->ctratt & NVME_CTRL_CTRATT_NVM_SETS);
 }
 
+typedef __u32 __bitwise nvme_submit_flags_t;
+
+enum {
+	NVME_SUBMIT_AT_HEAD  = (__force nvme_submit_flags_t)(1 << 0),
+	NVME_SUBMIT_NOWAIT = (__force nvme_submit_flags_t)(1 << 1),
+	NVME_SUBMIT_RESERVED = (__force nvme_submit_flags_t)(1 << 2),
+	NVME_SUBMIT_RETRY = (__force nvme_submit_flags_t)(1 << 3),
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


