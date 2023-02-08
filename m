Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8758CC05027
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Feb 2023 15:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IVLthHOtJVmbJrB0ipOBImtrQMQQITY/oQQYx2cj4wE=; b=4IwxTtEJtqrVG4+Acj7d5pjL3O
	jECMWmUTh0fmMZrUQGhCTNKKOce5sSwH3zm8hy6ARyQT5qU/MeipDfJPa/5V5+2RVLv68p7Ns5hgi
	yY1DmxOg1kNhh1+aHHyhmWe0hs8vtkbu4F6CW0BKXpBuKI1/wy1lr1FExkhJIGKB1mKel45sfUZmt
	i+34wRx5+JWtSxfer6FsPgzt6V9TeDPzUudE1wm1fiTyynJoogM55cQ3OQC3coQlUwQtTvP3uF+Sq
	82Z2AC2vUNqIYnM4GyVulI/UbIzP7j43KX4qe5gngZGr9/sy+XJ6YrIYJF9DTnEjSemmT5E3isIQW
	8jthvXeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPmCX-00G3AC-5k; Wed, 08 Feb 2023 15:17:37 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPmCM-00G36d-8J
	for linux-nvme@lists.infradead.org; Wed, 08 Feb 2023 15:17:29 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id CB9BC1FF10;
	Wed,  8 Feb 2023 15:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675869444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IVLthHOtJVmbJrB0ipOBImtrQMQQITY/oQQYx2cj4wE=;
	b=dXk1E0Ndy1lXM4s6CNNN1XPFkxwNLcqp5KPGXMkPJ6ms/dR17g6D1rY2P+qvvdRRQIyQaD
	RqSNx10XRCoYrOufojRXcg/UuI2CDgPq0L1Awu9zASM/2RW+lrs4JMT5F8WG8Q3atn/R2B
	R/ikAScHUrF+yhMAKLQ4dU6g3AHcDsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675869444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IVLthHOtJVmbJrB0ipOBImtrQMQQITY/oQQYx2cj4wE=;
	b=hJVnh+0C5dkjWfWQtpvGnToTNdqX5NPAws881Mv5CoEKoQU4jm2RSAp1+7/3DSqaJ6QQbH
	C5ZXO1GFvT//+eBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id B73662C145;
	Wed,  8 Feb 2023 15:17:24 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id A99F251BD09D; Wed,  8 Feb 2023 16:17:24 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/3] nvme: make 'at_head' parameter for __nvme_submit_sync_cmd() boolean
Date: Wed,  8 Feb 2023 16:17:20 +0100
Message-Id: <20230208151720.109130-4-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230208151720.109130-1-hare@suse.de>
References: <20230208151720.109130-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_071726_501320_15D51CE9 
X-CRM114-Status: GOOD (  13.75  )
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

Use a boolean for the 'at_head' parameter in __nvme_submit_sync_cmd()
to improve readability and consistency; it's being converted into a
boolean anyway.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c    |  2 +-
 drivers/nvme/host/core.c    |  8 ++++----
 drivers/nvme/host/fabrics.c | 12 +++++-------
 drivers/nvme/host/nvme.h    |  2 +-
 4 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 8a1edbf69b47..d4002845064a 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -83,7 +83,7 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 
 	/* Clear failfast flag to allow for retries */
 	req->cmd_flags &= ~REQ_FAILFAST_DRIVER;
-	ret = __nvme_submit_sync_cmd(req, NULL, data, data_len, 0);
+	ret = __nvme_submit_sync_cmd(req, NULL, data, data_len, false);
 	if (ret > 0)
 		dev_warn(ctrl->device,
 			"qid %d auth_send failed with status %d\n", qid, ret);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 278f7aa674c6..3a4b5e99e648 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1040,7 +1040,7 @@ EXPORT_SYMBOL_GPL(__nvme_alloc_rq);
  * if the result is positive, it's an NVM Express status code
  */
 int __nvme_submit_sync_cmd(struct request *req, union nvme_result *result,
-			   void *buffer, unsigned bufflen, int at_head)
+			   void *buffer, unsigned bufflen, bool at_head)
 {
 	int ret;
 
@@ -1068,7 +1068,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	return __nvme_submit_sync_cmd(req, NULL, buffer, bufflen, 0);
+	return __nvme_submit_sync_cmd(req, NULL, buffer, bufflen, false);
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
@@ -1498,7 +1498,7 @@ static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	ret = __nvme_submit_sync_cmd(req, &res, buffer, buflen, 0);
+	ret = __nvme_submit_sync_cmd(req, &res, buffer, buflen, false);
 	if (ret >= 0 && result)
 		*result = le32_to_cpu(res.u32);
 	return ret;
@@ -2234,7 +2234,7 @@ static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t l
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	return __nvme_submit_sync_cmd(req, NULL, buffer, len, 1);
+	return __nvme_submit_sync_cmd(req, NULL, buffer, len, true);
 }
 
 static void nvme_configure_opal(struct nvme_ctrl *ctrl, bool was_suspended)
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 7d2fd4b83bbc..db11c54b8d0e 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -157,8 +157,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	ret = __nvme_submit_sync_cmd(req, &res, NULL, 0, 0);
-
+	ret = __nvme_submit_sync_cmd(req, &res, NULL, 0, false);
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
 	if (unlikely(ret != 0))
@@ -207,8 +206,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	ret = __nvme_submit_sync_cmd(req, &res, NULL, 0, 0);
-
+	ret = __nvme_submit_sync_cmd(req, &res, NULL, 0, false);
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
 	if (unlikely(ret != 0))
@@ -256,7 +254,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	ret = __nvme_submit_sync_cmd(req, NULL, NULL, 0, 0);
+	ret = __nvme_submit_sync_cmd(req, NULL, NULL, 0, false);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
@@ -417,7 +415,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	ret = __nvme_submit_sync_cmd(req, &res, data, sizeof(*data), 1);
+	ret = __nvme_submit_sync_cmd(req, &res, data, sizeof(*data), true);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
@@ -507,7 +505,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	ret = __nvme_submit_sync_cmd(req, &res, data, sizeof(*data), 1);
+	ret = __nvme_submit_sync_cmd(req, &res, data, sizeof(*data), true);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d10f930d1edb..bf984ae5cf04 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -816,7 +816,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 struct request *__nvme_alloc_rq(struct request_queue *q,
 		struct nvme_command *cmd, int qid, blk_mq_req_flags_t flags);
 int __nvme_submit_sync_cmd(struct request *req, union nvme_result *result,
-		void *buffer, unsigned bufflen, int at_head);
+		void *buffer, unsigned bufflen, bool at_head);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
-- 
2.35.3


