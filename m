Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F566C3600E
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 10:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1kq7LGcba7D5T4wwpKR9EtOIkqdwqLtOXSjVS4vfLpc=; b=ETJEIQ+TV1uQP7ZW6KizjXvI2V
	LFELVI7NzmxAcImBh2bXQQHsAex1jWobHGjGuPn3YIvGBsRropfmKt4josHRonRU8+mfSQw5MTmCJ
	2NbFTgYAeLIGGx41i0VK494+o4Rpw+9S3yHMRxi+fD3hYGVbJNYTihh/wql8qDIqxMu7cwoYWfDY4
	9Coeu8soHm6Tm+b9x6lKLsM57MICTT1SME/nQJx7S8uibMBGfr0S5SqhMzJDN5HC2wvoSDJCyUCAq
	7yPopcxRb8azwyHVFxN0645qXQ69bs4auwVbBskn6Q3x7CIYnWxgGAdGGQS86Z1ZsTawBiBbbCoUN
	vVAPWqJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tweyv-00000002oOn-22hD;
	Mon, 24 Mar 2025 10:24:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twey0-00000002oCs-0OfV
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 10:23:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742811815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kq7LGcba7D5T4wwpKR9EtOIkqdwqLtOXSjVS4vfLpc=;
	b=iTe2M0iwJExQdjsp5K4LUpK9SeBOOeEBWxYyYLUbctXTO6MVpVbatm0YkBZ4EbnBBKtTr/
	s86SjfE8oH6ayu0eQfsk641AvNNNK8q9PxpCG9FDOzKZw1OjluSQcij1/6VY/8tXpQuTCO
	dMgVXRVrkArtOAJtB8bVHU9nSP3DQ8E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-ax2snE3NPxai08UyfmuAZQ-1; Mon,
 24 Mar 2025 06:23:32 -0400
X-MC-Unique: ax2snE3NPxai08UyfmuAZQ-1
X-Mimecast-MFC-AGG-ID: ax2snE3NPxai08UyfmuAZQ_1742811811
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECE2F1809CA6;
	Mon, 24 Mar 2025 10:23:30 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.77])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E8F0180B486;
	Mon, 24 Mar 2025 10:23:27 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	jmeneghi@redhat.com,
	hare@suse.de,
	cleech@redhat.com
Subject: [PATCH RFC v3 04/11] nvme-tcp: use the cancel command to perform an abort if target supports it
Date: Mon, 24 Mar 2025 11:23:03 +0100
Message-ID: <20250324102310.658007-5-mlombard@redhat.com>
In-Reply-To: <20250324102310.658007-1-mlombard@redhat.com>
References: <20250324102310.658007-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rd_9Q6oh5ny8Vvr9Y-eeWYT-AveMWa998PGUdO_IQe0_1742811811
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_032336_202650_B184A04D 
X-CRM114-Status: GOOD (  22.18  )
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
 drivers/nvme/host/core.c |  6 ++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/tcp.c  | 62 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d0dbc249b575..ad141028bcff 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1218,6 +1218,12 @@ bool nvme_io_command_supported(struct nvme_ctrl *ctrl, u8 opcode)
 }
 EXPORT_SYMBOL_GPL(nvme_io_command_supported);
 
+bool nvme_is_cancel(struct nvme_command *cmd)
+{
+	return cmd->common.opcode == nvme_cmd_cancel;
+}
+EXPORT_SYMBOL_GPL(nvme_is_cancel);
+
 u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 {
 	u32 effects = nvme_command_effects(ctrl, ns, opcode);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6388f0a52638..1225a6ff4093 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1190,6 +1190,7 @@ static inline void nvme_auth_revoke_tls_key(struct nvme_ctrl *ctrl) {};
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
 bool nvme_io_command_supported(struct nvme_ctrl *ctrl, u8 opcode);
+bool nvme_is_cancel(struct nvme_command *cmd);
 u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode);
 int nvme_execute_rq(struct request *rq, bool at_head);
 void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 542ffc921a3f..39de42ae3a7e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -122,6 +122,7 @@ struct nvme_tcp_request {
 	size_t			offset;
 	size_t			data_sent;
 	enum nvme_tcp_send_state state;
+	bool			aborted;
 };
 
 enum nvme_tcp_queue_flags {
@@ -129,6 +130,8 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_IO_CPU_SET	= 3,
+	NVME_TCP_Q_CANCEL_ONE   = 4,
+	NVME_TCP_Q_CANCEL_ALL   = 5,
 };
 
 enum nvme_tcp_recv_state {
@@ -205,6 +208,7 @@ static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
+static void nvme_tcp_complete_rq(struct request *rq);
 
 static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -617,7 +621,7 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		req->status = cqe->status;
 
 	if (!nvme_try_complete_req(rq, req->status, cqe->result))
-		nvme_complete_rq(rq);
+		nvme_tcp_complete_rq(rq);
 	queue->nr_cqe++;
 
 	return 0;
@@ -817,7 +821,7 @@ static inline void nvme_tcp_end_request(struct request *rq, u16 status)
 	union nvme_result res = {};
 
 	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
-		nvme_complete_rq(rq);
+		nvme_tcp_complete_rq(rq);
 }
 
 static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
@@ -1833,6 +1837,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		goto err_init_connect;
 
 	set_bit(NVME_TCP_Q_ALLOCATED, &queue->flags);
+	clear_bit(NVME_TCP_Q_CANCEL_ONE, &queue->flags);
+	clear_bit(NVME_TCP_Q_CANCEL_ALL, &queue->flags);
 
 	return 0;
 
@@ -2551,10 +2557,12 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
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
 
 	dev_warn(ctrl->device,
 		 "I/O tag %d (%04x) type %d opcode %#x (%s) QID %d timeout\n",
@@ -2579,10 +2587,39 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 		return BLK_EH_DONE;
 	}
 
+	if (!req->aborted) {
+		if (!nvme_io_command_supported(ctrl, nvme_cmd_cancel) || !qid)
+			goto err_recovery;
+
+		if (!test_and_set_bit(NVME_TCP_Q_CANCEL_ONE, &queue->flags)) {
+			action = NVME_CANCEL_ACTION_SINGLE_CMD;
+		} else if (!test_and_set_bit(NVME_TCP_Q_CANCEL_ALL,
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
+err_recovery:
 	nvme_tcp_error_recovery(ctrl);
 	return BLK_EH_RESET_TIMER;
 }
@@ -2627,6 +2664,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	req->pdu_len = 0;
 	req->pdu_sent = 0;
 	req->h2cdata_left = 0;
+	req->aborted = false;
 	req->data_len = blk_rq_nr_phys_segments(rq) ?
 				blk_rq_payload_bytes(rq) : 0;
 	req->curr_bio = rq->bio;
@@ -2742,10 +2780,24 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 	return len;
 }
 
+static void nvme_tcp_complete_rq(struct request *rq)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_tcp_queue *queue = req->queue;
+	bool is_cancel = nvme_is_cancel(req->req.cmd);
+
+	nvme_complete_rq(rq);
+
+	if (is_cancel) {
+		if (!test_and_clear_bit(NVME_TCP_Q_CANCEL_ALL, &queue->flags))
+			clear_bit(NVME_TCP_Q_CANCEL_ONE, &queue->flags);
+	}
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


