Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2E9606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MQ/OIUsc;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+qmVark
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=g1DyGkyDGRDjdyk7k2OT1dz5YFqdzU/onJ7y5KX0eMs=; b=MQ/OIUsclMugBp
	O+S4JJKn0oZQz0Vc5DpmLw4/r2CiLHKRG/d/8EyZLwgEz3+5HNnJtNEcsXLh9jDE0zkxgksOOQfsq
	e8vtHhypNjqjtgVbZusb3W+phXoSKxNqIYHorh0M3JflRy2hjIhMD7daBH//WQu6WbVEKA0WmOSOx
	epi27+Ok1RVuMucuCLe5+rp1bPYQTLEwDK66VzVqDTJZ1+kzhdCYdMo2ocGmAt2ZHbhYqrVT3873K
	tKWNKA0l5wAX2xzbEraL0CoFIzNOMIMvYcP/6uoX0yIFHAt7zmXQnW/07pVOKfQvVjMuDTSKH+H93
	qFwGuLohL3H0v/kCI7fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLP8q-000000032cR-0b7e;
	Mon, 26 Oct 2026 18:09:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLP8o-000000032c9-1gZr
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 18:09:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DAC21439A3;
	Mon, 26 Oct 2026 18:09:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793038189;
	b=RX7NG32NI2DoaaiceKS0mqgIfzZFi+6mZuisany2u1FCR3RkdkweEOnY1nuKJTumz/wL
	 vhDLoL05XpwkpgiqC1g2k3TJTlqK7CvBObjLsCeTwjRVeE1Tq2oRv3GgTNpX+tuSezn0+
	 7Nyo470HYeJ47NthY4s/XvQ6CsURznoo5Qr/D1P3BtvSyQ0JIdOt+AjbuTJ+gJlVOS/1Q
	 4n1u1/AjXplLOvuCPRwu87xniZE/zAEnuBx4Znyyhz0ymD4TuD+75sFF19tyFCpLelbI+
	 2TI8Ib/Hidj2rtfM1it/g6K/+cfupnQ7sBQ21joWkmEb5G3AHca6GXpziEg3h6PaZ2w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793038189;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=g1DyGkyDGRDjdyk7k2OT1dz5YFqdzU/onJ7y5KX0eMs=;
	b=LyFMdw9h5ty0hviRRW4KxktWmTwE++kaNwDEb3BhQWd7dIoRcEyhYUDuR1cuICNJrkYn
	 TEwJ54zaYfSfnmRfRTlj1YUINYwDWD/OpopZwdfhewcRLt+F4FmE+TNyaslOG2GAUZzY+
	 LIqxwzDTQbUPeEk2siYYPc95+lxqzfFTUQTQ7h24oPs0SxaYJh69vYL6y7cnLdLVoxR6B
	 31lew6MiE4kRhifD6UjUIgY3cVoA34wKCAzDyilg1eEc7F3DyaqOCr35sUFcBg8PSvPqj
	 HOyvlYG8GSixapzbSMIuerJOANHzwHrf1THr2LAjFaNweLyF1aq1lXfIqAcalyW+VwA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C2F971F01828;
	Mon, 26 Oct 2026 18:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793038189;
	bh=g1DyGkyDGRDjdyk7k2OT1dz5YFqdzU/onJ7y5KX0eMs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=O+qmVarkgLLGc3emsPKWxxztkvC9UdinvayxyW/Mn0axNXBs545Ex54dtKIbRKcYF
	 0lt4X1vV3vHzmf9apgi4I2uEoRdn+89aLYsnLPMTN4tBmdejETyQwWno+v/suNhyUH
	 ebTf43Q2soKT2mKZVOk+rocsDHg4f7BOo4CvQaNn705x/IltaKdgUrqGDxSPo31ee7
	 k/Ynievk2WMDT7SuLcAwZweyfWVMYOvOP+IjFxpN1h2KzGRvTSIN/fPjTgxFhE3ydu
	 39Ymjydgmj+j6gy0jJ932rhvADnB2UxkF/pYvvg3qdIvBVZ0fUCZ9wZpZfPVtJypuP
	 WZIhzDosj7hAw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4159F44E24;
	Mon, 26 Oct 2026 18:09:48 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Mon, 26 Oct 2026 14:09:45 -0400
Subject: [PATCH 2/2] nvme-tcp: skip TLS control records while waiting for
 the ICResp
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-nvme-tcp-ctrlrec-fixes-v1-2-ebf6ff7eff34@gmail.com>
References: <20261026-nvme-tcp-ctrlrec-fixes-v1-0-ebf6ff7eff34@gmail.com>
In-Reply-To: <20261026-nvme-tcp-ctrlrec-fixes-v1-0-ebf6ff7eff34@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Martin Belanger <martin.belanger@dell.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793038187; l=6652;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=EUPPHH0ueJSjw1+R4uzRq/kCNtZGOAasE74AcsJ584o=;
 b=bwpHw7IqFCCc9ZtBMGu9z1lfEGPkRKxugyCtKTPF6milVX37AbXIJUiz84mMmr4ySepWEsJFz
 voMx/wG/52hBSp02qhG9UE4E0pbM2l2absO24clNLTl+pOner3a4Dm5
X-Developer-Key: i=martin.nvme.dev@gmail.com; a=ed25519;
 pk=4K+XXetGK35w2LzRRddd/bbHawZU222BN+YZRuSpN+k=
X-Endpoint-Received: by B4 Relay for martin.nvme.dev@gmail.com/20261014
 with auth_id=1176
X-Original-From: Martin Belanger <martin.nvme.dev@gmail.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: martin.nvme.dev@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Martin Belanger <martin.belanger@dell.com>

A peer may send a NewSessionTicket as soon as the handshake completes,
ahead of the ICResp. nvme_tcp_init_connection() fails the connection on
any record that is not application data, so such a target cannot be
reached at all. An OpenSSL-based target does this by default.

Discard such a record and read again, up to a fixed number of records.
Report an alert, and fail the connection for any other record type.

The record type is now checked before the length. A control record
shorter than the ICResp was reported as -ECONNRESET, which hid the real
cause.

Fixes: 2837966ab2a8 ("nvme-tcp: control message handling for recvmsg()")
Assisted-by: LLM
Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/nvme/host/tcp.c | 157 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 135 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a03476f0f69d..2d361a9e8710 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -55,6 +55,12 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 		 "nvme TLS handshake timeout in seconds (default 10)");
 #endif
 
+/* read a TLS control record in chunks of this size */
+#define NVME_TCP_TLS_REC_CHUNK 256
+
+/* TLS records read while waiting for the ICResp, the ICResp included */
+#define NVME_TCP_ICRESP_MAX_RECORDS 8
+
 static int nvme_tcp_cpu_queues[NR_CPUS];
 static DEFINE_SPINLOCK(nvme_tcp_cpu_queues_lock);
 
@@ -1548,12 +1554,138 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	mutex_destroy(&queue->pf_cache_lock);
 }
 
+static int nvme_tcp_recv_tls_alert(struct nvme_tcp_queue *queue,
+				   struct msghdr *msg, int len)
+{
+	struct sock *sk = queue->sock->sk;
+	u8 level, description;
+
+	if (len < 2) {
+		dev_err(queue->ctrl->ctrl.device,
+			"queue %d: truncated TLS alert\n",
+			nvme_tcp_queue_id(queue));
+		return -ENOTCONN;
+	}
+
+	/* tls_alert_recv() reads through the iterator */
+	iov_iter_revert(&msg->msg_iter, len);
+	tls_alert_recv(sk, msg, &level, &description);
+
+	if (level == TLS_ALERT_LEVEL_FATAL) {
+		dev_err(queue->ctrl->ctrl.device,
+			"queue %d: fatal TLS alert %u\n",
+			nvme_tcp_queue_id(queue), description);
+		return -ENOTCONN;
+	}
+
+	/* a peer shutting down normally is not worth a warning */
+	if (description == TLS_ALERT_DESC_CLOSE_NOTIFY)
+		dev_dbg(queue->ctrl->ctrl.device,
+			"queue %d: TLS close_notify\n",
+			nvme_tcp_queue_id(queue));
+	else
+		dev_warn(queue->ctrl->ctrl.device,
+			 "queue %d: TLS alert %u\n",
+			 nvme_tcp_queue_id(queue), description);
+
+	return 0;
+}
+
+/*
+ * Discard a TLS record that arrived in place of the ICResp. A peer may send
+ * a NewSessionTicket as soon as the handshake completes.
+ *
+ * Returns 0 when the record was discarded and the ICResp can be read, or a
+ * negative errno if the connection cannot continue.
+ */
+static int nvme_tcp_skip_tls_record(struct nvme_tcp_queue *queue,
+				    struct msghdr *msg, u8 ctype, int len)
+{
+	u8 buf[NVME_TCP_TLS_REC_CHUNK];
+	int ret;
+
+	switch (ctype) {
+	case TLS_RECORD_TYPE_HANDSHAKE:
+		break;
+	case TLS_RECORD_TYPE_ALERT:
+		ret = nvme_tcp_recv_tls_alert(queue, msg, len);
+		return ret ? : -ENOTCONN;
+	default:
+		pr_err("queue %d: unhandled TLS record %u\n",
+		       nvme_tcp_queue_id(queue), ctype);
+		return -ENOTCONN;
+	}
+
+	/* the ICResp is in a later record, drain this one first */
+	while (!(msg->msg_flags & MSG_EOR)) {
+		struct kvec iov = {
+			.iov_base = buf,
+			.iov_len = sizeof(buf),
+		};
+		struct msghdr drain = {};
+
+		ret = kernel_recvmsg(queue->sock, &drain, &iov, 1, sizeof(buf),
+				     0);
+		if (ret <= 0) {
+			pr_warn("queue %d: failed to drain TLS record: %d\n",
+				nvme_tcp_queue_id(queue), ret);
+			return ret ? : -ECONNRESET;
+		}
+		msg->msg_flags = drain.msg_flags;
+	}
+
+	return 0;
+}
+
+/*
+ * Receive the ICResp. Over TLS, skip the records that a peer may send
+ * ahead of it.
+ *
+ * Returns the length received, or a negative errno.
+ */
+static int nvme_tcp_recv_icresp(struct nvme_tcp_queue *queue,
+				struct nvme_tcp_icresp_pdu *icresp)
+{
+	char cbuf[CMSG_LEN(sizeof(char))];
+	struct msghdr msg;
+	struct kvec iov;
+	u8 ctype;
+	int i, ret;
+
+	for (i = 0; i < NVME_TCP_ICRESP_MAX_RECORDS; i++) {
+		memset(&msg, 0, sizeof(msg));
+		memset(cbuf, 0, sizeof(cbuf));
+		iov.iov_base = icresp;
+		iov.iov_len = sizeof(*icresp);
+		if (nvme_tcp_queue_tls(queue)) {
+			msg.msg_control = cbuf;
+			msg.msg_controllen = sizeof(cbuf);
+		}
+		msg.msg_flags = MSG_WAITALL;
+		ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
+				     iov.iov_len, msg.msg_flags);
+		if (ret < 0 || !nvme_tcp_queue_tls(queue))
+			return ret;
+
+		ctype = tls_get_record_type(queue->sock->sk,
+					    (struct cmsghdr *)cbuf);
+		if (ctype == TLS_RECORD_TYPE_DATA)
+			return ret;
+
+		ret = nvme_tcp_skip_tls_record(queue, &msg, ctype, ret);
+		if (ret < 0)
+			return ret;
+	}
+
+	pr_err("queue %d: too many TLS records before the ICResp\n",
+	       nvme_tcp_queue_id(queue));
+	return -EPROTO;
+}
+
 static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_icreq_pdu *icreq;
 	struct nvme_tcp_icresp_pdu *icresp;
-	char cbuf[CMSG_LEN(sizeof(char))] = {};
-	u8 ctype;
 	struct msghdr msg = {};
 	struct kvec iov;
 	bool ctrl_hdgst, ctrl_ddgst;
@@ -1591,16 +1723,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 		goto free_icresp;
 	}
 
-	memset(&msg, 0, sizeof(msg));
-	iov.iov_base = icresp;
-	iov.iov_len = sizeof(*icresp);
-	if (nvme_tcp_queue_tls(queue)) {
-		msg.msg_control = cbuf;
-		msg.msg_controllen = sizeof(cbuf);
-	}
-	msg.msg_flags = MSG_WAITALL;
-	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
-			iov.iov_len, msg.msg_flags);
+	ret = nvme_tcp_recv_icresp(queue, icresp);
 	if (ret >= 0 && ret < sizeof(*icresp))
 		ret = -ECONNRESET;
 	if (ret < 0) {
@@ -1608,16 +1731,6 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 			nvme_tcp_queue_id(queue), ret);
 		goto free_icresp;
 	}
-	ret = -ENOTCONN;
-	if (nvme_tcp_queue_tls(queue)) {
-		ctype = tls_get_record_type(queue->sock->sk,
-					    (struct cmsghdr *)cbuf);
-		if (ctype != TLS_RECORD_TYPE_DATA) {
-			pr_err("queue %d: unhandled TLS record %d\n",
-			       nvme_tcp_queue_id(queue), ctype);
-			goto free_icresp;
-		}
-	}
 	ret = -EINVAL;
 	if (icresp->hdr.type != nvme_tcp_icresp) {
 		pr_err("queue %d: bad type returned %d\n",

-- 
2.53.0



