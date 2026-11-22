Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2E6606A32A
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Nov 2026 01:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1PgI9n99;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=de2S400J
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fWJHdnp4YwCtWnVVzUop7dWReDiuHEz0dyfLuLn6Ww4=; b=1PgI9n99yoa479lzc1T/Ti1/9/
	ukFXokv138x6HfqKzuloZX5dfgAvieb6HpehC/6fCBPaXAnBFoUpe8Y+hFhpKpfmjQEj5FFO3NvFt
	HZmFnFhVSFEN41YlSfXKWg3CMS8BlIeuXI0Son9Q3ZZe+bC6RZXcPCUbZfPq6eKS6VDV45WPsuJ4M
	PpVDs0B1i4rv6fxWGxXEUJFWcrWhR8kyvwvKH+WeHk28eWxmB7kDd6dAyITPUH6oBnCSiNq6Ro9XL
	EVSiCMzBuY6qtRvmXB4xa9jm4ckRIon/TUbBzfnJUIEi4cbmkAU4bNv51u1Zb1hySERIc72VARVCG
	ZmgQb35w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUwGA-00000000dvK-33pQ;
	Sun, 22 Nov 2026 01:20:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUwG7-00000000du9-3uCD
	for linux-nvme@lists.infradead.org;
	Sun, 22 Nov 2026 01:20:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795310446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fWJHdnp4YwCtWnVVzUop7dWReDiuHEz0dyfLuLn6Ww4=;
	b=de2S400JO7SpW2lU0OMLsVIYUnmDg02U1fPnulIyBtlojifaqESMcqOuk8eTxmuIk864eT
	pZrreKqLUID9g6+LTabuDZ5nrDIRR8Dl8wicewEOE64XMt8tUPvZguuCYamibqBMxaLOIZ
	VOaXcaJujVpqSQbMeo6X4vzzsaMcXjA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-e156JmlfNfOY5triLT84SA-1; Sun,
 22 Nov 2026 01:19:21 +0000
X-MC-Unique: e156JmlfNfOY5triLT84SA-1
X-Mimecast-MFC-AGG-ID: e156JmlfNfOY5triLT84SA_1795310359
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3737E1955F18;
	Sun, 22 Nov 2026 01:19:19 +0000 (UTC)
Received: from snishika-thinkpadp16vgen1.tokyo.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 553073003EBE;
	Sun, 22 Nov 2026 01:19:15 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>,
	Chris Leech <cleech@redhat.com>,
	Seiji Nishikawa <snishika@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] nvme-tcp: remove the direct send path
Date: Sun, 22 Nov 2026 10:18:25 +0900
Message-ID: <20261122011826.1959697-2-snishika@redhat.com>
In-Reply-To: <20261122011826.1959697-1-snishika@redhat.com>
References: <20261122011826.1959697-1-snishika@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: pBtXm1C61o-Ufnm4xqt4TJ4kqDSkBuk7FALgOGogAkM_1795310359
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261121_172048_048056_BD2141C5 
X-CRM114-Status: GOOD (  20.61  )
X-Spam-Score: 0.5 (/)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvme_tcp_queue_request() sends the request directly from the submitting
context when it runs on the io_cpu of the queue, the queue is empty and
it can take send_mutex. Commit db5ad6b7f8cd ("nvme-tcp: try to send
request in queue_rq context") added this to skip the workqueue hop when
the queue is idle.

Since then this path has needed a series of fixes for races and
priority inversions between it and io_work. These are
commit 5c11f7d9f843 ("nvme-tcp: Fix possible race of io_work and direct
send"), commit a0fdd1418007 ("nvme-tcp: rerun io_work if req_list is
not empty"), commit 70f437fb4395 ("nvme-tcp: fix io_work priority
inversion"), commit 08acb54b063a ("nvme-tcp: defer TLS inline send to
io_work") and commit 5db358f3a7f9 ("nvme-tcp: fix io_work priority
inversion when send_mutex is held").

All of them come from having 2 contexts that send on the same queue and
coordinate through send_mutex, while io_work runs on a high priority
workqueue and the submitting task does not.

Remove the direct send path and always send from io_work. TLS queues
already work this way since 08acb54b063a. With a single sender, io_work
has to be queued whenever the last request of a batch is added, so the
has_pending check in nvme_tcp_queue_request() goes away too, and
nvme_tcp_send_all() has no caller left.

Suggested-by: Hannes Reinecke <hare@suse.de>
Assisted-by: LLM
Signed-off-by: Seiji Nishikawa <snishika@redhat.com>
---
 drivers/nvme/host/tcp.c | 33 ++-------------------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 62a594b8ab9b..2b832ac3068a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -213,7 +213,6 @@ struct nvme_tcp_ctrl {
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
-static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /* lockdep can detect a circular dependency of the form
@@ -420,16 +419,6 @@ static inline void nvme_tcp_advance_req(struct nvme_tcp_request *req,
 	}
 }
 
-static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
-{
-	int ret;
-
-	/* drain the send queue as much as we can... */
-	do {
-		ret = nvme_tcp_try_send(queue);
-	} while (ret > 0);
-}
-
 static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue *queue)
 {
 	return !list_empty(&queue->send_list) ||
@@ -446,28 +435,10 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 		bool last)
 {
 	struct nvme_tcp_queue *queue = req->queue;
-	bool empty;
 
-	empty = llist_add(&req->lentry, &queue->req_list) &&
-		list_empty(&queue->send_list) && !queue->request;
-
-	/*
-	 * if we're the first on the send_list and we can try to send
-	 * directly, otherwise queue io_work. Also, only do that if we
-	 * are on the same cpu, so we don't introduce contention.
-	 *
-	 * TLS kTLS send takes ctx->tx_lock while blk_mq holds set->srcu.
-	 * lockdep reports circular locking via elevator_lock.  Defer TLS
-	 * sends to the io workqueue instead of inline from this path.
-	 */
-	if (queue->io_cpu == raw_smp_processor_id() &&
-	    !nvme_tcp_queue_tls(queue) &&
-	    empty && mutex_trylock(&queue->send_mutex)) {
-		nvme_tcp_send_all(queue);
-		mutex_unlock(&queue->send_mutex);
-	}
+	llist_add(&req->lentry, &queue->req_list);
 
-	if (last && nvme_tcp_queue_has_pending(queue))
+	if (last)
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 }
 
-- 
2.56.1


