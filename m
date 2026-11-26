Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3910606A31E
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 06:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TNsTnqvT;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KcTMZqg/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=q2Ii0a1d2+aW54hfrb8g8ouCHO/fw0cULVlPeHNl7ys=; b=TNsTnqvTyPRQatDLY+6dprCTEZ
	PqAnBDBsW1Xlhlxdyb0JqoNdR5z4ZXlaJjPlgX+n8cCj3pDbdHkxwhI7cOEt/WF95ETlPlvV6XGFd
	PwyhbBk25Ayb06J3TApl+DfEIl+wTrAf8sJzNxSXX8kMxUO59lNPHAf6gwlrx4JoSktTZaj+H4Baw
	Z4Rj0sYhDLxyv0SHbxHtYPZhsqzzlpTLUoAebDlBphNBR/10ccSMgx8EAYdFJoalKkpA7wfy+wj8b
	FhoQD0oyNZa7Z6jNJxEntrCJz0gLTrQe6maOM+DjjAn+1/3STfLx4JmXQI3fVuCT5xJLc0hgAazal
	/rr44EAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWT2n-0000000CCiw-009J;
	Thu, 26 Nov 2026 06:33:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWT2i-0000000CCiL-2itp
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 06:33:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795674793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q2Ii0a1d2+aW54hfrb8g8ouCHO/fw0cULVlPeHNl7ys=;
	b=KcTMZqg/RzDWGuRzMYWrDJTH7fExcarjN4PfqY9mrNDLFGBbunyjIIV+xkBNPkFX/utmpz
	2dDHe01O4lyZEbJidU8QYf/MY9AEH1xdrzR3js1UrMxzRpwFUNg+KiAbG8TdUDUZ8rObPh
	3k6pdtzvM7N3r9ox+cYnG0S2z6hNfoI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-3020HFePMyS2P06c2C9gnw-1; Thu,
 26 Nov 2026 06:33:09 +0000
X-MC-Unique: 3020HFePMyS2P06c2C9gnw-1
X-Mimecast-MFC-AGG-ID: 3020HFePMyS2P06c2C9gnw_1795674788
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2AF01802154;
	Thu, 26 Nov 2026 06:33:07 +0000 (UTC)
Received: from snishika-thinkpadp16vgen1.tokyo.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B891195608B;
	Thu, 26 Nov 2026 06:33:03 +0000 (UTC)
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
Subject: [PATCH v2] nvme-tcp: limit the direct send path to poll queues
Date: Thu, 26 Nov 2026 15:32:55 +0900
Message-ID: <20261126063255.3240292-1-snishika@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: FMfHVuzcZRKIKblxJdMN7QoWa8pxIpSO-RoSVic0dYw_1795674788
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_223316_830646_43CB79F0 
X-CRM114-Status: GOOD (  22.98  )
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

nvme_tcp_queue_request() sends the request directly from the submitting
context when it runs on the io_cpu of the queue, the queue is empty and
it can take send_mutex. Commit db5ad6b7f8cd ("nvme-tcp: try to send
request in queue_rq context") added this so that an idle queue can send
the request without waiting for io_work to run.

Since then this path has needed a series of fixes for races and
priority inversions between it and io_work. These are
commit 5c11f7d9f843 ("nvme-tcp: Fix possible race of io_work and direct
send"), commit a0fdd1418007 ("nvme-tcp: rerun io_work if req_list is
not empty"), commit 70f437fb4395 ("nvme-tcp: fix io_work priority
inversion"), commit 08acb54b063a ("nvme-tcp: defer TLS inline send to
io_work") and commit 5db358f3a7f9 ("nvme-tcp: fix io_work priority
inversion when send_mutex is held").

On a non-poll queue, the direct send path makes almost no difference to
the latency. fio with libaio and 4k random I/O at queue depth 1 over a
1Gb network, with and without the direct send path (average of 3 runs
of 60 seconds, latency in usec):

                      IOPS   slat   clat    lat
  randread   with     4153    7.1  232.3  239.3
             without  4154    4.7  234.7  239.4
  randwrite  with     2472   24.5  375.6  400.1
             without  2460   14.3  387.6  402.0

lat is slat plus clat. It changes by 0.1 usec for randread and by 1.9
usec for randwrite.

On a poll queue, the latency becomes worse without the direct send path.
The submitting task polls for the completion without sleeping. When it
runs on io_cpu, where io_work also runs, the kworker that runs io_work
can send the request only after the task is switched out. This happens
once per request. fio with io_uring and --hipri at queue depth 1 over
the same network, on the io_cpu of a poll queue (ctx is the number of
context switches of fio in one run):

                      IOPS   slat    clat     lat      ctx
  randread   with     5017   4.72  193.95  198.67      553
             without  4179   9.35  229.70  239.05  251,318
  randwrite  with     3619   5.60  269.94  275.54      542
             without  3621  10.62  264.53  275.16  217,806

For randread, lat goes up by 40 usec (20%) without the direct send
path.

So remove the direct send path, except for poll queues. The other
queues always send from io_work, as TLS queues already do.

Add a queue flag, NVME_TCP_Q_POLLED, for this. nvme_tcp_alloc_queue()
sets the flag when the queue is a poll queue, and
nvme_tcp_queue_request() checks it.

Suggested-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Seiji Nishikawa <snishika@redhat.com>
---
Changes since RFC:
- Keep the direct send path for poll queues. Sashiko pointed out the
  cost on poll queues, and the numbers in the RFC thread confirm it.
- Drop the patch that removed send_mutex. Poll queues still have 2
  senders, so send_mutex is still needed.

RFC: https://lore.kernel.org/linux-nvme/20261122011826.1959697-1-snishika@redhat.com/

 drivers/nvme/host/tcp.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 62a594b..3725cac 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -124,6 +124,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_IO_CPU_SET	= 3,
 	NVME_TCP_Q_TLS_RECORD	= 4,
+	NVME_TCP_Q_POLLED	= 5,
 };
 
 #define NVME_TCP_OPT_NR_QUEUES(opts) ((opts)->nr_io_queues + \
@@ -452,15 +453,18 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 		list_empty(&queue->send_list) && !queue->request;
 
 	/*
-	 * if we're the first on the send_list and we can try to send
-	 * directly, otherwise queue io_work. Also, only do that if we
-	 * are on the same cpu, so we don't introduce contention.
+	 * On a poll queue, the submitting task keeps polling on its cpu
+	 * instead of sleeping. If that cpu is io_cpu, sending from io_work
+	 * would cause a context switch to the kworker for every request.
+	 * So send the request directly here if the queue is empty and we
+	 * are on io_cpu. Otherwise send from io_work.
 	 *
 	 * TLS kTLS send takes ctx->tx_lock while blk_mq holds set->srcu.
 	 * lockdep reports circular locking via elevator_lock.  Defer TLS
 	 * sends to the io workqueue instead of inline from this path.
 	 */
-	if (queue->io_cpu == raw_smp_processor_id() &&
+	if (test_bit(NVME_TCP_Q_POLLED, &queue->flags) &&
+	    queue->io_cpu == raw_smp_processor_id() &&
 	    !nvme_tcp_queue_tls(queue) &&
 	    empty && mutex_trylock(&queue->send_mutex)) {
 		nvme_tcp_send_all(queue);
@@ -2190,6 +2194,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	queue->sock->sk->sk_allocation = GFP_ATOMIC;
 	queue->sock->sk->sk_use_task_frag = false;
 	queue->io_cpu = WORK_CPU_UNBOUND;
+	assign_bit(NVME_TCP_Q_POLLED, &queue->flags,
+		   nvme_tcp_poll_queue(queue));
 	queue->request = NULL;
 	queue->data_remaining = 0;
 	queue->ddgst_remaining = 0;
-- 
2.56.1


