Return-Path: <SRS0=/3pY=ZH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0831AC432C3
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2019 10:43:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17AE20748
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2019 10:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U3dDSC7X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvaAJfIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17AE20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3Cv8pzkqFZE/Gd0ps+o6kKzBIX3eS09aAgdZ14MSkhY=; b=U3dDSC7XMlCC3Y
	MdFIA69xiCegOZTSnSuGZdBxzTZ7nFNIuxFgcSoVT2u0Krk5tTpT8M16ACikgdoCe0Sg2Mtu8T2Zg
	/D+cZu84qQfcJQaY9rDFS4uZN4Z9SwhY4dNBCgXW8vZIFp+f09PjZvoG4pIa7HRcd0YxsNLK2PXtA
	9oVArMHh1vGkM+GVv6+Tq3gC2tTt1Hy7raFSTgcwBZ1r11l6MLHhiFHA97gohh3bKvN5x959QxNUN
	i5QzKxZWYN/1Ht6D8M4Bo43VvbDnPEFpSg2kE2LFQL3XjjLa1J/yiyBo4oOJqBpPRClLetDfroRT6
	yHFFiuQ4ReHkIkfjrSUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iVZ4V-0002Y2-NI; Fri, 15 Nov 2019 10:43:23 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iVZ4N-0002Nx-BC
 for linux-nvme@lists.infradead.org; Fri, 15 Nov 2019 10:43:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573814592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/M5kgQpUZ8+HJEaUnuPgsNPU9bN7NMoroHnC8vI5ohc=;
 b=OvaAJfIAKod0Sw+mWQ060xqQyuyZ5PVdiKdVVsOkky3WPVMsxvQ2NXjcMGyQVA1Zt1F5BZ
 JFJiCmCP/mAOnPQAcKM/6NH6Ctc1PxNECc3LbjblL84ajUFSKeMv07lh4I7sgfyWUaQCSy
 nGmDwpiZDoinjEu/YWysTt3rSJaiL1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210--4i6oc75NqyZa1FfY-mmIg-1; Fri, 15 Nov 2019 05:43:09 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1F0F477;
 Fri, 15 Nov 2019 10:43:07 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F83E5D6BE;
 Fri, 15 Nov 2019 10:43:04 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH RFC 2/3] nvme: don't use blk_mq_alloc_request_hctx() for
 allocating connect request
Date: Fri, 15 Nov 2019 18:42:37 +0800
Message-Id: <20191115104238.15107-3-ming.lei@redhat.com>
In-Reply-To: <20191115104238.15107-1-ming.lei@redhat.com>
References: <20191115104238.15107-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: -4i6oc75NqyZa1FfY-mmIg-1
X-Mimecast-Spam-Score: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191115_024315_479105_90BF772D 
X-CRM114-Status: GOOD (  14.15  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use one NVMe specific approach to choose transport queue for connect
request:

- IO connect request uses the unique reserved tag 0
- store the queue id into req->private_rq_data in nvme_alloc_request()
- inside .queue_rq(), select the transport queue via the stored qid

Also request's completion handler need to retrieve the block request via
.command_id and the transport queue instance. So store one flag of the connect
request into rq->private_rq_data before submitting, and make sure that the
flag is available in completion handler, then we can lookup the request
via the flag and the transport queue.

With this approach, we don't need the werid API of blk_mq_alloc_request_hctx()
any more.

Cc: James Smart <james.smart@broadcom.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c   |  9 +++-----
 drivers/nvme/host/fc.c     | 10 +++++++++
 drivers/nvme/host/rdma.c   | 40 +++++++++++++++++++++++++++++++++---
 drivers/nvme/host/tcp.c    | 41 ++++++++++++++++++++++++++++++++++---
 drivers/nvme/target/loop.c | 42 +++++++++++++++++++++++++++++++++++---
 5 files changed, 127 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa7ba09dca77..e96e3997389b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -481,15 +481,12 @@ struct request *nvme_alloc_request(struct request_queue *q,
 	unsigned op = nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
 	struct request *req;
 
-	if (qid == NVME_QID_ANY) {
-		req = blk_mq_alloc_request(q, op, flags);
-	} else {
-		req = blk_mq_alloc_request_hctx(q, op, flags,
-				qid ? qid - 1 : 0);
-	}
+	req = blk_mq_alloc_request(q, op, flags);
 	if (IS_ERR(req))
 		return req;
 
+	if (qid != NVME_QID_ANY)
+		req->private_rq_data = (unsigned long)qid;
 	req->cmd_flags |= REQ_FAILFAST_DRIVER;
 	nvme_clear_nvme_request(req);
 	nvme_req(req)->cmd = cmd;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 265f89e11d8b..6c836e83e59c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2333,6 +2333,16 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	u32 data_len;
 	blk_status_t ret;
 
+	/* connect request requires to use the specified queue */
+	if (rq->tag == 0 && ctrl->ctrl.admin_q != hctx->queue) {
+		unsigned qid = rq->private_rq_data;
+
+		WARN_ON_ONCE(!blk_rq_is_private(rq));
+
+		queue = &ctrl->queues[qid];
+		op->queue = queue;
+	}
+
 	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE ||
 	    !nvmf_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
 		return nvmf_fail_nonready_command(&queue->ctrl->ctrl, rq);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cb4c3000a57e..6056679e8c77 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1436,13 +1436,35 @@ static void nvme_rdma_submit_async_event(struct nvme_ctrl *arg)
 	WARN_ON_ONCE(ret);
 }
 
+static struct request *nvme_rdma_lookup_rq(struct nvme_rdma_queue *queue,
+		struct nvme_rdma_qe *qe, struct nvme_completion *cqe)
+{
+	int i;
+
+	if (cqe->command_id || !nvme_rdma_queue_idx(queue))
+		return blk_mq_tag_to_rq(nvme_rdma_tagset(queue),
+				cqe->command_id);
+
+	/* lookup request for connect IO */
+	for (i = 1; i < queue->ctrl->ctrl.queue_count; i++) {
+		struct request *rq = blk_mq_tag_to_rq(nvme_rdma_tagset(
+					&queue->ctrl->queues[i]), 0);
+
+		if (rq && rq->private_rq_data == (unsigned long)qe)
+			return rq;
+	}
+
+	return NULL;
+}
+
 static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
-		struct nvme_completion *cqe, struct ib_wc *wc)
+		struct nvme_rdma_qe *qe, struct ib_wc *wc)
 {
 	struct request *rq;
 	struct nvme_rdma_request *req;
+	struct nvme_completion *cqe = qe->data;
 
-	rq = blk_mq_tag_to_rq(nvme_rdma_tagset(queue), cqe->command_id);
+	rq = nvme_rdma_lookup_rq(queue, qe, cqe);
 	if (!rq) {
 		dev_err(queue->ctrl->ctrl.device,
 			"tag 0x%x on QP %#x not found\n",
@@ -1506,7 +1528,7 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		nvme_complete_async_event(&queue->ctrl->ctrl, cqe->status,
 				&cqe->result);
 	else
-		nvme_rdma_process_nvme_rsp(queue, cqe, wc);
+		nvme_rdma_process_nvme_rsp(queue, qe, wc);
 	ib_dma_sync_single_for_device(ibdev, qe->dma, len, DMA_FROM_DEVICE);
 
 	nvme_rdma_post_recv(queue, qe);
@@ -1743,6 +1765,18 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	WARN_ON_ONCE(rq->tag < 0);
 
+	/* connect request requires to use the specified queue */
+	if (rq->tag == 0 && queue->ctrl->ctrl.admin_q != hctx->queue) {
+		unsigned qid = rq->private_rq_data;
+
+		WARN_ON_ONCE(!blk_rq_is_private(rq));
+
+		queue = &queue->ctrl->queues[qid];
+		req->queue = queue;
+
+		rq->private_rq_data = (unsigned long)sqe;
+	}
+
 	if (!nvmf_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
 		return nvmf_fail_nonready_command(&queue->ctrl->ctrl, rq);
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 770dbcbc999e..5087e2d168f1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -425,12 +425,35 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	queue_work(nvme_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
+static struct request *nvme_tcp_lookup_rq(struct nvme_tcp_queue *queue,
+		struct nvme_tcp_rsp_pdu *pdu, struct nvme_completion *cqe)
+{
+	int i;
+
+	if (cqe->command_id || !nvme_tcp_queue_id(queue))
+		return blk_mq_tag_to_rq(nvme_tcp_tagset(queue),
+				cqe->command_id);
+
+	/* lookup request for connect IO */
+	for (i = 1; i < queue->ctrl->ctrl.queue_count; i++) {
+		struct request *rq = blk_mq_tag_to_rq(nvme_tcp_tagset(
+					&queue->ctrl->queues[i]), 0);
+
+		if (rq && rq->private_rq_data == (unsigned long)pdu)
+			return rq;
+	}
+
+	return NULL;
+}
+
+
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
-		struct nvme_completion *cqe)
+		struct nvme_tcp_rsp_pdu *pdu)
 {
+	struct nvme_completion *cqe = &pdu->cqe;
 	struct request *rq;
 
-	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), cqe->command_id);
+	rq = nvme_tcp_lookup_rq(queue, pdu, cqe);
 	if (!rq) {
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag 0x%x not found\n",
@@ -496,7 +519,7 @@ static int nvme_tcp_handle_comp(struct nvme_tcp_queue *queue,
 		nvme_complete_async_event(&queue->ctrl->ctrl, cqe->status,
 				&cqe->result);
 	else
-		ret = nvme_tcp_process_nvme_cqe(queue, cqe);
+		ret = nvme_tcp_process_nvme_cqe(queue, pdu);
 
 	return ret;
 }
@@ -2155,6 +2178,18 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 	bool queue_ready = test_bit(NVME_TCP_Q_LIVE, &queue->flags);
 	blk_status_t ret;
 
+	/* connect request requires to use the specified queue */
+	if (rq->tag == 0 && queue->ctrl->ctrl.admin_q != hctx->queue) {
+		unsigned qid = rq->private_rq_data;
+
+		WARN_ON_ONCE(!blk_rq_is_private(rq));
+
+		queue = &queue->ctrl->queues[qid];
+		req->queue = queue;
+
+		rq->private_rq_data = (unsigned long)queue->pdu;
+	}
+
 	if (!nvmf_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
 		return nvmf_fail_nonready_command(&queue->ctrl->ctrl, rq);
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 11f5aea97d1b..d97c3155d86a 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -90,6 +90,28 @@ static struct blk_mq_tags *nvme_loop_tagset(struct nvme_loop_queue *queue)
 	return queue->ctrl->tag_set.tags[queue_idx - 1];
 }
 
+static struct request *nvme_loop_lookup_rq(struct nvme_loop_queue *queue,
+		struct nvmet_req *req)
+{
+	struct nvme_completion *cqe = req->cqe;
+	int i;
+
+	if (cqe->command_id || !nvme_loop_queue_idx(queue))
+		return blk_mq_tag_to_rq(nvme_loop_tagset(queue),
+				cqe->command_id);
+
+	/* lookup request for connect IO */
+	for (i = 1; i < queue->ctrl->ctrl.queue_count; i++) {
+		struct request *rq = blk_mq_tag_to_rq(nvme_loop_tagset(
+					&queue->ctrl->queues[i]), 0);
+
+		if (rq && rq->private_rq_data == (unsigned long)req)
+			return rq;
+	}
+
+	return NULL;
+}
+
 static void nvme_loop_queue_response(struct nvmet_req *req)
 {
 	struct nvme_loop_queue *queue =
@@ -107,9 +129,7 @@ static void nvme_loop_queue_response(struct nvmet_req *req)
 		nvme_complete_async_event(&queue->ctrl->ctrl, cqe->status,
 				&cqe->result);
 	} else {
-		struct request *rq;
-
-		rq = blk_mq_tag_to_rq(nvme_loop_tagset(queue), cqe->command_id);
+		struct request *rq = nvme_loop_lookup_rq(queue, req);
 		if (!rq) {
 			dev_err(queue->ctrl->ctrl.device,
 				"tag 0x%x on queue %d not found\n",
@@ -139,6 +159,22 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	bool queue_ready = test_bit(NVME_LOOP_Q_LIVE, &queue->flags);
 	blk_status_t ret;
 
+	/* connect request requires to use the specified queue */
+	if (req->tag == 0) {
+		struct nvme_loop_ctrl *ctrl = hctx->queue->tag_set->driver_data;
+
+		if (ctrl->ctrl.admin_q != hctx->queue) {
+			unsigned qid = req->private_rq_data;
+
+			WARN_ON_ONCE(!blk_rq_is_private(req));
+
+			queue = &ctrl->queues[qid];
+			iod->queue = queue;
+
+			req->private_rq_data = (unsigned long)&iod->req;
+		}
+	}
+
 	if (!nvmf_check_ready(&queue->ctrl->ctrl, req, queue_ready))
 		return nvmf_fail_nonready_command(&queue->ctrl->ctrl, req);
 
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
