Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C600C61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 14:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FKzE1v19uvB0EWjrLLWp1LokGTAakydaljCYNTsWPdE=; b=BD7IFZNj0FC/V1hkJ60edWAIrM
	0oLVECxuJ8eli+qL05l9RRsIclOm8U2nE/KbCyzXYiIqXJGwaHHNlpg9NCN5fTpOmrKaEPVy9dqBb
	KIOIm1ZhdQvm1c8rcwzAFica7PHys+HW8X5iB4lQ9KA4FLtaYSy1ETPQV3yeXQGR6NTFYV+GQRkZ7
	OLGL6uUjptm5DbMSGuGnxx69Ax0TEw46rb+4wU05v6X+TGjf3T0eTWw49yKhouO74YT3WExMFC3UJ
	/yRyAbwTpb1mD3zflnzysTfuaSwyQ+SpXY2IxUnaVY7OUZMuN+oNdzf/RfRNTLdrwBW2XUoKf4vAO
	Ssk48rRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ84Q-0020lJ-1d; Thu, 09 Feb 2023 14:38:42 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ84F-0020ey-9U
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 14:38:34 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id CABE1375D1;
	Thu,  9 Feb 2023 14:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675953509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKzE1v19uvB0EWjrLLWp1LokGTAakydaljCYNTsWPdE=;
	b=Pg14WPhu9ZT2es5Y+uhFABtQQneO/+BMJvjqA30Y1uRW1QKlVvjXbZozjYgDEsFZVhUWWI
	lF3aoyZ7U6dCsjJxGKJmO33reekx4+pWDjNRhhEPXux9hrbMDb1u9OXxd9cIG+btkjsUbj
	dR4dgQ5FgqEkkxbBjWUPcDGrtOKsBGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675953509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FKzE1v19uvB0EWjrLLWp1LokGTAakydaljCYNTsWPdE=;
	b=DNIt4f0GsJziEBlSSG5LH31N8h/sI84e+GX9+t4KZy+LuaaYqARoXkfDfOERD/Aj6DsZC7
	CAGQodpJOsQ8mOBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id AA6B52C141;
	Thu,  9 Feb 2023 14:38:29 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 9E2A751BD13C; Thu,  9 Feb 2023 15:38:29 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/5] nvme: move result handling into nvme_execute_rq()
Date: Thu,  9 Feb 2023 15:38:18 +0100
Message-Id: <20230209143820.118097-4-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230209143820.118097-1-hare@suse.de>
References: <20230209143820.118097-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_063831_528168_86B375F3 
X-CRM114-Status: GOOD (  15.57  )
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

and simplify the calling convention.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c       | 16 ++++++++++------
 drivers/nvme/host/ioctl.c      |  5 +++--
 drivers/nvme/host/nvme.h       |  3 ++-
 drivers/nvme/target/passthru.c |  3 +--
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 78da9c6cbba8..11faebe87764 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1004,15 +1004,21 @@ EXPORT_SYMBOL_GPL(nvme_setup_cmd);
  * >0: nvme controller's cqe status response
  * <0: kernel error in lieu of controller response
  */
-int nvme_execute_rq(struct request *rq, bool at_head)
+int nvme_execute_rq(struct request *rq, union nvme_result *result,
+		    bool at_head)
 {
 	blk_status_t status;
+	int ret;
 
 	status = blk_execute_rq(rq, at_head);
 	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
 		return -EINTR;
-	if (nvme_req(rq)->status)
-		return nvme_req(rq)->status;
+	ret = nvme_req(rq)->status;
+	if (ret) {
+		if (result && ret >= 0)
+			*result = nvme_req(rq)->result;
+		return ret;
+	}
 	return blk_status_to_errno(status);
 }
 EXPORT_SYMBOL_NS_GPL(nvme_execute_rq, NVME_TARGET_PASSTHRU);
@@ -1048,9 +1054,7 @@ int __nvme_submit_sync_cmd(struct request *req, union nvme_result *result,
 	if (ret)
 		goto out;
 
-	ret = nvme_execute_rq(req, at_head);
-	if (result && ret >= 0)
-		*result = nvme_req(req)->result;
+	ret = nvme_execute_rq(req, result, at_head);
  out:
 	blk_mq_free_request(req);
 	return ret;
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 723e7d5b778f..cdba543cbd02 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -220,6 +220,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		u64 *result, unsigned timeout, unsigned int flags)
 {
 	struct nvme_ns *ns = q->queuedata;
+	union nvme_result res;
 	struct nvme_ctrl *ctrl;
 	struct request *req;
 	void *meta = NULL;
@@ -243,9 +244,9 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	ctrl = nvme_req(req)->ctrl;
 
 	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
-	ret = nvme_execute_rq(req, false);
+	ret = nvme_execute_rq(req, &res, false);
 	if (result)
-		*result = le64_to_cpu(nvme_req(req)->result.u64);
+		*result = le64_to_cpu(res.u64);
 	if (meta)
 		ret = nvme_finish_user_metadata(req, meta_buffer, meta,
 						meta_len, ret);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9b4b3bb69e27..a63650b00d1a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1071,7 +1071,8 @@ static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
 u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode);
-int nvme_execute_rq(struct request *rq, bool at_head);
+int nvme_execute_rq(struct request *rq, union nvme_result *result,
+		    bool at_head);
 void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 		       struct nvme_command *cmd, int status);
 struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index aae6d5bb4fd8..f5ab4d7a8c1f 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -221,7 +221,7 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	int status;
 
 	effects = nvme_passthru_start(ctrl, ns, req->cmd->common.opcode);
-	status = nvme_execute_rq(rq, false);
+	status = nvme_execute_rq(rq, &req->cqe->result, false);
 	if (status == NVME_SC_SUCCESS &&
 	    req->cmd->common.opcode == nvme_admin_identify) {
 		switch (req->cmd->identify.cns) {
@@ -238,7 +238,6 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	} else if (status < 0)
 		status = NVME_SC_INTERNAL;
 
-	req->cqe->result = nvme_req(rq)->result;
 	nvmet_req_complete(req, status);
 	blk_mq_free_request(rq);
 
-- 
2.35.3


