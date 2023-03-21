Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188B0C74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 12:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PgOfFrHCcKEjSa8iU26GAfH3GvTcujJssi3xMC2H8X4=; b=oE5Ca6rGlPtp7DuArSRRYLSFyM
	EDmxtDLw/S1RkqBs9+bnWhzWUYeXQpfe0OQJxvZ7pLPOMStFF8Nn4KeIQ3KKCg0OJsYwkI/a8Wv5Q
	ZqfKNVfWLzJYjJz+1/sAH8cOXKtL/DloxisBBtAgoqLxeZyaWpGoCiwE4rk05ZLc3DIWIhvkxtT2d
	D5EwHJQD61LQeeLE7W3u7VsmV8Tml1P1W+aBRZbd4EgeQyj/1D8WjrJKXF1TjZ57JRXKsH2EDRTat
	98n1wYWyJjcN+iMoq1ea7Ahkf5SBW2mWbez+SDOm/U69j7Ol6jKayIV4jCTbHgK2ACveV/M6qP0Gb
	mVnPHoJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pebLd-00CNah-22;
	Tue, 21 Mar 2023 12:44:17 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pebLN-00CNOd-1a
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 12:44:05 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id E750B1FFFF;
	Tue, 21 Mar 2023 12:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679402637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgOfFrHCcKEjSa8iU26GAfH3GvTcujJssi3xMC2H8X4=;
	b=KQq49GYm1JRqhujnOvi8FrEf09R55PDqiCKT84L/cSvWQ00AF5/5qaNbYAK0dBWeEQ2DGf
	pfdF0EAotlDbshcyJrEEjSZ9gZWji9RuP9o7+8jTuPM8qgOi7yErEtHq9mG1VQ+UVhB/P6
	/d2G/R4Hqi1xJMo0kmjBL3UtoCuLuCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679402637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgOfFrHCcKEjSa8iU26GAfH3GvTcujJssi3xMC2H8X4=;
	b=OFGYOxUYf7bLawIrzUfRCe5Ulvdbo28Nn8fWYelCJhfy0GMZUS4K/f0OMU3PqjUtDLAbHx
	GylXvcT/WToSMuAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id D5CC62C14F;
	Tue, 21 Mar 2023 12:43:57 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id BE7A651BEE9E; Tue, 21 Mar 2023 13:43:57 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <cel@kernel.org>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 05/18] nvme-tcp: implement recvmsg rx flow for TLS
Date: Tue, 21 Mar 2023 13:43:12 +0100
Message-Id: <20230321124325.77385-6-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230321124325.77385-1-hare@suse.de>
References: <20230321124325.77385-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_054401_724799_51DAA638 
X-CRM114-Status: GOOD (  19.21  )
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

TLS offload only implements recvmsg(), so implement the receive
side with using recvmsg().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 156 ++++++++++++++++++++--------------------
 1 file changed, 77 insertions(+), 79 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 42c0598c31f2..0e14b1b90855 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -529,7 +529,7 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->pdu_remaining = sizeof(struct nvme_tcp_rsp_pdu) +
 				nvme_tcp_hdgst_len(queue);
 	queue->pdu_offset = 0;
-	queue->data_remaining = -1;
+	queue->data_remaining = 0;
 	queue->ddgst_remaining = 0;
 }
 
@@ -707,25 +707,32 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	return 0;
 }
 
-static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
-		unsigned int *offset, size_t *len)
+static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, bool pending)
 {
 	struct nvme_tcp_hdr *hdr;
-	char *pdu = queue->pdu;
-	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
+	size_t rcv_len = queue->pdu_remaining;
+	struct msghdr msg = {
+		.msg_flags = pending ? 0 : MSG_DONTWAIT,
+	};
+	struct kvec iov = {
+		.iov_base = (u8 *)queue->pdu + queue->pdu_offset,
+		.iov_len = rcv_len,
+	};
 	int ret;
 
-	ret = skb_copy_bits(skb, *offset,
-		&pdu[queue->pdu_offset], rcv_len);
-	if (unlikely(ret))
+	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_PDU)
+		return 0;
+
+	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
+			     iov.iov_len, msg.msg_flags);
+	if (ret <= 0)
 		return ret;
 
+	rcv_len = ret;
 	queue->pdu_remaining -= rcv_len;
 	queue->pdu_offset += rcv_len;
-	*offset += rcv_len;
-	*len -= rcv_len;
 	if (queue->pdu_remaining)
-		return 0;
+		return queue->pdu_remaining;
 
 	hdr = queue->pdu;
 	if (queue->hdr_digest) {
@@ -734,7 +741,6 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			return ret;
 	}
 
-
 	if (queue->data_digest) {
 		ret = nvme_tcp_check_ddgst(queue, queue->pdu);
 		if (unlikely(ret))
@@ -765,19 +771,21 @@ static inline void nvme_tcp_end_request(struct request *rq, u16 status)
 		nvme_complete_rq(rq);
 }
 
-static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
-			      unsigned int *offset, size_t *len)
+static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
 	struct request *rq =
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
+	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DATA)
+		return 0;
+
 	while (true) {
-		int recv_len, ret;
+		struct msghdr msg;
+		int ret;
 
-		recv_len = min_t(size_t, *len, queue->data_remaining);
-		if (!recv_len)
+		if (!queue->data_remaining)
 			break;
 
 		if (!iov_iter_count(&req->iter)) {
@@ -798,25 +806,20 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		}
 
 		/* we can read only from what is left in this bio */
-		recv_len = min_t(size_t, recv_len,
-				iov_iter_count(&req->iter));
+		memset(&msg, 0, sizeof(msg));
+		msg.msg_iter = req->iter;
 
-		if (queue->data_digest)
-			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
-				&req->iter, recv_len, queue->rcv_hash);
-		else
-			ret = skb_copy_datagram_iter(skb, *offset,
-					&req->iter, recv_len);
-		if (ret) {
+		ret = sock_recvmsg(queue->sock, &msg, 0);
+		if (ret <= 0) {
 			dev_err(queue->ctrl->ctrl.device,
-				"queue %d failed to copy request %#x data",
+				"queue %d failed to receive request %#x data",
 				nvme_tcp_queue_id(queue), rq->tag);
 			return ret;
 		}
 
-		*len -= recv_len;
-		*offset += recv_len;
-		queue->data_remaining -= recv_len;
+		queue->data_remaining -= ret;
+		if (queue->data_remaining)
+			nvme_tcp_advance_req(req, ret);
 	}
 
 	if (!queue->data_remaining) {
@@ -833,27 +836,36 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		}
 	}
 
-	return 0;
+	return queue->data_remaining;
 }
 
-static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
-		struct sk_buff *skb, unsigned int *offset, size_t *len)
+static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
 	char *ddgst = (char *)&queue->recv_ddgst;
-	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
+	size_t recv_len = queue->ddgst_remaining;
 	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
+	struct msghdr msg = {
+		.msg_flags = 0,
+	};
+	struct kvec iov = {
+		.iov_base = (u8 *)ddgst + off,
+		.iov_len = recv_len,
+	};
 	int ret;
 
-	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
-	if (unlikely(ret))
+	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DDGST)
+		return 0;
+
+	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1, iov.iov_len,
+			     msg.msg_flags);
+	if (ret <= 0)
 		return ret;
 
+	recv_len = ret;
 	queue->ddgst_remaining -= recv_len;
-	*offset += recv_len;
-	*len -= recv_len;
 	if (queue->ddgst_remaining)
-		return 0;
+		return queue->ddgst_remaining;
 
 	if (queue->recv_ddgst != queue->exp_ddgst) {
 		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
@@ -881,37 +893,41 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	return 0;
 }
 
-static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
-			     unsigned int offset, size_t len)
+static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue, bool pending)
 {
-	struct nvme_tcp_queue *queue = desc->arg.data;
-	size_t consumed = len;
 	int result;
+	int nr_cqe = queue->nr_cqe;
 
-	while (len) {
+	do {
 		switch (nvme_tcp_recv_state(queue)) {
 		case NVME_TCP_RECV_PDU:
-			result = nvme_tcp_recv_pdu(queue, skb, &offset, &len);
-			break;
+			result = nvme_tcp_recv_pdu(queue, pending);
+			if (result)
+				break;
+			fallthrough;
 		case NVME_TCP_RECV_DATA:
-			result = nvme_tcp_recv_data(queue, skb, &offset, &len);
-			break;
+			result = nvme_tcp_recv_data(queue);
+			if (result)
+				break;
+			fallthrough;
 		case NVME_TCP_RECV_DDGST:
-			result = nvme_tcp_recv_ddgst(queue, skb, &offset, &len);
+			result = nvme_tcp_recv_ddgst(queue);
 			break;
 		default:
 			result = -EFAULT;
 		}
-		if (result) {
-			dev_err(queue->ctrl->ctrl.device,
-				"receive failed:  %d\n", result);
-			queue->rd_enabled = false;
-			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
-			return result;
-		}
+		if (nr_cqe != queue->nr_cqe)
+			break;
+	} while (result >= 0);
+	if (result < 0 && result != -EAGAIN) {
+		dev_err(queue->ctrl->ctrl.device,
+			"receive failed: %d state %d %s\n",
+			result, nvme_tcp_recv_state(queue),
+			pending ? "pending" : "");
+		queue->rd_enabled = false;
+		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
 	}
-
-	return consumed;
+	return result < 0 ? result : (queue->nr_cqe - nr_cqe);
 }
 
 static void nvme_tcp_data_ready(struct sock *sk)
@@ -1203,22 +1219,6 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 	return ret;
 }
 
-static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
-{
-	struct socket *sock = queue->sock;
-	struct sock *sk = sock->sk;
-	read_descriptor_t rd_desc;
-	int consumed;
-
-	rd_desc.arg.data = queue;
-	rd_desc.count = 1;
-	lock_sock(sk);
-	queue->nr_cqe = 0;
-	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
-	release_sock(sk);
-	return consumed;
-}
-
 static void nvme_tcp_io_work(struct work_struct *w)
 {
 	struct nvme_tcp_queue *queue =
@@ -1232,13 +1232,11 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		if (mutex_trylock(&queue->send_mutex)) {
 			result = nvme_tcp_try_send(queue);
 			mutex_unlock(&queue->send_mutex);
-			if (result > 0)
-				pending = true;
-			else if (unlikely(result < 0))
+			if (unlikely(result < 0))
 				break;
 		}
 
-		result = nvme_tcp_try_recv(queue);
+		result = nvme_tcp_try_recv(queue, pending);
 		if (result > 0)
 			pending = true;
 		else if (unlikely(result < 0))
@@ -2491,7 +2489,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
 	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queue))
 		sk_busy_loop(sk, true);
-	nvme_tcp_try_recv(queue);
+	nvme_tcp_try_recv(queue, false);
 	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
 	return queue->nr_cqe;
 }
-- 
2.35.3


