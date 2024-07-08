Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E988C3271E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jul 2024 07:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e4JvfPDpYzwMW9ctF/e69wP2WiuW5Cqwa+ycuy7l2Ls=; b=hzlLHKfR8fhN1W18M908Zxoa0u
	/F24ISw8F/PrTeDJqjvcELFdWixULgkgFIdXc0T3wjuP0qEydyEpE8p4HP2aB0GMSED7SYdaSmXSC
	wW1wGq4reg9AucUmx0alJV0Yr16pCUWGcRJvp86kqBZ/VNStTuvWeSsqWk4b2CYhC+rp74LxmGg4x
	5LcdxoPfMgb+fR0tPX31jek3zaRLRkEMMBUQIMJoPc6H+cScKe3hy9Jopwwt2kXnlwwKuBD/lg0U5
	oVP3ikIcJDHmxqsRvFFMQJEFtS4byVAK2SNk8mXEsQlYfvi+Tp9H7ZgkPnv42tK9afhfooEKtaCiD
	TL5Aa1Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQiW7-00000002z72-0qWG;
	Mon, 08 Jul 2024 07:10:31 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQiVy-00000002z4V-1uGw
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jul 2024 07:10:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 575CB60A0C;
	Mon,  8 Jul 2024 07:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DCBC4AF0D;
	Mon,  8 Jul 2024 07:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720422621;
	bh=J5XOIyvDrxAnmj0GIMPT1L8U5fJ8cDXhWfXgK41/p9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qXDZf5n2KgR0ElxtgAJ7KHqbtS/0P1aQkxS8rW9MbaDisa0o6byX+Z0P+wysWut+E
	 4vTqDxJuKvkLG2vWyKpN4QHtbHFXeT7cyx77bHnEejpLxC7sDMbCi8gTdNRaeg/5mv
	 bw1O6nFQGyG0nzMZBlJIJut8wR7dpZ+IcryWzX3wBiOpyx3hh+yF9eEzM3LmtQjNWP
	 dxS2cvWW/lVo+qEc58oj3S6DyjxlGJAW+yk2XXHsgB9tAthYfS4sQL1N4SaB8dFEno
	 SUdBXOxgAsxyNTJ14F+4Z+UzkPKWQrrhpViGdjx0YZK5wUMoxwqe8kYawM6jQOih8t
	 O2kGUbOkwg3ow==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/3] nvme-tcp: improve rx/tx fairness
Date: Mon,  8 Jul 2024 09:10:11 +0200
Message-Id: <20240708071013.69984-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240708071013.69984-1-hare@kernel.org>
References: <20240708071013.69984-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_001022_707026_140E15C3 
X-CRM114-Status: GOOD (  19.70  )
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

We need to restrict both side, rx and tx, to only run for a certain time
to ensure that we're not blocking the other side and induce starvation.
So pass in a 'deadline' value to nvme_tcp_send_all() and nvme_tcp_try_recv()
and break out of the loop if the deadline is reached.

As we now have a timestamp we can also use it to print out a warning
if the actual time spent exceeds the deadline.

Performance comparison:
               baseline rx/tx fairness
4k seq write:  449MiB/s 480MiB/s
4k rand write: 410MiB/s 481MiB/s
4k seq read:   478MiB/s 481MiB/s
4k rand read:  547MiB/s 480MiB/s

Random read is ever so disappointing, but that will be fixed with the later
patches.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 0873b3949355..f621d3ba89b2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -153,6 +153,7 @@ struct nvme_tcp_queue {
 	size_t			data_remaining;
 	size_t			ddgst_remaining;
 	unsigned int		nr_cqe;
+	unsigned long		deadline;
 
 	/* send state */
 	struct nvme_tcp_request *request;
@@ -359,14 +360,18 @@ static inline void nvme_tcp_advance_req(struct nvme_tcp_request *req,
 	}
 }
 
-static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
+static inline int nvme_tcp_send_all(struct nvme_tcp_queue *queue,
+				    unsigned long deadline)
 {
 	int ret;
 
 	/* drain the send queue as much as we can... */
 	do {
 		ret = nvme_tcp_try_send(queue);
+		if (time_after(jiffies, deadline))
+			break;
 	} while (ret > 0);
+	return ret;
 }
 
 static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue *queue)
@@ -385,6 +390,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 		bool sync, bool last)
 {
 	struct nvme_tcp_queue *queue = req->queue;
+	unsigned long deadline = jiffies + msecs_to_jiffies(1);
 	bool empty;
 
 	empty = llist_add(&req->lentry, &queue->req_list) &&
@@ -397,7 +403,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 	 */
 	if (queue->io_cpu == raw_smp_processor_id() &&
 	    sync && empty && mutex_trylock(&queue->send_mutex)) {
-		nvme_tcp_send_all(queue);
+		nvme_tcp_send_all(queue, deadline);
 		mutex_unlock(&queue->send_mutex);
 	}
 
@@ -959,9 +965,14 @@ static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
 			return result;
 		}
+		if (time_after(jiffies, queue->deadline)) {
+			desc->count = 0;
+			break;
+		}
+
 	}
 
-	return consumed;
+	return consumed - len;
 }
 
 static void nvme_tcp_data_ready(struct sock *sk)
@@ -1258,7 +1269,7 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 	return ret;
 }
 
-static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
+static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue, unsigned long deadline)
 {
 	struct socket *sock = queue->sock;
 	struct sock *sk = sock->sk;
@@ -1269,6 +1280,7 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 	rd_desc.count = 1;
 	lock_sock(sk);
 	queue->nr_cqe = 0;
+	queue->deadline = deadline;
 	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
 	release_sock(sk);
 	return consumed;
@@ -1278,14 +1290,15 @@ static void nvme_tcp_io_work(struct work_struct *w)
 {
 	struct nvme_tcp_queue *queue =
 		container_of(w, struct nvme_tcp_queue, io_work);
-	unsigned long deadline = jiffies + msecs_to_jiffies(1);
+	unsigned long tx_deadline = jiffies + msecs_to_jiffies(1);
+	unsigned long rx_deadline = tx_deadline + msecs_to_jiffies(1), overrun;
 
 	do {
 		bool pending = false;
 		int result;
 
 		if (mutex_trylock(&queue->send_mutex)) {
-			result = nvme_tcp_try_send(queue);
+			result = nvme_tcp_send_all(queue, tx_deadline);
 			mutex_unlock(&queue->send_mutex);
 			if (result > 0)
 				pending = true;
@@ -1293,7 +1306,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
 				break;
 		}
 
-		result = nvme_tcp_try_recv(queue);
+		result = nvme_tcp_try_recv(queue, rx_deadline);
 		if (result > 0)
 			pending = true;
 		else if (unlikely(result < 0))
@@ -1302,7 +1315,13 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		if (!pending || !queue->rd_enabled)
 			return;
 
-	} while (!time_after(jiffies, deadline)); /* quota is exhausted */
+	} while (!time_after(jiffies, rx_deadline)); /* quota is exhausted */
+
+	overrun = jiffies - rx_deadline;
+	if (nvme_tcp_queue_id(queue) > 0 &&
+	    overrun > msecs_to_jiffies(10))
+		dev_dbg(queue->ctrl->ctrl.device, "queue %d: queue stall (%u msecs)\n",
+			nvme_tcp_queue_id(queue), jiffies_to_msecs(overrun));
 
 	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 }
@@ -2666,6 +2685,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 {
 	struct nvme_tcp_queue *queue = hctx->driver_data;
 	struct sock *sk = queue->sock->sk;
+	unsigned long deadline = jiffies + msecs_to_jiffies(1);
 
 	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
 		return 0;
@@ -2673,7 +2693,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
 	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queue))
 		sk_busy_loop(sk, true);
-	nvme_tcp_try_recv(queue);
+	nvme_tcp_try_recv(queue, deadline);
 	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
 	return queue->nr_cqe;
 }
-- 
2.35.3


