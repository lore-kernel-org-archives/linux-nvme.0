Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91588606A329
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 00:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=J2UPGnu9;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+nqkzuM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=TPtorLgwbu04SO30Jsep8IejcWBvFK3cB0f2sKfPiYc=; b=J2UPGnu9K6DN63
	xnsnhDKRb01j4A7tCx2nScOCLRzqGwVvUFug3XAxW1QRpTgGrfuX1E/BdLzUTByKO+rvDQYrxUHVB
	0KGP8G24CFAfWXQyf3C9ravB41rMuwB2r8XUjhZgbyPJyhaGwtVREuJMmqTVBDDSUXV9MNqzJZjEA
	JQd59uM+dosMsPavi1pTufvNkgTsJTJNDFToh9ehrGWzr5i+bSOIUPk9mrQvk9WEDKn5mZS/9A3KB
	1ZZwTKSgq1XtH8mmk+mwKD2zUakLvWZ+TC2v1KldcRzXITx/RMpf/PiGNhCQIsEgaAPYSUT68C3na
	sP5Pf0sjFTGjhIw7CNyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL8hq-00000001X3q-2WPK;
	Mon, 26 Oct 2026 00:36:54 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL8hp-00000001X3W-2TfB
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 00:36:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0FF2B43E3B;
	Mon, 26 Oct 2026 00:36:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792975012;
	b=l2QNzJiiAxKQSvNR/9GUvxMQfbpRDIVLOcx3lkd9x93CFrfUpVByF/dIJy2MkqE7HAbc
	 aBjv/pWqEDX/xEEDGvKKyacZkLS0bhv5Qs0PxZu1P7wf2Tk/A+k7cD6udeZA9CTSmHzYk
	 3Y8UPtOfcS/M85sCk6UPhdKib4YQoSnShkBMd7+qOo6RwnnIs9QtFu8Lw0PfgAohPrdA7
	 55hVbFzEqSJCZHy43Or/J5+hlpX051+hZ2Nt/o/VgbgYxXeF+hqMDNLUyWSqd9giv8Wgi
	 XBnYlwZLKxArvzZa+f01Eos7bvq92mwNFLYg6Ew2oFl0AcbkATg0EZNhZLGvRZ+IJ+w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792975012;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=TPtorLgwbu04SO30Jsep8IejcWBvFK3cB0f2sKfPiYc=;
	b=imSDd+G9n64uGJUH0M0eMdt+bbAvcRmhxndxwP1R6CgqJyFpUGiRCQ9FdALUxpuerfy4
	 pCVGKSAS+smQC91V6DfWatt0fOz30lOvBxnJajOayRl8+ABrx/gqAgvsYtYntOPM9Ne8W
	 1D3b6DxeLD939eNQANkurAw0a7O41MmmET6oBeHUoyMNOHGXJpOUSN3g2EtDBHOFuEf3m
	 vVsuBQq9UkiLkGJWpERKdbZL2Hl1F5ZjR6MKlof+ztAAhNQXyhdK3uIU+CUNjhnP4Bzv6
	 vNO0GL4SzQoawxYwMgGUnW2sOZlZmnjWRwnBBRpmRra75TVtd3RIGvgyv3+pIOLui3g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C93B31F01828;
	Mon, 26 Oct 2026 00:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792975012;
	bh=TPtorLgwbu04SO30Jsep8IejcWBvFK3cB0f2sKfPiYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=i+nqkzuMiuA0w2K1AHO5buAA2EinWyMWEBcumn9OfophNmCXeHC8pd/47E1GNzGdM
	 qz/otkurVRI+YefuTv/VMRGylKj9HMquW+0txAdd8EJbUfVRDQb5yz/kLEJrniMbqF
	 k7UT0kAJdAJhgTw5RFjmiPqsktSpIZKZ53e9HyeNSV9By1DAis9QhK2ur5u+3k3Ano
	 tBRot6Lmzhc67xNYrIukSVVs08tpJyK8xpF3RH+quLj4Y8TjMBkPmp7xuzLkabXIyO
	 JPMMoXniXAivvpJjpigheyygJORNyBS+FqFQDcU9Rk4tJ7tYgMYAk9H2XD4SzPPASu
	 xoOxnbSYREh/Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 471D844B66;
	Mon, 26 Oct 2026 00:36:51 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Sun, 25 Oct 2026 20:36:50 -0400
Subject: [PATCH RFC net-next 3/5] tls: update the RX key when a KeyUpdate
 is received
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-keyupdate-rfc-v1-3-60b7756eccbd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792975010; l=10616;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=oxgRhUT/L6/dPSDTa2YMv2hVUTi45v/ZMA1ysGHsZdU=;
 b=xdYJWDmuJIParGA5ZNyNV4XcZnEWcAFbNpe8/LayNId15RWTu1cj9/NtjtjbM4kPLvK/cKziK
 AY5t9cTPPkpBhKBwMA/iEqyEyWuil7CL9X1MC8gV/KGnBheD4v9+g4H
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
second, the same limit as GnuTLS.

Assisted-by: LLM
Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 include/net/tls.h       |   7 +++
 net/tls/Makefile        |   3 +-
 net/tls/tls.h           |   2 +
 net/tls/tls_keyupdate.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/tls/tls_sw.c        |  35 +++++++++--
 5 files changed, 190 insertions(+), 7 deletions(-)

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
index 000000000000..543bf57599c7
--- /dev/null
+++ b/net/tls/tls_keyupdate.c
@@ -0,0 +1,150 @@
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
+	if (++rx_ctx->key_update_count > TLS_KEYUPDATE_RX_MAX_PER_SEC)
+		return -EBADMSG;
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
index 312e51270f29..a314fa638dc3 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1551,15 +1551,26 @@ static int tls_check_pending_rekey(struct sock *sk, struct tls_context *ctx,
 	if (hs_type == TLS_HANDSHAKE_KEYUPDATE) {
 		struct tls_sw_context_rx *rx_ctx = ctx->priv_ctx_rx;
 
-		WRITE_ONCE(rx_ctx->key_update_pending, true);
 		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYRECEIVED);
+
+		if (ctx->rx_secret.len) {
+			err = tls_keyupdate_rx(sk, skb);
+			if (err) {
+				tls_err_abort(sk, err);
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
@@ -1883,6 +1894,11 @@ int tls_sw_recvmsg(struct sock *sk,
 		err = tls_rx_one_record(sk, msg, &darg);
 		if (err < 0)
 			goto recv_end;
+		if (err > 0) {
+			tls_rx_rec_done(ctx);
+			consume_skb(darg.skb);
+			continue;
+		}
 
 		async |= darg.async;
 
@@ -2019,9 +2035,8 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	if (err)
 		goto splice_read_end;
 
-	if (!skb_queue_empty(&ctx->rx_list)) {
-		skb = __skb_dequeue(&ctx->rx_list);
-	} else {
+	skb = __skb_dequeue(&ctx->rx_list);
+	while (!skb) {
 		struct tls_decrypt_arg darg;
 
 		err = tls_rx_rec_wait(sk, flags & SPLICE_F_NONBLOCK,
@@ -2036,7 +2051,10 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 			goto splice_read_end;
 
 		tls_rx_rec_done(ctx);
-		skb = darg.skb;
+		if (err > 0)
+			consume_skb(darg.skb);
+		else
+			skb = darg.skb;
 	}
 
 	rxm = strp_msg(skb);
@@ -2118,6 +2136,11 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
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

-- 
2.53.0



