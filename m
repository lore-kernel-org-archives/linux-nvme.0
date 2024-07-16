Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484E4C3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jul 2024 07:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hkfGpZqetpy2H78WyNiQdXmlv5J38z7BJDPWMGou1xw=; b=srN5hOtH55XcJBUlcNJJHWphSN
	rGps6jR/syZjDLKfuT8rKpZtpWWphWv6dG7MkNEyn3l4HAz68zLOXcE+xH+2yHiMOrFRO2KhKNx7L
	JCjtGRsCPOpY2gfwO9lwu8qk/pV0R8iCBmq7aXZWWNqGq1k0vk6P+hut0mJEOSbRa8zVXeJB4/8rg
	eNcs7nYTTDUSeU+fDDYggqNoNv6N9wz+pQMbGO6fTJNPfkqYQFwOaX6C09lsj+u8jcfqSba38Nevv
	4k6pZmx+JmA/iZKOwEMmG8WlDpvbUGMczo0L+DWJ8eYIHy7GAw4+n5fNKuEgAkzSFN6bBOPurZhYZ
	YiKXASmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTcjt-00000009bwi-3Z3i;
	Tue, 16 Jul 2024 07:36:45 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTcjp-00000009bsc-0iIU
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jul 2024 07:36:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 80133CE1030;
	Tue, 16 Jul 2024 07:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57565C116B1;
	Tue, 16 Jul 2024 07:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721115398;
	bh=Xsj9r3w0Q+vosvr2HK7BlZOWNtJqQnJTy0RJ4wI5Adk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NzPeprHnMJ1gASY7odnCzvl4G5ze3twy1Gjcx6VVqbe/BDgGyP9E9L/4ODEpXv4gd
	 g/lnW28XCwz7YUPcoorrRRvzUao9A9Pwoafm4UuTiMHDQvQTfZGkOIv0iWk2UpyBxi
	 zwxMCrQRaVBoxESKSp3sFclr7o4qxm2n3F1K4e+oroqvinO2dwBi6a1yCHJisKKxKS
	 SM7wxuzK4EgM87f+6p0fJAO3d2WhJ16Qzbn+ndHi6tY/yeucwAAdXgA3zP05A5CT9Q
	 t7uyzj8G2WA13+6KdLVX7zAlJ66yK1XhGL/CHanXAhYgMSkzVh+DxsHBt7kjGSs2q5
	 HYs/WJe16mR0Q==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/8] nvme-tcp: improve stall debugging
Date: Tue, 16 Jul 2024 09:36:12 +0200
Message-Id: <20240716073616.84417-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240716073616.84417-1-hare@kernel.org>
References: <20240716073616.84417-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_003641_582329_E098BFF4 
X-CRM114-Status: GOOD (  13.68  )
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

Add counter for the number of send and receive calls, and an additional
counter for the number of SQEs processed.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 04d840709d5d..9caee99955c2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -156,7 +156,10 @@ struct nvme_tcp_queue {
 	int			pdu_offset;
 	size_t			data_remaining;
 	size_t			ddgst_remaining;
+	unsigned int		nr_sqe;
+	unsigned int		nr_send;
 	unsigned int		nr_cqe;
+	unsigned int		nr_recv;
 
 	/* send state */
 	struct nvme_tcp_request *request;
@@ -368,6 +371,8 @@ static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
 	int ret;
 
 	/* drain the send queue as much as we can... */
+	queue->nr_sqe = 0;
+	queue->nr_send = 0;
 	do {
 		ret = nvme_tcp_try_send(queue);
 	} while (ret > 0);
@@ -944,6 +949,7 @@ static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 	if (unlikely(!queue->rd_enabled))
 		return -EFAULT;
 
+	queue->nr_recv++;
 	while (len) {
 		switch (nvme_tcp_recv_state(queue)) {
 		case NVME_TCP_RECV_PDU:
@@ -1028,6 +1034,7 @@ static void nvme_tcp_state_change(struct sock *sk)
 static inline void nvme_tcp_done_send_req(struct nvme_tcp_queue *queue)
 {
 	queue->request = NULL;
+	queue->nr_sqe++;
 }
 
 static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
@@ -1071,6 +1078,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 
 		bvec_set_page(&bvec, page, len, offset);
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
+		queue->nr_send++;
 		ret = sock_sendmsg(queue->sock, &msg);
 		if (ret <= 0)
 			return ret;
@@ -1127,6 +1135,7 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 
 	bvec_set_virt(&bvec, (void *)pdu + req->offset, len);
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
+	queue->nr_send++;
 	ret = sock_sendmsg(queue->sock, &msg);
 	if (unlikely(ret <= 0))
 		return ret;
@@ -1165,6 +1174,7 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 
 	bvec_set_virt(&bvec, (void *)pdu + req->offset, len);
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
+	queue->nr_send++;
 	ret = sock_sendmsg(queue->sock, &msg);
 	if (unlikely(ret <= 0))
 		return ret;
@@ -1198,6 +1208,7 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
 	else
 		msg.msg_flags |= MSG_EOR;
 
+	queue->nr_send++;
 	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
 	if (unlikely(ret <= 0))
 		return ret;
@@ -1275,6 +1286,7 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 	rd_desc.count = 1;
 	lock_sock(sk);
 	queue->nr_cqe = 0;
+	queue->nr_recv = 0;
 	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
 	release_sock(sk);
 	return consumed;
@@ -1288,6 +1300,8 @@ static void nvme_tcp_io_work(struct work_struct *w)
 	u64 tx_deadline = start + deadline;
 	bool pending = false;
 
+	queue->nr_sqe = 0;
+	queue->nr_send = 0;
 	do {
 		int result;
 
@@ -1318,8 +1332,9 @@ static void nvme_tcp_io_work(struct work_struct *w)
 	overrun = ktime_to_us(ktime_get()) - start;
 	if (overrun > 10 * deadline) {
 		dev_dbg(queue->ctrl->ctrl.device,
-			"queue %d: stall (%llu msecs)%s%s\n",
+			"queue %d: stall (%llu msecs) send %u sqe %u recv %u cqe %u%s%s\n",
 			nvme_tcp_queue_id(queue), div_u64(overrun, 1000),
+			queue->nr_send, queue->nr_sqe, queue->nr_recv, queue->nr_cqe,
 			list_empty(&queue->send_list) ? " empty" : "", queue->request ? " pending" : "");
 	}
 	if (pending)
-- 
2.35.3


