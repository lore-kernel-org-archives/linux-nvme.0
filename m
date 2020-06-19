Return-Path: <SRS0=ohfr=AA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C05C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 00:30:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7529206E2
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 00:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W73BHxXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7529206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tPvex3had/JZ+XMvlS/pIxwe7EqEBGJWjD+gHc83ai4=; b=W73BHxXt/rcbnw
	XzBFDLHbCSgLu3oE0Sdt6kWCw8h7+DpifNq4nE3TX1tJ4zfYRpFLGdXC1pVZY1mSCUgvxaXO6c33X
	dMnQ8ik/Ru5M7AagYD5aMBoi2HVS8qyJIKGzsOLwkopwNUoIMhmH/fQAtll+hwLDgkGPBZwC/BJyN
	MOJcjQCuat1Px3RzJAjz4EWV6t/cI9ejlUzwuHVjPfV1LOyBqHUcflQPWbAzOl7Qg0PpRt30tjw48
	LeTncquJKPVof5xkT3J0QTaEDfDKScPWkm3pVnkLSHzMKSybru0BPiCyxbcUbcksi+GET9cao8aUD
	bC3E/X5a1Oo8n7sBRNBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jm4vO-0002e6-Bi; Fri, 19 Jun 2020 00:30:30 +0000
Received: from [2601:647:4802:9070:1cb6:2f11:eeb8:2d3d]
 (helo=localhost.localdomain)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jm4vK-0002b7-4s; Fri, 19 Jun 2020 00:30:26 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/3] nvme-tcp: have queue prod/cons send list become a llist
Date: Thu, 18 Jun 2020 17:30:22 -0700
Message-Id: <20200619003024.153517-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200619003024.153517-1-sagi@grimberg.me>
References: <20200619003024.153517-1-sagi@grimberg.me>
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

The queue processing will splice to a queue local list, this should
alleviate some contention on the send_list lock, but also prepares
us to the next patch where we look on these lists for network stack
flag optimization.

Remove queue lock as its unused anymore.

Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 79ef2b8e2b3c..93fc6d9f97df 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -46,6 +46,7 @@ struct nvme_tcp_request {
 	u32			pdu_sent;
 	u16			ttag;
 	struct list_head	entry;
+	struct llist_node	lentry;
 	__le32			ddgst;
 
 	struct bio		*curr_bio;
@@ -75,8 +76,8 @@ struct nvme_tcp_queue {
 	struct work_struct	io_work;
 	int			io_cpu;
 
-	spinlock_t		lock;
 	struct mutex		send_mutex;
+	struct llist_head	req_list;
 	struct list_head	send_list;
 
 	/* recv state */
@@ -266,10 +267,8 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 	struct nvme_tcp_queue *queue = req->queue;
 	bool empty;
 
-	spin_lock(&queue->lock);
-	empty = list_empty(&queue->send_list) && !queue->request;
-	list_add_tail(&req->entry, &queue->send_list);
-	spin_unlock(&queue->lock);
+	empty = llist_add(&req->lentry, &queue->req_list) &&
+		list_empty(&queue->send_list) && !queue->request;
 
 	/*
 	 * if we're the first on the send_list and we can try to send
@@ -285,18 +284,38 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 	}
 }
 
+static void nvme_tcp_process_req_list(struct nvme_tcp_queue *queue)
+{
+	struct nvme_tcp_request *req;
+	struct llist_node *node;
+
+	node = llist_del_all(&queue->req_list);
+	if (!node)
+		return;
+
+	while (node) {
+		req = llist_entry(node, struct nvme_tcp_request, lentry);
+		list_add(&req->entry, &queue->send_list);
+		node = node->next;
+	}
+}
+
 static inline struct nvme_tcp_request *
 nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_request *req;
 
-	spin_lock(&queue->lock);
 	req = list_first_entry_or_null(&queue->send_list,
 			struct nvme_tcp_request, entry);
-	if (req)
-		list_del(&req->entry);
-	spin_unlock(&queue->lock);
+	if (!req) {
+		nvme_tcp_process_req_list(queue);
+		req = list_first_entry_or_null(&queue->send_list,
+				struct nvme_tcp_request, entry);
+		if (unlikely(!req))
+			return NULL;
+	}
 
+	list_del(&req->entry);
 	return req;
 }
 
@@ -1342,8 +1361,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	int ret, rcv_pdu_size;
 
 	queue->ctrl = ctrl;
+	init_llist_head(&queue->req_list);
 	INIT_LIST_HEAD(&queue->send_list);
-	spin_lock_init(&queue->lock);
 	mutex_init(&queue->send_mutex);
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
 	queue->queue_size = queue_size;
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
