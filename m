Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA73606A326
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GMVHHtF/;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M5sVcatE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jEfZ5R4FSozjLO0Zv56VX5Utg/dxxI39TSzbY5TNJdM=; b=GMVHHtF/5Z/Ucw
	6YZNXJJMDduXnphQXWAHiqefwfgHQhjYgaUEv9vcQhN2ouEpkfsHEmRFXLHdsVc4+NOVh18Ns29f/
	Dvodsc8uoJ2W2xcE6Bd+/16rVedXccnEvKZRrjrLMbM83J96Zj7C28KcK1PkWyslS7lkhB9M8Rrnf
	CaqCkN+MB/glB+qKzE3YRBEt6Fz/O49LFwOjZdjUpj6AChWkMW2nDdegpXMp0eJoATeWyIAAqMxBJ
	3ILQtBZKos2yuiaZW+qZtH2NbntoTnSaCrak0AmQMr5trc0HdWVLqyfEnRpU7zSUPWorjr9TP+57Y
	FsxtZzB8THhndAaNIQ9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL8ht-00000001X5a-2VUm;
	Mon, 26 Oct 2026 00:36:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL8hr-00000001X3o-11cl
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 00:36:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3B6326025F;
	Mon, 26 Oct 2026 00:36:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792975013;
	b=yq0vq6HJ24geOgAD1LuBi07GJ5b1M+BIz1XoW9CDoBXSQiGHHdCn6SkCmfCJMetX4QaL
	 GfjXHediy2dNA5SygK8DroUjz/gnSpb4Mnnvih8U5OXwbGzMDeZDTdfKOBiHo+mO54/0v
	 SiFcSV7vK51W26KpjPB5WlvHXElVnBKGSx/ojLYs/RFxFB5go9/fB4X2QIGHIYDpC6/rX
	 CaVHdGpP1/ZunBL5/o1KS+dRc5RLVcjDOQT/HQKaEPnq0vL/LF+7wx9xW0xzrrVEXKa1s
	 1XmJqMVSeXRXcRxp7Hq1TsVKGJTebWs2ZEyOo4tToqBnAucs8+KP7kZFuyC/ml6EcjQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792975013;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=jEfZ5R4FSozjLO0Zv56VX5Utg/dxxI39TSzbY5TNJdM=;
	b=dBdxqq9NXw1VOUKK4qpt/I+0lc6IWSR24ZMTbqj6RkRzw9CLkxZX1eFZDA+90BVn0GMW
	 Q9cLOMwk5DN2k3Evc+33s1i8jY3+Hix/lpNW2CDeIjaVgdARxd6UfJ6W/7O4m7eQRPZl7
	 F0KsGNbF/c4WpRdhGVer86boiz4Y+Q+CoNBPMDQeQVi4wtBpo9SAMFDhn4AwnUpQ0FuZ0
	 06vUW3UjP3V+QOPaRza6CGsUV2pb6aXm5p0+gFTbsNrktnPMYmLqwg4cf6xeRYMPIwP7p
	 gwChPkGK6VbgTJOMGCO8zpCBN5eht2tWyo5bi0tsbL1Y6Mp83opNbISdaaCQ3XI27VA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C931C1F01825;
	Mon, 26 Oct 2026 00:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792975013;
	bh=jEfZ5R4FSozjLO0Zv56VX5Utg/dxxI39TSzbY5TNJdM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=M5sVcatEIZ2QvoKm5g1gGwF+QGjnksRy9D6rrsbVx4El4yZLqpbjCHc/z3VbJ5E/W
	 ElvGjuQ5EmnsQnPon8k0IoIlgiWjNEqOFYMS+6o2f1Q2uTT/N0omO1Fnz1NNXWtScG
	 kl4adT7eKE7vQ9IXTiQDxIB9mKsovJq1SQwFlwzsKSIO0qhLTevlp/1SVJCBMMT8CD
	 3VzhuC3+OdY37mHymYuzms0Q3an3SUCOsvTy5A6jhIFzzMl+8ybsbra5TuKE7u8vbJ
	 leXaOxD7YMMf+TnDzEGcYSItMlwfvSW902iH1q3LyNiL9+Qg2SXg/sXKN6Kia4cRum
	 UCMmfXMe7+cHA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 33FAF44B35;
	Mon, 26 Oct 2026 00:36:51 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Sun, 25 Oct 2026 20:36:48 -0400
Subject: [PATCH RFC net-next 1/5] tls: add HKDF-Expand-Label for the TLS
 1.3 key schedule
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-keyupdate-rfc-v1-1-60b7756eccbd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792975010; l=5260;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=KFb/WEz4iFeKmXNASo0mrUcGnSDIwkKN7bp4a4n7vAw=;
 b=11as8MymhIqjTUV33YbNlHSCn+8eFNAFoLHlPaUSFZLiwaVGnlI1Z9yvksdSX6rBSU1CsePy0
 rhKPHLDxLE+A1fWltSiJWemh4K40WlemrBL0FOyyZ6QFBQjzIcki8Qp
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

A TLS 1.3 KeyUpdate derives the next traffic secret, key and IV with
HKDF-Expand-Label (RFC 9846, section 7.2). Add the helper for the
kernel to do this itself.

Only the part of the key schedule after the handshake is needed. The
input is a traffic secret, which is already a pseudorandom key, so
HKDF-Extract is not needed. Each output is at most Hash.length bytes,
so each derivation is a single HMAC with the library SHA-256 or SHA-384
functions.

Assisted-by: LLM
Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 net/tls/Kconfig    |  2 ++
 net/tls/Makefile   |  2 +-
 net/tls/tls.h      |  2 ++
 net/tls/tls_hkdf.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/net/tls/Kconfig b/net/tls/Kconfig
index 4f4d5973a28f..6183ebe954ee 100644
--- a/net/tls/Kconfig
+++ b/net/tls/Kconfig
@@ -8,6 +8,8 @@ config TLS
 	select CRYPTO
 	select CRYPTO_AES
 	select CRYPTO_GCM
+	select CRYPTO_LIB_SHA256
+	select CRYPTO_LIB_SHA512
 	select NET_SOCK_MSG
 	default n
 	help
diff --git a/net/tls/Makefile b/net/tls/Makefile
index 4c7d296081ee..6edcf1271b75 100644
--- a/net/tls/Makefile
+++ b/net/tls/Makefile
@@ -7,6 +7,6 @@ CFLAGS_trace.o := -I$(src)
 
 obj-$(CONFIG_TLS) += tls.o
 
-tls-y := tls_main.o tls_sw.o tls_proc.o trace.o tls_strp.o
+tls-y := tls_main.o tls_sw.o tls_proc.o trace.o tls_strp.o tls_hkdf.o
 
 tls-$(CONFIG_TLS_DEVICE) += tls_device.o tls_device_fallback.o
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 60a37bdaaa25..b2061f6bf065 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -147,6 +147,8 @@ void tls_strp_abort_strp(struct tls_strparser *strp, int err);
 int init_prot_info(struct tls_prot_info *prot,
 		   const struct tls_crypto_info *crypto_info,
 		   const struct tls_cipher_desc *cipher_desc);
+int tls_hkdf_expand_label(const u8 *secret, size_t secret_len,
+			  const char *label, u8 *out, size_t out_len);
 int tls_set_sw_offload(struct sock *sk, int tx,
 		       struct tls_crypto_info *new_crypto_info);
 void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
diff --git a/net/tls/tls_hkdf.c b/net/tls/tls_hkdf.c
new file mode 100644
index 000000000000..49e33146ac7e
--- /dev/null
+++ b/net/tls/tls_hkdf.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Dell Technologies Inc. or its subsidiaries.
+ *
+ * TLS 1.3 HKDF-Expand-Label, RFC 9846 section 7.1.
+ *
+ * TLS 1.3 derives all of its secrets and keys with HKDF (RFC 5869). The
+ * TLS handshake runs in user space and gives the kernel one application
+ * traffic secret for each direction. For a KeyUpdate, the kernel derives
+ * the next traffic secret from the current one (section 7.2), and the
+ * new key and IV from the next traffic secret (section 7.3). Both steps
+ * use only HKDF-Expand-Label, so this file implements only that
+ * function, not the full key schedule of the handshake.
+ *
+ * The input is always a traffic secret. It is already a random key of
+ * the hash length, so HKDF-Extract is not needed. No output is longer
+ * than the hash, so HKDF-Expand is a single HMAC.
+ */
+
+#include <crypto/sha2.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/unaligned.h>
+
+#include "tls.h"
+
+#define TLS_HKDF_LABEL_PREFIX		"tls13 "
+#define TLS_HKDF_LABEL_PREFIX_LEN	(sizeof(TLS_HKDF_LABEL_PREFIX) - 1)
+#define TLS_HKDF_LABEL_MAX		32
+
+/**
+ * tls_hkdf_expand_label - HKDF-Expand-Label with an empty context
+ * @secret: the secret
+ * @secret_len: length of @secret, which selects the hash: SHA-256 for
+ *	SHA256_DIGEST_SIZE, SHA-384 for SHA384_DIGEST_SIZE
+ * @label: the label, without the "tls13 " prefix
+ * @out: output buffer
+ * @out_len: number of bytes to derive, at most @secret_len
+ *
+ * Return: 0 on success, -EINVAL if a length is not valid.
+ */
+int tls_hkdf_expand_label(const u8 *secret, size_t secret_len,
+			  const char *label, u8 *out, size_t out_len)
+{
+	u8 info[2 + 1 + TLS_HKDF_LABEL_PREFIX_LEN + TLS_HKDF_LABEL_MAX + 1 + 1];
+	size_t label_len = strlen(label);
+	u8 tmp[SHA384_DIGEST_SIZE];
+	size_t pos = 0;
+
+	if (secret_len != SHA256_DIGEST_SIZE &&
+	    secret_len != SHA384_DIGEST_SIZE)
+		return -EINVAL;
+	if (!out_len || out_len > secret_len || label_len > TLS_HKDF_LABEL_MAX)
+		return -EINVAL;
+
+	/* struct {
+	 *	uint16 length;
+	 *	opaque label<7..255>;
+	 *	opaque context<0..255>;
+	 * } HkdfLabel;
+	 *
+	 * followed by the HKDF-Expand counter for the first output block.
+	 */
+	put_unaligned_be16(out_len, info);
+	pos += 2;
+	info[pos++] = TLS_HKDF_LABEL_PREFIX_LEN + label_len;
+	memcpy(info + pos, TLS_HKDF_LABEL_PREFIX, TLS_HKDF_LABEL_PREFIX_LEN);
+	pos += TLS_HKDF_LABEL_PREFIX_LEN;
+	memcpy(info + pos, label, label_len);
+	pos += label_len;
+	info[pos++] = 0;	/* empty context */
+	info[pos++] = 1;	/* counter */
+
+	if (secret_len == SHA256_DIGEST_SIZE)
+		hmac_sha256_usingrawkey(secret, secret_len, info, pos, tmp);
+	else
+		hmac_sha384_usingrawkey(secret, secret_len, info, pos, tmp);
+
+	memcpy(out, tmp, out_len);
+	memzero_explicit(tmp, sizeof(tmp));
+
+	return 0;
+}

-- 
2.53.0



