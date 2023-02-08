Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B38C636CC
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Feb 2023 08:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RyF/s+GgYnTxekZ/n53s+qMQSxkW0rTh6z0Gl8C/KJQ=; b=xBK0+O503p4fv86snhaNoSEfu7
	O2GdLgtnfsrPWZh3bBfbV9LHe+jbyd4efXLwcxBxD8kQ0Jd8znSEv6pKOUDpUC25i4PFa7wp9RUku
	RdAezvbOMw8+kxQGh35hzYF+/uQSCY9sguqJVjKr5MIZiE6Su+TEViF7aGaX/6R+MgRUTlPCft7ll
	kceEunn+OkS08AA0l9vB5jgdOr+aQVOvVNPoc7O8hB+SGTwnc8WO/mriA3bHrA0D6iklriwg5WKHA
	EBlpBMlknjb5qQV4ttCM8V7nXv/wZtD51yt/bfHHFcb1lkcO6JAhZKr4RdteURY1TExr9JmcTZPEj
	9DkPTyMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPg9R-00Ee6n-5m; Wed, 08 Feb 2023 08:50:01 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPg9K-00Ee45-Lz
	for linux-nvme@lists.infradead.org; Wed, 08 Feb 2023 08:49:56 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 057803403A;
	Wed,  8 Feb 2023 08:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675846190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RyF/s+GgYnTxekZ/n53s+qMQSxkW0rTh6z0Gl8C/KJQ=;
	b=tvQjCwaDPAI+PQwkYASfh3+r3sRdZgOQOx+NrW81TXfwVoig85bqJmXLQQaqsE7Bl0VvKH
	wqP3u6bnjsaE5SXK5Dz+UaAEY72D9qb9zpv8uiNfH9Tn3OMZ/8BmXDfgWuO3Si/+MQGXyx
	3AQ0mvgOHtS20IaEZwT/rZUvTet0aKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675846190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RyF/s+GgYnTxekZ/n53s+qMQSxkW0rTh6z0Gl8C/KJQ=;
	b=trLOOsgZLYrXxXu+dMbxEwUgjkCHyA6ublz+C4lG/m9Lhj7Qj2pY1+vhX7uuEyksdFyeYU
	Gu9XBIrYf2nBF+CQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id E50F22C149;
	Wed,  8 Feb 2023 08:49:49 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id D788851BD06E; Wed,  8 Feb 2023 09:49:49 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/3] nvme: make 'at_head' parameter for __nvme_submit_sync_cmd() boolean
Date: Wed,  8 Feb 2023 09:49:39 +0100
Message-Id: <20230208084939.145257-4-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230208084939.145257-1-hare@suse.de>
References: <20230208084939.145257-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_004954_885275_EA30FEC7 
X-CRM114-Status: GOOD (  14.07  )
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
 drivers/nvme/host/fabrics.c | 10 +++++-----
 drivers/nvme/host/nvme.h    |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 50cd45e92998..4f287806571a 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -82,7 +82,7 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	ret = __nvme_submit_sync_cmd(q, req, NULL, data, data_len, 0);
+	ret = __nvme_submit_sync_cmd(q, req, NULL, data, data_len, false);
 	if (ret > 0)
 		dev_warn(ctrl->device,
 			"qid %d auth_send failed with status %d\n", qid, ret);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e7c954eae9c7..b8020c3ff13e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1042,7 +1042,7 @@ EXPORT_SYMBOL_GPL(__nvme_alloc_rq);
  * if the result is positive, it's an NVM Express status code
  */
 int __nvme_submit_sync_cmd(struct request_queue *q, struct request *req,
-		union nvme_result *result, void *buffer, unsigned bufflen, int at_head)
+		union nvme_result *result, void *buffer, unsigned bufflen, bool at_head)
 {
 	int ret;
 
@@ -1070,7 +1070,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	return __nvme_submit_sync_cmd(q, req, NULL, buffer, bufflen, 0);
+	return __nvme_submit_sync_cmd(q, req, NULL, buffer, bufflen, false);
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
@@ -1501,7 +1501,7 @@ static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 		return PTR_ERR(req);
 
 	ret = __nvme_submit_sync_cmd(dev->admin_q, req, &res,
-			buffer, buflen, 0);
+			buffer, buflen, false);
 	if (ret >= 0 && result)
 		*result = le32_to_cpu(res.u32);
 	return ret;
@@ -2237,7 +2237,7 @@ static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t l
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	return __nvme_submit_sync_cmd(ctrl->admin_q, req, NULL, buffer, len, 1);
+	return __nvme_submit_sync_cmd(ctrl->admin_q, req, NULL, buffer, len, true);
 }
 
 static void nvme_configure_opal(struct nvme_ctrl *ctrl, bool was_suspended)
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index d999364af43d..ce56ff85d23c 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -157,7 +157,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, req, &res, NULL, 0, 0);
+	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, req, &res, NULL, 0, false);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -207,7 +207,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, req, &res, NULL, 0, 0);
+	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, req, &res, NULL, 0, false);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -256,7 +256,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, req, NULL, NULL, 0, 0);
+	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, req, NULL, NULL, 0, false);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
@@ -418,7 +418,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		return PTR_ERR(req);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, req, &res,
-			data, sizeof(*data), 1);
+			data, sizeof(*data), true);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
@@ -509,7 +509,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		return PTR_ERR(req);
 
 	ret = __nvme_submit_sync_cmd(ctrl->connect_q, req, &res,
-			data, sizeof(*data), 1);
+			data, sizeof(*data), true);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 624f1879ee20..f506d0db3c06 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -817,7 +817,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 struct request *__nvme_alloc_rq(struct request_queue *q,
 		struct nvme_command *cmd, int qid, blk_mq_req_flags_t flags, bool retry);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct request *req, union nvme_result *result,
-		void *buffer, unsigned bufflen, int at_head);
+		void *buffer, unsigned bufflen, bool at_head);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
-- 
2.35.3


