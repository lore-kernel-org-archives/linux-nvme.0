Return-Path: <SRS0=/503=JU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7DBC433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 22:07:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC1C6146B
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 22:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC1C6146B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Z9P76Sm/amt5/deE0NL8zSTJBNSfZCOhBqlYVIulORE=; b=nEJFMxAU7qb+r9NnYqJ+KPETH
	0B3JApn1sZ72XDxMAkjM/3OPAA8L1UVVRILDmPugocnCsPq8wNvk3Tpd91t194wxP3DtyBRl0xeJZ
	4VrbYe59GnPWYYBScqLfi9ngU+GJwLWD1wFUIVUcJuPw9TAnhIQVK/VULgL7J55O/EcAnyhYdL/3z
	AJFX8yHCiyVw2aSfP0R2CV+GAcLYkoruZNWmr6v55XeTwMCkqN0Gi4S1ShbcW27vl7HD+qotDutOJ
	YnQ9PWZ0HCG9dn1D9fZmchyfp9PyA+y3/7Rog3DKULk7SIggNiVhWkuIdfzeo8A5elt4ZbfF2mE35
	9y+I04qSA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1la3wf-002TIX-I9; Fri, 23 Apr 2021 22:06:41 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1la3w5-002TDm-SD
 for linux-nvme@desiato.infradead.org; Fri, 23 Apr 2021 22:06:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=Dwsa3ehzP1iT+4wcuLoOSBr8vBr72SXLptrgruA5wM8=; b=Gd/lHVAoSnu7Skdg82KEm/Fjua
 4ZJHoLFbO6CSpEgrHmtm8j1ETOQLbg+KDFSe+EdtpDRrEp2yOPWP42PGLwhF02UdlmcP8ylHJWzKZ
 YKczNb+pHr/ao7NlstWBBQdiEp48kZKseTD6814MG+X//5OSwaRAfkU5EzYo5mVJV3gr3Tuw/NJPA
 oXreEMmfMY92MqIXaGIholSmPvEByiByf7Q7fh4SSXKqw96CxlszlsxtUpIoI+jo1dY+xsabcCPRK
 +YtIzPHCTaGlQU3ZMkGZoZozfH6iDTafs4LDh+tWfXavvi6QpYLwhNk2XKZgFD6HLYf9mM6nPIjNG
 rsGBF2iA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1la3w2-00Ej8J-Sm
 for linux-nvme@lists.infradead.org; Fri, 23 Apr 2021 22:06:04 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id F353A61476;
 Fri, 23 Apr 2021 22:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619215562;
 bh=5PfpiaM1Ya4Oo35Ovb4quqM5fhvUVC9mt/ed2m31HAk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PM1Gol8XeA5C/QziRFXkxmPyVIuh5WZEvtvCrhU1Jprsz1vgvKFzv1GvXliUR5ZSF
 OvHbzpw+OkVdBft6ydgVm6OcVHCC4cpWHCgehurUwEGm0Ub2PRYztPKGAgvoaAHczb
 8KboRQSwcWxGG7QGR3eE62AhzvHHCRcYqnRa/qOsISfwugV04rA8Evd79Xdgzlyb0O
 NzX10wOVf5WBvqHzBozYzOBLW92qKjn5o3bXkS5T/s25dGZyDqGEeB43xZmpt6bUG1
 gy7WnL64ply50vT2PzemFVJx5uVVkS3XbJfgyYoqUamVb3tBUL3kVO02dC6PCWevWJ
 xnHWhnrY2wyMw==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org
Cc: Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 2/5] nvme: use blk_execute_rq() for passthrough commands
Date: Fri, 23 Apr 2021 15:05:55 -0700
Message-Id: <20210423220558.40764-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210423220558.40764-1-kbusch@kernel.org>
References: <20210423220558.40764-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210423_150602_992093_B53F9E3F 
X-CRM114-Status: GOOD (  15.53  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The generic blk_execute_rq() knows how to handle polled completions. Use
that instead of implementing an nvme specific handler.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c    | 38 +++++--------------------------------
 drivers/nvme/host/fabrics.c | 13 ++++++-------
 drivers/nvme/host/fabrics.h |  2 +-
 drivers/nvme/host/fc.c      |  2 +-
 drivers/nvme/host/nvme.h    |  2 +-
 drivers/nvme/host/rdma.c    |  3 +--
 drivers/nvme/host/tcp.c     |  2 +-
 drivers/nvme/target/loop.c  |  2 +-
 8 files changed, 17 insertions(+), 47 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 85538c38aae9..10bb8406e067 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -944,31 +944,6 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_setup_cmd);
 
-static void nvme_end_sync_rq(struct request *rq, blk_status_t error)
-{
-	struct completion *waiting = rq->end_io_data;
-
-	rq->end_io_data = NULL;
-	complete(waiting);
-}
-
-static void nvme_execute_rq_polled(struct request_queue *q,
-		struct gendisk *bd_disk, struct request *rq, int at_head)
-{
-	DECLARE_COMPLETION_ONSTACK(wait);
-
-	WARN_ON_ONCE(!test_bit(QUEUE_FLAG_POLL, &q->queue_flags));
-
-	rq->cmd_flags |= REQ_HIPRI;
-	rq->end_io_data = &wait;
-	blk_execute_rq_nowait(bd_disk, rq, at_head, nvme_end_sync_rq);
-
-	while (!completion_done(&wait)) {
-		blk_poll(q, request_to_qc_t(rq->mq_hctx, rq), true);
-		cond_resched();
-	}
-}
-
 /*
  * Returns 0 on success.  If the result is negative, it's a Linux error code;
  * if the result is positive, it's an NVM Express status code
@@ -976,7 +951,7 @@ static void nvme_execute_rq_polled(struct request_queue *q,
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
 		unsigned timeout, int qid, int at_head,
-		blk_mq_req_flags_t flags, bool poll)
+		blk_mq_req_flags_t flags)
 {
 	struct request *req;
 	int ret;
@@ -997,10 +972,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 			goto out;
 	}
 
-	if (poll)
-		nvme_execute_rq_polled(req->q, NULL, req, at_head);
-	else
-		blk_execute_rq(NULL, req, at_head);
+	blk_execute_rq(NULL, req, at_head);
 	if (result)
 		*result = nvme_req(req)->result;
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
@@ -1017,7 +989,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, unsigned bufflen)
 {
 	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen, 0,
-			NVME_QID_ANY, 0, 0, false);
+			NVME_QID_ANY, 0, 0);
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
@@ -1370,7 +1342,7 @@ static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 	c.features.dword11 = cpu_to_le32(dword11);
 
 	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res,
-			buffer, buflen, 0, NVME_QID_ANY, 0, 0, false);
+			buffer, buflen, 0, NVME_QID_ANY, 0, 0);
 	if (ret >= 0 && result)
 		*result = le32_to_cpu(res.u32);
 	return ret;
@@ -1969,7 +1941,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 	cmd.common.cdw11 = cpu_to_le32(len);
 
 	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len, 0,
-			NVME_QID_ANY, 1, 0, false);
+			NVME_QID_ANY, 1, 0);
 }
 EXPORT_SYMBOL_GPL(nvme_sec_submit);
 #endif /* CONFIG_BLK_SED_OPAL */
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 604ab0e5a2ad..e468f66878d7 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -151,7 +151,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0, false);
+			NVME_QID_ANY, 0, 0);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -198,7 +198,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0, false);
+			NVME_QID_ANY, 0, 0);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -244,7 +244,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.value = cpu_to_le64(val);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0, 0,
-			NVME_QID_ANY, 0, 0, false);
+			NVME_QID_ANY, 0, 0);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
@@ -398,7 +398,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res,
 			data, sizeof(*data), 0, NVME_QID_ANY, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, false);
+			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
@@ -422,7 +422,6 @@ EXPORT_SYMBOL_GPL(nvmf_connect_admin_queue);
  * @qid:	NVMe I/O queue number for the new I/O connection between
  *		host and target (note qid == 0 is illegal as this is
  *		the Admin queue, per NVMe standard).
- * @poll:	Whether or not to poll for the completion of the connect cmd.
  *
  * This function issues a fabrics-protocol connection
  * of a NVMe I/O queue (via NVMe Fabrics "Connect" command)
@@ -434,7 +433,7 @@ EXPORT_SYMBOL_GPL(nvmf_connect_admin_queue);
  *	> 0: NVMe error status code
  *	< 0: Linux errno error code
  */
-int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid, bool poll)
+int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 {
 	struct nvme_command cmd;
 	struct nvmf_connect_data *data;
@@ -461,7 +460,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid, bool poll)
 
 	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
 			data, sizeof(*data), 0, qid, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, poll);
+			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 888b108d87a4..2e296f951679 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -178,7 +178,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
 int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl);
-int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid, bool poll);
+int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid);
 int nvmf_register_transport(struct nvmf_transport_ops *ops);
 void nvmf_unregister_transport(struct nvmf_transport_ops *ops);
 void nvmf_free_options(struct nvmf_ctrl_options *opts);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9b9b7be0f412..aafa38882d71 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2346,7 +2346,7 @@ nvme_fc_connect_io_queues(struct nvme_fc_ctrl *ctrl, u16 qsize)
 					(qsize / 5));
 		if (ret)
 			break;
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, i, false);
+		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
 		if (ret)
 			break;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c6102ce83bb4..c8f6ec5b8d2b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -637,7 +637,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
 		unsigned timeout, int qid, int at_head,
-		blk_mq_req_flags_t flags, bool poll);
+		blk_mq_req_flags_t flags);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 660c774fa9e1..f02212040573 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -680,11 +680,10 @@ static void nvme_rdma_stop_io_queues(struct nvme_rdma_ctrl *ctrl)
 static int nvme_rdma_start_queue(struct nvme_rdma_ctrl *ctrl, int idx)
 {
 	struct nvme_rdma_queue *queue = &ctrl->queues[idx];
-	bool poll = nvme_rdma_poll_queue(queue);
 	int ret;
 
 	if (idx)
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, idx, poll);
+		ret = nvmf_connect_io_queue(&ctrl->ctrl, idx);
 	else
 		ret = nvmf_connect_admin_queue(&ctrl->ctrl);
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 75435cdb156c..dc523818b822 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1558,7 +1558,7 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	int ret;
 
 	if (idx)
-		ret = nvmf_connect_io_queue(nctrl, idx, false);
+		ret = nvmf_connect_io_queue(nctrl, idx);
 	else
 		ret = nvmf_connect_admin_queue(nctrl);
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 6665da3b634f..bf83b4d1cef7 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -335,7 +335,7 @@ static int nvme_loop_connect_io_queues(struct nvme_loop_ctrl *ctrl)
 	int i, ret;
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, i, false);
+		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
 		if (ret)
 			return ret;
 		set_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[i].flags);
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
