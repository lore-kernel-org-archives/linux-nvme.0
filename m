Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FE1C36010
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 10:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+J3bwvtGKPVFvvIcJBK0Or57xmBFbwKGKd5IXLjWIS0=; b=TYj/y00Ji2vv01tx2Ji+hhTL0u
	7fYdpiEzcdzmejq7hjanqod+NwqaUOWmLkfUkEeXsGA69QGXSyXb71+1pYWSYlQPHt7bP3VO7ddRK
	TkP5xZPSc8IZMhw5/9tNvHSsUqnT5wUAxWfH0WP/uyJPBIe5Had8+mfW0OF87HOQSZqYz4Vxwieit
	1/OdPy7P/BMD6W6fqBY2V78U0OydynmlI5ATnffv3cjnnQgxnyTxA39SV2Qs6+DUuENjx7SR7DgV1
	YH5HEXYQxBAU2Uu7fEfiu6xOT4WKBdpVu0S9ohxSFny06N6t9xC6GSV2KgXIE18GGTLPbOaP9ke8h
	bmguzRvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tweyw-00000002oPH-18sf;
	Mon, 24 Mar 2025 10:24:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twey5-00000002oDh-3Tpt
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 10:23:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742811821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+J3bwvtGKPVFvvIcJBK0Or57xmBFbwKGKd5IXLjWIS0=;
	b=IjgkgSslzCv+lmXramxJQ89JLd/khKiImTNR/nLrCCwWx4M365eOLhevk8sziZxjDtuhOE
	a0ofra+BorfHib+2qg2fVu16PBA+yTbXPzQwYsAhSaV8XD1Pj8WK8oiY8cV7e0Pgar0WFI
	Opm4js1BObDBG8rCQXK/Cv62EPKvRqc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-X2Uhxj5XMzKnv90kCV5VHw-1; Mon,
 24 Mar 2025 06:23:35 -0400
X-MC-Unique: X2Uhxj5XMzKnv90kCV5VHw-1
X-Mimecast-MFC-AGG-ID: X2Uhxj5XMzKnv90kCV5VHw_1742811814
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FEC5180AF5E;
	Mon, 24 Mar 2025 10:23:34 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.77])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9336C180B488;
	Mon, 24 Mar 2025 10:23:31 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	jmeneghi@redhat.com,
	hare@suse.de,
	cleech@redhat.com
Subject: [PATCH RFC v3 05/11] nvme-rdma: use the cancel command to perform an abort if target supports it
Date: Mon, 24 Mar 2025 11:23:04 +0100
Message-ID: <20250324102310.658007-6-mlombard@redhat.com>
In-Reply-To: <20250324102310.658007-1-mlombard@redhat.com>
References: <20250324102310.658007-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PlQnV_Sn4Kc9uZq48n5i_LOdghiL_0djR72rd3-sdJ4_1742811814
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_032341_935085_A7559DFB 
X-CRM114-Status: GOOD (  19.79  )
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
to a maximum of 2 per queue;
If more than one command time out at the same time, the driver will use a
Cancel command with action flag set to "Multiple commands" to abort all
the commands on the specified queue as a last resort to avoid a
controller reset.

If the cancel command is not supported or if any error is encountered,
the driver will fall back to the normal controller reset.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/rdma.c | 50 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index b5a0295b5bf4..3de37d116e4a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -74,12 +74,15 @@ struct nvme_rdma_request {
 	struct nvme_rdma_sgl	data_sgl;
 	struct nvme_rdma_sgl	*metadata_sgl;
 	bool			use_sig_mr;
+	bool			aborted;
 };
 
 enum nvme_rdma_queue_flags {
 	NVME_RDMA_Q_ALLOCATED		= 0,
 	NVME_RDMA_Q_LIVE		= 1,
 	NVME_RDMA_Q_TR_READY		= 2,
+	NVME_RDMA_Q_CANCEL_ONE		= 3,
+	NVME_RDMA_Q_CANCEL_ALL		= 4,
 };
 
 struct nvme_rdma_queue {
@@ -619,6 +622,8 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 	}
 
 	set_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags);
+	clear_bit(NVME_RDMA_Q_CANCEL_ONE, &queue->flags);
+	clear_bit(NVME_RDMA_Q_CANCEL_ALL, &queue->flags);
 
 	return 0;
 
@@ -1954,16 +1959,18 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_rdma_queue *queue = req->queue;
-	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
+	struct nvme_rdma_ctrl *rdma_ctrl = queue->ctrl;
+	struct nvme_ctrl *ctrl = &rdma_ctrl->ctrl;
 	struct nvme_command *cmd = req->req.cmd;
 	int qid = nvme_rdma_queue_idx(queue);
+	int error, action;
 
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
@@ -1981,11 +1988,40 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 		return BLK_EH_DONE;
 	}
 
+	if (!req->aborted) {
+		if (!nvme_io_command_supported(ctrl, nvme_cmd_cancel) || !qid)
+			goto err_recovery;
+
+		if (!test_and_set_bit(NVME_RDMA_Q_CANCEL_ONE, &queue->flags)) {
+			action = NVME_CANCEL_ACTION_SINGLE_CMD;
+		} else if (!test_and_set_bit(NVME_RDMA_Q_CANCEL_ALL,
+						&queue->flags)) {
+			action = NVME_CANCEL_ACTION_MUL_CMD;
+		} else {
+			/* No free reserved commands.
+			 * this means a "multiple commands" cancel
+			 * is currently under execution and this request
+			 * is likely to be canceled. Mark this
+			 * request as aborted and reset the timer.
+			 */
+			goto abort;
+		}
+
+		error = nvme_submit_cancel_req(ctrl, rq, qid, action);
+		if (error)
+			goto err_recovery;
+
+abort:
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
 
@@ -2009,6 +2045,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return nvme_fail_nonready_command(&queue->ctrl->ctrl, rq);
 
 	dev = queue->device->dev;
+	req->aborted = false;
 
 	req->sqe.dma = ib_dma_map_single(dev, req->sqe.data,
 					 sizeof(struct nvme_command),
@@ -2113,6 +2150,7 @@ static void nvme_rdma_complete_rq(struct request *rq)
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_rdma_queue *queue = req->queue;
 	struct ib_device *ibdev = queue->device->dev;
+	bool is_cancel = nvme_is_cancel(req->req.cmd);
 
 	if (req->use_sig_mr)
 		nvme_rdma_check_pi_status(req);
@@ -2121,6 +2159,10 @@ static void nvme_rdma_complete_rq(struct request *rq)
 	ib_dma_unmap_single(ibdev, req->sqe.dma, sizeof(struct nvme_command),
 			    DMA_TO_DEVICE);
 	nvme_complete_rq(rq);
+	if (is_cancel) {
+		if (!test_and_clear_bit(NVME_RDMA_Q_CANCEL_ALL, &queue->flags))
+			clear_bit(NVME_RDMA_Q_CANCEL_ONE, &queue->flags);
+	}
 }
 
 static void nvme_rdma_map_queues(struct blk_mq_tag_set *set)
-- 
2.43.5


