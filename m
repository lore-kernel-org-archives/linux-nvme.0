Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EEDC678D4
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Mar 2023 09:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=heLf8XKAnf2STycnzAP0XzbXWpXz/+i7pKHvIveL1LU=; b=1upSProApidOSYTblD3Oa0Erv1
	dV5u9tx66ODj2GUBptVtYGpS99DQbVnVKIBS//5xY5qPzZd1KLOp0e4H9W2ECR+eI6WeL2DC1jei1
	0SwNiwBNvw0DC7v1wve2IsPT/5jEeGfckpvObmCn/MjIjGstqmUo+nZB0/RWzewU7HOxKgKlzRzs6
	4GoII6wBfJx+TDGTgwJtMV+seYpPIQTEuUZ5US7rmUyI5ghyyy/IfvWv7BDHI7yOJjtgBzICLs+9C
	0cKRl6LOoirRzxSwAdTDtp0t+xjCKK0BWxqPHGgEz6LbQq7U8p2FIpm2ym2Lm6r1L9ZzAJtz7GGpU
	qnXo+HTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ7DQ-00C67z-7q; Mon, 06 Mar 2023 09:33:08 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ7D8-00C62X-DL
	for linux-nvme@lists.infradead.org; Mon, 06 Mar 2023 09:32:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 71DF61FDE1;
	Mon,  6 Mar 2023 09:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1678095167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=heLf8XKAnf2STycnzAP0XzbXWpXz/+i7pKHvIveL1LU=;
	b=n+vO4Z75Q9M+UMmAuhrVpRSSxia0wRFyMO8Evj5Ao9HGwwE+TLtOalFmLfPpqFiFi7/HDq
	u005Ly0wUR+i8Zrzj0+yLJHW6G0zH9nWsdh2Jn0kFs6g1ZYLZu2cneKHvbP/DjS5XsWfI5
	ZlayUzf3bHwKuPdFmGrgus7VkTMrJic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1678095167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=heLf8XKAnf2STycnzAP0XzbXWpXz/+i7pKHvIveL1LU=;
	b=XyviUatsBRODQAsIjHhmY95gEbr1vGq9FYFWIK0XnJWXcDyJSbBclqNvMKgIqgFJoIgI7N
	Vl99DfHVqjm2yiCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65C9413513;
	Mon,  6 Mar 2023 09:32:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 2tXWGD+zBWRwYAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 06 Mar 2023 09:32:47 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [RFC v2 1/6] nvme-rdma: stream line queue functions arguments
Date: Mon,  6 Mar 2023 10:32:39 +0100
Message-Id: <20230306093244.20775-2-dwagner@suse.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306093244.20775-1-dwagner@suse.de>
References: <20230306093244.20775-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230306_013250_640512_1DFC0F46 
X-CRM114-Status: GOOD (  15.14  )
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

In preparation to move common code from the fabrics driver to fabrics.c,
we stream line the low level functions. This allows any common code just
to pass in nvme subsystem global types, such as 'struct nvme_ctrl'
instead of the driver specialized types 'struct nvme_rdma_ctrl'.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/rdma.c | 62 ++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index bbad26b82b56..c26c04c67684 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -133,6 +133,11 @@ static inline struct nvme_rdma_ctrl *to_rdma_ctrl(struct nvme_ctrl *ctrl)
 	return container_of(ctrl, struct nvme_rdma_ctrl, ctrl);
 }
 
+static inline int nvme_rdma_queue_id(struct nvme_rdma_queue *queue)
+{
+	return queue - queue->ctrl->queues;
+}
+
 static LIST_HEAD(device_list);
 static DEFINE_MUTEX(device_list_mutex);
 
@@ -571,13 +576,19 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	return ret;
 }
 
-static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
-		int idx, size_t queue_size)
+static int nvme_rdma_alloc_queue(struct nvme_ctrl *nctrl, int idx)
 {
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	struct nvme_rdma_queue *queue;
 	struct sockaddr *src_addr = NULL;
+	size_t queue_size;
 	int ret;
 
+	if (idx == 0)
+		queue_size = NVME_AQ_DEPTH;
+	else
+		queue_size = ctrl->ctrl.sqsize + 1;
+
 	queue = &ctrl->queues[idx];
 	mutex_init(&queue->queue_lock);
 	queue->ctrl = ctrl;
@@ -641,16 +652,22 @@ static void __nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 	ib_drain_qp(queue->qp);
 }
 
-static void nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
+static void nvme_rdma_stop_queue(struct nvme_ctrl *nctrl, int qid)
 {
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+	struct nvme_rdma_queue *queue = &ctrl->queues[qid];
+
 	mutex_lock(&queue->queue_lock);
 	if (test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags))
 		__nvme_rdma_stop_queue(queue);
 	mutex_unlock(&queue->queue_lock);
 }
 
-static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
+static void nvme_rdma_free_queue(struct nvme_ctrl *nctrl, int qid)
 {
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+	struct nvme_rdma_queue *queue = &ctrl->queues[qid];
+
 	if (!test_and_clear_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
 		return;
 
@@ -664,7 +681,7 @@ static void nvme_rdma_free_io_queues(struct nvme_rdma_ctrl *ctrl)
 	int i;
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++)
-		nvme_rdma_free_queue(&ctrl->queues[i]);
+		nvme_rdma_free_queue(&ctrl->ctrl, i);
 }
 
 static void nvme_rdma_stop_io_queues(struct nvme_rdma_ctrl *ctrl)
@@ -672,18 +689,19 @@ static void nvme_rdma_stop_io_queues(struct nvme_rdma_ctrl *ctrl)
 	int i;
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++)
-		nvme_rdma_stop_queue(&ctrl->queues[i]);
+		nvme_rdma_stop_queue(&ctrl->ctrl, i);
 }
 
-static int nvme_rdma_start_queue(struct nvme_rdma_ctrl *ctrl, int idx)
+static int nvme_rdma_start_queue(struct nvme_ctrl *nctrl, int idx)
 {
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	struct nvme_rdma_queue *queue = &ctrl->queues[idx];
 	int ret;
 
 	if (idx)
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, idx);
+		ret = nvmf_connect_io_queue(nctrl, idx);
 	else
-		ret = nvmf_connect_admin_queue(&ctrl->ctrl);
+		ret = nvmf_connect_admin_queue(nctrl);
 
 	if (!ret) {
 		set_bit(NVME_RDMA_Q_LIVE, &queue->flags);
@@ -702,7 +720,7 @@ static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl,
 	int i, ret = 0;
 
 	for (i = first; i < last; i++) {
-		ret = nvme_rdma_start_queue(ctrl, i);
+		ret = nvme_rdma_start_queue(&ctrl->ctrl, i);
 		if (ret)
 			goto out_stop_queues;
 	}
@@ -711,7 +729,7 @@ static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl,
 
 out_stop_queues:
 	for (i--; i >= first; i--)
-		nvme_rdma_stop_queue(&ctrl->queues[i]);
+		nvme_rdma_stop_queue(&ctrl->ctrl, i);
 	return ret;
 }
 
@@ -773,8 +791,7 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 	}
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
-		ret = nvme_rdma_alloc_queue(ctrl, i,
-				ctrl->ctrl.sqsize + 1);
+		ret = nvme_rdma_alloc_queue(&ctrl->ctrl, i);
 		if (ret)
 			goto out_free_queues;
 	}
@@ -783,7 +800,7 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 
 out_free_queues:
 	for (i--; i >= 1; i--)
-		nvme_rdma_free_queue(&ctrl->queues[i]);
+		nvme_rdma_free_queue(&ctrl->ctrl, i);
 
 	return ret;
 }
@@ -811,7 +828,7 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl)
 				sizeof(struct nvme_command), DMA_TO_DEVICE);
 		ctrl->async_event_sqe.data = NULL;
 	}
-	nvme_rdma_free_queue(&ctrl->queues[0]);
+	nvme_rdma_free_queue(&ctrl->ctrl, 0);
 }
 
 static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
@@ -820,7 +837,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	bool pi_capable = false;
 	int error;
 
-	error = nvme_rdma_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
+	error = nvme_rdma_alloc_queue(&ctrl->ctrl, 0);
 	if (error)
 		return error;
 
@@ -855,7 +872,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
 	}
 
-	error = nvme_rdma_start_queue(ctrl, 0);
+	error = nvme_rdma_start_queue(&ctrl->ctrl, 0);
 	if (error)
 		goto out_remove_admin_tag_set;
 
@@ -882,7 +899,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	blk_sync_queue(ctrl->ctrl.admin_q);
 out_stop_queue:
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
+	nvme_rdma_stop_queue(&ctrl->ctrl, 0);
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
 out_remove_admin_tag_set:
 	if (new)
@@ -894,7 +911,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		ctrl->async_event_sqe.data = NULL;
 	}
 out_free_queue:
-	nvme_rdma_free_queue(&ctrl->queues[0]);
+	nvme_rdma_free_queue(&ctrl->ctrl, 0);
 	return error;
 }
 
@@ -967,7 +984,7 @@ static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
 {
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	blk_sync_queue(ctrl->ctrl.admin_q);
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
+	nvme_rdma_stop_queue(&ctrl->ctrl, 0);
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	if (remove) {
 		nvme_unquiesce_admin_queue(&ctrl->ctrl);
@@ -1118,7 +1135,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 destroy_admin:
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	blk_sync_queue(ctrl->ctrl.admin_q);
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
+	nvme_rdma_stop_queue(&ctrl->ctrl, 0);
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	if (new)
 		nvme_remove_admin_tag_set(&ctrl->ctrl);
@@ -1965,9 +1982,10 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 static void nvme_rdma_complete_timed_out(struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 	struct nvme_rdma_queue *queue = req->queue;
 
-	nvme_rdma_stop_queue(queue);
+	nvme_rdma_stop_queue(ctrl, nvme_rdma_queue_id(queue));
 	nvmf_complete_timed_out_request(rq);
 }
 
-- 
2.39.2


