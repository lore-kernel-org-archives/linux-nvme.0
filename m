Return-Path: <SRS0=wdCx=X2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028B5C352AA
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Oct 2019 23:13:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE68B2086A
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Oct 2019 23:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O8UMtDcQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kRPFlv3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE68B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+WkzS9ImDJxnzCex9sutlkIaa63DiddkO4VAaO+/JCc=; b=O8UMtDcQAaa4nz
	ZkLjw6b/X3V4a43Wq2lmro5r6VbWjVpUDW5IK6CXKOYVCm4s5+2lvf8JxOyoaoUZvglEwT8qf9Fe+
	2zDLwYRwCRTXhFtdUmBUo74OOVxD2OBnsOSyq2b+/CQlIoUaIftqq5bpB4tyWeHa206eb/3Brn/th
	R/Z4eDp+jZ8gv+fIGxr+JwCb72YWm6vFvGUo47tiJn/9wolf+WtFjYDiufv99wSr1yARiNd8bt/cd
	VFrf5VYDVu+UHx4pCQ5fq8LevixVdwYK7BYi+bfe+SexD4tmaq2+2c8VqKenXDDCpHpgjpZOGkKpz
	sZdKux0GHSy4dyz0SpKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iFRL8-0006Xk-2a; Tue, 01 Oct 2019 23:13:54 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFRL3-0006XF-Qy
 for linux-nvme@lists.infradead.org; Tue, 01 Oct 2019 23:13:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569971630; x=1601507630;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=c33RtDTWsvyO2aJZ12O6irLoXbEpqLmHbx8D8BtCa2M=;
 b=kRPFlv3c+2rQmwpYGiQOZC009Un4ui+vOeWCPOcsKGVb1WV1C3dnq97f
 7bztR1DuOdboOpAiIxCnToff4t+MblkPzkUaWUCd0Nd9Fl46mh/Y56oVF
 r8bVp0b3dg2jZ2QDpfBTdSg3B5oEEFTPhR6CGJ02pQiLLOvpwocDAgFtY
 RPH0O8Gr4eekaH0DrhpEmHLLJSc383pAa+DteF4wcxupX364MRlynCBlm
 Osw2fq8r5bnG+JpKdtExU45P+1MyDXugb04ukS5tPD5dnkQYtf7D8b9UV
 OmupddLmuwhYxyE24txFs6vVbtNWeblgFez6clrpMlp515MG5u5L4sLB1 g==;
IronPort-SDR: NFDnQ5V/fhSS0e+r4fnJY/LK+Ro/jJwgjCKT18um6rXUNnqlstfDlLb6xQkRY26hQGl7v1/+/w
 LntC7UqzarcW26vp+AArIDjDI6ivwqySqotdF1kpSI/L1UAxzhdFWV/tgXBQw46iSjXfCufVAE
 +DSASZ1jcC+J0VJB558zH/pOHdt7qIiGi/QRlSu/YZbkEfjFkowUm5Xq7MXbVN43HG0c7WJ1m+
 u+rOEHatpwsqMF4NAn2kBSeIzf1yMvTM8OXjofltyhZBf6j2oAgpqSJa4vHb9OfwPVboDKmmdn
 qYI=
X-IronPort-AV: E=Sophos;i="5.64,572,1559491200"; d="scan'208";a="120348580"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2019 07:13:49 +0800
IronPort-SDR: sHNGOThyuFlyRyvjUBzfjospa/wldkCw+iyzT3vegnwvP18NyRol9R7qUlx01hD0LuExyfqPPK
 2lGS8VN7xqA/s4n0/k5Qd4DoB6l5vb+dg2wLY43V3BQUrqkmLMVITq9Y7hW0KU3uXEWCDAPo/8
 7ZlxLJPAWDkb1WvmVwWwjDXkc/rDvfqVg/oteZAIFCLoN65zgGSCYypXlDLAOHaNkgxAaLyfX7
 6B2oAbLq/TlgCpwrffZNFZ/ByGC+jA8K5qPVn9TpM39VfPUlrOHdn6R2io0oLQObG+QWL8txAx
 0DNuLrxFDeikuFauo8pAgq/M
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2019 16:10:00 -0700
IronPort-SDR: wZy8J4N9wj0VmFq2UZxqWOKF2kWTDaK5cuubjWY1/yK7E+LusWEwYETUsBm73g8U0IYP71wq/Y
 ofzUJ+4S6GEG08I9n8ivuB9D7dUzSo/oEGtgVDS1lomlHNCckABuuN1Kmgxj0xg83LgHvVyYb0
 BGsucwEUlgjlwRfYgiZRIeiS5FsrjgU8UpO8XdtkNjvhSV4saXQQ5RwaE7guhyQbTjLeoL6INN
 rRdoJVyoRtc1bjAdNDZAIN6DBnLPbEmiHYr9Cr14CUjfu8dtvOeyKO2uFEb+IAlV6ukSq4rKAy
 cHw=
WDCIronportException: Internal
Received: from cvenusqemu.hgst.com ([10.202.66.73])
 by uls-op-cesaip01.wdc.com with ESMTP; 01 Oct 2019 16:13:48 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: define struct for __nvme_submit_sync_cmd()
Date: Tue,  1 Oct 2019 16:13:46 -0700
Message-Id: <20191001231346.18518-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191001_161349_912829_1166BE22 
X-CRM114-Status: GOOD (  15.76  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Over the period of time __nvme_submit_sync_cmd() function has grown to
accept large number of paratements. The function __nvme_submit_sync_cmd()
now takes 10 parameters. This patch consolidates all the parameters into
one defined structure.

This makes calls to the same function easy to read and improves overall
code readability.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Hi,

	I've compile tested this patch. Once we agree on this change
	I'll send out a tested version.

Regards,
Chaitanya
---
 drivers/nvme/host/core.c    | 78 +++++++++++++++++++++---------
 drivers/nvme/host/fabrics.c | 96 ++++++++++++++++++++++++++++---------
 drivers/nvme/host/nvme.h    | 18 +++++--
 3 files changed, 142 insertions(+), 50 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e35615940365..9be51df8fb2f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -769,32 +769,30 @@ static void nvme_execute_rq_polled(struct request_queue *q,
  * Returns 0 on success.  If the result is negative, it's a Linux error code;
  * if the result is positive, it's an NVM Express status code
  */
-int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-		union nvme_result *result, void *buffer, unsigned bufflen,
-		unsigned timeout, int qid, int at_head,
-		blk_mq_req_flags_t flags, bool poll)
+int __nvme_submit_sync_cmd(struct nvme_submit_sync_data *d)
 {
 	struct request *req;
 	int ret;
 
-	req = nvme_alloc_request(q, cmd, flags, qid);
+	req = nvme_alloc_request(d->q, d->cmd, d->flags, d->qid);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	req->timeout = d->timeout ? d->timeout : ADMIN_TIMEOUT;
 
-	if (buffer && bufflen) {
-		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
+	if (d->buffer && d->bufflen) {
+		ret = blk_rq_map_kern(d->q, req, d->buffer, d->bufflen,
+				      GFP_KERNEL);
 		if (ret)
 			goto out;
 	}
 
-	if (poll)
-		nvme_execute_rq_polled(req->q, NULL, req, at_head);
+	if (d->poll)
+		nvme_execute_rq_polled(req->q, NULL, req, d->at_head);
 	else
-		blk_execute_rq(req->q, NULL, req, at_head);
-	if (result)
-		*result = nvme_req(req)->result;
+		blk_execute_rq(req->q, NULL, req, d->at_head);
+	if (d->result)
+		*(d->result) = nvme_req(req)->result;
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
 	else
@@ -808,8 +806,20 @@ EXPORT_SYMBOL_GPL(__nvme_submit_sync_cmd);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, unsigned bufflen)
 {
-	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen, 0,
-			NVME_QID_ANY, 0, 0, false);
+	struct nvme_submit_sync_data d = {
+		.q = q,
+		.cmd = cmd,
+		.result = NULL,
+		.buffer = buffer,
+		.bufflen = bufflen,
+		.timeout= 0,
+		.qid = NVME_QID_ANY,
+		.at_head = 0,
+		.flags = 0,
+		.poll = false
+	};
+
+	return __nvme_submit_sync_cmd(&d);
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
@@ -1114,19 +1124,30 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl,
 }
 
 static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
-		unsigned int dword11, void *buffer, size_t buflen, u32 *result)
+			 unsigned int dword11, void *buffer, size_t buflen,
+			 u32 *result)
 {
-	struct nvme_command c;
+	struct nvme_command c = {};
 	union nvme_result res;
 	int ret;
+	struct nvme_submit_sync_data d = {
+		.q = dev->admin_q,
+		.cmd = &c,
+		.result = &res,
+		.buffer = buffer,
+		.bufflen = buflen,
+		.timeout = 0,
+		.qid = NVME_QID_ANY,
+		.at_head = 0,
+		.flags = 0,
+		.poll = false,
+	};
 
-	memset(&c, 0, sizeof(c));
 	c.features.opcode = op;
 	c.features.fid = cpu_to_le32(fid);
 	c.features.dword11 = cpu_to_le32(dword11);
 
-	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res,
-			buffer, buflen, 0, NVME_QID_ANY, 0, 0, false);
+	ret = __nvme_submit_sync_cmd(&d);
 	if (ret >= 0 && result)
 		*result = le32_to_cpu(res.u32);
 	return ret;
@@ -1954,10 +1975,22 @@ static const struct pr_ops nvme_pr_ops = {
 
 #ifdef CONFIG_BLK_SED_OPAL
 int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
-		bool send)
+		    bool send)
 {
 	struct nvme_ctrl *ctrl = data;
 	struct nvme_command cmd;
+	struct nvme_submit_sync_data d = {
+		.q = dev->admin_q,
+		.cmd = &cmd,
+		.result = NULL,
+		.buffer = buffer,
+		.bufflen = len,
+		.timeout = ADMIN_TIMEOUT,
+		.qid = NVME_QID_ANY,
+		.at_head = 1;
+		.flags = 0;
+		.poll = false;
+	};
 
 	memset(&cmd, 0, sizeof(cmd));
 	if (send)
@@ -1968,8 +2001,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 	cmd.common.cdw10 = cpu_to_le32(((u32)secp) << 24 | ((u32)spsp) << 8);
 	cmd.common.cdw11 = cpu_to_le32(len);
 
-	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
-				      ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0, false);
+	return __nvme_submit_sync_cmd(&d);
 }
 EXPORT_SYMBOL_GPL(nvme_sec_submit);
 #endif /* CONFIG_BLK_SED_OPAL */
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 74b8818ac9a1..c5a8aec5f046 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -144,14 +144,25 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	struct nvme_command cmd;
 	union nvme_result res;
 	int ret;
+	struct nvme_submit_sync_data d = {
+		.q = ctrl->fabrics_q,
+		.cmd = &cmd,
+		.result = &res,
+		.buffer = NULL,
+		.bufflen = 0,
+		.timeout = 0,
+		.qid = NVME_QID_ANY,
+		.at_head = 0,
+		.flags = 0,
+		.poll = false
+	};
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.prop_get.opcode = nvme_fabrics_command;
 	cmd.prop_get.fctype = nvme_fabrics_type_property_get;
 	cmd.prop_get.offset = cpu_to_le32(off);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0, false);
+	ret = __nvme_submit_sync_cmd(&d);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -190,6 +201,18 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	struct nvme_command cmd;
 	union nvme_result res;
 	int ret;
+	struct nvme_submit_sync_data d = {
+		.q = ctrl->fabrics_q,
+		.cmd = &cmd,
+		.result = &res,
+		.buffer = NULL,
+		.bufflen = 0,
+		.timeout = 0,
+		.qid = NVME_QID_ANY,
+		.at_head = 0,
+		.flags = 0,
+		.poll = false
+	};
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.prop_get.opcode = nvme_fabrics_command;
@@ -197,9 +220,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.attrib = 1;
 	cmd.prop_get.offset = cpu_to_le32(off);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0, false);
-
+	ret = __nvme_submit_sync_cmd(&d);
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
 	if (unlikely(ret != 0))
@@ -235,6 +256,18 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 {
 	struct nvme_command cmd;
 	int ret;
+	struct nvme_submit_sync_data d = {
+		.q = ctrl->fabrics_q,
+		.cmd = &cmd,
+		.result = NULL,
+		.buffer = NULL,
+		.bufflen = 0,
+		.timeout = 0,
+		.qid = NVME_QID_ANY,
+		.at_head = 0,
+		.flags = 0,
+		.poll = false
+	};
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.prop_set.opcode = nvme_fabrics_command;
@@ -243,8 +276,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.offset = cpu_to_le32(off);
 	cmd.prop_set.value = cpu_to_le64(val);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0, false);
+	ret = __nvme_submit_sync_cmd(&d);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
@@ -366,10 +398,25 @@ static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
  */
 int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 {
+	struct nvmf_connect_data *data = kzalloc(sizeof(*data), GFP_KERNEL);
 	struct nvme_command cmd;
 	union nvme_result res;
-	struct nvmf_connect_data *data;
 	int ret;
+	struct nvme_submit_sync_data d = {
+		.q = ctrl->fabrics_q,
+		.cmd = &cmd,
+		.result = &res,
+		.buffer = data,
+		.bufflen = sizeof(data),
+		.timeout = 0,
+		.qid = NVME_QID_ANY,
+		.at_head = 1,
+		.flags = BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT,
+		.poll = false
+	};
+
+	if (!data)
+		return -ENOMEM;
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.connect.opcode = nvme_fabrics_command;
@@ -387,18 +434,12 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	if (ctrl->opts->disable_sqflow)
 		cmd.connect.cattr |= NVME_CONNECT_DISABLE_SQFLOW;
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
 	uuid_copy(&data->hostid, &ctrl->opts->host->id);
 	data->cntlid = cpu_to_le16(0xffff);
 	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res,
-			data, sizeof(*data), 0, NVME_QID_ANY, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, false);
+	ret = __nvme_submit_sync_cmd(&d);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
@@ -436,10 +477,25 @@ EXPORT_SYMBOL_GPL(nvmf_connect_admin_queue);
  */
 int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid, bool poll)
 {
+	struct nvmf_connect_data *data = kzalloc(sizeof(*data), GFP_KERNEL);
 	struct nvme_command cmd;
-	struct nvmf_connect_data *data;
 	union nvme_result res;
 	int ret;
+	struct nvme_submit_sync_data d = {
+		.q = ctrl->connect_q,
+		.cmd = &cmd,
+		.result = &res,
+		.buffer = data,
+		.bufflen = sizeof(*data),
+		.timeout = 0,
+		.qid = qid,
+		.at_head = 1,
+		.flags = BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT,
+		.poll = poll
+	};
+
+	if (!data)
+		return -ENOMEM;
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.connect.opcode = nvme_fabrics_command;
@@ -450,18 +506,12 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid, bool poll)
 	if (ctrl->opts->disable_sqflow)
 		cmd.connect.cattr |= NVME_CONNECT_DISABLE_SQFLOW;
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
 	uuid_copy(&data->hostid, &ctrl->opts->host->id);
 	data->cntlid = cpu_to_le16(ctrl->cntlid);
 	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
-	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
-			data, sizeof(*data), 0, qid, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, poll);
+	ret = __nvme_submit_sync_cmd(&d);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 38a83ef5bcd3..f172d8e02fc6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -395,6 +395,19 @@ struct nvme_ctrl_ops {
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
 };
 
+struct nvme_submit_sync_data {
+	struct request_queue *q;
+	struct nvme_command *cmd;
+	union nvme_result *result;
+	void *buffer;
+	unsigned bufflen;
+	unsigned timeout;
+	int qid;
+	int at_head;
+	blk_mq_req_flags_t flags;
+	bool poll;
+};
+
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
 			    const char *dev_name);
@@ -485,10 +498,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmd);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
-int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-		union nvme_result *result, void *buffer, unsigned bufflen,
-		unsigned timeout, int qid, int at_head,
-		blk_mq_req_flags_t flags, bool poll);
+int __nvme_submit_sync_cmd(struct nvme_submit_sync_data *d);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
