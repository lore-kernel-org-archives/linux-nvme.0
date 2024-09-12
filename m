Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4106EEB560
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 08:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vqrJju04yvQBpkei4pGNoBllji1QlS58Sz6Tae3GNDM=; b=M1LqKINmrmAOKCD42+l4qCppbj
	/qFpMJs4ulgo/UEFo0kU5ktha4r6DsRoiYm2wwOk6Gbr62P/JLbsBv9/oYKxBJmmsM8PKHxbBewq9
	PqJH349vx3oqCoU90IB9+L54fJIrqGYxqaATeB4QZ8Fss7qm6BY0jP0cRX5XtHLu6Wgt2sdzqq1zJ
	eWa4FKQRtDzQx2OLrO3+T2ohqF3azItV7isXiq6QsEukbQbZ1HJKDAs1E760eKRqURBuZdBm8icPL
	naB3z4jmqJhjXFFgp8H1+voGN4IGeSkPeUQb8y3FGBZRy0pK3/74zB5+GjtimqO0+rFdLrfaZhex2
	6Q7cZJhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sof1I-0000000CKpM-42bO;
	Thu, 12 Sep 2024 08:17:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soezF-0000000CKWH-2GXZ
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 08:15:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726128932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vqrJju04yvQBpkei4pGNoBllji1QlS58Sz6Tae3GNDM=;
	b=P7s5RsCeyi5LzmObSicyDGuZ3OX4Z+EtZ6reX3YnoDLtcM6MkEgFrAvIj3+ipvJHjMrjU9
	W6PRKX09p1UZxQqedJGXcNvx/PhmGhMYkvdIoepxl2fIZGNsyxOM++MMEf1LvuV0R5Ngyt
	cqCRy7kZYqEO6H8hPx/XAhj+QuqTq5M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-NkotCG2COqedKuwq82jw4g-1; Thu,
 12 Sep 2024 04:15:31 -0400
X-MC-Unique: NkotCG2COqedKuwq82jw4g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F38B1955DC8;
	Thu, 12 Sep 2024 08:15:30 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.45.224.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D710195605A;
	Thu, 12 Sep 2024 08:15:28 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@meta.com
Cc: hare@kernel.org,
	sagi@grimberg.me,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH RFC V2 6/7] nvme-rdma: use the cancel command to perform an abort if target supports it
Date: Thu, 12 Sep 2024 10:15:09 +0200
Message-ID: <20240912081510.171857-7-mlombard@redhat.com>
In-Reply-To: <20240912081510.171857-1-mlombard@redhat.com>
References: <20240912081510.171857-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_011533_676136_BDAAF3C6 
X-CRM114-Status: GOOD (  19.44  )
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

If available, use Cancel command to abort the command that timed
out instead of resetting the controller.

Limit the number of outstanding cancel commands
to MAX_RSV_CANCEL_MAX per queue;
If the number of reserved commands runs low, the driver will use a
Cancel command with action flag set to "Multiple commands" to abort all
the commands on the specified queue as a last resort to avoid a
controller reset.

If the cancel command is not supported, if any error is encountered or
if the pool of reserved commands is exhausted,
the driver will fall back to the normal controller reset.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/rdma.c | 43 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2eb33842f971..00e4c9ce7fbc 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -74,6 +74,7 @@ struct nvme_rdma_request {
 	struct nvme_rdma_sgl	data_sgl;
 	struct nvme_rdma_sgl	*metadata_sgl;
 	bool			use_sig_mr;
+	bool			aborted;
 };
 
 enum nvme_rdma_queue_flags {
@@ -97,6 +98,7 @@ struct nvme_rdma_queue {
 	struct completion	cm_done;
 	bool			pi_support;
 	int			cq_size;
+	atomic_t		cancel_free_cmds;
 	struct mutex		queue_lock;
 };
 
@@ -575,6 +577,7 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 
 	queue = &ctrl->queues[idx];
 	mutex_init(&queue->queue_lock);
+	atomic_set(&queue->cancel_free_cmds, NVME_RSV_CANCEL_MAX);
 	queue->ctrl = ctrl;
 	if (idx && ctrl->ctrl.max_integrity_segments)
 		queue->pi_support = true;
@@ -1959,16 +1962,19 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_rdma_queue *queue = req->queue;
-	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
+	struct nvme_rdma_ctrl *rdma_ctrl = queue->ctrl;
+	struct nvme_ctrl *ctrl = &rdma_ctrl->ctrl;
 	struct nvme_command *cmd = req->req.cmd;
 	int qid = nvme_rdma_queue_idx(queue);
+	int error, action;
+	int cancel_free_cmds;
 
-	dev_warn(ctrl->ctrl.device,
+	dev_warn(ctrl->device,
 		 "I/O tag %d (%04x) opcode %#x (%s) QID %d timeout\n",
 		 rq->tag, nvme_cid(rq), cmd->common.opcode,
 		 nvme_fabrics_opcode_str(qid, cmd), qid);
 
-	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_LIVE) {
+	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
 		/*
 		 * If we are resetting, connecting or deleting we should
 		 * complete immediately because we may block controller
@@ -1986,11 +1992,33 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 		return BLK_EH_DONE;
 	}
 
+	if (!req->aborted) {
+		if (!nvme_io_command_supported(ctrl, nvme_cmd_cancel))
+			goto err_recovery;
+
+		cancel_free_cmds = atomic_dec_return(&queue->cancel_free_cmds);
+		if (cancel_free_cmds < 0)
+			goto err_recovery;
+
+		if (cancel_free_cmds > 0)
+			action = NVME_CANCEL_ACTION_SINGLE_CMD;
+		else
+			action = NVME_CANCEL_ACTION_MUL_CMD;
+
+		error = nvme_submit_cancel_req(ctrl, rq, qid, action);
+		if (error)
+			goto err_recovery;
+
+		req->aborted = true;
+		return BLK_EH_RESET_TIMER;
+	}
+
 	/*
 	 * LIVE state should trigger the normal error recovery which will
 	 * handle completing this request.
 	 */
-	nvme_rdma_error_recovery(ctrl);
+err_recovery:
+	nvme_rdma_error_recovery(rdma_ctrl);
 	return BLK_EH_RESET_TIMER;
 }
 
@@ -2014,6 +2042,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return nvme_fail_nonready_command(&queue->ctrl->ctrl, rq);
 
 	dev = queue->device->dev;
+	req->aborted = false;
 
 	req->sqe.dma = ib_dma_map_single(dev, req->sqe.data,
 					 sizeof(struct nvme_command),
@@ -2118,6 +2147,8 @@ static void nvme_rdma_complete_rq(struct request *rq)
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_rdma_queue *queue = req->queue;
 	struct ib_device *ibdev = queue->device->dev;
+	struct nvme_command *cmd = req->req.cmd;
+	int c;
 
 	if (req->use_sig_mr)
 		nvme_rdma_check_pi_status(req);
@@ -2125,6 +2156,10 @@ static void nvme_rdma_complete_rq(struct request *rq)
 	nvme_rdma_unmap_data(queue, rq);
 	ib_dma_unmap_single(ibdev, req->sqe.dma, sizeof(struct nvme_command),
 			    DMA_TO_DEVICE);
+	if (cmd && cmd->common.opcode == nvme_cmd_cancel) {
+		c = atomic_inc_return(&queue->cancel_free_cmds);
+		WARN_ON_ONCE(c > NVME_RSV_CANCEL_MAX);
+	}
 	nvme_complete_rq(rq);
 }
 
-- 
2.43.5


