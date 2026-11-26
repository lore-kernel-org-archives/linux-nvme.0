Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB675606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZU+IIdST;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kg/snmFD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=+xm6Nkf6BzesHyi2GpHfWG2ZszRki3RAcUZM3tdcUwM=; b=ZU+IIdSTc+KlvTgK7r/3KqkiFE
	ASRDMRaApWhydElKSS9+5b4EDyyFYzb7fFdI5yb0uNmLHjs/ghnZmeAchMf94YsjNu0qRhvI1Jf55
	0VDDrp0mgnUOlqg3PPDfFkxeKgQynorfgbVlCxlNzWqRP7iiS/SKl+MZ0yf0ZoagtpsHXeXm8mTIl
	1dbDgrRym95JXyzx2JvikcrNsN1VGWrs42NZRUoSGhYWktz+A12VqjSnTyxiwbl16woz0htN5xh0H
	MWdMIJLVtCAFNJbATzZ8Rw4wg8Ztmewp/Qj+9Vd5cn2SJMrDdE+KgTJcdwFS/3QHA6qVsvBauArcH
	crD77IvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWVI2-0000000CSiK-0dgE;
	Thu, 26 Nov 2026 08:57:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWVHz-0000000CShH-1CIn
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 08:57:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795683430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+xm6Nkf6BzesHyi2GpHfWG2ZszRki3RAcUZM3tdcUwM=;
	b=Kg/snmFD9lSsZeV/+BQ0cLB1UWaryjAquFEcnDXL/rgO2nRTn4eOcnrOkZP4LQdJl0JExF
	HQZLCs7OElRx2VLs3vLxnliav/q5N/eQ14X0nZBM8QQcU6acHhBpkc86QufJ/jNqwjCgnQ
	JAZFn0ka+6Qb31uifNyj3XqYWx3HyoQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-8PSsJiaINlmfJzoEnyN7Bg-1; Thu,
 26 Nov 2026 08:57:05 +0000
X-MC-Unique: 8PSsJiaINlmfJzoEnyN7Bg-1
X-Mimecast-MFC-AGG-ID: 8PSsJiaINlmfJzoEnyN7Bg_1795683424
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 817251800BC0;
	Thu, 26 Nov 2026 08:57:04 +0000 (UTC)
Received: from snishika-thinkpadp16vgen1.tokyo.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42F7641F;
	Thu, 26 Nov 2026 08:56:59 +0000 (UTC)
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
Subject: [PATCH] nvme-tcp: fix use of a released socket in nvme_tcp_poll()
Date: Thu, 26 Nov 2026 17:56:53 +0900
Message-ID: <20261126085653.3339227-1-snishika@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: rFsoz1-IgPhwc4XXBxqs_-GOxoDVgS4AKbK45dFTcfI_1795683424
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_005711_403750_F8F76FC0 
X-CRM114-Status: GOOD (  21.09  )
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

A controller reset while polled I/O is running crashes the kernel:

  BUG: kernel NULL pointer dereference, address: 0000000000000018
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  Oops: Oops: 0000 [#1] SMP PTI
  CPU: 2 UID: 0 PID: 2585 Comm: fio
  RIP: 0010:nvme_tcp_poll+0x14/0xd0 [nvme_tcp]
  Call Trace:
   <TASK>
   blk_mq_poll+0x6e/0xc0
   bio_poll+0x8e/0x140
   iocb_bio_iopoll+0x2e/0x50
   io_do_iopoll+0xda/0x470
   __se_sys_io_uring_enter+0x43f/0x7a0
   do_syscall_64+0xe9/0x340
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

nvme_tcp_poll() reads queue->sock->sk before it checks NVME_TCP_Q_LIVE.
The reset stops the queue and then nvme_tcp_free_queue() releases the
socket and sets queue->sock to NULL. Nothing keeps nvme_tcp_poll() out
of the queue while this happens, so it reads a NULL queue->sock.
Checking NVME_TCP_Q_LIVE before the read of queue->sock does not suffice
because the socket can be released after the check.

In the vmcore of the crash above, the controller is in
NVME_CTRL_CONNECTING, and the queue that was polled has sock == NULL and
flags == 0. The reset work has freed all I/O queues and waits for the
admin queue connect command.

The crash is always reproducible by resetting the controller while
polled I/O is running on a poll queue. For example, connect with
--nr-poll-queues=4, run fio with --ioengine=io_uring --hipri on the
device, and run "nvme reset" every 10 seconds.

Take queue_lock in nvme_tcp_poll() and check NVME_TCP_Q_LIVE under it
before using the socket. nvme_tcp_stop_queue_nowait() clears
NVME_TCP_Q_LIVE under queue_lock, and nvme_tcp_free_queue() releases the
socket under queue_lock. So nvme_tcp_poll() sees either NVME_TCP_Q_LIVE
cleared or a valid socket, and the reset waits until nvme_tcp_poll()
drops the lock. nvme_tcp_get_address() already uses queue_lock in the
same way.

Use mutex_trylock() so that nvme_tcp_poll() does not sleep on the lock.
If the trylock fails, nvme_tcp_poll() returns 0 and the caller polls
again.

Fixes: 1a9460cef571 ("nvme-tcp: support simple polling")
Signed-off-by: Seiji Nishikawa <snishika@redhat.com>
---
 drivers/nvme/host/tcp.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 62a594b..dbd9bdc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -3196,18 +3196,32 @@ static void nvme_tcp_map_queues(struct blk_mq_tag_set *set)
 static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 {
 	struct nvme_tcp_queue *queue = hctx->driver_data;
-	struct sock *sk = queue->sock->sk;
-	int ret;
+	struct sock *sk;
+	int ret = 0;
 
-	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
+	/*
+	 * A controller reset stops the queue and releases the socket under
+	 * queue_lock. Hold queue_lock so that the socket stays valid while it
+	 * is used here. Do not sleep on the lock. If the trylock fails, return
+	 * 0 and the caller polls again.
+	 */
+	if (!mutex_trylock(&queue->queue_lock))
 		return 0;
 
+	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
+		goto out_unlock;
+
+	sk = queue->sock->sk;
 	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
 	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queue))
 		sk_busy_loop(sk, true);
 	ret = nvme_tcp_try_recv(queue);
 	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
-	return ret < 0 ? ret : queue->nr_cqe;
+	if (ret >= 0)
+		ret = queue->nr_cqe;
+out_unlock:
+	mutex_unlock(&queue->queue_lock);
+	return ret;
 }
 
 static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
-- 
2.43.0


