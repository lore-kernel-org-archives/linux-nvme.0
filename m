Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13014606A8A8
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 20:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sV2Z0iap;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yh/R184N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=TRMplQjMcSNgBQttSLhuCUme6usJ/pp7aRxUs0kI/qA=; b=sV2Z0iapCSnjGP
	iLZPQTH+uLjZ/GGu1+k+uj7ThPp1/SHAOaldTezzlHfRh8dpcUG3nJbTQvW51wSY8bKjCcWT0OL+J
	e6UuTgtImeg19Rny7j8YMxOxqOMeOJyE8URp5hndwCMoHXVgbRmsKJrzlWW38us4KEMIo2sdISlKB
	Wmr7w93nCL2h4xYDi8H8bvjubd6XbPMYHGI5/PFhMMMauF9bNBl2mE8p1+nHyfhuGa3LhpyaD5W2r
	gIu6kdvcEcrlmaLhetk4PQsEheWAjFqxCPsTNo3slG9/UrL/huIrK0bYb325450vMIkEIRytNlgZ9
	Y1cX8iT4KE1Giv/aIzpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRF9X-00000007fI2-1qUN;
	Wed, 11 Nov 2026 20:42:43 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRF9W-00000007fHP-2Mj4
	for linux-nvme@lists.infradead.org;
	Wed, 11 Nov 2026 20:42:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 41F31402C1;
	Wed, 11 Nov 2026 20:42:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794429762;
	b=Er1mEygRZmzZXjxuvW42hFR8LnQRtku3C6Pa27W2tj0Uf0IjN5P25Sgu2k8Sdxru2uXv
	 5nXwDsCwtjdtvyquyKcqcnbONl7Qq/p74/yZx44pP+chbDlLf42CkQxb+O16QNBxneuo5
	 a60RoSeeysyOrWRMBK35IwEmymrUBxUucYI62jFPqfxImziKU5efZW4cdxSje2vbB44cK
	 OYq4c7QpLGKJl6sxQ48XTsP/UjEIQFmMUqHpJkxYXErXbrQeyjQCS7F/8tmsMM/ejRhPr
	 pyudCg0wlCMnhvBC3i+CGnttCp1hHnG6zeizkz+dg/3gwKb+ewhGqZfKdV5eKTY19Ng==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794429762;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=TRMplQjMcSNgBQttSLhuCUme6usJ/pp7aRxUs0kI/qA=;
	b=ZiEzx+UhoQ8Yjc5QX6x0FlfybIyTeV7vDaS+nouz6r5gGUqfezcn6F77jxm5Z6JSgb/E
	 uWG8JTgdD2DO+A1JW0W/Aha4NiNfnP9khpY1NuXzC8YU8wK553VMY78II9kxN43HJfI3r
	 5eXI5sNdWksMEh3ZtuhrWV5ppeT2PRNolIslDo4C8fqkvV8l0tk3+lma+8Cy55Ow+8UQd
	 YPiKqeAZiWfO7qz4yPdSEfje/GIM5hmXIyBLTv16u7a5/vTLhrCJJPYo8MeBc6bHOPHJe
	 fGdRS94zQdc/S/8LBPeXP28N0cbIBXpUJWJ8coGpfZamv9YdNfuV0/8Sj9BJMhK2mAw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 38F641F00A07;
	Wed, 11 Nov 2026 20:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794429762;
	bh=TRMplQjMcSNgBQttSLhuCUme6usJ/pp7aRxUs0kI/qA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Yh/R184NrX2i/jJNy1CgiiGOWGD6NZSG3XQIQcmfC5x5tSmz3ljoR40/4covEvLEw
	 AMren50PB8JS1GbOnMALp6YDkrmy533+akSJTVIjO+3+mKwZA5WJ5ngYr+AU5D/pwd
	 //bHGi2oZLznavDDWjLM+TLoGTaf722ZmRxM221aTQ3t/91f0AVrLUXecB3kDMMUUJ
	 19Qi2FpgK3FiB78F0aP02sS+o7bHuxRfy6F/CZ2tJvgkWURxgmXRDuJYuHgIWahXQm
	 5g6y26g8BzwjxdcVyttK5YCekkQsJpPnweewZ3AZsdHDzhx4l96h14KDoZj607HelI
	 3sUuyARRKh5zg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B783749102;
	Wed, 11 Nov 2026 20:42:40 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 15:42:40 -0500
Subject: [PATCH v2 2/3] nvme-tcp: move the TLS record read loop into a
 helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-nvme-tcp-live-ctrlrec-v2-2-6295202b84de@gmail.com>
References: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
In-Reply-To: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@kernel.org>
Cc: Martin Belanger <martin.nvme.dev@gmail.com>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Martin Belanger <martin.belanger@dell.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794429760; l=3262;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=iV5/gLYMfi+3qRWU5mC/o8rnoZZhFX0PW8m+y9ICDUg=;
 b=JX09F1pj6vzcnu3uUb52dgixo4JckifcEXUhT34WvJIXVx3kZ9c2fP0SmM07+F2zmR7D/WzfA
 e+XKtdGo1HLCJBWdEHh4tGozw4aNW3gDvVpDQbVKGwaWznH2xt6P91+
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
index 749d77b4e172..c3bf345c4e92 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1629,31 +1629,16 @@ static int nvme_tcp_recv_tls_alert(struct nvme_tcp_queue *queue,
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
@@ -1667,16 +1652,47 @@ static int nvme_tcp_skip_tls_record(struct nvme_tcp_queue *queue,
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



