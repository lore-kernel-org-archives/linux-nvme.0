Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5701606EE8C
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2026 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HZQ0aG/n;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bsh7tCeh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jp/T7qDZhQP44LNBSqD6ZO7okcn9yICCZEC4Mys519s=; b=HZQ0aG/naBd3P5
	jOlEnNvvyfEBEkozAlE6ft645yp53LODRyLtbMlN6GZmwM2v8JpQLAYHI9SWvsJsdYOZ/B4hTXEWt
	8ihAFPecRBbmzRr7ZiHspvt/d1nUzBGG3zy32VKTIK5rVhAVEKQzyc4BL1x/2htOb/xBA9PzZpsa8
	yHbwZ0xJ8tLlwwZ/Jpl1ksRPMZF0fJYaPTsij+9XJG9h5eBmO9P44ZD4GobbZWyCZftBK8ycYNR6n
	4LcYUxJ2i0COu3cv+i/DiiNibLCHciAYFxjQLfak6/3P/NqF9jlFRf3QjDGwKukR7zo2LpP57in9B
	slKjUY3/q8uW4vwNdhIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNvMF-0000000HMtn-3M0g;
	Mon, 02 Nov 2026 16:58:07 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNvMC-0000000HMsT-10kS
	for linux-nvme@lists.infradead.org;
	Mon, 02 Nov 2026 16:58:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9466C42DD9;
	Mon,  2 Nov 2026 16:58:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793638683;
	b=EjyBlvmjiOJgSAuXy6tlYj8N+12X4806+IcYaZadJSJnN1OQZo3TFcqzXlltumsQRgTU
	 LfKIRgrt67kGHaQlLuoxU9tGEuTBip8HX5HzjFSleedv0/whG+msNJmyrqhvgFv0uQlvi
	 gr1xRE+B18p8XLIRJ6WMZauGJFgLEosZ2XkUN3ybLqdXhi5U23yBKbbFDQqrHSbuVnU5M
	 v1KPoejd7SlJ3DVfdazuHUAk4CNn1RqlDskXyIdGqgqVEwuU4162JmsmYMCk9XbG15Fgi
	 p6iVk3oY22FxIdpzIWUHLjzVmsYvOsoMuepGwksWg6At8KWY0vl/n2uSfUWvh2UAYsg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793638683;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=jp/T7qDZhQP44LNBSqD6ZO7okcn9yICCZEC4Mys519s=;
	b=qqOFrgadwzbCpyw3XRC/nvbe9b9WJxKz3vnHcUL3ZFXcVI6juLpQgDRWe1SYJO7Lp7Pw
	 DsvMTKuJACpQMMSuvWeT06p8iFewqQUA2c5lI+MUgccC+35fJY7QsqL/rGv/4JtctJZar
	 AWl5y04DKrYn3RVbOvTC92lpgvr5dbbXlFF9dXiOWpk244V8xxrn0FOVPMRmw+MNsRwjK
	 pojoEqs1R/oqFlViutqRnDoUaA9fwYKswnNs1fH57Nm0kJhx7pHb+T2UAWHPVjFDhXieT
	 7QHytLv3FAEt78v1lJrnVWLKakuSX5VxVtyqQIpNtoJkK7WkmxdQq0ynJiYBqWwv3SQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 239211F00A21;
	Mon,  2 Nov 2026 16:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793638683;
	bh=jp/T7qDZhQP44LNBSqD6ZO7okcn9yICCZEC4Mys519s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bsh7tCehQe30dLCkwymQWdUT02NlzRXtAB1nr/+PJPw67m81PFCfe3Vy8ikRlr7gt
	 dE2Q1g9Ruxvpb7Xmj/o9DKMAnR9cJoiltd5r+gJEbCH43/Jgh9SkCRc2u+HL0JVYvN
	 bgs+CjVwYQoUIP7NMtFe+IY/mHUMF6LsYW00GQCr2TcBVV4YKrudGfPt/l4kUNRtx1
	 heTtfm3jujOuaChA1GQbBH7HGx3G2mA8kbSelH4l9u07W1/o2zp0Bry9ZunUVK4YPN
	 aNXN1I+qeYc2ZvvUeOSMTJ/0UbwASvKTPInWnzbxAP1K/W8LU84u7t2dEWyLrvbPih
	 35HXjSLvExxrg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A2A6E465AF;
	Mon,  2 Nov 2026 16:58:01 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Mon, 02 Nov 2026 11:58:00 -0500
Subject: [PATCH net-next v4 3/5] tls: update the RX key when a KeyUpdate is
 received
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-keyupdate-rfc-v4-3-f17419972b9f@gmail.com>
References: <20261102-keyupdate-rfc-v4-0-f17419972b9f@gmail.com>
In-Reply-To: <20261102-keyupdate-rfc-v4-0-f17419972b9f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793638681; l=11406;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=m+35dPQyW6DYNvcvHE5eunfT0SEOzhoEtPpt83riyJ4=;
 b=NVJ0eqMC1yiOwpSNsgbK1XyYeEV6E7vrr6TXdkh0tkuZJNn4KfpGMdtGYld5emi7LL4veR93W
 sNVZp8tGmWqBMLCvRgto41ntcbAG0MCxEcdyDYospQuTwKgyjodp1DF
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

When a KeyUpdate arrives, kTLS blocks reads with -EKEYEXPIRED until
the user installs the next key. A kernel user such as nvme-tcp or
sunrpc never does, so the connection stalls.

For a socket with a registered RX secret, derive the next key and
install it when the KeyUpdate is decrypted. The record is not passed to
the user, so recvmsg(), splice() and read_sock() go on to the next
record. Without a registered secret the behavior is unchanged.

A KeyUpdate that is not alone in its record, has a wrong length or an
invalid request_update value ends the connection, as RFC 9846 section
4.7.3 requires. So does a peer that sends more than 8 KeyUpdates in one
second, the same limit as GnuTLS. That case is counted as
TlsRxRekeyError and logged, rate limited.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 include/net/tls.h       |   7 +++
 net/tls/Makefile        |   3 +-
 net/tls/tls.h           |   2 +
 net/tls/tls_keyupdate.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/tls/tls_sw.c        |  43 ++++++++++++--
 5 files changed, 202 insertions(+), 7 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index aacc6d12226e..a5bc28a7d1f5 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -63,6 +63,11 @@ struct tls_rec;
 
 #define TLS_HANDSHAKE_KEYUPDATE		24	/* rfc8446 B.3: Key update */
 
+/* KeyUpdate: msg_type, 24-bit length, request_update (RFC 9846 4.7.3) */
+#define TLS_KEYUPDATE_MSG_SIZE		5
+#define TLS_KEY_UPDATE_NOT_REQUESTED	0
+#define TLS_KEY_UPDATE_REQUESTED	1
+
 #define TLS_AAD_SPACE_SIZE		13
 
 /* SHA-384, the longest hash of a TLS 1.3 cipher suite kTLS supports */
@@ -142,6 +147,8 @@ struct tls_sw_context_rx {
 	u8 zc_capable:1;
 	u8 reader_contended:1;
 	bool key_update_pending;
+	u8 key_update_count;		/* received in this window */
+	unsigned long key_update_window;	/* jiffies */
 
 	struct tls_strparser strp;
 
diff --git a/net/tls/Makefile b/net/tls/Makefile
index 6edcf1271b75..ce8ac6a59f8c 100644
--- a/net/tls/Makefile
+++ b/net/tls/Makefile
@@ -7,6 +7,7 @@ CFLAGS_trace.o := -I$(src)
 
 obj-$(CONFIG_TLS) += tls.o
 
-tls-y := tls_main.o tls_sw.o tls_proc.o trace.o tls_strp.o tls_hkdf.o
+tls-y := tls_main.o tls_sw.o tls_proc.o trace.o tls_strp.o tls_hkdf.o \
+	 tls_keyupdate.o
 
 tls-$(CONFIG_TLS_DEVICE) += tls_device.o tls_device_fallback.o
diff --git a/net/tls/tls.h b/net/tls/tls.h
index b2061f6bf065..63ece8074985 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -149,6 +149,8 @@ int init_prot_info(struct tls_prot_info *prot,
 		   const struct tls_cipher_desc *cipher_desc);
 int tls_hkdf_expand_label(const u8 *secret, size_t secret_len,
 			  const char *label, u8 *out, size_t out_len);
+int tls_keyupdate_rekey(struct sock *sk, int tx);
+int tls_keyupdate_rx(struct sock *sk, struct sk_buff *skb);
 int tls_set_sw_offload(struct sock *sk, int tx,
 		       struct tls_crypto_info *new_crypto_info);
 void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
diff --git a/net/tls/tls_keyupdate.c b/net/tls/tls_keyupdate.c
new file mode 100644
index 000000000000..281c7b13eb82
--- /dev/null
+++ b/net/tls/tls_keyupdate.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Dell Technologies Inc. or its subsidiaries.
+ *
+ * TLS 1.3 KeyUpdate, RFC 9846 sections 4.7.3 and 7.2.
+ *
+ * A TLS 1.3 peer can change the key of the direction it sends in at any
+ * time. It sends a KeyUpdate message, then encrypts all later records
+ * with the next key. A sender must also change its key before the key
+ * has protected too many records (section 5.5).
+ *
+ * The next key is derived from the application traffic secret, not from
+ * the current key. User space gives the kernel only the key and IV, so
+ * the kernel cannot derive the next key on its own. Without the secret,
+ * a received KeyUpdate goes to the application, and the kernel stops
+ * decrypting until the application installs the next key with TLS_RX.
+ *
+ * With TLS_TX_TRAFFIC_SECRET or TLS_RX_TRAFFIC_SECRET, user space also
+ * gives the kernel the secret of that direction. The kernel then handles
+ * KeyUpdate itself. This file derives and installs the next key, and
+ * processes a received KeyUpdate. tls_sw.c sends KeyUpdate messages.
+ */
+
+#include <linux/jiffies.h>
+#include <linux/skbuff.h>
+#include <net/strparser.h>
+#include <net/tls.h>
+
+#include "tls.h"
+
+/* A peer that sends more KeyUpdates than this in one second ends the
+ * connection. Each one costs three HMACs and a new key, and carries no
+ * data.
+ */
+#define TLS_KEYUPDATE_RX_MAX_PER_SEC	8
+
+/**
+ * tls_keyupdate_rekey - install the next key of one direction
+ * @sk: socket
+ * @tx: non-zero for the transmit direction
+ *
+ * Derive the next application traffic secret from the registered one,
+ * then its key and IV, and install them. The record sequence number
+ * restarts at zero.
+ *
+ * Return: 0 on success, or a negative errno. On error the installed key
+ * and the registered secret do not change.
+ */
+int tls_keyupdate_rekey(struct sock *sk, int tx)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+	struct tls_traffic_secret *secret;
+	const struct tls_cipher_desc *cipher_desc;
+	u8 iv[TLS_MAX_SALT_SIZE + TLS_MAX_IV_SIZE];
+	u8 next[TLS_MAX_TRAFFIC_SECRET_SIZE];
+	union tls_crypto_context tmp = {};
+	struct tls_crypto_info *info = &tmp.info;
+	int rc;
+
+	secret = tx ? &ctx->tx_secret : &ctx->rx_secret;
+	cipher_desc = get_cipher_desc(ctx->prot_info.cipher_type);
+	if (!cipher_desc || !secret->len ||
+	    cipher_desc->salt + cipher_desc->iv > sizeof(iv))
+		return -EINVAL;
+
+	/* version and cipher_type; the rest of tmp stays zero */
+	*info = tx ? ctx->crypto_send.info : ctx->crypto_recv.info;
+
+	rc = tls_hkdf_expand_label(secret->data, secret->len, "traffic upd",
+				   next, secret->len);
+	if (rc)
+		goto out;
+
+	rc = tls_hkdf_expand_label(next, secret->len, "key",
+				   crypto_info_key(info, cipher_desc),
+				   cipher_desc->key);
+	if (rc)
+		goto out;
+
+	rc = tls_hkdf_expand_label(next, secret->len, "iv", iv,
+				   cipher_desc->salt + cipher_desc->iv);
+	if (rc)
+		goto out;
+
+	memcpy(crypto_info_salt(info, cipher_desc), iv, cipher_desc->salt);
+	memcpy(crypto_info_iv(info, cipher_desc), iv + cipher_desc->salt,
+	       cipher_desc->iv);
+
+	rc = tls_set_sw_offload(sk, tx, info);
+	if (rc)
+		goto out;
+
+	memcpy(secret->data, next, secret->len);
+
+out:
+	memzero_explicit(next, sizeof(next));
+	memzero_explicit(iv, sizeof(iv));
+	memzero_explicit(&tmp, sizeof(tmp));
+
+	return rc;
+}
+
+/**
+ * tls_keyupdate_rx - process a received KeyUpdate
+ * @sk: socket
+ * @skb: the decrypted record, which starts with a KeyUpdate message
+ *
+ * Called with the socket locked, for a direction with a registered
+ * secret. The caller does not pass the record to the user.
+ *
+ * Return: 0 on success, or a negative errno if the connection must end.
+ */
+int tls_keyupdate_rx(struct sock *sk, struct sk_buff *skb)
+{
+	struct tls_context *ctx = tls_get_ctx(sk);
+	struct tls_sw_context_rx *rx_ctx = tls_sw_ctx_rx(ctx);
+	const struct strp_msg *rxm = strp_msg(skb);
+	u8 msg[TLS_KEYUPDATE_MSG_SIZE];
+	int rc;
+
+	/* A KeyUpdate must end its record (section 5.1). Another message
+	 * in the same record is not supported.
+	 */
+	if (rxm->full_len != sizeof(msg) ||
+	    skb_copy_bits(skb, rxm->offset, msg, sizeof(msg)))
+		return -EBADMSG;
+
+	/* msg_type, a 24-bit length of 1, then request_update */
+	if (msg[1] || msg[2] || msg[3] != 1)
+		return -EBADMSG;
+	if (msg[4] != TLS_KEY_UPDATE_NOT_REQUESTED &&
+	    msg[4] != TLS_KEY_UPDATE_REQUESTED)
+		return -EBADMSG;
+
+	if (!rx_ctx->key_update_count ||
+	    time_after(jiffies, rx_ctx->key_update_window + HZ)) {
+		rx_ctx->key_update_window = jiffies;
+		rx_ctx->key_update_count = 0;
+	}
+	if (++rx_ctx->key_update_count > TLS_KEYUPDATE_RX_MAX_PER_SEC) {
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYERROR);
+		net_warn_ratelimited("tls: peer sent more than %d KeyUpdates in one second\n",
+				     TLS_KEYUPDATE_RX_MAX_PER_SEC);
+		return -EBADMSG;
+	}
+
+	rc = tls_keyupdate_rekey(sk, 0);
+	if (rc) {
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYERROR);
+		return rc;
+	}
+	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
+
+	return 0;
+}
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 771e02bff519..027c32edaf85 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1551,15 +1551,28 @@ static int tls_check_pending_rekey(struct sock *sk, struct tls_context *ctx,
 	if (hs_type == TLS_HANDSHAKE_KEYUPDATE) {
 		struct tls_sw_context_rx *rx_ctx = ctx->priv_ctx_rx;
 
-		WRITE_ONCE(rx_ctx->key_update_pending, true);
 		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYRECEIVED);
+
+		if (ctx->rx_secret.len) {
+			err = tls_keyupdate_rx(sk, skb);
+			if (err) {
+				tls_err_abort(sk, err);
+				/* callers free the record only on success */
+				consume_skb(skb);
+				return err;
+			}
+			return 1;
+		}
+
+		WRITE_ONCE(rx_ctx->key_update_pending, true);
 	}
 
 	return 0;
 }
 
 /* On decrypt failure the connection is aborted (sk_err set) before
- * returning a negative errno.
+ * returning a negative errno. Return 1 for a record the kernel consumed
+ * (a KeyUpdate): the caller frees it and does not pass it to the user.
  */
 static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 			     struct tls_decrypt_arg *darg)
@@ -1883,6 +1896,11 @@ int tls_sw_recvmsg(struct sock *sk,
 		err = tls_rx_one_record(sk, msg, &darg);
 		if (err < 0)
 			goto recv_end;
+		if (err > 0) {
+			tls_rx_rec_done(ctx);
+			consume_skb(darg.skb);
+			continue;
+		}
 
 		async |= darg.async;
 
@@ -2023,9 +2041,8 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	if (err)
 		goto splice_read_end;
 
-	if (!skb_queue_empty(&ctx->rx_list)) {
-		skb = __skb_dequeue(&ctx->rx_list);
-	} else {
+	skb = __skb_dequeue(&ctx->rx_list);
+	while (!skb) {
 		struct tls_decrypt_arg darg;
 
 		err = tls_rx_rec_wait(sk, nonblock, true, false);
@@ -2039,7 +2056,10 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 			goto splice_read_end;
 
 		tls_rx_rec_done(ctx);
-		skb = darg.skb;
+		if (err > 0)
+			consume_skb(darg.skb);
+		else
+			skb = darg.skb;
 	}
 
 	rxm = strp_msg(skb);
@@ -2121,6 +2141,11 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 			err = tls_rx_one_record(sk, NULL, &darg);
 			if (err < 0)
 				goto read_sock_end;
+			if (err > 0) {
+				tls_rx_rec_done(ctx);
+				consume_skb(darg.skb);
+				continue;
+			}
 
 			released = tls_read_flush_backlog(sk, prot, INT_MAX,
 							  0, decrypted,
@@ -2520,6 +2545,12 @@ static void tls_finish_key_update(struct sock *sk, struct tls_context *tls_ctx)
 {
 	struct tls_sw_context_rx *ctx = tls_ctx->priv_ctx_rx;
 
+	/* Only a pending KeyUpdate holds poll() back. The in-kernel rekey
+	 * runs while the KeyUpdate record is still queued.
+	 */
+	if (!READ_ONCE(ctx->key_update_pending))
+		return;
+
 	WRITE_ONCE(ctx->key_update_pending, false);
 	/* wake-up pre-existing poll() */
 	ctx->saved_data_ready(sk);

-- 
2.53.0



