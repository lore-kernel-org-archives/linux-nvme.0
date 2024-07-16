Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A8BC3DA5D
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jul 2024 07:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JqrgcCHJdCspyuPHaTG3LFNrt/wv8PFc57GwJSPS1zo=; b=uXDkA10fOzALWjP7oHOdkLAK+i
	0uIr0d3NCXzMqv0r5SRv2nZs7C14kA6KKv5QDW+K+FlYy8IksEz7MEYXxqOnTTiQb32RvyPIT8rZr
	0Rc1+guxsmcFIkwgvaiptvrNkk0oB0m7W0b/rtti/FXR232Vczk5x/T6Oyi/298WYe5G5X9eqrpnt
	KcGKnEZFSNJvQB13AM3HQSHrWxMp7hPrpRctJcHHG5zVNH1+xrLpIa/oggGXwg7FbLKHhzbSyHP+f
	nb1QOpRZwEAcBl4NodkkHKJyinlmXRZnzeHczHfJi10bVG+9yyIRbh/BtaTS+yiLF9WQOVPPbDBVF
	0YYvZvJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTcjs-00000009bvH-2O94;
	Tue, 16 Jul 2024 07:36:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTcjl-00000009bqt-3enJ
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jul 2024 07:36:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 31D2960EA0;
	Tue, 16 Jul 2024 07:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC83C116B1;
	Tue, 16 Jul 2024 07:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721115396;
	bh=9K8mOVDUxZt7ImKufIf6FedAaHjYG0VMNEgBTibGjDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+tH6O5jWy8j5dM0Ycgg2Gl3cMWU/Ysl9q5cPrlIQq9PupZUTDMdGfm1s8qCbx7X2
	 4Hx2NbXNnE6YbqwY5tquViNXQBWkCUCuznMUez541bJacbsvDlIq7WhGKaWaXR9guM
	 YUbMkQcFwgNZ5XBMdTd8fQm69sv2bD2BbNtRLpHPwBZ+UeZ1VOqCYM8q34lWu03btX
	 pcPNTJmXmX8nLPIAM8iHLSpWe5DtjUlgxUeIrTm8QpZ4YY1OL6mqGu7XH64POOJIuT
	 ePlP5R9mRYaq/RqGiVi5ScbmL7F41JJS/RiG1yQS6GLjC+C78nXVdjvcAtNYV4rOfH
	 pYuciWcyEvtFQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/8] nvme-tcp: re-init request list entries
Date: Tue, 16 Jul 2024 09:36:11 +0200
Message-Id: <20240716073616.84417-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240716073616.84417-1-hare@kernel.org>
References: <20240716073616.84417-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_003638_018918_4BD18E8C 
X-CRM114-Status: GOOD (  12.43  )
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

From: Hannes Reinecke <hare@suse.de>

When removing entries from a list we should re-init the list entries
to allow for checking if the entries are still on the list.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7876bf7d2fac..04d840709d5d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -412,11 +412,13 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 static void nvme_tcp_process_req_list(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_request *req;
-	struct llist_node *node;
+	struct llist_node *node, *next;
 
-	for (node = llist_del_all(&queue->req_list); node; node = node->next) {
+	for (node = llist_del_all(&queue->req_list); node; node = next) {
 		req = llist_entry(node, struct nvme_tcp_request, lentry);
 		list_add(&req->entry, &queue->send_list);
+		next = node->next;
+		init_llist_node(node);
 	}
 }
 
@@ -435,7 +437,7 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
 			return NULL;
 	}
 
-	list_del(&req->entry);
+	list_del_init(&req->entry);
 	return req;
 }
 
-- 
2.35.3


