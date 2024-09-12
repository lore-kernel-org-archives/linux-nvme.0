Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE52EEB561
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 08:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X+x3C+s7rH7mHjGxCGdQF4KDC4btk7exBL3PY4CMeN8=; b=3MpeOCRYuIjtgj752Bj9auIDmc
	RBTf40GVMgk5gPbpqdYcqrK7OLyLpzWqawj6kWSTLcsSFewpexBXIGlDNkRAwxh9DMJNHY28x4LAy
	KkPBlvlb1Z9Jc26EVLOkEgC5XOMxvvpFRgIFLR55AMXJFYNL2nwirWJ+sLHbVaOBBC+evr520HpEW
	JrAO+27YGhImQ9VWraUGA8RlrVZcsOavw3wl71xx+Nw6UPIPZVcAM2iWa2gYmjUEAHBbe3h1mwLR6
	drW1qGKPAJa0lRJdb6oolwZ0RpxYIk/8CNCijS9p1azdTbFCaBpuxFSN8RLTH+8iONC/vSCUAeTJt
	yhar6qhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sof1K-0000000CKqP-0QZi;
	Thu, 12 Sep 2024 08:17:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soezG-0000000CKWm-1iXV
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 08:15:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726128933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+x3C+s7rH7mHjGxCGdQF4KDC4btk7exBL3PY4CMeN8=;
	b=Z4RMWkpWQW/Qe8pLpfn0Jtxk7QnfHrUB/sgIpu1UCtLYsgmq70zRaZnNoKbgc8kWCox306
	zwkgaubdInnyCk9GvmTZS1lUN/AErndYIUmDOek/rYRgsEqleQdODMpVBKMqGO7RDyKp/9
	xUr3gaG297TbNNmwODIKpLGNTZ7NWVk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-GMSggYVtNyqb6ndmkXK8iQ-1; Thu,
 12 Sep 2024 04:15:29 -0400
X-MC-Unique: GMSggYVtNyqb6ndmkXK8iQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5F21196CE3E;
	Thu, 12 Sep 2024 08:15:27 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.45.224.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 97F0E195605A;
	Thu, 12 Sep 2024 08:15:25 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@meta.com
Cc: hare@kernel.org,
	sagi@grimberg.me,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH RFC V2 5/7] nvme-tcp: use the cancel command to perform an abort if target supports it
Date: Thu, 12 Sep 2024 10:15:08 +0200
Message-ID: <20240912081510.171857-6-mlombard@redhat.com>
In-Reply-To: <20240912081510.171857-1-mlombard@redhat.com>
References: <20240912081510.171857-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_011534_549081_8FD50280 
X-CRM114-Status: GOOD (  21.79  )
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
 drivers/nvme/host/tcp.c | 58 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a2a47d3ab99f..c4f04b451854 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -121,6 +121,7 @@ struct nvme_tcp_request {
 	size_t			offset;
 	size_t			data_sent;
 	enum nvme_tcp_send_state state;
+	bool			aborted;
 };
 
 enum nvme_tcp_queue_flags {
@@ -172,6 +173,7 @@ struct nvme_tcp_queue {
 	struct completion       tls_complete;
 	int                     tls_err;
 	struct page_frag_cache	pf_cache;
+	atomic_t		cancel_free_cmds;
 
 	void (*state_change)(struct sock *);
 	void (*data_ready)(struct sock *);
@@ -202,6 +204,7 @@ static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
+static void nvme_tcp_complete_rq(struct request *rq);
 
 static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -600,7 +603,7 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		req->status = cqe->status;
 
 	if (!nvme_try_complete_req(rq, req->status, cqe->result))
-		nvme_complete_rq(rq);
+		nvme_tcp_complete_rq(rq);
 	queue->nr_cqe++;
 
 	return 0;
@@ -800,7 +803,7 @@ static inline void nvme_tcp_end_request(struct request *rq, u16 status)
 	union nvme_result res = {};
 
 	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
-		nvme_complete_rq(rq);
+		nvme_tcp_complete_rq(rq);
 }
 
 static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
@@ -1658,6 +1661,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	mutex_init(&queue->send_mutex);
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
 
+	atomic_set(&queue->cancel_free_cmds, NVME_RSV_CANCEL_MAX);
+
 	if (qid > 0)
 		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
 	else
@@ -2444,10 +2449,13 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 {
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
-	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
 	struct nvme_command *cmd = &pdu->cmd;
-	int qid = nvme_tcp_queue_id(req->queue);
+	struct nvme_tcp_queue *queue = req->queue;
+	struct nvme_ctrl *ctrl = &queue->ctrl->ctrl;
+	int qid = nvme_tcp_queue_id(queue);
+	int error, action;
+	int cancel_free_cmds;
 
 	dev_warn(ctrl->device,
 		 "I/O tag %d (%04x) type %d opcode %#x (%s) QID %d timeout\n",
@@ -2472,10 +2480,34 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 		return BLK_EH_DONE;
 	}
 
+	if (!req->aborted) {
+		if (!nvme_io_command_supported(ctrl, nvme_cmd_cancel))
+			goto err_recovery;
+
+		cancel_free_cmds = atomic_dec_return(&queue->cancel_free_cmds);
+		if (cancel_free_cmds < 0) {
+			/* No free reserved commands */
+			goto err_recovery;
+		}
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
+err_recovery:
 	nvme_tcp_error_recovery(ctrl);
 	return BLK_EH_RESET_TIMER;
 }
@@ -2520,6 +2552,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	req->pdu_len = 0;
 	req->pdu_sent = 0;
 	req->h2cdata_left = 0;
+	req->aborted = false;
 	req->data_len = blk_rq_nr_phys_segments(rq) ?
 				blk_rq_payload_bytes(rq) : 0;
 	req->curr_bio = rq->bio;
@@ -2634,10 +2667,25 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 	return len;
 }
 
+static void nvme_tcp_complete_rq(struct request *rq)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_tcp_queue *queue = req->queue;
+	struct nvme_command *cmd = req->req.cmd;
+	int c;
+
+	if (cmd && cmd->common.opcode == nvme_cmd_cancel) {
+		c = atomic_inc_return(&queue->cancel_free_cmds);
+		WARN_ON_ONCE(c > NVME_RSV_CANCEL_MAX);
+	}
+
+	nvme_complete_rq(rq);
+}
+
 static const struct blk_mq_ops nvme_tcp_mq_ops = {
 	.queue_rq	= nvme_tcp_queue_rq,
 	.commit_rqs	= nvme_tcp_commit_rqs,
-	.complete	= nvme_complete_rq,
+	.complete	= nvme_tcp_complete_rq,
 	.init_request	= nvme_tcp_init_request,
 	.exit_request	= nvme_tcp_exit_request,
 	.init_hctx	= nvme_tcp_init_hctx,
-- 
2.43.5


