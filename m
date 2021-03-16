Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DC1C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 17:09:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 837006511F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 17:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837006511F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fiV0jRL58swMl16OIgQtaz9oxnn1WzIr5oQxwvtbUEU=; b=O0cPEtWSKBDmUjjzX0JGcOUXB
	Lt7C2MlTjyQayB1F5uBzRKk1NzW8ONKLr+4TnPrv65NhIdR4Ak6BJEUqpanCSq4sTC6k0pUaf59la
	OSjffv+rkyQiMdQsj35g2fzEgv75Br0gWQyMKTrTT01fQNPgOj102rIkQsct2Zpti0a5cMbwUf2D+
	FXMcUdLfL08HTBnmDRXB3TAIgad252QH+3o5QwLmRJ45ZRYJpouq9Vp9f7qfZCgemxRCWALsScofj
	qPW1Vj9jVNGYzhu2idRlpJ4jagBswUlKj923OaV7+DYM5PRAbDj8OPyBnD/uh9BDsn0L0tEaiFM+A
	uT+nupibw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMDCK-001Md8-DG; Tue, 16 Mar 2021 17:09:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMD9S-001LCS-In
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 17:06:47 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC12565114;
 Tue, 16 Mar 2021 17:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615914395;
 bh=Ohp1rtlxuaj8Xr43V2942pqQ8VMhXoFAX8h3mEftrWI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UgUofIZ7FF78+mNkicHmqzuuN88Wh9FkrYkZGh+f5E4hdE9RifhL3JsBn+QSAfXGv
 UgyCfunvgJ00VpDWIia6JuCm/e3nTjicSjzjBmoWIffZKK292EXHhb/Oqhiuo1otTI
 Wirs7dq38V6lqGN1PQdqcjPGHYPiKbwTK8UJnoGsDD2atofxPL+Kyeik1CDr6J8CWR
 /l1fLuglZqgiGdc9+qsK4ha5sAYZeAZLOtpDL7764/6LuAtpm/NhbQADl4OTL6D3/V
 FKrKZ3NEjjSTF2pwqSd0S1FSt/l8unU0/8MAmMLtpzu+v1kbeBeTElBg61YsFDRDJ8
 6ufW24tJ6g6VQ==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] nvme: use driver pdu command for passthrough
Date: Tue, 16 Mar 2021 10:06:32 -0700
Message-Id: <20210316170632.4161183-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210316170632.4161183-1-kbusch@kernel.org>
References: <20210316170632.4161183-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_170639_641183_76AAA24E 
X-CRM114-Status: GOOD (  16.97  )
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

All nvme transport drivers preallocate an nvme command for each request.
Use that for passthrough commands instead of the stack allocated
command. All transports must initialize the generic nvme_request's 'cmd'
to point to the transport specific preallocated command, and modify
nvme_setup_cmd() to initialize the driver pdu's nvme_command.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c   | 19 ++++++-------------
 drivers/nvme/host/fc.c     |  5 ++---
 drivers/nvme/host/nvme.h   |  3 +--
 drivers/nvme/host/pci.c    |  3 ++-
 drivers/nvme/host/rdma.c   |  5 +++--
 drivers/nvme/host/tcp.c    |  5 ++++-
 drivers/nvme/target/loop.c |  4 +++-
 7 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 512e5578c6e4..eb71ef1648a0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -575,6 +575,9 @@ EXPORT_SYMBOL_NS_GPL(nvme_put_ns, NVME_TARGET_PASSTHRU);
 
 static inline void nvme_clear_nvme_request(struct request *req)
 {
+	struct nvme_command *cmd = nvme_req(req)->cmd;
+
+	memset(cmd, 0, sizeof(*cmd));
 	nvme_req(req)->retries = 0;
 	nvme_req(req)->flags = 0;
 	req->rq_flags |= RQF_DONTPREP;
@@ -595,7 +598,7 @@ static inline void nvme_init_request(struct request *req,
 
 	req->cmd_flags |= REQ_FAILFAST_DRIVER;
 	nvme_clear_nvme_request(req);
-	nvme_req(req)->cmd = cmd;
+	memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
 }
 
 struct request *nvme_alloc_request(struct request_queue *q,
@@ -724,14 +727,6 @@ static void nvme_assign_write_stream(struct nvme_ctrl *ctrl,
 		req->q->write_hints[streamid] += blk_rq_bytes(req) >> 9;
 }
 
-static inline void nvme_setup_passthrough(struct request *req,
-		struct nvme_command *cmd)
-{
-	memcpy(cmd, nvme_req(req)->cmd, sizeof(*cmd));
-	/* passthru commands should let the driver set the SGL flags */
-	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
-}
-
 static inline void nvme_setup_flush(struct nvme_ns *ns,
 		struct nvme_command *cmnd)
 {
@@ -886,19 +881,17 @@ void nvme_cleanup_cmd(struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
 
-blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
-		struct nvme_command *cmd)
+blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 {
+	struct nvme_command *cmd = nvme_req(req)->cmd;
 	blk_status_t ret = BLK_STS_OK;
 
 	if (!(req->rq_flags & RQF_DONTPREP))
 		nvme_clear_nvme_request(req);
 
-	memset(cmd, 0, sizeof(*cmd));
 	switch (req_op(req)) {
 	case REQ_OP_DRV_IN:
 	case REQ_OP_DRV_OUT:
-		nvme_setup_passthrough(req, cmd);
 		break;
 	case REQ_OP_FLUSH:
 		nvme_setup_flush(ns, cmd);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index fe8c32f0efb1..0d4fb8edbf7c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2128,6 +2128,7 @@ nvme_fc_init_request(struct blk_mq_tag_set *set, struct request *rq,
 	op->op.fcp_req.first_sgl = op->sgl;
 	op->op.fcp_req.private = &op->priv[0];
 	nvme_req(rq)->ctrl = &ctrl->ctrl;
+	nvme_req(rq)->cmd = &op->op.cmd_iu.sqe;
 	return res;
 }
 
@@ -2759,8 +2760,6 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_fc_ctrl *ctrl = queue->ctrl;
 	struct request *rq = bd->rq;
 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
-	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
-	struct nvme_command *sqe = &cmdiu->sqe;
 	enum nvmefc_fcp_datadir	io_dir;
 	bool queue_ready = test_bit(NVME_FC_Q_LIVE, &queue->flags);
 	u32 data_len;
@@ -2770,7 +2769,7 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	    !nvmf_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
 		return nvmf_fail_nonready_command(&queue->ctrl->ctrl, rq);
 
-	ret = nvme_setup_cmd(ns, rq, sqe);
+	ret = nvme_setup_cmd(ns, rq);
 	if (ret)
 		return ret;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 76de7ed55d90..b0863c59fac4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -623,8 +623,7 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl);
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, blk_mq_req_flags_t flags);
 void nvme_cleanup_cmd(struct request *req);
-blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
-		struct nvme_command *cmd);
+blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1a0912146c74..d47bb18b976a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -430,6 +430,7 @@ static int nvme_init_request(struct blk_mq_tag_set *set, struct request *req,
 	iod->nvmeq = nvmeq;
 
 	nvme_req(req)->ctrl = &dev->ctrl;
+	nvme_req(req)->cmd = &iod->cmd;
 	return 0;
 }
 
@@ -932,7 +933,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
 		return BLK_STS_IOERR;
 
-	ret = nvme_setup_cmd(ns, req, cmnd);
+	ret = nvme_setup_cmd(ns, req);
 	if (ret)
 		return ret;
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9b0a61841851..f94c6e7d5d93 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -314,6 +314,7 @@ static int nvme_rdma_init_request(struct blk_mq_tag_set *set,
 			NVME_RDMA_DATA_SGL_SIZE;
 
 	req->queue = queue;
+	nvme_req(rq)->cmd = req->sqe.data;
 
 	return 0;
 }
@@ -2038,7 +2039,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request *rq = bd->rq;
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_rdma_qe *sqe = &req->sqe;
-	struct nvme_command *c = sqe->data;
+	struct nvme_command *c = nvme_req(rq)->cmd;
 	struct ib_device *dev;
 	bool queue_ready = test_bit(NVME_RDMA_Q_LIVE, &queue->flags);
 	blk_status_t ret;
@@ -2061,7 +2062,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	ib_dma_sync_single_for_cpu(dev, sqe->dma,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
 
-	ret = nvme_setup_cmd(ns, rq, c);
+	ret = nvme_setup_cmd(ns, rq);
 	if (ret)
 		goto unmap_qe;
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ee25492ec130..4d9ea6c2ef87 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -417,6 +417,7 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 {
 	struct nvme_tcp_ctrl *ctrl = set->driver_data;
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_tcp_cmd_pdu *pdu;
 	int queue_idx = (set == &ctrl->tag_set) ? hctx_idx + 1 : 0;
 	struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
@@ -427,8 +428,10 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	if (!req->pdu)
 		return -ENOMEM;
 
+	pdu = req->pdu;
 	req->queue = queue;
 	nvme_req(rq)->ctrl = &ctrl->ctrl;
+	nvme_req(rq)->cmd = &pdu->cmd;
 
 	return 0;
 }
@@ -2259,7 +2262,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	u8 hdgst = nvme_tcp_hdgst_len(queue), ddgst = 0;
 	blk_status_t ret;
 
-	ret = nvme_setup_cmd(ns, rq, &pdu->cmd);
+	ret = nvme_setup_cmd(ns, rq);
 	if (ret)
 		return ret;
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 8fd53df5cf7d..6665da3b634f 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -141,7 +141,7 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (!nvmf_check_ready(&queue->ctrl->ctrl, req, queue_ready))
 		return nvmf_fail_nonready_command(&queue->ctrl->ctrl, req);
 
-	ret = nvme_setup_cmd(ns, req, &iod->cmd);
+	ret = nvme_setup_cmd(ns, req);
 	if (ret)
 		return ret;
 
@@ -205,8 +205,10 @@ static int nvme_loop_init_request(struct blk_mq_tag_set *set,
 		unsigned int numa_node)
 {
 	struct nvme_loop_ctrl *ctrl = set->driver_data;
+	struct nvme_loop_iod *iod = blk_mq_rq_to_pdu(req);
 
 	nvme_req(req)->ctrl = &ctrl->ctrl;
+	nvme_req(req)->cmd = &iod->cmd;
 	return nvme_loop_init_iod(ctrl, blk_mq_rq_to_pdu(req),
 			(set == &ctrl->tag_set) ? hctx_idx + 1 : 0);
 }
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
