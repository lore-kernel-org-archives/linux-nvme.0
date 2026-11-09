Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE0460A5BDF
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HNHevVr1;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gY+VfllG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=P2fmqmmprCAGOSYykgJw6VD4J+cu5F8pWWrtYwCx08s=; b=HNHevVr1bAuYGf
	6xkd+TDUpNtB96FARCelwJ3vPJystfj2p4vLOmtX7YvrJwhutLDqtGXLSOqSmjKXDYkDxEJ4qmjiN
	zuoH18AnvYOf+AaPWSmsweMQh9wEwWDWDGpYMOGEl3qvRA0KO4DsZ35aLlZstRqJtgrrEXt8pB425
	PRzo//ycyKJPhrg9WAWopEH/Xbwll+xUhhBDqQO0JraggZi+LJRbfz8SufLSgaPOS1XiZWWqWDBGp
	88CXy3azI5N0LXeszKEeHvEv6blhAta/kLSst1Fg4o6jHTnUIYCoeMy3BwLa4DK0eo0BvEIxSm43y
	LYSh0hWBZzRp+XmzQaEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQUft-00000001Vu3-3UI4;
	Mon, 09 Nov 2026 19:05:01 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQUfs-00000001VtI-0nu7
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 19:05:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 522A963294;
	Mon,  9 Nov 2026 19:04:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794251099;
	b=ahhBkNHL9kK2sZzL73nrzaU3x5udFFjiFSkLC+BsM7OgCJGEEbIXWyGvvOfhgr99QMCb
	 yn0ZtnEphq1HLMtmLMj3RXrACxhJWAFJchhNbBNXq2LvmrvYcmKlal/DnW/CyYBEh+Oc1
	 NEi7spPuI6osQz0cmjb+hRMhFsNHGSzz/Fyd2Zp4t4LYoZTLZWDN8xLVwXG68NGI3ieOc
	 V7B3UST8c8epxsN9/GWeEUa7lVBeCyerJchGGTCf6F0g25OWnwj79qVpjm/XKAR9ux9EA
	 BxEje3N81FRuHAuLl/04XGo2LfLGhqcom0p0DO11AAQHwADEa6EunN2Sewq0x9lyPpQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794251099;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=P2fmqmmprCAGOSYykgJw6VD4J+cu5F8pWWrtYwCx08s=;
	b=JbDkDqERGkqYkG5JbJ0euwvZRa7iwUwmm5ZsY4Ippe5BYg4bqmWbEFfpjGbKHklRa5vU
	 jcyRQJe9n6ovT8XV/Lp5l7zJH98U93+vCo64CMYTMhMEvrkSvxoauN7NUbowKPJkBOSwp
	 R3PuVAGPQQua84iqOa2ajHpCOlzipKoWJt0WLHXWDL/9JUbtO5771QvkUAwkB2gUrN8dV
	 wemx1b3nkvZ0MHUB/XXX0I1J3MSCkL1YSMJqIAokw0UJialhc5wVkcqOejwXt2ahicUlg
	 SVOZ1LvYxOHf9mVRmLixE3ALQZy29HCwtlNaqykbM9/jo6bs0HnVo3k0i7t2pnxh6Sw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 686A81F008A1;
	Mon,  9 Nov 2026 19:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794251099;
	bh=P2fmqmmprCAGOSYykgJw6VD4J+cu5F8pWWrtYwCx08s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gY+VfllGE9Yy/nLafpqIvTQSojg1VfdPrajioPJqR8fAtHzexFhtHgqhCVQvM7+Yv
	 NMJPFOWsaWu5h9Pm7C+KSiTG8K1LWXLcsNEdVgnistJrQCGjMYOHAiHws3shi7bpG7
	 Wm98FyLYXfpbvVw29NprY5oKHfOMi2jrxmdCmZGYrYdTVmx84FQT5Y1hed2+SMZXkt
	 NuH4I0crt2+LKcnkU+5AVE6plGlnOigz46C0z8V4DjZ9vyfM7LzjXwIEczVRc4GA6P
	 RmnTUaiv7hGOJZV7l3k9+w6ee/hGLpAvgvwgkZFXfAu9wP0VLTO9iC7nqzjv6JczTz
	 UoVeWpqFz3Stg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EB96D485F2;
	Mon,  9 Nov 2026 19:04:57 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Mon, 09 Nov 2026 14:04:53 -0500
Subject: [PATCH 1/2] nvme-tcp: move the TLS record read loop into a helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-nvme-tcp-live-ctrlrec-v1-1-47ba61670e65@gmail.com>
References: <20261109-nvme-tcp-live-ctrlrec-v1-0-47ba61670e65@gmail.com>
In-Reply-To: <20261109-nvme-tcp-live-ctrlrec-v1-0-47ba61670e65@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@kernel.org>
Cc: Martin Belanger <martin.nvme.dev@gmail.com>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Martin Belanger <martin.belanger@dell.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794251097; l=3262;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=I4tNXDC3YZTae17hei8TZK0tGRXfiT5ZPYdrswIwZ+c=;
 b=1kbWCQoRGlIaN5Ypz1TLuG8zQn3jMAb+c8snPAK0dO/VssR/HwmDS5nDoV9ZaJnoCKCbU5uLB
 b1UD11paE1WA6G+Qk0VF55nQQLiYHPCp4E6+rKjJyXEu4AfscHdR5ft
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

Move the read loop out of nvme_tcp_skip_tls_record() into a new
helper, nvme_tcp_drain_tls_record(). The next patch uses the helper
to read TLS records that arrive on a live queue.

No functional change.

Cc: stable@vger.kernel.org
Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/nvme/host/tcp.c | 60 +++++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7ecc6c007f8d..bf71e6f6a6ef 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1623,31 +1623,16 @@ static int nvme_tcp_recv_tls_alert(struct nvme_tcp_queue *queue,
 }
 
 /*
- * Discard a TLS record that arrived in place of the ICResp. A peer may send
- * a NewSessionTicket as soon as the handshake completes.
+ * Read the rest of a TLS record whose first part was read into @msg.
  *
- * Returns 0 when the record was discarded and the ICResp can be read, or a
- * negative errno if the connection cannot continue.
+ * Returns the bytes read, or a negative errno.
  */
-static int nvme_tcp_skip_tls_record(struct nvme_tcp_queue *queue,
-				    struct msghdr *msg, u8 ctype, int len)
+static int nvme_tcp_drain_tls_record(struct nvme_tcp_queue *queue,
+				     struct msghdr *msg, int flags)
 {
 	u8 buf[NVME_TCP_TLS_REC_CHUNK];
-	int ret;
+	int ret, drained = 0;
 
-	switch (ctype) {
-	case TLS_RECORD_TYPE_HANDSHAKE:
-		break;
-	case TLS_RECORD_TYPE_ALERT:
-		ret = nvme_tcp_recv_tls_alert(queue, msg, len);
-		return ret ? : -ENOTCONN;
-	default:
-		pr_err("queue %d: unhandled TLS record %u\n",
-		       nvme_tcp_queue_id(queue), ctype);
-		return -ENOTCONN;
-	}
-
-	/* the ICResp is in a later record, drain this one first */
 	while (!(msg->msg_flags & MSG_EOR)) {
 		struct kvec iov = {
 			.iov_base = buf,
@@ -1661,16 +1646,47 @@ static int nvme_tcp_skip_tls_record(struct nvme_tcp_queue *queue,
 		};
 
 		ret = kernel_recvmsg(queue->sock, &drain, &iov, 1, sizeof(buf),
-				     0);
+				     flags);
 		if (ret <= 0) {
 			pr_warn("queue %d: failed to drain TLS record: %d\n",
 				nvme_tcp_queue_id(queue), ret);
 			return ret ? : -ECONNRESET;
 		}
+		drained += ret;
 		msg->msg_flags = drain.msg_flags;
 	}
 
-	return 0;
+	return drained;
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
+	ret = nvme_tcp_drain_tls_record(queue, msg, 0);
+
+	return ret < 0 ? ret : 0;
 }
 
 /*

-- 
2.53.0



