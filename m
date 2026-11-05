Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E6A6082BCB
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VuTVCYM9;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQvYsS5B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kH3aeQG1zjkky2iTwwiZsNSmhO92m6g31TTG4/mfG38=; b=VuTVCYM9outWif
	g/4S9Fff7UFcxVc/aXireuTBRM/Be73raq1ERlgIiX+SPT1UL7i2qHyO8zOK6Vxu5nyVJzQxvHDj7
	FjlGYutMjopnRLWnm9PsxSGKSXiOFn8lJ8j5ZkRw4r4kvYAsfGPbZf5X80bTL0enfdBP1495zvUDA
	9Fj9DOyDWPRXXzUJgu0zQVPxIWf1GwKttpW89/Lerk2CCGJ+4abzgFfUaESI1UqWXqftek9lHFH+9
	5wKJ9/pj9+WpNY+cVoO0yvoyz95anZNSLaR+g3179RkKMGR9MQkzVqG+fus9GZNtBjVjJjlLTsjlT
	oVWlCAqnKGl27aTBZmxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0MY-00000009cAd-27VK;
	Thu, 05 Nov 2026 16:30:54 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP0MM-00000009c61-3ApB
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 16:30:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 28BE3609FF;
	Thu,  5 Nov 2026 16:30:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793896241;
	b=D9bIsKbVMEAoVAyx45tXiJykYOVB/t/oLe/G+T6BWfsf2AulympFKqDRcKwQWOKAaPUH
	 7IBFTgpryqcHCP3McNEJk7B+WN44S434x4TQBH3r14319TvyLTFsu9DzXGAL4V2GTErJd
	 MCsjGmc2DOvv8cx5GxooUd7k5wueHpwE7muTpYLsKODZB8TkG2YmOoMklhMpjcBt1W6D4
	 P5vjpSPnFE9t1FXyHLlT5+mId5AwTF1fsfMDB5YoaFnyZdqGShnB+/wP6et+bUZbSQRc7
	 vvsMk3Z9wWBK3yytOzzKPKfkImcV4qx69WW/cTHhyaRgAWjLfAa0ePpSFPVN0XyRRFQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793896241;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=kH3aeQG1zjkky2iTwwiZsNSmhO92m6g31TTG4/mfG38=;
	b=xTHZAL9c/ywuJInuMkMZz+UZrLYRUEFJ2OaXdRhdFUxnx+q6jHSuYl9o3j5FwfHBEjg9
	 zqlKhurMuCB1V9EDtX5Dr46WR/LYTdmhwPeLop7vO+ehkUphMsN+ednGj4DEDcbaSMl2i
	 fYyE3gT8bmxn8EP4SKQXLBGTi4Mvg3uGLh3MJEylYX5r82CvDNmkYwOwJixtFpfUpfkcN
	 JJc+llW1WsMLKAE1jCrD7LMsB3aZVYbS83WbXkO4Szp0FG+fW90NXZ7h9KXz6yXZ/rZUt
	 xJtvNtfjIhJFJ68OJ8h7JmaTs7RTlp1jDiA8+aF77QHpjYBshnSnuthp34uCcjOYUhQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1450C1F00A15;
	Thu,  5 Nov 2026 16:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896241;
	bh=kH3aeQG1zjkky2iTwwiZsNSmhO92m6g31TTG4/mfG38=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hQvYsS5BIgtggtu8HSqIUIrfX+REPbHJKs4TcufksdplAOak/hm8G4Jx0t1DXI9Zx
	 OOm+rYBRysu0RzIz1OdDbQl5w6ShiaCtT8WpryYCEGILsirzomT1PtxSMNW0Dllz7b
	 bPJEM+XzksarHvY15qi3H0jRc7yavLaqSLPn1E6gx3qhb0f9+y0pa3FrC/x/xpAyNN
	 Ln16/jYbbnouX0BVpYTreavkxqGC1wD6luB/sIwwOj08pfgvgj+hwCw4+QcNK7/3bO
	 o1VSb171fxNdT1OaBroaJNvFJgmYD0pQRrgO+GpgFT+/7o7fyLA4APEhaMqjGMlEIo
	 O7pbG2MD/92hw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 970584732C;
	Thu,  5 Nov 2026 16:30:39 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Thu, 05 Nov 2026 11:30:40 -0500
Subject: [PATCH net-next v6 4/6] tls: update the RX key when a KeyUpdate is
 received
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-keyupdate-rfc-v6-4-99b695f9eb4f@gmail.com>
References: <20261105-keyupdate-rfc-v6-0-99b695f9eb4f@gmail.com>
In-Reply-To: <20261105-keyupdate-rfc-v6-0-99b695f9eb4f@gmail.com>
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
 Martin Belanger <martin.nvme.dev@gmail.com>, 
 Martin Belanger <martin.belanger@dell.com>, 
 Daniel Pereira <danielmaraboo@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793896238; l=11213;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=dsc8bTbjua1Q1639nENGEqhwASElOJ5OhNYJ4v5pDYw=;
 b=vhJkvKrpYBfq/dzyjkSAYUjjUCx5puiHXm/yI3q4pdszyNUg4M/oKR0xvtcEhN/jHKeLifFQH
 AkDuLHO/X9jBxqd6CFZFMVm1xzsgZ+E6h5zA4LJ+JTAGB0hk0Jt+UIQ
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

Reviewed-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Martin Belanger <martin.belanger@dell.com>
Reviewed-by: Daniel Pereira <danielmaraboo@gmail.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 include/net/tls.h       |   7 +++
 net/tls/Makefile        |   3 +-
 net/tls/tls.h           |   2 +
 net/tls/tls_keyupdate.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/tls/tls_sw.c        |  38 +++++++++++-
 5 files changed, 201 insertions(+), 4 deletions(-)

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
index 000000000000..49f45d892262
--- /dev/null
+++ b/net/tls/tls_keyupdate.c
@@ -0,0 +1,155 @@
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
+	union tls_crypto_context tmp;
+	struct tls_crypto_info *info = (void *)&tmp;
+	int rc;
+
+	secret = tx ? &ctx->tx_secret : &ctx->rx_secret;
+	cipher_desc = get_cipher_desc(ctx->prot_info.cipher_type);
+	if (!cipher_desc || !secret->len ||
+	    cipher_desc->salt + cipher_desc->iv > sizeof(iv))
+		return -EINVAL;
+
+	/* version and cipher_type; the rest of tmp stays zero */
+	memset(&tmp, 0, sizeof(tmp));
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
index 7f7a2f70b02a..027c32edaf85 100644
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
 
@@ -2038,7 +2056,10 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 			goto splice_read_end;
 
 		tls_rx_rec_done(ctx);
-		skb = darg.skb;
+		if (err > 0)
+			consume_skb(darg.skb);
+		else
+			skb = darg.skb;
 	}
 
 	rxm = strp_msg(skb);
@@ -2120,6 +2141,11 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
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
@@ -2519,6 +2545,12 @@ static void tls_finish_key_update(struct sock *sk, struct tls_context *tls_ctx)
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



