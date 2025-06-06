Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADCBC61CE7
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jun 2025 20:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/XhRBh62Hwzyfxj9CvFGhi1yIryrKqtwUBjKo8jh5vA=; b=WIYV5hBRsKZ5Zq9ZPPa8e8zgmT
	Nj1rcMl7YiKDzGDHJg2lbIVP2o9slpmJW7beTO8KrjKouC90eJretTHhDNe8rCDgQQJCefRwm8Zzl
	niAV/IZOVicva928JRbxd/CwEtLy1Ku+v+qOzXwmFnecW+7CohWht9IIayh5mK89cAJcxHPJQjzyG
	puOkMkg3IiMywYs2yZnQoylavZMaePbBm9OCken6OAaMM429ObQvPPeSOrW2bNFQGY3H+XaL2cSwq
	l5T0GBtT5onzMHOEqkMsCLC0iAWYFHM0CbrwaucDgB+2lhQEmGCTq96k8MQfkYO3lnWwIoWZWdB7d
	LiWJKfzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNdW0-00000000wM2-1xJo;
	Fri, 06 Jun 2025 20:18:12 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNdVx-00000000wLL-3v4e
	for linux-nvme@lists.infradead.org;
	Fri, 06 Jun 2025 20:18:11 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-b2f603b0ef6so708417a12.1
        for <linux-nvme@lists.infradead.org>; Fri, 06 Jun 2025 13:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749241089; x=1749845889; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XhRBh62Hwzyfxj9CvFGhi1yIryrKqtwUBjKo8jh5vA=;
        b=WuybG2E2X1XMBB7uZMcrTR5wnDSvHYLj6OoJcp35pIEDn7rVLctwGCkrUgProhSy0H
         aCqx0xx/UkwXoy5OYMW8uKs548dzKUWbayxutzx8eIrZELhMNgkYASRLymDNpsJhIw4S
         XAT7b8JMnMWxtMxJl5ZZKSluStRtKX1B0tIPXNp0IU0ZocqA62XOyuj4loK400uvMUmp
         qOMBZyHE7MGNQdQhNNzJK5GtOyt1tuUBbH5nURTSt+wiim1XGrRagyPY0uGZ7RhgZ8Qa
         40MHSwyBCdEojKf6+cI+fgM7u/5e8rNP6DzQm9kF2/xuxfa3ShchlfgzepGEcglkIVk2
         2bAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749241089; x=1749845889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XhRBh62Hwzyfxj9CvFGhi1yIryrKqtwUBjKo8jh5vA=;
        b=VBN/otMbBLxF5ESgLXKkC1+js+JEijMXNKexg92eOahXbBThtNT4fnHdgLML3qgXvf
         h1/uAOdzA9cat5tzIVHVNDgaozN16l4zZkKn1uuZJSxrIihP5EFJGDYbw4as0t9c7Uc6
         YleUDp6yyLq4CML4d5r67RIjN6+RPJzwyDhwVSPeLe9pmM0rGl7zYq/g5r4Xltji3BPz
         8WEXJr/iTVL3kwy4CLixCsg7+aEC9og6Aj0eC3kQY3vtJwtg1c4skRz+AeIJy9YMAyue
         sAoxZ3B8YisSm75CroYX4nRxnZm9yTQT3STTRXnfuwDvCCXaat1BuXVWWc7FoZAD1uP3
         lXGg==
X-Gm-Message-State: AOJu0YxH+Lb/77zuz0z9auxv31GrXMqX1+8RTzIYBxjphxHYf+gK0bBr
	Id3ycRi1k3xaM6e/Zro2PIdoERT0Hz2HYlaVRv2e+wf0PAons977Aard9bsQ0w==
X-Gm-Gg: ASbGncvP8EDQlLksyIG//nfrubRU74eNMVMr6Z2o6zL961w4V07xlHey81ekhE4UP4n
	gdgbMbRdYAZzMEdJIxRyRpKSfCAsngqqEMmBuYTAs4kYoCcJhInOA+zPZe2TQfvIqKGL3WYeIsE
	OTFEUyX8/1ApsAsBCi9lz5iCJ/TaXA69r0orbc778mzeTEAfHA8sTP7rBTGv4SCXtM1fQ0LjJHb
	V1Y9pcsCuFtMR2J/5+84CfQdSTIYv4sq8Gle+ubXBqincGrJBYgZHGMbhGbVWNlpUHh5auFpxbk
	U/KdKHK/2tR+q/mg6/5fo6L448+MfnY7rDlD2cs2hkfCQY7zz7tZENaY1SDuUkfAxPozTJkvY/A
	xx31M/8FUQhy13Q==
X-Google-Smtp-Source: AGHT+IGe881IAoUwww6uvcwyW/lISdMYQ/B4GRvlqqp2SnVvm8m3mnQ8j46i4ZFtmHQ5atcIDfqyjA==
X-Received: by 2002:a17:90b:350d:b0:311:ea13:2e61 with SMTP id 98e67ed59e1d1-31347697347mr5676009a91.34.1749241088924;
        Fri, 06 Jun 2025 13:18:08 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:8b15:3e66:8393:27ba])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3135c5939a0sm591537a91.41.2025.06.06.13.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 13:18:08 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH 1/2] nvme/ioctl: split user request allocation from user command submission
Date: Sat,  7 Jun 2025 05:16:09 +0900
Message-ID: <20250606201654.9558-2-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606201654.9558-1-ikegami.t@gmail.com>
References: <20250606201654.9558-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_131809_975990_26943E25 
X-CRM114-Status: GOOD (  19.93  )
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

Delete unnecessary nvme command copy for the performance improvement.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/core.c  |  10 +-
 drivers/nvme/host/ioctl.c | 213 +++++++++++++++++++++-----------------
 2 files changed, 125 insertions(+), 98 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f69a232a000a..8736a9a8d74d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -734,14 +734,16 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
 	if (!logging_enabled)
 		req->rq_flags |= RQF_QUIET;
 
-	/* passthru commands should let the driver set the SGL flags */
-	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
-
 	req->cmd_flags |= REQ_FAILFAST_DRIVER;
 	if (req->mq_hctx->type == HCTX_TYPE_POLL)
 		req->cmd_flags |= REQ_POLLED;
 	nvme_clear_nvme_request(req);
-	memcpy(nr->cmd, cmd, sizeof(*cmd));
+
+	if (likely(cmd)) {
+		/* passthru commands should let the driver set the SGL flags */
+		cmd->common.flags &= ~NVME_CMD_SGL_ALL;
+		memcpy(nr->cmd, cmd, sizeof(*cmd));
+	}
 }
 EXPORT_SYMBOL_GPL(nvme_init_request);
 
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index ca86d3bf7ea4..02edb0900413 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -14,7 +14,7 @@ enum {
 	NVME_IOCTL_PARTITION	= (1 << 1),
 };
 
-static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
+static bool nvme_cmd_allowed(struct nvme_ns *ns, __u8 opcode, __u32 cdw10,
 		unsigned int flags, bool open_for_write)
 {
 	u32 effects;
@@ -30,8 +30,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	 * Do not allow unprivileged processes to send vendor specific or fabrics
 	 * commands as we can't be sure about their effects.
 	 */
-	if (c->common.opcode >= nvme_cmd_vendor_start ||
-	    c->common.opcode == nvme_fabrics_command)
+	if (opcode >= nvme_cmd_vendor_start || opcode == nvme_fabrics_command)
 		goto admin;
 
 	/*
@@ -41,8 +40,8 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	 * potentially sensitive information.
 	 */
 	if (!ns) {
-		if (c->common.opcode == nvme_admin_identify) {
-			switch (c->identify.cns) {
+		if (opcode == nvme_admin_identify) {
+			switch (cdw10 & 0xff) {
 			case NVME_ID_CNS_NS:
 			case NVME_ID_CNS_CS_NS:
 			case NVME_ID_CNS_NS_CS_INDEP:
@@ -59,7 +58,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	 * and marks this command as supported.  If not reject unprivileged
 	 * passthrough.
 	 */
-	effects = nvme_command_effects(ns->ctrl, ns, c->common.opcode);
+	effects = nvme_command_effects(ns->ctrl, ns, opcode);
 	if (!(effects & NVME_CMD_EFFECTS_CSUPP))
 		goto admin;
 
@@ -77,7 +76,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	 * change the logical block contents if the file descriptor is open for
 	 * writing.
 	 */
-	if ((nvme_is_write(c) || (effects & NVME_CMD_EFFECTS_LBCC)) &&
+	if ((opcode & 1 || (effects & NVME_CMD_EFFECTS_LBCC)) &&
 	    !open_for_write)
 		goto admin;
 
@@ -99,15 +98,15 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
 }
 
 static struct request *nvme_alloc_user_request(struct request_queue *q,
-		struct nvme_command *cmd, blk_opf_t rq_flags,
-		blk_mq_req_flags_t blk_flags)
+		__u8 opcode, blk_opf_t rq_flags, blk_mq_req_flags_t blk_flags)
 {
+	enum req_op op = opcode & 1 ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
 	struct request *req;
 
-	req = blk_mq_alloc_request(q, nvme_req_op(cmd) | rq_flags, blk_flags);
+	req = blk_mq_alloc_request(q, op | rq_flags, blk_flags);
 	if (IS_ERR(req))
 		return req;
-	nvme_init_request(req, cmd);
+	nvme_init_request(req, NULL);
 	nvme_req(req)->flags |= NVME_REQ_USERCMD;
 	return req;
 }
@@ -165,21 +164,17 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 }
 
 static int nvme_submit_user_cmd(struct request_queue *q,
-		struct nvme_command *cmd, u64 ubuffer, unsigned bufflen,
+		struct request *req, u64 ubuffer, unsigned bufflen,
 		void __user *meta_buffer, unsigned meta_len,
 		u64 *result, unsigned timeout, unsigned int flags)
 {
+	struct nvme_command *cmd = nvme_req(req)->cmd;
 	struct nvme_ns *ns = q->queuedata;
 	struct nvme_ctrl *ctrl;
-	struct request *req;
 	struct bio *bio;
 	u32 effects;
 	int ret;
 
-	req = nvme_alloc_user_request(q, cmd, 0, 0);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
 	req->timeout = timeout;
 	if (ubuffer && bufflen) {
 		ret = nvme_map_user_request(req, ubuffer, bufflen, meta_buffer,
@@ -211,9 +206,10 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 {
 	struct nvme_user_io io;
-	struct nvme_command c;
+	struct nvme_command *c;
 	unsigned length, meta_len;
 	void __user *metadata;
+	struct request *req;
 
 	if (copy_from_user(&io, uio, sizeof(io)))
 		return -EFAULT;
@@ -254,19 +250,25 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 			return -EINVAL;
 	}
 
-	memset(&c, 0, sizeof(c));
-	c.rw.opcode = io.opcode;
-	c.rw.flags = io.flags;
-	c.rw.nsid = cpu_to_le32(ns->head->ns_id);
-	c.rw.slba = cpu_to_le64(io.slba);
-	c.rw.length = cpu_to_le16(io.nblocks);
-	c.rw.control = cpu_to_le16(io.control);
-	c.rw.dsmgmt = cpu_to_le32(io.dsmgmt);
-	c.rw.reftag = cpu_to_le32(io.reftag);
-	c.rw.lbat = cpu_to_le16(io.apptag);
-	c.rw.lbatm = cpu_to_le16(io.appmask);
-
-	return nvme_submit_user_cmd(ns->queue, &c, io.addr, length, metadata,
+	req = nvme_alloc_user_request(ns->queue, io.opcode, 0, 0);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	c = nvme_req(req)->cmd;
+	memset(c, 0, sizeof(*c));
+	c->rw.opcode = io.opcode;
+	/* passthru commands should let the driver set the SGL flags */
+	c->rw.flags = io.flags & ~NVME_CMD_SGL_ALL;
+	c->rw.nsid = cpu_to_le32(ns->head->ns_id);
+	c->rw.slba = cpu_to_le64(io.slba);
+	c->rw.length = cpu_to_le16(io.nblocks);
+	c->rw.control = cpu_to_le16(io.control);
+	c->rw.dsmgmt = cpu_to_le32(io.dsmgmt);
+	c->rw.reftag = cpu_to_le32(io.reftag);
+	c->rw.lbat = cpu_to_le16(io.apptag);
+	c->rw.lbatm = cpu_to_le16(io.appmask);
+
+	return nvme_submit_user_cmd(ns->queue, req, io.addr, length, metadata,
 			meta_len, NULL, 0, 0);
 }
 
@@ -287,9 +289,11 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		struct nvme_passthru_cmd __user *ucmd, unsigned int flags,
 		bool open_for_write)
 {
+	struct request_queue *q = ns ? ns->queue : ctrl->admin_q;
 	struct nvme_passthru_cmd cmd;
-	struct nvme_command c;
+	struct nvme_command *c;
 	unsigned timeout = 0;
+	struct request *req;
 	u64 result;
 	int status;
 
@@ -300,28 +304,35 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (!nvme_validate_passthru_nsid(ctrl, ns, cmd.nsid))
 		return -EINVAL;
 
-	memset(&c, 0, sizeof(c));
-	c.common.opcode = cmd.opcode;
-	c.common.flags = cmd.flags;
-	c.common.nsid = cpu_to_le32(cmd.nsid);
-	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
-	c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
-	c.common.cdw10 = cpu_to_le32(cmd.cdw10);
-	c.common.cdw11 = cpu_to_le32(cmd.cdw11);
-	c.common.cdw12 = cpu_to_le32(cmd.cdw12);
-	c.common.cdw13 = cpu_to_le32(cmd.cdw13);
-	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
-	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
-
-	if (!nvme_cmd_allowed(ns, &c, 0, open_for_write))
+	if (!nvme_cmd_allowed(ns, cmd.opcode, cmd.cdw10, 0, open_for_write))
 		return -EACCES;
 
+	req = nvme_alloc_user_request(q, cmd.opcode, 0, 0);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	c = nvme_req(req)->cmd;
+	memset(c, 0, sizeof(*c));
+	c->common.opcode = cmd.opcode;
+
+	/* passthru commands should let the driver set the SGL flags */
+	c->common.flags = cmd.flags & ~NVME_CMD_SGL_ALL;
+	c->common.nsid = cpu_to_le32(cmd.nsid);
+	c->common.cdw2[0] = cpu_to_le32(cmd.cdw2);
+	c->common.cdw2[1] = cpu_to_le32(cmd.cdw3);
+	c->common.cdw10 = cpu_to_le32(cmd.cdw10);
+	c->common.cdw11 = cpu_to_le32(cmd.cdw11);
+	c->common.cdw12 = cpu_to_le32(cmd.cdw12);
+	c->common.cdw13 = cpu_to_le32(cmd.cdw13);
+	c->common.cdw14 = cpu_to_le32(cmd.cdw14);
+	c->common.cdw15 = cpu_to_le32(cmd.cdw15);
+
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
-	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
-			cmd.addr, cmd.data_len, nvme_to_user_ptr(cmd.metadata),
-			cmd.metadata_len, &result, timeout, 0);
+	status = nvme_submit_user_cmd(q, req, cmd.addr, cmd.data_len,
+			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
+			&result, timeout, 0);
 
 	if (status >= 0) {
 		if (put_user(result, &ucmd->result))
@@ -335,9 +346,11 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		struct nvme_passthru_cmd64 __user *ucmd, unsigned int flags,
 		bool open_for_write)
 {
+	struct request_queue *q = ns ? ns->queue : ctrl->admin_q;
 	struct nvme_passthru_cmd64 cmd;
-	struct nvme_command c;
+	struct nvme_command *c;
 	unsigned timeout = 0;
+	struct request *req;
 	int status;
 
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
@@ -347,26 +360,32 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (!nvme_validate_passthru_nsid(ctrl, ns, cmd.nsid))
 		return -EINVAL;
 
-	memset(&c, 0, sizeof(c));
-	c.common.opcode = cmd.opcode;
-	c.common.flags = cmd.flags;
-	c.common.nsid = cpu_to_le32(cmd.nsid);
-	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
-	c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
-	c.common.cdw10 = cpu_to_le32(cmd.cdw10);
-	c.common.cdw11 = cpu_to_le32(cmd.cdw11);
-	c.common.cdw12 = cpu_to_le32(cmd.cdw12);
-	c.common.cdw13 = cpu_to_le32(cmd.cdw13);
-	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
-	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
-
-	if (!nvme_cmd_allowed(ns, &c, flags, open_for_write))
+	if (!nvme_cmd_allowed(ns, cmd.opcode, cmd.cdw10, flags, open_for_write))
 		return -EACCES;
 
+	req = nvme_alloc_user_request(q, cmd.opcode, 0, 0);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	c = nvme_req(req)->cmd;
+	memset(c, 0, sizeof(*c));
+	c->common.opcode = cmd.opcode;
+	/* passthru commands should let the driver set the SGL flags */
+	c->common.flags = cmd.flags & ~NVME_CMD_SGL_ALL;
+	c->common.nsid = cpu_to_le32(cmd.nsid);
+	c->common.cdw2[0] = cpu_to_le32(cmd.cdw2);
+	c->common.cdw2[1] = cpu_to_le32(cmd.cdw3);
+	c->common.cdw10 = cpu_to_le32(cmd.cdw10);
+	c->common.cdw11 = cpu_to_le32(cmd.cdw11);
+	c->common.cdw12 = cpu_to_le32(cmd.cdw12);
+	c->common.cdw13 = cpu_to_le32(cmd.cdw13);
+	c->common.cdw14 = cpu_to_le32(cmd.cdw14);
+	c->common.cdw15 = cpu_to_le32(cmd.cdw15);
+
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
-	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
+	status = nvme_submit_user_cmd(q, req,
 			cmd.addr, cmd.data_len, nvme_to_user_ptr(cmd.metadata),
 			cmd.metadata_len, &cmd.result, timeout, flags);
 
@@ -454,7 +473,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	const struct nvme_uring_cmd *cmd = io_uring_sqe_cmd(ioucmd->sqe);
 	struct request_queue *q = ns ? ns->queue : ctrl->admin_q;
 	struct nvme_uring_data d;
-	struct nvme_command c;
+	struct nvme_command *c;
 	struct iov_iter iter;
 	struct iov_iter *map_iter = NULL;
 	struct request *req;
@@ -462,43 +481,22 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	blk_mq_req_flags_t blk_flags = 0;
 	int ret;
 
-	c.common.opcode = READ_ONCE(cmd->opcode);
-	c.common.flags = READ_ONCE(cmd->flags);
-	if (c.common.flags)
+	if (READ_ONCE(cmd->flags))
 		return -EINVAL;
 
-	c.common.command_id = 0;
-	c.common.nsid = cpu_to_le32(cmd->nsid);
-	if (!nvme_validate_passthru_nsid(ctrl, ns, le32_to_cpu(c.common.nsid)))
+	if (!nvme_validate_passthru_nsid(ctrl, ns, cmd->nsid))
 		return -EINVAL;
 
-	c.common.cdw2[0] = cpu_to_le32(READ_ONCE(cmd->cdw2));
-	c.common.cdw2[1] = cpu_to_le32(READ_ONCE(cmd->cdw3));
-	c.common.metadata = 0;
-	c.common.dptr.prp1 = c.common.dptr.prp2 = 0;
-	c.common.cdw10 = cpu_to_le32(READ_ONCE(cmd->cdw10));
-	c.common.cdw11 = cpu_to_le32(READ_ONCE(cmd->cdw11));
-	c.common.cdw12 = cpu_to_le32(READ_ONCE(cmd->cdw12));
-	c.common.cdw13 = cpu_to_le32(READ_ONCE(cmd->cdw13));
-	c.common.cdw14 = cpu_to_le32(READ_ONCE(cmd->cdw14));
-	c.common.cdw15 = cpu_to_le32(READ_ONCE(cmd->cdw15));
-
-	if (!nvme_cmd_allowed(ns, &c, 0, ioucmd->file->f_mode & FMODE_WRITE))
+	if (!nvme_cmd_allowed(ns, cmd->opcode, cmd->cdw10, 0, ioucmd->file->f_mode & FMODE_WRITE))
 		return -EACCES;
 
-	d.metadata = READ_ONCE(cmd->metadata);
-	d.addr = READ_ONCE(cmd->addr);
-	d.data_len = READ_ONCE(cmd->data_len);
-	d.metadata_len = READ_ONCE(cmd->metadata_len);
-	d.timeout_ms = READ_ONCE(cmd->timeout_ms);
-
 	if (d.data_len && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		/* fixedbufs is only for non-vectored io */
 		if (vec)
 			return -EINVAL;
 
 		ret = io_uring_cmd_import_fixed(d.addr, d.data_len,
-			nvme_is_write(&c) ? WRITE : READ, &iter, ioucmd,
+			cmd->opcode & 1 ? WRITE : READ, &iter, ioucmd,
 			issue_flags);
 		if (ret < 0)
 			return ret;
@@ -506,6 +504,36 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		map_iter = &iter;
 	}
 
+	req = nvme_alloc_user_request(q, cmd->opcode, rq_flags, blk_flags);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	c = nvme_req(req)->cmd;
+	c->common.opcode = READ_ONCE(cmd->opcode);
+	/* passthru commands should let the driver set the SGL flags */
+	c->common.flags = READ_ONCE(cmd->flags) & ~NVME_CMD_SGL_ALL;
+
+	c->common.command_id = 0;
+	c->common.nsid = cpu_to_le32(cmd->nsid);
+
+	c->common.cdw2[0] = cpu_to_le32(READ_ONCE(cmd->cdw2));
+	c->common.cdw2[1] = cpu_to_le32(READ_ONCE(cmd->cdw3));
+	c->common.metadata = 0;
+	c->common.dptr.prp1 = c->common.dptr.prp2 = 0;
+	c->common.cdw10 = cpu_to_le32(READ_ONCE(cmd->cdw10));
+	c->common.cdw11 = cpu_to_le32(READ_ONCE(cmd->cdw11));
+	c->common.cdw12 = cpu_to_le32(READ_ONCE(cmd->cdw12));
+	c->common.cdw13 = cpu_to_le32(READ_ONCE(cmd->cdw13));
+	c->common.cdw14 = cpu_to_le32(READ_ONCE(cmd->cdw14));
+	c->common.cdw15 = cpu_to_le32(READ_ONCE(cmd->cdw15));
+
+	d.metadata = READ_ONCE(cmd->metadata);
+	d.addr = READ_ONCE(cmd->addr);
+	d.data_len = READ_ONCE(cmd->data_len);
+	d.metadata_len = READ_ONCE(cmd->metadata_len);
+	d.timeout_ms = READ_ONCE(cmd->timeout_ms);
+
+
 	if (issue_flags & IO_URING_F_NONBLOCK) {
 		rq_flags |= REQ_NOWAIT;
 		blk_flags = BLK_MQ_REQ_NOWAIT;
@@ -513,9 +541,6 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (issue_flags & IO_URING_F_IOPOLL)
 		rq_flags |= REQ_POLLED;
 
-	req = nvme_alloc_user_request(q, &c, rq_flags, blk_flags);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
 	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
 
 	if (d.data_len) {
-- 
2.48.1


