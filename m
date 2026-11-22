Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA7E606A320
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Nov 2026 01:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tfTPGXxd;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cvPjmkCF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vqC6JaIi9wPgKET/5n4UqUkNpxqYQB/CR4jVp4a3Hhs=; b=tfTPGXxdNk0krTdSlMlTAkDfRu
	APSuhcdzaf2rcyvQR7N46skEbeGsFKHq7rnOOh0hShtEJX/TBHTDS1cxoUUhZDPUd8UCreyXexcuH
	3dxh9abw92Q8L6Ctjcn/l0nVWrzV27AnVfllMuyRvRIylrsg04AAM1Uh0Lz7HyHiRRPREwmLXVAX2
	MN2VRhtRfEVQhwo7fc63lOMoG16l6HXeBW8YPdqC4Af/r2sSI7kYUEMub05HJmL2cWK/fsYdMq9DD
	DVN1KbvEaH0bzAZRC0AjCIkFgZQmtE9EN2ekthGQIIepz15u90ezqaSMqrsltxXlogir9ILRnIRqO
	ZyzCH9Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUwGD-00000000dwm-3VYf;
	Sun, 22 Nov 2026 01:20:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUwG9-00000000dus-1CQr
	for linux-nvme@lists.infradead.org;
	Sun, 22 Nov 2026 01:20:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795310448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vqC6JaIi9wPgKET/5n4UqUkNpxqYQB/CR4jVp4a3Hhs=;
	b=cvPjmkCFyVlOQ7uEqH8PUsYs9bYrZq0F7Y1zJfmK8MGCn92XMN3TqeP52L9ddCnL4Qmh+b
	YW2NEeOF7VyzmMZ1w1bFdL5PvYMDjRhJD2F81G9K3/sMW0cj3r3bSLbEqwzcfn1Iht8f+y
	l+cdWmZaKKENKTqdTYJxdJznVcKtBCo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-YEotI8lvOzmf2WVVKiJbYg-1; Sun,
 22 Nov 2026 01:19:26 +0000
X-MC-Unique: YEotI8lvOzmf2WVVKiJbYg-1
X-Mimecast-MFC-AGG-ID: YEotI8lvOzmf2WVVKiJbYg_1795310364
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B165180047B;
	Sun, 22 Nov 2026 01:19:24 +0000 (UTC)
Received: from snishika-thinkpadp16vgen1.tokyo.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40F8C3003EC5;
	Sun, 22 Nov 2026 01:19:20 +0000 (UTC)
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
Subject: [RFC PATCH 2/2] nvme-tcp: remove send_mutex
Date: Sun, 22 Nov 2026 10:18:26 +0900
Message-ID: <20261122011826.1959697-3-snishika@redhat.com>
In-Reply-To: <20261122011826.1959697-1-snishika@redhat.com>
References: <20261122011826.1959697-1-snishika@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: l8rpNnT8fch3fus56XVT7mJYHs-P7XixUU5ytN9Sba8_1795310364
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261121_172049_469894_9E8478ED 
X-CRM114-Status: GOOD (  16.21  )
X-Spam-Score: -2.8 (--)
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

With the direct send path gone, io_work is the only context that sends
on a queue. A work item never runs concurrently with itself, so
send_mutex does not protect anything anymore.

Remove it, together with the mutex_trylock() in nvme_tcp_io_work() and
the got_send_mutex check, which is now always true.

Assisted-by: LLM
Signed-off-by: Seiji Nishikawa <snishika@redhat.com>
---
 drivers/nvme/host/tcp.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2b832ac3068a..b116268fe2f5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -142,7 +142,6 @@ struct nvme_tcp_queue {
 	int			io_cpu;
 
 	struct mutex		queue_lock;
-	struct mutex		send_mutex;
 	struct mutex		pf_cache_lock;
 	struct llist_head	req_list;
 	struct list_head	send_list;
@@ -1482,18 +1481,13 @@ static void nvme_tcp_io_work(struct work_struct *w)
 
 	do {
 		bool pending = false;
-		bool got_send_mutex = false;
 		int result;
 
-		if (mutex_trylock(&queue->send_mutex)) {
-			got_send_mutex = true;
-			result = nvme_tcp_try_send(queue);
-			mutex_unlock(&queue->send_mutex);
-			if (result > 0)
-				pending = true;
-			else if (unlikely(result < 0))
-				break;
-		}
+		result = nvme_tcp_try_send(queue);
+		if (result > 0)
+			pending = true;
+		else if (unlikely(result < 0))
+			break;
 
 		result = nvme_tcp_try_recv(queue);
 		if (result > 0)
@@ -1501,13 +1495,8 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		else if (unlikely(result < 0))
 			return;
 
-		/*
-		 * did we get some space after spending time in recv?
-		 * Only check this if we could take send_mutex. Otherwise
-		 * the task holding it sends the requests and queues io_work
-		 * again after it releases the mutex.
-		 */
-		if (got_send_mutex && nvme_tcp_queue_has_pending(queue) &&
+		/* did we get some space after spending time in recv? */
+		if (nvme_tcp_queue_has_pending(queue) &&
 		    sk_stream_is_writeable(queue->sock->sk))
 			pending = true;
 
@@ -2087,7 +2076,6 @@ static void nvme_tcp_init_queue(struct nvme_tcp_ctrl *ctrl, int qid)
 
 	queue->ctrl = ctrl;
 	mutex_init(&queue->queue_lock);
-	mutex_init(&queue->send_mutex);
 	mutex_init(&queue->pf_cache_lock);
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
 	queue->hdr_digest = ctrl->ctrl.opts->hdr_digest;
@@ -2099,7 +2087,6 @@ static void nvme_tcp_exit_queue(struct nvme_tcp_ctrl *ctrl, int qid)
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 
 	mutex_destroy(&queue->queue_lock);
-	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->pf_cache_lock);
 }
 
-- 
2.56.1


