Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC48C636CC
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Feb 2023 08:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bqLYwV6Wu9Bl6AHqYIndfRfUR61wmggTIb0Arh8ZMuU=; b=Bk/chS5/LPAN6KVHwSbWO/Ga5G
	+ajoUeso9hNrL6wCOdyz7XtXKD2DevErm5GdYYMXJz9lCP76VJLyGr5l5Gqw4LxAE25IDVVugCdWn
	KnsMLF+qSDImvtc3Wyl1DRoDVZNOpFGTX9WDR5CpeEgxqO4i+LMiccnDDMrIFLAEco8+Rnstofm3d
	Ur9I8Rm+N6/vlE/boCZlq0Kvnn+Kwl9c2xKgQpHoznGwKqlXWv5lo+ay04oCVjVWHbn+Tjpj41azi
	TV8cClYOnMkHeNEBTDLhbCa/+y+rHZzPxtI/5MlDpeH1/yeQJrG5hnVpV1DsldJwOtWM/CyF6ZkdR
	XD280eQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPg9W-00Ee8A-Sp; Wed, 08 Feb 2023 08:50:06 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPg9K-00Ee44-M4
	for linux-nvme@lists.infradead.org; Wed, 08 Feb 2023 08:49:57 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 04862208A2;
	Wed,  8 Feb 2023 08:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675846190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqLYwV6Wu9Bl6AHqYIndfRfUR61wmggTIb0Arh8ZMuU=;
	b=wXwDVw49D3xTANG+l5VbU2O6hU5bi5U0i+tpNo/gzaNBBS7LtC9El8NtERakYQT/ldhyn4
	okyEEScZYOUm1+hMM4/USuYL5dgTu/U8VoogtvIOMRGsUZOLGaD9sRimsbnMbnCjpS0yr3
	WTqPxx3ap6K+cjQqHGOueXktijBKOGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675846190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqLYwV6Wu9Bl6AHqYIndfRfUR61wmggTIb0Arh8ZMuU=;
	b=AeeORrbLjQjEybo5Ar78pR5rImC8sF1OoXdz+gZQvc/LRMVcj4J0KUTFDiOS1rrjXjfwjH
	7zyBSDEjmx72JJCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id DDA9E2C146;
	Wed,  8 Feb 2023 08:49:49 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id D019E51BD06C; Wed,  8 Feb 2023 09:49:49 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/3] nvme: retry internal commands if DNR status bit is not set
Date: Wed,  8 Feb 2023 09:49:38 +0100
Message-Id: <20230208084939.145257-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230208084939.145257-1-hare@suse.de>
References: <20230208084939.145257-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_004955_086935_A6616FB0 
X-CRM114-Status: GOOD (  19.09  )
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

Add a 'retry' argument to __nvme_alloc_rq() to instruct
the function to not set the FAILFAST_DRIVER bit for the command,
causing it to be retried in nvme_decide_disposition() if the DNR
bit is not set in the command result.
And modify the authentication code to allow for retries.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c       |  3 ++-
 drivers/nvme/host/core.c       | 18 ++++++++++--------
 drivers/nvme/host/fabrics.c    | 10 +++++-----
 drivers/nvme/host/ioctl.c      |  2 +-
 drivers/nvme/host/nvme.h       |  5 +++--
 drivers/nvme/host/pci.c        |  5 +++--
 drivers/nvme/target/passthru.c |  2 +-
 7 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index cbb6f1cb2046..50cd45e92998 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -77,7 +77,8 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 		cmd.auth_receive.al = cpu_to_le32(data_len);
 	}
 
-	req = __nvme_alloc_rq(q, &cmd, qid == 0 ? NVME_QID_ANY : qid, flags);
+	req = __nvme_alloc_rq(q, &cmd, qid == 0 ? NVME_QID_ANY : qid,
+			      flags, true);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4e0f61f27823..e7c954eae9c7 100644
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
@@ -1019,7 +1021,7 @@ EXPORT_SYMBOL_NS_GPL(nvme_execute_rq, NVME_TARGET_PASSTHRU);
 
 struct request *__nvme_alloc_rq(struct request_queue *q,
 				struct nvme_command *cmd, int qid,
-				blk_mq_req_flags_t flags)
+				blk_mq_req_flags_t flags, bool retry)
 {
 	struct request *req;
 
@@ -1029,7 +1031,7 @@ struct request *__nvme_alloc_rq(struct request_queue *q,
 		req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), flags,
 						qid - 1);
 	if (!IS_ERR(req))
-		nvme_init_request(req, cmd);
+		nvme_init_request(req, cmd, retry);
 
 	return req;
 }
@@ -1064,7 +1066,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 {
 	struct request *req;
 
-	req = __nvme_alloc_rq(q, cmd, NVME_QID_ANY, 0);
+	req = __nvme_alloc_rq(q, cmd, NVME_QID_ANY, 0, false);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
@@ -1211,7 +1213,7 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	}
 
 	rq = __nvme_alloc_rq(ctrl->admin_q, &ctrl->ka_cmd, NVME_QID_ANY,
-			     BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+			     BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, false);
 	if (IS_ERR(rq)) {
 		/* allocation failure, reset the controller */
 		dev_err(ctrl->device, "keep-alive failed: %ld\n", PTR_ERR(rq));
@@ -1494,7 +1496,7 @@ static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 	c.features.fid = cpu_to_le32(fid);
 	c.features.dword11 = cpu_to_le32(dword11);
 
-	req = __nvme_alloc_rq(dev->admin_q, &c, NVME_QID_ANY, 0);
+	req = __nvme_alloc_rq(dev->admin_q, &c, NVME_QID_ANY, 0, false);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
@@ -2231,7 +2233,7 @@ static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t l
 	cmd.common.cdw10 = cpu_to_le32(((u32)secp) << 24 | ((u32)spsp) << 8);
 	cmd.common.cdw11 = cpu_to_le32(len);
 
-	req = __nvme_alloc_rq(ctrl->admin_q, &cmd, NVME_QID_ANY, 0);
+	req = __nvme_alloc_rq(ctrl->admin_q, &cmd, NVME_QID_ANY, 0, false);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index f8e623279b75..d999364af43d 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -153,7 +153,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.fctype = nvme_fabrics_type_property_get;
 	cmd.prop_get.offset = cpu_to_le32(off);
 
-	req = __nvme_alloc_rq(ctrl->fabrics_q, &cmd, NVME_QID_ANY, 0);
+	req = __nvme_alloc_rq(ctrl->fabrics_q, &cmd, NVME_QID_ANY, 0, false);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
@@ -203,7 +203,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.attrib = 1;
 	cmd.prop_get.offset = cpu_to_le32(off);
 
-	req = __nvme_alloc_rq(ctrl->fabrics_q, &cmd, NVME_QID_ANY, 0);
+	req = __nvme_alloc_rq(ctrl->fabrics_q, &cmd, NVME_QID_ANY, 0, false);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
@@ -252,7 +252,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.offset = cpu_to_le32(off);
 	cmd.prop_set.value = cpu_to_le64(val);
 
-	req = __nvme_alloc_rq(ctrl->fabrics_q, &cmd, NVME_QID_ANY, 0);
+	req = __nvme_alloc_rq(ctrl->fabrics_q, &cmd, NVME_QID_ANY, 0, false);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
@@ -413,7 +413,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
 	req = __nvme_alloc_rq(ctrl->fabrics_q, &cmd, NVME_QID_ANY,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, false);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
@@ -504,7 +504,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
 	req = __nvme_alloc_rq(ctrl->fabrics_q, &cmd, NVME_QID_ANY,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, false);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
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
index 0ae5ef8b217f..624f1879ee20 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -774,7 +774,8 @@ static inline enum req_op nvme_req_op(struct nvme_command *cmd)
 }
 
 #define NVME_QID_ANY -1
-void nvme_init_request(struct request *req, struct nvme_command *cmd);
+void nvme_init_request(struct request *req, struct nvme_command *cmd,
+		       bool retry);
 void nvme_cleanup_cmd(struct request *req);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req);
 blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
@@ -814,7 +815,7 @@ static inline bool nvme_is_unique_nsid(struct nvme_ctrl *ctrl,
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 struct request *__nvme_alloc_rq(struct request_queue *q,
-		struct nvme_command *cmd, int qid, blk_mq_req_flags_t flags);
+		struct nvme_command *cmd, int qid, blk_mq_req_flags_t flags, bool retry);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct request *req, union nvme_result *result,
 		void *buffer, unsigned bufflen, int at_head);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8e3bae7d489b..f8ff52ad472e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1377,7 +1377,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 		 nvmeq->qid);
 
 	abort_req = __nvme_alloc_rq(dev->ctrl.admin_q, &cmd,
-			NVME_QID_ANY, BLK_MQ_REQ_NOWAIT);
+			NVME_QID_ANY, BLK_MQ_REQ_NOWAIT, false);
 	if (IS_ERR(abort_req)) {
 		atomic_inc(&dev->ctrl.abort_limit);
 		return BLK_EH_RESET_TIMER;
@@ -2390,7 +2390,8 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	cmd.delete_queue.opcode = opcode;
 	cmd.delete_queue.qid = cpu_to_le16(nvmeq->qid);
 
-	req = __nvme_alloc_rq(q, &cmd, NVME_QID_ANY, BLK_MQ_REQ_NOWAIT);
+	req = __nvme_alloc_rq(q, &cmd, NVME_QID_ANY,
+			BLK_MQ_REQ_NOWAIT, false);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 0dae824a2d05..c00ab5ac54db 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -316,7 +316,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		timeout = nvmet_req_subsys(req)->admin_timeout;
 	}
 
-	rq = __nvme_alloc_rq(q, req->cmd, NVME_QID_ANY, 0);
+	rq = __nvme_alloc_rq(q, req->cmd, NVME_QID_ANY, 0, false);
 	if (IS_ERR(rq)) {
 		status = NVME_SC_INTERNAL;
 		goto out_put_ns;
-- 
2.35.3


