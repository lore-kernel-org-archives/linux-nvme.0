Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD6E606A329
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 00:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lhV1vxDc;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KD0kL8yE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wjEx0jnB2lq7AFcWUhIUn1KEStROxXi9cfKwfmIEYew=; b=lhV1vxDc7sywm2
	QxHWKwMbd2+Ye/Ffht+NmJXtHox7YtsqNDu1naphl1kHFRDcsdSt2WLkP3pf0mBy4Px/pHIbmln+U
	h+Azp03dFnDOj3VLGhVJGugWZj/5cLwF7alJbL9zCuo0XxNhBwSuf8AwhinBJ8Yiuh6tR96D8/SyO
	IA2wWlxPLyEBRC+2gZvXo3RAG6c27P0CQZtYvaCrkIntV5q8/3JOmxh0Dw71ECoJAtdW7HMBiwbpl
	ZJOoGPUYCEJ0DpTy1/LQgkAI/e3+B8uKquR4JAhNPfroW+dmpTkpF7UAUOwQvKdc4GaHbPCefFKZi
	PaSFf8fQcMmMirQgUlWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL8ht-00000001X5x-3HSj;
	Mon, 26 Oct 2026 00:36:57 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL8hr-00000001X43-1rj7
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 00:36:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DC05860A54;
	Mon, 26 Oct 2026 00:36:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792975014;
	b=zNcFK2u0hvaGPoybeeyA2xhrhkCzLBQSmdid0JZxOF/jtyfj089ng26LhAqcGKTZP/9f
	 5Ygfh/5OHKkKbEX8EhFzZJkGjYcSXDqLQISveVg1lGDO6vaQU9UqYRBqk34FCl7xln7XB
	 oRWj/Eoi1VEVQNnyMzUb4XfB7YPJOMEyzkjRW8Kg88NxpQ/VNMcjxzFjD3vJV+BkYTfKH
	 8GYI/faFmVxmHP0X9UyqkyVUEXq8fNwSIam/yiRePbTYFNBiONTdsjg+SojgFLOWhWOPi
	 0igp+Q6VLQV78CaOVI4ROR6vO+Fm+TBnVVJ9TJ3xfXzv8YMVI6xFEEDRcSKNqH4a/ow==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792975014;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=wjEx0jnB2lq7AFcWUhIUn1KEStROxXi9cfKwfmIEYew=;
	b=fOE18+P7z6I1OQrZhVycYtYbNFIK9NPiS+2pp/G4vrdSPNPBDao0y3o8nsXGppKp2MLH
	 0+yKld5mPCgDv2SQTe9XS50vRnwoMPl0N9QwBmQeIo5+isW/BHrNDoABJMjdEG+63YlGg
	 3cDJf3wUJyag4eORruBS9aP7PMRmXnPzu2euasiR6v+oRpGU1ZtR7Y0RVNHjjKQKWsyI8
	 1Zbhtfy15XDSGObQgr+pp7PGABzY+4GQ8fVNXmlFgNqLoxh8m5jAWDvhbla5Qhb2LIHmD
	 vQttnMKoDC4WhRXB/wToCRCseWzOr7zW2Fk2mYXkkJQlmBkFmwyENrGZgeIjXmpHlNQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C93F21F01829;
	Mon, 26 Oct 2026 00:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792975014;
	bh=wjEx0jnB2lq7AFcWUhIUn1KEStROxXi9cfKwfmIEYew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KD0kL8yEbHXFy641tvZlh9xjFEIU3uEiCTvirLamhzPzN8c2a90emLM/c1oNTybg+
	 M78YVB6pGzn8Hsi1Z0seusHTEtT1jPsm5lRa71EaayOro/YL4byF2a8Z/k+dK/OqLM
	 oEfp2aOp/irXi+bh2wORdvSZTU02B5etlKlRVxioUenEXjtvX2KdSXy9dfftc48JGv
	 tjX+4zMuAPSG0sR+Stsmunme2jgeB79aS4Y0kD+piqZ1ZrTDdyX2tQmpRSdHEgZ4Nd
	 dILx5NV9cNIn90Uk5V4frNZHPyaoWNJlYGGWCbJLc3vHb0rlZ5WGvRxSibQTIIu+B0
	 370qUSgeeZrmg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 50EF444B6A;
	Mon, 26 Oct 2026 00:36:51 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Sun, 25 Oct 2026 20:36:51 -0400
Subject: [PATCH RFC net-next 4/5] tls: send a KeyUpdate at the record limit
 and on request
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-keyupdate-rfc-v1-4-60b7756eccbd@gmail.com>
References: <20261025-keyupdate-rfc-v1-0-60b7756eccbd@gmail.com>
In-Reply-To: <20261025-keyupdate-rfc-v1-0-60b7756eccbd@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>, Chuck Lever <cel@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Martin Belanger <martin.belanger@dell.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792975010; l=11802;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=IQCztR4U4bIZ5m5bfb1vIoAMdhZ5FDJQqfxnIziKxlI=;
 b=92wXbLgKMqkEtIPtjmNbWz+hnaZWEdD4Bymko6jtn4lWNifa1vdlafQ5gZXGASoD0JiF04zku
 Pj1h9p5qWyOBNYeuLfC0pYw+zj09PMuQK0zj6bil9S3nLn/0gDzO9hZ
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

RFC 9846 section 5.5 requires a key update before the key reaches its
usage limit, 2^24.5 full-size records for AES-GCM. The limit counts
records, and only the record layer knows where records start and end.
Section 4.7.3 also requires a reply to a KeyUpdate with
update_requested, sent before the next Application Data record. Both
need a KeyUpdate at an exact position in the record stream.

For a socket with a registered TX secret, send a KeyUpdate before the
next record when the key has protected 2^24 records, as GnuTLS does,
or when the peer asked for one. ChaCha20-Poly1305 has no record limit.
The KeyUpdate is sent as a handshake record, which closes the open data
record first. Pending encryptions are then completed, and only then is
the next key installed.

Add TLS_TX_KEY_UPDATE to send a KeyUpdate now, optionally asking the
peer to update too. It can only bring a KeyUpdate forward: the record
limit is enforced either way. Following section 4.7.3, a new request
to the peer waits for the answer to the previous one, and no more than
2^48-1 epochs are used.

Assisted-by: LLM
Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 Documentation/networking/tls.rst |  17 +++++
 include/net/tls.h                |   5 +-
 include/uapi/linux/tls.h         |   1 +
 net/tls/tls.h                    |   1 +
 net/tls/tls_keyupdate.c          |   5 ++
 net/tls/tls_main.c               |  32 +++++++++
 net/tls/tls_sw.c                 | 149 ++++++++++++++++++++++++++++++++++++++-
 7 files changed, 208 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/tls.rst b/Documentation/networking/tls.rst
index 2e011bd1ce4a..69752a6d67df 100644
--- a/Documentation/networking/tls.rst
+++ b/Documentation/networking/tls.rst
@@ -326,6 +326,23 @@ direction is then left to the application again.
 
 The secrets cannot be read back.
 
+With a registered TX secret, the kernel sends a KeyUpdate before the key
+reaches its record limit (RFC 9846, section 5.5): after 2^24 records, except
+for ChaCha20-Poly1305, which has no limit. It also sends one before the next
+record when a received KeyUpdate asks for it. With a registered RX secret,
+the kernel processes a received KeyUpdate and does not pass the record to
+the application. A peer that sends more than 8 KeyUpdates in one second ends
+the connection.
+
+TLS_TX_KEY_UPDATE
+~~~~~~~~~~~~~~~~~
+
+TLS 1.3 only. Send a KeyUpdate now and install the next TX key. Needs a
+registered TX secret. The value is an ``int``: 0 to send a KeyUpdate, 1 to
+also ask the peer to update its key. Asking the peer needs a registered RX
+secret, and fails with ``EBUSY`` until the peer has answered the previous
+request.
+
 Statistics
 ==========
 
diff --git a/include/net/tls.h b/include/net/tls.h
index a5bc28a7d1f5..d3123b17030c 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -282,9 +282,12 @@ struct tls_context {
 	union tls_crypto_context crypto_send;
 	union tls_crypto_context crypto_recv;
 
-	/* Registered for KeyUpdate, protected by the socket lock */
+	/* KeyUpdate state, protected by the socket lock */
 	struct tls_traffic_secret tx_secret;
 	struct tls_traffic_secret rx_secret;
+	u64 tx_key_updates;		/* KeyUpdates sent */
+	bool tx_key_update_reply;	/* peer set update_requested */
+	bool tx_key_update_asked;	/* we set it, no answer yet */
 
 	struct list_head list;
 	refcount_t refcount;
diff --git a/include/uapi/linux/tls.h b/include/uapi/linux/tls.h
index d1b136ecea96..c85408cb6ce7 100644
--- a/include/uapi/linux/tls.h
+++ b/include/uapi/linux/tls.h
@@ -44,6 +44,7 @@
 #define TLS_TX_MAX_PAYLOAD_LEN	5	/* Maximum plaintext size */
 #define TLS_TX_TRAFFIC_SECRET	6	/* TLS 1.3 TX traffic secret */
 #define TLS_RX_TRAFFIC_SECRET	7	/* TLS 1.3 RX traffic secret */
+#define TLS_TX_KEY_UPDATE	8	/* Send a TLS 1.3 KeyUpdate now */
 
 /* Supported versions */
 #define TLS_VERSION_MINOR(ver)	((ver) & 0xFF)
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 63ece8074985..d12c9278c814 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -151,6 +151,7 @@ int tls_hkdf_expand_label(const u8 *secret, size_t secret_len,
 			  const char *label, u8 *out, size_t out_len);
 int tls_keyupdate_rekey(struct sock *sk, int tx);
 int tls_keyupdate_rx(struct sock *sk, struct sk_buff *skb);
+int tls_sw_key_update(struct sock *sk, int request);
 int tls_set_sw_offload(struct sock *sk, int tx,
 		       struct tls_crypto_info *new_crypto_info);
 void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
diff --git a/net/tls/tls_keyupdate.c b/net/tls/tls_keyupdate.c
index 543bf57599c7..851d5b54b336 100644
--- a/net/tls/tls_keyupdate.c
+++ b/net/tls/tls_keyupdate.c
@@ -146,5 +146,10 @@ int tls_keyupdate_rx(struct sock *sk, struct sk_buff *skb)
 	}
 	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
 
+	/* Any KeyUpdate from the peer answers our update_requested */
+	ctx->tx_key_update_asked = false;
+	if (msg[4] == TLS_KEY_UPDATE_REQUESTED)
+		ctx->tx_key_update_reply = true;
+
 	return 0;
 }
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 1c6e993ec012..0bce7df279a5 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -934,6 +934,35 @@ static int do_tls_setsockopt_secret(struct sock *sk, sockptr_t optval,
 	return 0;
 }
 
+static int do_tls_setsockopt_key_update(struct sock *sk, sockptr_t optval,
+					unsigned int optlen)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+	int value, rc;
+
+	if (sockptr_is_null(optval) || optlen != sizeof(value))
+		return -EINVAL;
+
+	if (copy_from_sockptr(&value, optval, sizeof(value)))
+		return -EFAULT;
+
+	if (value != 0 && value != 1)
+		return -EINVAL;
+
+	rc = mutex_lock_interruptible(&ctx->tx_lock);
+	if (rc)
+		return rc;
+	lock_sock(sk);
+	if (ctx->tx_conf == TLS_SW)
+		rc = tls_sw_key_update(sk, value);
+	else
+		rc = -EINVAL;
+	release_sock(sk);
+	mutex_unlock(&ctx->tx_lock);
+
+	return rc;
+}
+
 static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			     unsigned int optlen)
 {
@@ -967,6 +996,9 @@ static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 					      optname == TLS_TX_TRAFFIC_SECRET);
 		release_sock(sk);
 		break;
+	case TLS_TX_KEY_UPDATE:
+		rc = do_tls_setsockopt_key_update(sk, optval, optlen);
+		break;
 	default:
 		rc = -ENOPROTOOPT;
 		break;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index a314fa638dc3..4acedddfb01e 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -40,6 +40,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/splice.h>
+#include <linux/unaligned.h>
 #include <crypto/aead.h>
 
 #include <net/strparser.h>
@@ -1005,6 +1006,150 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 	return copied > 0 ? copied : ret;
 }
 
+/* RFC 9846 section 5.5 allows 2^24.5 full-size records per AES-GCM key.
+ * Send the KeyUpdate a little earlier.
+ */
+#define TLS_KEYUPDATE_TX_RECORDS	BIT_ULL(24)
+
+/* Section 4.7.3: the epoch must not exceed 2^48-1. The application
+ * traffic secrets start at epoch 3.
+ */
+#define TLS_KEYUPDATE_MAX		(BIT_ULL(48) - 4)
+
+/* Send a KeyUpdate with the current key, then install the next key.
+ * Called with tx_lock held and the socket locked.
+ */
+static int tls_tx_key_update(struct sock *sk, u8 request, int flags)
+{
+	u8 body[TLS_KEYUPDATE_MSG_SIZE] = {
+		TLS_HANDSHAKE_KEYUPDATE, 0, 0, 1, request
+	};
+	struct tls_context *tls_ctx = tls_get_ctx(sk);
+	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
+	u8 record_type = TLS_RECORD_TYPE_HANDSHAKE;
+	u8 buf[CMSG_SPACE(sizeof(record_type))];
+	struct msghdr msg = {};
+	struct cmsghdr *cmsg;
+	struct kvec iov;
+	int ret;
+
+	memset(buf, 0, sizeof(buf));
+	msg.msg_control = buf;
+	msg.msg_controllen = sizeof(buf);
+	msg.msg_flags = flags & MSG_DONTWAIT;
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level = SOL_TLS;
+	cmsg->cmsg_type = TLS_SET_RECORD_TYPE;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(record_type));
+	memcpy(CMSG_DATA(cmsg), &record_type, sizeof(record_type));
+
+	iov.iov_base = body;
+	iov.iov_len = sizeof(body);
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, sizeof(body));
+
+	/* A control record closes the open record first, so all data
+	 * written so far goes out with the current key, ahead of the
+	 * KeyUpdate.
+	 */
+	ret = tls_sw_sendmsg_locked(sk, &msg, sizeof(body));
+	if (ret < 0)
+		return ret;
+
+	/* Nothing may be encrypted with the next key before the KeyUpdate
+	 * is encrypted with the current one.
+	 */
+	ret = tls_encrypt_async_wait(ctx);
+	if (!ret)
+		ret = tls_keyupdate_rekey(sk, 1);
+	if (ret) {
+		/* The peer expects the next key: the connection is lost */
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYERROR);
+		tls_err_abort(sk, ret);
+		return ret;
+	}
+
+	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
+	tls_ctx->tx_key_updates++;
+	if (request == TLS_KEY_UPDATE_NOT_REQUESTED)
+		tls_ctx->tx_key_update_reply = false;
+
+	return 0;
+}
+
+/* Send a KeyUpdate if one is due: in reply to the peer's
+ * update_requested (RFC 9846 section 4.7.3), or before the key reaches
+ * its record limit (section 5.5). ChaCha20-Poly1305 has no record limit:
+ * the sequence number would wrap first.
+ */
+static int tls_tx_key_update_if_due(struct sock *sk, int flags)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+	bool limit;
+
+	if (likely(!ctx->tx_secret.len))
+		return 0;
+
+	limit = ctx->prot_info.cipher_type != TLS_CIPHER_CHACHA20_POLY1305 &&
+		get_unaligned_be64(ctx->tx.rec_seq) >= TLS_KEYUPDATE_TX_RECORDS;
+	if (!limit && !ctx->tx_key_update_reply)
+		return 0;
+
+	if (ctx->tx_key_updates >= TLS_KEYUPDATE_MAX) {
+		/* Ignore update_requested. At the record limit the
+		 * connection must end.
+		 */
+		ctx->tx_key_update_reply = false;
+		return limit ? -EKEYEXPIRED : 0;
+	}
+
+	return tls_tx_key_update(sk, TLS_KEY_UPDATE_NOT_REQUESTED, flags);
+}
+
+/**
+ * tls_sw_key_update - send a KeyUpdate now, for TLS_TX_KEY_UPDATE
+ * @sk: socket
+ * @request: non-zero to also ask the peer to update its key
+ *
+ * Called with tx_lock held and the socket locked.
+ *
+ * Return: 0 on success, or a negative errno.
+ */
+int tls_sw_key_update(struct sock *sk, int request)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+	int ret;
+
+	if (!ctx->tx_secret.len)
+		return -EINVAL;
+
+	if (request) {
+		/* Only the kernel sees the answer */
+		if (!ctx->rx_secret.len)
+			return -EINVAL;
+		/* Section 4.7.3: wait for the answer to the previous one */
+		if (ctx->tx_key_update_asked)
+			return -EBUSY;
+	}
+
+	if (ctx->tx_key_updates >= TLS_KEYUPDATE_MAX - 1)
+		return -EKEYEXPIRED;
+
+	/* A reply must carry update_not_requested */
+	if (request && ctx->tx_key_update_reply) {
+		ret = tls_tx_key_update(sk, TLS_KEY_UPDATE_NOT_REQUESTED, 0);
+		if (ret)
+			return ret;
+	}
+
+	ret = tls_tx_key_update(sk, request ? TLS_KEY_UPDATE_REQUESTED :
+				TLS_KEY_UPDATE_NOT_REQUESTED, 0);
+	if (!ret && request)
+		ctx->tx_key_update_asked = true;
+
+	return ret;
+}
+
 int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
@@ -1019,7 +1164,9 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	if (ret)
 		return ret;
 	lock_sock(sk);
-	ret = tls_sw_sendmsg_locked(sk, msg, size);
+	ret = tls_tx_key_update_if_due(sk, msg->msg_flags);
+	if (!ret)
+		ret = tls_sw_sendmsg_locked(sk, msg, size);
 	release_sock(sk);
 	mutex_unlock(&tls_ctx->tx_lock);
 	return ret;

-- 
2.53.0



