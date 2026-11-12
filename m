Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF7D606A8B6
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GBnhaVa9;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AoaQusyt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ju/Ne27USNw4GWI49iZCO6dCHHDJ3hjr+EdskD0k17s=; b=GBnhaVa9TNYEWL
	nlmZMVWfFQM3xqzh+f7BJoqWq2RsSWLICyXrBJZzY3/DEL8kJ7O6wpCzQImMpyFDq5E0ehbRMj+YX
	/LZLonLsu8kmf7aOLNsyrLIZ1dob9l0aKG/YFbWm3kSgn1ThJmABoMUIeBvAe5tv+OuSQCKsZjWDA
	Dg7Sdvnkj05uAyrSIrMRYbqEeHQTzfzQa2emg1e8zdmdsrvPwNLxRP2BcrqB3md7QcVu8B1QunRhF
	9bOQWSINRYgdrfKVG9c2RSuTYv2g4I2bpF7MkwLwOGpZg/4pT2GcmWN6Qf0EMt2K0aYxoIpBdVIWt
	qiXye3oZ4OQjcd9VouaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRc71-0000000B42i-0aAS;
	Thu, 12 Nov 2026 21:13:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRc6z-0000000B41w-2CLr
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 21:13:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EFBD4403D0;
	Thu, 12 Nov 2026 21:13:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794518016;
	b=cEXquLdEyvIGRwwYUyRWpv3HWEWynaEpxAE+dSQ1tQ30ALr8rJmRoiZSQMXMUoDQsYy+
	 B1dAprOTsrGCioXIbVGbQPnBTn6VkZWXhCZt1g6qskWrYYPZeCbm/wyUU11Vyp3t9Q3o8
	 G/tTADzNdcm/1QWOyV70h6aAkNilz6VIMH4nbkH2zBpAQsh9JrZTb9rZmR7x6HZX6zh0T
	 rJJhAvk+kzXBy8kUUXFvUf29whML1f2m6HAE6QyXNT84UGhvPwpLE+UmdnnlMvZzkyX4/
	 +vDgQYDDmrrJyJ3BlzTPE/S6uI6TcYB21VaYP1RVPN3kzbba0TB3GyEfU+lJqM6oPBA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794518016;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=ju/Ne27USNw4GWI49iZCO6dCHHDJ3hjr+EdskD0k17s=;
	b=zzoy8XpMyqKjWTPtJxupE7zrAaLSVeDfoI7e1lqCl1FQV/wlPCsANdaE7wvuhJx+tP4p
	 xPrZERAP5+lUIGkf1EBfS2nwy6L3XHPKYBEo+izYRnQNHI69YEBp2v3/UqMfcdV76vlH3
	 aMhN6Tu2bHS2daptAaiuwHvNoKbLt3L6PZakr5kpElNFY2cFQImYZwjm87MJIQuzobIJ9
	 Wz2pgzzzqLSK7XDLcTJcYeKc0Nyt5Qr12JPTvDCskI9PrZgGWNxKlNHghvjMNP6+pgGZk
	 e++wES0MxppoteIsdOW94Ri58Hg0M59D0yrMdhJm+gBdZg77pFrfd71mAH1rxEJD5hw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C81301F000C6;
	Thu, 12 Nov 2026 21:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794518016;
	bh=ju/Ne27USNw4GWI49iZCO6dCHHDJ3hjr+EdskD0k17s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=AoaQusyt2BVmU26Bjzoby+BLG8HPImBPTmHmQNn6aI7EjHVWu1VR1+UvY3Kwh5S5F
	 gySqB/g72Laci3LVoa7BlmGogc1U1OXh1U8WXGbdoA/WjSfsLu3qeWLJxzVJ2fOL9U
	 +WhVQEHrBnJJwHSQ7fJqYJKHcl4IJ78PszAaNVHJZO7BOb9qCojH0YCrD75/I5O7r/
	 ELBIgRokUMcCiDgITGN2+IOc5Et+63Ztc32w1AK4Bku/h4nuunW9RDIg3Ni+DYPo1i
	 2ZHE+ZHgVa/GVxINbt8VAeUj+gHcSOuf/USi4NhulAZY/zSu+BXAmKTH4/lQQzSOkI
	 S5uuu78eMickA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5422F474F2;
	Thu, 12 Nov 2026 21:13:35 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 16:13:35 -0500
Subject: [PATCH v3 2/3] nvme-tcp: move the TLS record read loop into a
 helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-nvme-tcp-live-ctrlrec-v3-2-49760bd9eaa8@gmail.com>
References: <20261112-nvme-tcp-live-ctrlrec-v3-0-49760bd9eaa8@gmail.com>
In-Reply-To: <20261112-nvme-tcp-live-ctrlrec-v3-0-49760bd9eaa8@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@kernel.org>
Cc: Martin Belanger <martin.nvme.dev@gmail.com>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Martin Belanger <martin.belanger@dell.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794518014; l=3310;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=FtiyVAi+tsuAV1pkCkNXF2SIPBQlx9U9Q/ZMmwpLydA=;
 b=gdK0ysAwmRSX1Xpm0gP+jOGFmNl7djrblDhVNI0xnsSTYCivmFu0XRZQ9SkmW/M0/K+wPI5lm
 VAbsVuibUvgBaUeD5p4DV2xBwvGLj3GDGoEmAgqD0v77xAkZLvHWj29
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
Reviewed-by: Hannes Reinecke <hare@kernel.org>
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



