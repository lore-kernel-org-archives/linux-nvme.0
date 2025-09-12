Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B0DCA101F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Sep 2025 11:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QxlHj0u0+W2WRSSQtrdcVvdckvFKHGWm6ExU9JdBQHM=; b=PszSzO2/IjWt5F/MY4cu8gRCMu
	r2ttKyAp+BGT/hFrA7bontyBSj/3kTmpZMcLDNiFq4ZfUqSAs9FldZxAxya4Grb9vf4yStedF7dDX
	BVApeEliJubaZT+tuiBznkf0Qp89mRppuGEX+2RyFL3HRMmoO6bd0EOULMesnMpLOS5cVL7u8dqG8
	3AGkkhu0o2t/orKnZln6Aos2ZQP2rN3mtqT/0Fv6DGpcegOZJVfDdOrP8Fa940djFsSVHxnKoRgp0
	DEmjR8xbfmX9I9JbShlTEHFm2bsLIerSGyo0PcoeHxN3MQ1882Sa5yX+rJvgf+MFfyUy1R+xYb3Rq
	eotNqbXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux2QO-000000092BN-3Y5J;
	Fri, 12 Sep 2025 11:58:44 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux2QM-0000000929q-0uBu
	for linux-nvme@lists.infradead.org;
	Fri, 12 Sep 2025 11:58:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2C56544216;
	Fri, 12 Sep 2025 11:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B6CC4CEF1;
	Fri, 12 Sep 2025 11:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678321;
	bh=x4zWndgCW0WD5Z2wdbOHPvh7K2eQP2N+LOI6+/gJblo=;
	h=From:To:Cc:Subject:Date:From;
	b=nRpeCJBp5KrSKwxdsHnQdj9La8rbpIZGi5Tpd8aMN1bpyIuHg5p+j/v/lziemd22/
	 eIKp8aLSGV5Wwnm03XcxGblCGeodEqKk5sb+sJWvsbFdeLEC+Ru9U1OvpUsLGYumED
	 7+rRW8jfpnDOQAwjvZiRBu2BH9WRDE6hkU+HtOFH22PpjRZWLx/vusH8JDmVQX8rJx
	 LXWdxnOydjthZB8RJnAE5VOK+PMJw5yUCURied6GDLgBvn3fNzlRAO21MnkNZnHcAn
	 4zO8dDlIVwbCx1iKMsU064gebFrBSoIjXxg9y0IfctHMaeiC/GeTNsQ9fyjjj1Fjxu
	 csr3IeNaM7bRg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Alistair Francis <alistair.francis@wdc.com>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH RFC] nvme-tcp: Implement recvmsg() receive flow
Date: Fri, 12 Sep 2025 13:58:29 +0200
Message-ID: <20250912115829.58669-1-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_045842_299228_4AE1DBAB 
X-CRM114-Status: GOOD (  19.60  )
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

Switch to use recvmsg() so that we get access to TLS control
messages eg for handling TLS KeyUpdate.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 204 ++++++++++++++++++++++------------------
 1 file changed, 111 insertions(+), 93 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c0fe8cfb7229..9ef1d4aea838 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -17,6 +17,7 @@
 #include <net/tls_prot.h>
 #include <net/handshake.h>
 #include <linux/blk-mq.h>
+#include <linux/iov_iter.h>
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
 
@@ -476,6 +477,28 @@ static inline void nvme_tcp_ddgst_update(u32 *crcp,
 	}
 }
 
+static size_t nvme_tcp_ddgst_step(void *iter_base, size_t progress, size_t len,
+				  void *priv, void *priv2)
+{
+	u32 *crcp = priv;
+
+	*crcp = crc32c(*crcp, iter_base, len);
+        return 0;
+}
+
+static int nvme_tcp_ddgst_calc(struct nvme_tcp_request *req, u32 *crcp,
+			       size_t maxsize)
+{
+	struct iov_iter tmp = req->iter;
+	int err = 0;
+
+	tmp.count = maxsize;
+	if (iterate_and_advance_kernel(&tmp, maxsize, crcp, &err,
+				       nvme_tcp_ddgst_step) != maxsize)
+		return err;
+	return 0;
+}
+
 static inline __le32 nvme_tcp_ddgst_final(u32 crc)
 {
 	return cpu_to_le32(~crc);
@@ -827,23 +850,26 @@ static void nvme_tcp_handle_c2h_term(struct nvme_tcp_queue *queue,
 		"Received C2HTermReq (FES = %s)\n", msg);
 }
 
-static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
-		unsigned int *offset, size_t *len)
+static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
 {
-	struct nvme_tcp_hdr *hdr;
 	char *pdu = queue->pdu;
-	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
+	struct msghdr msg = {
+		.msg_flags = MSG_DONTWAIT,
+	};
+	struct kvec iov = {
+		.iov_base = pdu + queue->pdu_offset,
+		.iov_len = queue->pdu_remaining,
+	};
+	struct nvme_tcp_hdr *hdr;
 	int ret;
 
-	ret = skb_copy_bits(skb, *offset,
-		&pdu[queue->pdu_offset], rcv_len);
-	if (unlikely(ret))
+	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
+			     iov.iov_len, msg.msg_flags);
+	if (ret <= 0)
 		return ret;
 
-	queue->pdu_remaining -= rcv_len;
-	queue->pdu_offset += rcv_len;
-	*offset += rcv_len;
-	*len -= rcv_len;
+	queue->pdu_remaining -= ret;
+	queue->pdu_offset += ret;
 	if (queue->pdu_remaining)
 		return 0;
 
@@ -907,20 +933,19 @@ static inline void nvme_tcp_end_request(struct request *rq, u16 status)
 		nvme_complete_rq(rq);
 }
 
-static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
-			      unsigned int *offset, size_t *len)
+static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
 	struct request *rq =
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
-	while (true) {
-		int recv_len, ret;
+	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DATA)
+		return 0;
 
-		recv_len = min_t(size_t, *len, queue->data_remaining);
-		if (!recv_len)
-			break;
+	while (queue->data_remaining) {
+		struct msghdr msg;
+		int ret;
 
 		if (!iov_iter_count(&req->iter)) {
 			req->curr_bio = req->curr_bio->bi_next;
@@ -940,25 +965,22 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		}
 
 		/* we can read only from what is left in this bio */
-		recv_len = min_t(size_t, recv_len,
-				iov_iter_count(&req->iter));
+		memset(&msg, 0, sizeof(msg));
+		msg.msg_iter = req->iter;
+		msg.msg_flags = MSG_DONTWAIT;
 
-		if (queue->data_digest)
-			ret = skb_copy_and_crc32c_datagram_iter(skb, *offset,
-				&req->iter, recv_len, &queue->rcv_crc);
-		else
-			ret = skb_copy_datagram_iter(skb, *offset,
-					&req->iter, recv_len);
-		if (ret) {
+		ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
+		if (ret < 0) {
 			dev_err(queue->ctrl->ctrl.device,
-				"queue %d failed to copy request %#x data",
+				"queue %d failed to receive request %#x data",
 				nvme_tcp_queue_id(queue), rq->tag);
 			return ret;
 		}
-
-		*len -= recv_len;
-		*offset += recv_len;
-		queue->data_remaining -= recv_len;
+		if (queue->data_digest)
+			nvme_tcp_ddgst_calc(req, &queue->rcv_crc, ret);
+		queue->data_remaining -= ret;
+		if (queue->data_remaining)
+			nvme_tcp_advance_req(req, ret);
 	}
 
 	if (!queue->data_remaining) {
@@ -968,7 +990,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		} else {
 			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
 				nvme_tcp_end_request(rq,
-						le16_to_cpu(req->status));
+						     le16_to_cpu(req->status));
 				queue->nr_cqe++;
 			}
 			nvme_tcp_init_recv_ctx(queue);
@@ -978,24 +1000,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	return 0;
 }
 
-static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
-		struct sk_buff *skb, unsigned int *offset, size_t *len)
+static int __nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
-	char *ddgst = (char *)&queue->recv_ddgst;
-	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
-	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
-	int ret;
-
-	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
-	if (unlikely(ret))
-		return ret;
-
-	queue->ddgst_remaining -= recv_len;
-	*offset += recv_len;
-	*len -= recv_len;
-	if (queue->ddgst_remaining)
-		return 0;
 
 	if (queue->recv_ddgst != queue->exp_ddgst) {
 		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
@@ -1023,40 +1030,32 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	return 0;
 }
 
-static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
-			     unsigned int offset, size_t len)
+static int nvme_tcp_recvmsg_ddgst(struct nvme_tcp_queue *queue)
 {
-	struct nvme_tcp_queue *queue = desc->arg.data;
-	size_t consumed = len;
-	int result;
+	char *ddgst = (char *)&queue->recv_ddgst;
+	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
+	struct msghdr msg = {
+		.msg_flags = MSG_WAITALL,
+	};
+	struct kvec iov = {
+		.iov_base = (u8 *)ddgst + off,
+		.iov_len = queue->ddgst_remaining,
+	};
+	int ret;
 
-	if (unlikely(!queue->rd_enabled))
-		return -EFAULT;
+	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DDGST)
+		return 0;
 
-	while (len) {
-		switch (nvme_tcp_recv_state(queue)) {
-		case NVME_TCP_RECV_PDU:
-			result = nvme_tcp_recv_pdu(queue, skb, &offset, &len);
-			break;
-		case NVME_TCP_RECV_DATA:
-			result = nvme_tcp_recv_data(queue, skb, &offset, &len);
-			break;
-		case NVME_TCP_RECV_DDGST:
-			result = nvme_tcp_recv_ddgst(queue, skb, &offset, &len);
-			break;
-		default:
-			result = -EFAULT;
-		}
-		if (result) {
-			dev_err(queue->ctrl->ctrl.device,
-				"receive failed:  %d\n", result);
-			queue->rd_enabled = false;
-			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
-			return result;
-		}
-	}
+	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1, iov.iov_len,
+			     msg.msg_flags);
+	if (ret <= 0)
+		return ret;
+
+	queue->ddgst_remaining -= ret;
+	if (queue->ddgst_remaining)
+		return 0;
 
-	return consumed;
+	return __nvme_tcp_recv_ddgst(queue);
 }
 
 static void nvme_tcp_data_ready(struct sock *sk)
@@ -1353,20 +1352,39 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 	return ret;
 }
 
-static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
+static int nvme_tcp_try_recvmsg(struct nvme_tcp_queue *queue)
 {
-	struct socket *sock = queue->sock;
-	struct sock *sk = sock->sk;
-	read_descriptor_t rd_desc;
-	int consumed;
+	int result;
+	int nr_cqe = queue->nr_cqe;
+
+	if (unlikely(!queue->rd_enabled))
+		return -EFAULT;
+
+	do {
+		switch (nvme_tcp_recv_state(queue)) {
+		case NVME_TCP_RECV_PDU:
+			result = nvme_tcp_recvmsg_pdu(queue);
+			break;
+		case NVME_TCP_RECV_DATA:
+			result = nvme_tcp_recvmsg_data(queue);
+			break;
+		case NVME_TCP_RECV_DDGST:
+			result = nvme_tcp_recvmsg_ddgst(queue);
+			break;
+		default:
+			result = -EFAULT;
+		}
+	} while (result >= 0);
+
+	if (result < 0 && result != -EAGAIN) {
+		dev_err(queue->ctrl->ctrl.device,
+			"receive failed:  %d\n", result);
+		queue->rd_enabled = false;
+		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+	} else if (result == -EAGAIN)
+		result = 0;
 
-	rd_desc.arg.data = queue;
-	rd_desc.count = 1;
-	lock_sock(sk);
-	queue->nr_cqe = 0;
-	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
-	release_sock(sk);
-	return consumed == -EAGAIN ? 0 : consumed;
+	return result < 0 ? result : (queue->nr_cqe = nr_cqe);
 }
 
 static void nvme_tcp_io_work(struct work_struct *w)
@@ -1388,7 +1406,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
 				break;
 		}
 
-		result = nvme_tcp_try_recv(queue);
+		result = nvme_tcp_try_recvmsg(queue);
 		if (result > 0)
 			pending = true;
 		else if (unlikely(result < 0))
@@ -2794,7 +2812,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
 	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queue))
 		sk_busy_loop(sk, true);
-	ret = nvme_tcp_try_recv(queue);
+	ret = nvme_tcp_try_recvmsg(queue);
 	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
 	return ret < 0 ? ret : queue->nr_cqe;
 }
-- 
2.43.0


