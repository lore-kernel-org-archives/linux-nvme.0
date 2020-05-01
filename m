Return-Path: <SRS0=VrRv=6P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0966C35280
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 21:26:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A069520857
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 21:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sjbyw126"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A069520857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4Z7wpfPGIrbT1G17DIz+pL7jqgM4IhpZUl1o/OiuZ8U=; b=Sjbyw126Lu2t7C
	og9GRhHbgqM3A4UbFSgg7F6YVZv613LDchTaBe0UmVYqPNWONwzvo6kE968IkQPJGc5B2F5D4Uu7T
	q17S2q9p4dh7GOR11c1FwxDKSPk1yNMewfcUuMftcythO44NyG4LI9KLNcoyu+8iLovFm/Oah6l/j
	6JZfsfi2cy3BY0k9bi/xDcV0Lm+TCBEHocgw06ZiYXNLPCb/tS+EHyw6c42A/XLuRASPZXouzqpPy
	+8OxO738gmhReYJRh9CIAgjdOApx0x/MAPzLA8b/NLr6EhDW/rPftN8C13LfjoEP1Sw9i5QtKWWWa
	/aB9jZTWqdnzwFA3QObw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUdAh-0003Ds-6w; Fri, 01 May 2020 21:26:11 +0000
Received: from [2601:647:4802:9070:4c3:8135:9a7c:5f17]
 (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUdAK-0002oR-4B; Fri, 01 May 2020 21:25:48 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme-tcp: try to send request in queue_rq context
Date: Fri,  1 May 2020 14:25:45 -0700
Message-Id: <20200501212545.21856-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501212545.21856-1-sagi@grimberg.me>
References: <20200501212545.21856-1-sagi@grimberg.me>
MIME-Version: 1.0
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
Cc: Anil Vasudevan <anil.vasudevan@intel.com>,
 Mark Wunderlich <mark.wunderlich@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Today, nvme-tcp automatically schedules a send request
to a workqueue context, which is 1 more than we'd need
in case the socket buffer is wide open.

However, because we have async send activity (as a result
of r2t, or write_space callbacks), we need to synchronize
sends from possibly multiple contexts (ideally all running
on the same cpu though).

Thus, we only try to send directly from queue_rq in cases:
1. the send_list is empty
2. we can send it synchronously (i.e. not from the RX path)
3. we run on the same cpu as the queue->io_cpu to avoid
   contention on the send operation.

Proposed-by: Mark Wunderlich <mark.wunderlich@intel.com>
Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 43 ++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b28f91d0f083..c79e248b9f43 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -76,6 +76,7 @@ struct nvme_tcp_queue {
 	int			io_cpu;
 
 	spinlock_t		lock;
+	struct mutex		send_mutex;
 	struct list_head	send_list;
 
 	/* recv state */
@@ -132,6 +133,7 @@ static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
 static struct workqueue_struct *nvme_tcp_wq;
 static struct blk_mq_ops nvme_tcp_mq_ops;
 static struct blk_mq_ops nvme_tcp_admin_mq_ops;
+static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
 
 static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -258,15 +260,29 @@ static inline void nvme_tcp_advance_req(struct nvme_tcp_request *req,
 	}
 }
 
-static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req)
+static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
+		bool sync)
 {
 	struct nvme_tcp_queue *queue = req->queue;
+	bool empty;
 
 	spin_lock(&queue->lock);
+	empty = list_empty(&queue->send_list) && !queue->request;
 	list_add_tail(&req->entry, &queue->send_list);
 	spin_unlock(&queue->lock);
 
-	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+	/*
+	 * if we're the first on the send_list and we can try to send
+	 * directly, otherwise queue io_work. Also, only do that if we
+	 * are on the same cpu, so we don't introduce contention.
+	 */
+	if (queue->io_cpu == smp_processor_id() &&
+	    sync && empty && mutex_trylock(&queue->send_mutex)) {
+		nvme_tcp_try_send(queue);
+		mutex_unlock(&queue->send_mutex);
+	} else {
+		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+	}
 }
 
 static inline struct nvme_tcp_request *
@@ -579,7 +595,7 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	req->state = NVME_TCP_SEND_H2C_PDU;
 	req->offset = 0;
 
-	nvme_tcp_queue_request(req);
+	nvme_tcp_queue_request(req, false);
 
 	return 0;
 }
@@ -1065,11 +1081,14 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		bool pending = false;
 		int result;
 
-		result = nvme_tcp_try_send(queue);
-		if (result > 0)
-			pending = true;
-		else if (unlikely(result < 0))
-			break;
+		if (mutex_trylock(&queue->send_mutex)) {
+			result = nvme_tcp_try_send(queue);
+			mutex_unlock(&queue->send_mutex);
+			if (result > 0)
+				pending = true;
+			else if (unlikely(result < 0))
+				break;
+		}
 
 		result = nvme_tcp_try_recv(queue);
 		if (result > 0)
@@ -1321,6 +1340,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	queue->ctrl = ctrl;
 	INIT_LIST_HEAD(&queue->send_list);
 	spin_lock_init(&queue->lock);
+	mutex_init(&queue->send_mutex);
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
 	queue->queue_size = queue_size;
 
@@ -1545,6 +1565,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 		set->reserved_tags = 2; /* connect + keep-alive */
 		set->numa_node = NUMA_NO_NODE;
+		set->flags = BLK_MQ_F_BLOCKING;
 		set->cmd_size = sizeof(struct nvme_tcp_request);
 		set->driver_data = ctrl;
 		set->nr_hw_queues = 1;
@@ -1556,7 +1577,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->queue_depth = nctrl->sqsize + 1;
 		set->reserved_tags = 1; /* fabric connect */
 		set->numa_node = NUMA_NO_NODE;
-		set->flags = BLK_MQ_F_SHOULD_MERGE;
+		set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
 		set->cmd_size = sizeof(struct nvme_tcp_request);
 		set->driver_data = ctrl;
 		set->nr_hw_queues = nctrl->queue_count - 1;
@@ -2115,7 +2136,7 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	ctrl->async_req.curr_bio = NULL;
 	ctrl->async_req.data_len = 0;
 
-	nvme_tcp_queue_request(&ctrl->async_req);
+	nvme_tcp_queue_request(&ctrl->async_req, true);
 }
 
 static enum blk_eh_timer_return
@@ -2246,7 +2267,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(rq);
 
-	nvme_tcp_queue_request(req);
+	nvme_tcp_queue_request(req, true);
 
 	return BLK_STS_OK;
 }
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
