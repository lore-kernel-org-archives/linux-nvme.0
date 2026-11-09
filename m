Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D35B60A5BE0
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=f+Q/2YXl;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OGpFYM0z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=typ1ZZDCTjU92dY1u0fxgSRr7RdySGAm9/knVmjBoMQ=; b=f+Q/2YXl1i6xDK
	uqvDieK3G8F6LTVG4p7bI+1IGsZ7gHSyPk/BZisBnzw4CFDM+14Q1XchyDmHYtU4imUXuvU+O1oQi
	JzOCNB5d/yOOi94Nsb1A7q/NZRt2mNaH/gwwoDCpd40F6vZR3zhCtFGUc0ili/nW7rhat52EBDv3P
	vu6aV9ZC5mUXtTAlRmhZizW5lU/M75E9l1SFJiNXOsKT7YHHJakQ/MdlSG54AnqPkOMuzWWQ5QPFN
	m/pC92SMzQiRF9zeLm43FYBpV0qzq1FaANDeZWRj/I2bO1/pPT91SK7xa6REf6bJcIdkpE5eQD+V9
	wAeM2G96YrY4j7iutL8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQUft-00000001Vtw-2ziU;
	Mon, 09 Nov 2026 19:05:01 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQUfs-00000001VtH-0Ea1
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 19:05:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 623D8419A2;
	Mon,  9 Nov 2026 19:04:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794251099;
	b=DJvdamYbXK7AiilLvz4tz8ARWVm8hnp/GpVECo4NDsQ2Z4ytfTKwQPOhWn2eADaajU+4
	 L4N0YJZM1ZDoBHBlQfxOM8p68aEpzO7zUSWHFzYUZiIwdV3ie4hTt8Wt5K5m0j9nLlsl8
	 YMcySa2u309rhCka7inIXn44QqeDDlg70aAhLjocfuIiswJqCAHPOKFXFs9QUTRerw5sL
	 1E27lK1kF36vx8RQDo3PJkr7KKZ22kOB4Y8t/EFaV2dtRxjcwYLnkuT4m7rNmIB7fUME0
	 EvaWUKyjWuqyH1E9fa+Nkq80rCK0irYoWI74YO4VVs9moTbEg5qPNFi16XDc3XocTVg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794251099;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=typ1ZZDCTjU92dY1u0fxgSRr7RdySGAm9/knVmjBoMQ=;
	b=eiHKSuHPQYmv2jM1MKgrBMzxV1Mv8uxy2G1pDSTAOjZVwkuyQYCI5mT0oyedteb2bRcs
	 61bFLeXUMf0bqiG6diBB4yKmANqmnHEkPQK5oleMP0EJbVGxkvN2/X/opk2Tkax4OL421
	 n9GBvP0PcJENe5tHPEAZeaM4rzQ+GHG/qezA6VLur62s0yF4xVO2Fk1MB/uAGKw4UE5pc
	 GrlWqM4QN3nMnX7SJrwkzhaIIHzLl/PyRvEhNuYmAuL46MHo/k9RpdDOT1btBLN9Wq5xS
	 12Rvl3o0LfeX8wUk3HnnF9zcN5DkY7dSJpq2c/OA2MijtDbvw8xT32rOqnJFfllMGXw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7735E1F008A2;
	Mon,  9 Nov 2026 19:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794251099;
	bh=typ1ZZDCTjU92dY1u0fxgSRr7RdySGAm9/knVmjBoMQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OGpFYM0z1Le6AopdI/JuGbSZAWWy5Gze3DDTAGDe/zcHo8xBAoMiix85qqRTsooUR
	 W0AtOAAuixtns2l6t3JmpCcLlzxBFWocIEDeQIe/V4qWvmOmjXMcs/sDO93DiVGsqM
	 3ZvpnyrP2yV4G7LQ5tcfYgpW/iypR6QCES+ZstpYiRq2I7dvbHWQYccri+td+Zw8jk
	 HFSxlmYPqgqSjaJrudENgONRS1vpQKFYzZmkrPWEF7JxmxHdyjEhL6P3+qWl6u8pwz
	 MimiQrRp3bQehycJyP3Pn1ywW4SRJlYxw6XNAtu9OMCx52vkE6cs5iFjhxIgwM/7et
	 TRAnidIOS1enA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 08118485EE;
	Mon,  9 Nov 2026 19:04:58 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Mon, 09 Nov 2026 14:04:54 -0500
Subject: [PATCH 2/2] nvme-tcp: consume TLS records without application data
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-nvme-tcp-live-ctrlrec-v1-2-47ba61670e65@gmail.com>
References: <20261109-nvme-tcp-live-ctrlrec-v1-0-47ba61670e65@gmail.com>
In-Reply-To: <20261109-nvme-tcp-live-ctrlrec-v1-0-47ba61670e65@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@kernel.org>
Cc: Martin Belanger <martin.nvme.dev@gmail.com>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Martin Belanger <martin.belanger@dell.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794251097; l=4643;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=Cd79eqDVxaXiCrNFtCelJMTLFVctD6vS8rdx4/D7gB8=;
 b=QSToNQCLWHhIuqtqk68fhuSC59RXxcR+UQ0FxGYxYlvVUBu+tFZfXe6eRd6RNlTeNV56bkHLB
 dNV8LD/mtMoCI6KuYbXMtjXEqumExVfopwXN6gyP52kumoEKMZJCpde
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

A peer may send a TLS record without application data at any time
after the handshake: a NewSessionTicket, a KeyUpdate or an alert.
tls_sw_read_sock() cannot pass such a record to nvme_tcp_recv_skb().
It returns -EINVAL and leaves the record at the head of the receive
queue. nvme_tcp_try_recv() then starts error recovery, and the
controller reconnects.

TLS 1.3 allows a server to send a NewSessionTicket at any time after
the handshake (RFC 8446, section 4.6.1). Alerts can also arrive at any
time.

On -EINVAL, read the record with recvmsg(), which reports the record
type. Discard handshake messages other than KeyUpdate. Log alerts, and
fail the queue on a fatal alert. Fail the queue on a KeyUpdate, which
nvme-tcp cannot answer, and on any other record type. recvmsg() takes
the socket lock, so release it around the read.

svc_tcp_recvfrom() in sunrpc handles -EINVAL from read_sock() the same
way.

Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/nvme/host/tcp.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bf71e6f6a6ef..d460273a328a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1444,6 +1444,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 	return ret;
 }
 
+static int nvme_tcp_recv_tls_record(struct nvme_tcp_queue *queue);
+
 static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
@@ -1456,6 +1458,18 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 	lock_sock(sk);
 	queue->nr_cqe = 0;
 	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
+	/*
+	 * kTLS cannot pass a TLS record without application data to
+	 * nvme_tcp_recv_skb(). It returns -EINVAL and leaves the record at
+	 * the head of the receive queue. recvmsg() takes the socket lock,
+	 * so read the record without it.
+	 */
+	if (unlikely(consumed == -EINVAL && nvme_tcp_queue_tls(queue) &&
+		     queue->rd_enabled)) {
+		release_sock(sk);
+		consumed = nvme_tcp_recv_tls_record(queue);
+		lock_sock(sk);
+	}
 	/*
 	 * nvme_tcp_recv_skb() handles its own errors, so a queue that is
 	 * still enabled failed inside read_sock(). Handle it before
@@ -1659,6 +1673,78 @@ static int nvme_tcp_drain_tls_record(struct nvme_tcp_queue *queue,
 	return drained;
 }
 
+/*
+ * Read the TLS record that read_sock() could not pass to
+ * nvme_tcp_recv_skb(). The caller must not hold the socket lock.
+ *
+ * A KeyUpdate needs new keys that nothing here can supply. Other handshake
+ * messages, such as a NewSessionTicket, are discarded.
+ *
+ * Returns the bytes consumed, or a negative errno if the connection cannot
+ * continue.
+ */
+static int nvme_tcp_recv_tls_record(struct nvme_tcp_queue *queue)
+{
+	u8 buf[NVME_TCP_TLS_REC_CHUNK];
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
+	struct kvec iov = {
+		.iov_base = buf,
+		.iov_len = sizeof(buf),
+	};
+	struct msghdr msg = {
+		.msg_control = cbuf,
+		.msg_controllen = sizeof(cbuf),
+	};
+	int len, ret;
+	u8 ctype;
+
+	len = kernel_recvmsg(queue->sock, &msg, &iov, 1, sizeof(buf),
+			     MSG_DONTWAIT);
+	if (len <= 0) {
+		dev_err(queue->ctrl->ctrl.device,
+			"queue %d: failed to read TLS record: %d\n",
+			nvme_tcp_queue_id(queue), len);
+		goto fail;
+	}
+
+	ctype = tls_get_record_type(queue->sock->sk, (struct cmsghdr *)cbuf);
+	switch (ctype) {
+	case TLS_RECORD_TYPE_HANDSHAKE:
+		if (buf[0] == TLS_HANDSHAKE_KEYUPDATE) {
+			dev_err(queue->ctrl->ctrl.device,
+				"queue %d: peer sent a TLS KeyUpdate, which is not supported\n",
+				nvme_tcp_queue_id(queue));
+			return -EKEYEXPIRED;
+		}
+		break;
+	case TLS_RECORD_TYPE_ALERT:
+		ret = nvme_tcp_recv_tls_alert(queue, &msg, len);
+		if (ret)
+			return ret;
+		break;
+	default:
+		dev_err(queue->ctrl->ctrl.device,
+			"queue %d: unexpected TLS record %u\n",
+			nvme_tcp_queue_id(queue), ctype);
+		return -EPROTO;
+	}
+
+	ret = nvme_tcp_drain_tls_record(queue, &msg, MSG_DONTWAIT);
+	if (ret < 0) {
+		len = ret;
+		goto fail;
+	}
+
+	return len + ret;
+
+fail:
+	/* read_sock() left a whole record, so none of it can be missing */
+	if (len == -EAGAIN)
+		return -EPROTO;
+
+	return len ? : -ECONNRESET;
+}
+
 /*
  * Discard a TLS record that arrived in place of the ICResp. A peer may send
  * a NewSessionTicket as soon as the handshake completes.

-- 
2.53.0



