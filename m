Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077E7606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=b/g/pFCi;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GCRK9IK2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=cfk4OSkWDWN76rpf/j4iJRJATWOuTCVb6dMEhWv/eGg=; b=b/g/pFCikz9ILdvd7x3VeC/X0X
	PWAkx+7kAA4aVAmQjKkbzBFjlD3pmbjNoei1GciHvi6jYChwT5olLWQObUpcg9l8HUKqTyt4OSsnh
	Rx0SLmjz9i07wOnLFaXFzGWegu/JDK3wu5oQqx7Au3KlkKgDDu9+GJRKeZLMq1w9JsjnaR94Eh2RE
	4XlovAAclUSJmnJCaG30avF/mF8mDamNUb7j/0NN+PXIGdKICGlG3m1vz4dtM7TefX/jOo08Emp4G
	+sUF4QNHBbxUFCqoW2fQuOvafJRLiNeq2VEOG4PRBspgPCiRq6VN8u4YjB8YkFmk2Hjwv5xQLVQS7
	3J9ra3cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xREpA-00000007c69-1skk;
	Wed, 11 Nov 2026 20:21:40 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xREp9-00000007c5z-0Amo
	for linux-nvme@lists.infradead.org;
	Wed, 11 Nov 2026 20:21:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 21B686182C;
	Wed, 11 Nov 2026 20:21:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794428497;
	b=WtPlCptVuxGT4+Edd4kyAVYY8ltdeFgAoItH+Zgbaqk9B5gm7BpvTk9B1jWf9992py5x
	 qn2WLXsQOOyL8q0Xwk2CWQ4ME5sFdOOQZLPuTwRfmMVFyMwzYY7Htuwfn0motm4f5aKO+
	 rj8kOKRQGJj3z0CxHubJyoFpt3f7dqVvCC/o8XIn2jgfob531Pm/r/pTjeacSnq6EgrfE
	 yH6kM2E5ByfC2zKARiJuPzxtSbnyAe6mLCPBCYQUjmtMPqGRAQzeDyOd7ISpk3+i6TT/V
	 wRPelf7jawlDdP39X5LexGrdLMekDMD/rvRVTVZcrCiZ7dOa6H91R/Fa95pbppwQOHA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794428497;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=cfk4OSkWDWN76rpf/j4iJRJATWOuTCVb6dMEhWv/eGg=;
	b=igPYUqngK+d7HRfcfDOZa9FdiQ/3YYhLfyCgIodh+s0F0GcTlYWKYgUHaXBAxa7BTODe
	 rjs4lkQ+yGx7jEIWm9gFtLZPK+mVK6MNdTbg4loxjzPDgnbpg0kaFcrrZEUrMrIBG8CDO
	 2ZEsLHuWpwngOGSuYmkrThvNm+yp3YPeAf5GoGQ8MYNFpVSIvOUSoB+rlFeoEeH2CzpB5
	 u7qCbhbnRWgSo4QRDeGOtBOb90UlXLVUa9yuBXvXJaOS05yhrlnmt8AvCzIpPMqycqN2M
	 19eg8bYeITg0TXnlxvSnH9QubjwtA1fGoqjEZshd5dDVWuGTusJqlRIR53yQoA0QWbQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2B03F1F00A05;
	Wed, 11 Nov 2026 20:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794428497;
	bh=cfk4OSkWDWN76rpf/j4iJRJATWOuTCVb6dMEhWv/eGg=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=GCRK9IK2uoipHQEr/bwJceKAbCfdASB+AyhBsT0hfMUFYOxiR03mHABIwS9HwWjBp
	 3BvzA5U9Z5ftA1FDiOAnMztEIdlqcCnHKMWFROjXdnJ6R7pjjBYOPho2wKLEeFKkyL
	 yzha7Blp02/CHGohLzI92Wi3Df3kqZxfQ/PQI7HpRxlWDzmtFMeDCLEEwFjmT0gpqw
	 XTFUnvIXhXDCvZ5Es6gsriKwhD/lJ97FR/RUvD430Yt2cmx2QWViQHdMlNXFu3baDd
	 6U9cANVNVVOpb84eodIbypby2vZJSRjgm/MqYdSOSaj9T872QWgrQsfzlbzMCkZjkq
	 1in9ESwXDmToQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A8CD1490E5;
	Wed, 11 Nov 2026 20:21:36 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 15:21:34 -0500
Subject: [PATCH 6.12.y] nvme-tcp: skip TLS control records while waiting
 for the ICResp
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-icresp-stable-6-12-v1-1-d0b44764f745@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0Q6CMBAEf4Xcs0fsRQvhV4wPtG71DAHSQ6Mh/
 LtV9202mVnJkBVGXbVSxlNNp7GA21UUb/14BeulMMlevCtjjRk2sy19GMCenXBzOCK0knxMDRV
 xzkj6+kVP5Gsn9ZvO/98e4Y64fIu0bR90FmDAfgAAAA==
X-Change-ID: 20261111-icresp-stable-6-12-745eb82f6cf7
To: stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Martin Belanger <martin.nvme.dev@gmail.com>, linux-nvme@lists.infradead.org, 
 Hannes Reinecke <hare@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Jens Axboe <axboe@kernel.dk>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794428496; l=7593;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=a6B0KKV/akMjIUlylU413V+vvxVF5j8imkqly0d087A=;
 b=7XyOU2Zr0DC4wC/ojBdxfx+1y8bFMvEGvitA72aClDW7KkF+4uSWewsZ3dHfFAI3Y4Qy+/hW0
 9U5EEYnAJNWChyEKfLrcikZYx6tfrFdwGlS/ltW3rQG0NYqA7KfY7tm
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Martin Belanger <martin.belanger@dell.com>

commit 12c20e2903563acfb949342967adb900310a24d4 upstream.

A peer may send a NewSessionTicket as soon as the handshake completes,
ahead of the ICResp. nvme_tcp_init_connection() fails the connection on
any record that is not application data, so such a target cannot be
reached at all. An OpenSSL-based target does this by default.

RFC 9846 section 4.7.1 requires a client that does not support session
resumption to ignore a NewSessionTicket. Discard such a record and read
again, up to a fixed number of records. Report an alert, and fail the
connection for any other record type.

The record type is now checked before the length. A control record
shorter than the ICResp was reported as -ECONNRESET, which hid the real
cause.

Fixes: 2837966ab2a8 ("nvme-tcp: control message handling for recvmsg()")
Assisted-by: LLM
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin Belanger <martin.belanger@dell.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ Martin: resolved a context conflict next to nvme_tcp_cpu_queues ]
Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
Upstream has no Cc: stable. Tested on v6.12.117: NewSessionTickets of 64
to 1000 bytes ahead of the ICResp now connect; without the patch the
connect fails.
---
 drivers/nvme/host/tcp.c | 162 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 140 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 67d02cfb47ec..7c1ebac54a50 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -54,6 +54,12 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 		 "nvme TLS handshake timeout in seconds (default 10)");
 #endif
 
+/* read a TLS control record in chunks of this size */
+#define NVME_TCP_TLS_REC_CHUNK 256
+
+/* TLS records read while waiting for the ICResp, the ICResp included */
+#define NVME_TCP_ICRESP_MAX_RECORDS 8
+
 static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -1562,12 +1568,143 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
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
+		char cbuf[CMSG_LEN(sizeof(char))] = {};
+		/* kTLS fails a control record read without a cmsg buffer */
+		struct msghdr drain = {
+			.msg_control = cbuf,
+			.msg_controllen = sizeof(cbuf),
+		};
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
+		if (ret <= 0 || !nvme_tcp_queue_tls(queue))
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
@@ -1605,16 +1742,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
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
@@ -1622,16 +1750,6 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
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

---
base-commit: d3417611a3b40b7f04a29e558cebac2bf69889d7
change-id: 20261111-icresp-stable-6-12-745eb82f6cf7

Best regards,
--  
Martin Belanger <martin.nvme.dev@gmail.com>



