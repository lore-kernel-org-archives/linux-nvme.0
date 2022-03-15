Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FC2C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=t7tNbkBlf0vml1cYFarRdfdhYIWU2PWaNTo63JxdxyA=; b=piYuc42pzgNnkTywTRoYzOg+hq
	8t14zTmhe07xb6qrbGqcFT5VkKgwI1t2jhkzvOmCEWIwe9BQp4TkBxVm7VM3MJBtPaubZ3hAY9BX2
	5jauU9lj4u9TAkB+igN/6XtaKjl9uY5pYrO1RKgDXWfK0js7rVz6gLF+WTX1udHrpqZyeCuAcYBEj
	BL2Kg1fQv7822B7SgHKFXPU3lm9mRzVSzuvNlw2JsSrfUDrEElWYFlpV0D1pFmMZ+DmCTUq3YC7aC
	nfRgWvCwEBqj78CZU+Qo4T3YU8R2RzsC1Jqb2fdwWkB62MjpRxkjdbypwS50Kj4ZY32ch0dD8AOsn
	0wQH+NfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU8ll-009eL4-Cm; Tue, 15 Mar 2022 15:07:29 +0000
Received: from [46.140.54.162] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU8gs-009cmz-ES; Tue, 15 Mar 2022 15:02:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: remove nvme_alloc_request and nvme_alloc_request_qid
Date: Tue, 15 Mar 2022 16:02:22 +0100
Message-Id: <20220315150222.2590959-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Just open code the allocation + initialization in the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c       | 46 ++++++++--------------------------
 drivers/nvme/host/ioctl.c      |  3 ++-
 drivers/nvme/host/nvme.h       |  8 ++++--
 drivers/nvme/host/pci.c        | 17 +++++++------
 drivers/nvme/target/passthru.c |  3 ++-
 5 files changed, 31 insertions(+), 46 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 75f7c53a67811..3c0461129bcae 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -639,13 +639,8 @@ static inline void nvme_clear_nvme_request(struct request *req)
 	req->rq_flags |= RQF_DONTPREP;
 }
 
-static inline unsigned int nvme_req_op(struct nvme_command *cmd)
-{
-	return nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
-}
-
-static inline void nvme_init_request(struct request *req,
-		struct nvme_command *cmd)
+/* initialize a passthrough request */
+void nvme_init_request(struct request *req, struct nvme_command *cmd)
 {
 	if (req->q->queuedata)
 		req->timeout = NVME_IO_TIMEOUT;
@@ -661,30 +656,7 @@ static inline void nvme_init_request(struct request *req,
 	nvme_clear_nvme_request(req);
 	memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
 }
-
-struct request *nvme_alloc_request(struct request_queue *q,
-		struct nvme_command *cmd, blk_mq_req_flags_t flags)
-{
-	struct request *req;
-
-	req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
-	if (!IS_ERR(req))
-		nvme_init_request(req, cmd);
-	return req;
-}
-EXPORT_SYMBOL_GPL(nvme_alloc_request);
-
-static struct request *nvme_alloc_request_qid(struct request_queue *q,
-		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid)
-{
-	struct request *req;
-
-	req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), flags,
-			qid ? qid - 1 : 0);
-	if (!IS_ERR(req))
-		nvme_init_request(req, cmd);
-	return req;
-}
+EXPORT_SYMBOL_GPL(nvme_init_request);
 
 /*
  * For something we're not in a state to send to the device the default action
@@ -1110,11 +1082,14 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	int ret;
 
 	if (qid == NVME_QID_ANY)
-		req = nvme_alloc_request(q, cmd, flags);
+		req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
 	else
-		req = nvme_alloc_request_qid(q, cmd, flags, qid);
+		req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), flags,
+						qid ? qid - 1 : 0);
+
 	if (IS_ERR(req))
 		return PTR_ERR(req);
+	nvme_init_request(req, cmd);
 
 	if (timeout)
 		req->timeout = timeout;
@@ -1304,14 +1279,15 @@ static void nvme_keep_alive_work(struct work_struct *work)
 		return;
 	}
 
-	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd,
-				BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+	rq = blk_mq_alloc_request(ctrl->admin_q, nvme_req_op(&ctrl->ka_cmd),
+				  BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
 	if (IS_ERR(rq)) {
 		/* allocation failure, reset the controller */
 		dev_err(ctrl->device, "keep-alive failed: %ld\n", PTR_ERR(rq));
 		nvme_reset_ctrl(ctrl);
 		return;
 	}
+	nvme_init_request(rq, &ctrl->ka_cmd);
 
 	rq->timeout = ctrl->kato * HZ;
 	rq->end_io_data = ctrl;
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index aaf3dfad26574..554566371ffa4 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -66,9 +66,10 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	void *meta = NULL;
 	int ret;
 
-	req = nvme_alloc_request(q, cmd, 0);
+	req = blk_mq_alloc_request(q, nvme_req_op(cmd), 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
+	nvme_init_request(req, cmd);
 
 	if (timeout)
 		req->timeout = timeout;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 47badb76c654c..1ea908d43e174 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -698,9 +698,13 @@ void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
 
+static inline unsigned int nvme_req_op(struct nvme_command *cmd)
+{
+	return nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
+}
+
 #define NVME_QID_ANY -1
-struct request *nvme_alloc_request(struct request_queue *q,
-		struct nvme_command *cmd, blk_mq_req_flags_t flags);
+void nvme_init_request(struct request *req, struct nvme_command *cmd);
 void nvme_cleanup_cmd(struct request *req);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req);
 blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed6809158..9f4f3884fefe9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -424,8 +424,9 @@ static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 	return 0;
 }
 
-static int nvme_init_request(struct blk_mq_tag_set *set, struct request *req,
-		unsigned int hctx_idx, unsigned int numa_node)
+static int nvme_pci_init_request(struct blk_mq_tag_set *set,
+		struct request *req, unsigned int hctx_idx,
+		unsigned int numa_node)
 {
 	struct nvme_dev *dev = set->driver_data;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -1428,12 +1429,13 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		"I/O %d QID %d timeout, aborting\n",
 		 req->tag, nvmeq->qid);
 
-	abort_req = nvme_alloc_request(dev->ctrl.admin_q, &cmd,
-			BLK_MQ_REQ_NOWAIT);
+	abort_req = blk_mq_alloc_request(dev->ctrl.admin_q, nvme_req_op(&cmd),
+					 BLK_MQ_REQ_NOWAIT);
 	if (IS_ERR(abort_req)) {
 		atomic_inc(&dev->ctrl.abort_limit);
 		return BLK_EH_RESET_TIMER;
 	}
+	nvme_init_request(abort_req, &cmd);
 
 	abort_req->end_io_data = NULL;
 	blk_execute_rq_nowait(abort_req, false, abort_endio);
@@ -1722,7 +1724,7 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.complete	= nvme_pci_complete_rq,
 	.init_hctx	= nvme_admin_init_hctx,
-	.init_request	= nvme_init_request,
+	.init_request	= nvme_pci_init_request,
 	.timeout	= nvme_timeout,
 };
 
@@ -1732,7 +1734,7 @@ static const struct blk_mq_ops nvme_mq_ops = {
 	.complete	= nvme_pci_complete_rq,
 	.commit_rqs	= nvme_commit_rqs,
 	.init_hctx	= nvme_init_hctx,
-	.init_request	= nvme_init_request,
+	.init_request	= nvme_pci_init_request,
 	.map_queues	= nvme_pci_map_queues,
 	.timeout	= nvme_timeout,
 	.poll		= nvme_poll,
@@ -2475,9 +2477,10 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	cmd.delete_queue.opcode = opcode;
 	cmd.delete_queue.qid = cpu_to_le16(nvmeq->qid);
 
-	req = nvme_alloc_request(q, &cmd, BLK_MQ_REQ_NOWAIT);
+	req = blk_mq_alloc_request(q, nvme_req_op(&cmd), BLK_MQ_REQ_NOWAIT);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
+	nvme_init_request(req, &cmd);
 
 	req->end_io_data = nvmeq;
 
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index a810bf569fff8..a4de1e0d518b5 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -254,11 +254,12 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		timeout = nvmet_req_subsys(req)->admin_timeout;
 	}
 
-	rq = nvme_alloc_request(q, req->cmd, 0);
+	rq = blk_mq_alloc_request(q, nvme_req_op(req->cmd), 0);
 	if (IS_ERR(rq)) {
 		status = NVME_SC_INTERNAL;
 		goto out_put_ns;
 	}
+	nvme_init_request(rq, req->cmd);
 
 	if (timeout)
 		rq->timeout = timeout;
-- 
2.30.2


