Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF67A606A331
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 20:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rbgPPD+D;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wqprkbe2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Ih0J5YKp9JLhGEP1XtD8RTjP9z4xhBkg2Gv4RM2lq2g=; b=rbgPPD+DDMZI12
	YiiaNf436hkgDlpYo0eYKri7V0N2ZJ92l36kAlgyFS+eyZSOlJynqQKrvRk2W0a8pKj4DQdThbqVh
	EHDuzWXS5xnipVRaBkXDF4cuTLbPSlP6qSiH2Dl0hk6WaUS9glQXVOpKrbl0EVoocsxJ8nSYy0/Dd
	92cuddDVxeRJ3xEghJ+/OYCzISuh7nea3PlzUjQxq/RgUjOIpYQexibas1eMuLEHzx8ud3+21UTvB
	gPwdod+o39ERW6CW79+qFezgwbJD5D9uX2pAl1BZUNe4CfUpNVUi9dvCL1o5E6tJeQlcX+kGjrYBZ
	jXq0XoKyjME7G8N/HzMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRF9Z-00000007fJI-2jC0;
	Wed, 11 Nov 2026 20:42:45 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRF9X-00000007fHa-0Nrz
	for linux-nvme@lists.infradead.org;
	Wed, 11 Nov 2026 20:42:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 69A316354D;
	Wed, 11 Nov 2026 20:42:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794429762;
	b=Dru0hBlmOscDDXRuITIDHAkZa1v0dWoZXXU3xapr3vUTxwMjzBxU5imRxhDrUwMtBJIn
	 tS1Aq4oYnlDywGSlUUni6F0XWg5/EpUs0XyUr13h4T8LJd4gDnF30Q8I8+21x4VW4oE/6
	 xMxZOEhBOk6sIK4UKQsFDrxWRZ4a33pqBOJIqLMxBpJUTkuECaELUkHZ87Vs6bVa8PPju
	 hIuFuyXrsr6yUO/njC3/2/wVG5v6DoS3Gi15ugc1q1c7rDnp+4oNLg0fZ6xnXTXBCq/qT
	 nMl/CqDR/iG1Q9euPCSN5YX9VsxmqHseshnqxif16U4/Yduy/62IOJJEEpZrIKrS0Ig==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794429762;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Ih0J5YKp9JLhGEP1XtD8RTjP9z4xhBkg2Gv4RM2lq2g=;
	b=UAFTH7odFTuOvvp9BEZgsyioKRQNoNUih1CfLxM24hEDgO8iF3eYAx4wuUiJrHrUCjT6
	 7LskejE9ivIb+HSICURGCUk9Dz8SSlMiKYwmW+wZe60S5AhIO0SAd3ku+ahFHWbASsRmx
	 MKbD4agEQ3o6qFhuTNGSmasVYHHU1GuZ7bCNPBrrsMIxno/wpnK85kle/zJv0ql7zUovN
	 vK/dRqABxzXtZTu7w48SukrCcHLENC6UPYCwb3o9d6WkZ/Xujcf8xNT3m1upkhIAbshR4
	 OYA8VVgBPZ7GGbNaxeLkuxL0q2kEDowsOPLNMr7S3qSUitR3NrOjg37VSgntd/XtDZA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5BDAA1F00A08;
	Wed, 11 Nov 2026 20:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794429762;
	bh=Ih0J5YKp9JLhGEP1XtD8RTjP9z4xhBkg2Gv4RM2lq2g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Wqprkbe2kKhszVITAIRjwE3gRIyYYKk3syrhsXj+pCq/ZUtnqB7LhwKhmMuqlO9td
	 jGN2U5KGf/WailgMu2bwBwdAv8t/uQ+CzFd4eqMpPZ+ZOSwzfJgvB9ncPSPmqHfEE4
	 byxYo8USI1tOODBX0It89sGlA2Myg66HWX6HeS/mRxw5yO2j3/c1uuTZr6luQTTrEb
	 aBKKVYJ7+CRxTvSCjWVMOg9BFtm8DMV4Z63mm3gmqu4AJO6IDHI0UUhahvS+zO6czQ
	 hcxDzqQCwU3PQeRTmjTtv+7T37yjsmSFHEp+F/suUTJHB2ZksAWeqls6DebDccTpV/
	 pk86vfgJOeZnQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D875749106;
	Wed, 11 Nov 2026 20:42:40 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 15:42:41 -0500
Subject: [PATCH v2 3/3] nvme-tcp: consume TLS records without application
 data
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-nvme-tcp-live-ctrlrec-v2-3-6295202b84de@gmail.com>
References: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
In-Reply-To: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@kernel.org>
Cc: Martin Belanger <martin.nvme.dev@gmail.com>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Martin Belanger <martin.belanger@dell.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794429760; l=5497;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=m228vdxP3ZzFl+gT3m3W5yTlx4aQ1XbuGpyRUHeWzeg=;
 b=tjSB6muxQQMw6dnrZQgd+BNhSPHA4JJ0d9L3x048ettB5iD72O5kJEeqM0fK0kMBsBy43jg4v
 lXszNakTBErA8ajamBX5FF/aZ93Vk4/0WZBoDwPkDuG1pdDByi2tb4p
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

On a poll queue, nvme_tcp_poll() and nvme_tcp_io_work() can both see
the record while the socket lock is released. A queue flag makes sure
that only one of them reads it.

svc_tcp_recvfrom() in sunrpc handles -EINVAL from read_sock() the same
way.

Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/nvme/host/tcp.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c3bf345c4e92..cc6a46f118b2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -123,6 +123,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_IO_CPU_SET	= 3,
+	NVME_TCP_Q_TLS_RECORD	= 4,
 };
 
 #define NVME_TCP_OPT_NR_QUEUES(opts) ((opts)->nr_io_queues + \
@@ -1450,6 +1451,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 	return ret;
 }
 
+static int nvme_tcp_recv_tls_record(struct nvme_tcp_queue *queue);
+
 static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
@@ -1462,10 +1465,31 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
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
+		/*
+		 * On a poll queue, nvme_tcp_poll() and nvme_tcp_io_work() can
+		 * both get here for the same record. Only one of them reads it.
+		 */
+		if (test_and_set_bit(NVME_TCP_Q_TLS_RECORD, &queue->flags)) {
+			consumed = 0;
+		} else {
+			release_sock(sk);
+			consumed = nvme_tcp_recv_tls_record(queue);
+			lock_sock(sk);
+			clear_bit(NVME_TCP_Q_TLS_RECORD, &queue->flags);
+		}
+	}
 	/*
 	 * nvme_tcp_recv_skb() handles its own errors, so a queue that is
-	 * still enabled failed inside read_sock(). Handle it before
-	 * release_sock() processes the backlog.
+	 * still enabled failed inside read_sock() or while reading a TLS
+	 * record. Handle it before release_sock() processes the backlog.
 	 */
 	if (unlikely(consumed < 0 && consumed != -EAGAIN &&
 		     queue->rd_enabled)) {
@@ -1665,6 +1689,74 @@ static int nvme_tcp_drain_tls_record(struct nvme_tcp_queue *queue,
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
+	union nvme_tcp_tls_cmsg u = {};
+	struct kvec iov = {
+		.iov_base = buf,
+		.iov_len = sizeof(buf),
+	};
+	struct msghdr msg = {
+		.msg_control = &u,
+		.msg_controllen = sizeof(u),
+	};
+	int len, ret;
+	u8 ctype;
+
+	len = kernel_recvmsg(queue->sock, &msg, &iov, 1, sizeof(buf),
+			     MSG_DONTWAIT);
+	if (len <= 0)
+		goto fail;
+
+	ctype = tls_get_record_type(queue->sock->sk, &u.cmsg);
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



