Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96114C44529
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 14:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MfzW64IqlFOm9N3cNKZG0XElklhfVlPozs5pACA20uY=; b=wFNponVxRwRPrEVyIgs4yD2/Xb
	QAtWL7kdGeSJB6UPcMxa60VHww600pwHLCqFi3xzPfTdV2t17ZCGBoCynWZL2eYSsaOu7rWQX7Vm4
	r/1ixetnaJTP4nqOdzE9XfJbDtbr9rwaTmHmrVonJzZq8x9JhhaC7jcj2jjEMxDFZ0xrsQrta7KwV
	S5LOwIQZuyyAiy17eOcnS/QMt3/mQdylI4x6o9iGNmd4nNdhSPKXdPXYC6UXNflEtlZp1Fhj/vxq6
	Xhg5misW/5kH8CYB6fCvcF7+nPEH3ZEpa6APwDOGN3iqjG3FP1iyr71ntN/cp0+r+zK0owRDq0sqj
	9TfshqJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmB8b-00000009c7P-0aXq;
	Tue, 21 Jul 2026 14:08:01 +0000
Received: from mout-b-203.mailbox.org ([195.10.208.52])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmB8Y-00000009c62-0w6Y
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 14:07:59 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4h4K3H1FNjzLlrV;
	Tue, 21 Jul 2026 16:07:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1784642875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MfzW64IqlFOm9N3cNKZG0XElklhfVlPozs5pACA20uY=;
	b=JfcLgWp3YwVpfMKAzDqPorRz0sTU6tAS9ht+8ttoZndQCly1IJGOwdDeEKI+5EI6x7X/Ao
	4gbGfFzCPr9xykaZsNVen7OmNX5d6OL6eumW7I6dxKP/BCWTw7VJaYYspLvVJhWruhYrIg
	/jKFnNMiyISS+shvLdhcWnNn5kOXaIih1Y0d22NbYkpWXKDcfCwC+yqFSOEzIua81AMf9W
	LwPWG4vy+udrNmgmSrVABojrrUKIHHF6wA4OX1pAimgo2MHTJ+uUBNYYuO08bAge9sBdlH
	gJzPUQmqZuf5XersvXiSf3WDIKb/cX9EmKNv4rMk2Aw9aBPkfrHUf79r603khQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of marco@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marco@mandelbit.com
From: Marco Baffo <marco@mandelbit.com>
To: linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	ebiggers@kernel.org,
	Jason@zx2c4.com,
	ardb@kernel.org,
	tytso@mit.edu,
	jaegeuk@kernel.org,
	linux-fscrypt@vger.kernel.org,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de,
	linux-nvme@lists.infradead.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	antonio@openvpn.net,
	sd@queasysnail.net,
	linux-kernel@vger.kernel.org,
	Marco Baffo <marco@mandelbit.com>
Subject: [PATCH 3/5] fscrypt: use HKDF library functions
Date: Tue, 21 Jul 2026 16:06:42 +0200
Message-ID: <20260721140644.780006-4-marco@mandelbit.com>
In-Reply-To: <20260721140644.780006-1-marco@mandelbit.com>
References: <20260721140644.780006-1-marco@mandelbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4h4K3H1FNjzLlrV
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_070758_412720_3543393D 
X-CRM114-Status: GOOD (  15.28  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Convert fscrypt to the common HKDF-SHA512 helpers without changing its
derived keys. The info bytes are processed in the same order as before.
An empty salt is equivalent to the previous 64-byte all-zero salt after
HMAC key padding.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 fs/crypto/hkdf.c | 56 +++++++++++-------------------------------------
 1 file changed, 13 insertions(+), 43 deletions(-)

diff --git a/fs/crypto/hkdf.c b/fs/crypto/hkdf.c
index 706f56d0076e..7df7d466a3e4 100644
--- a/fs/crypto/hkdf.c
+++ b/fs/crypto/hkdf.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Implementation of HKDF ("HMAC-based Extract-and-Expand Key Derivation
- * Function"), aka RFC 5869.  See also the original paper (Krawczyk 2010):
- * "Cryptographic Extraction and Key Derivation: The HKDF Scheme".
+ * Key derivation using HKDF-SHA512.
  *
  * This is used to derive keys from the fscrypt master keys (or from the
  * "software secrets" which hardware derives from the fscrypt master keys, in
@@ -11,6 +9,8 @@
  * Copyright 2019 Google LLC
  */
 
+#include <crypto/hkdf.h>
+
 #include "fscrypt_private.h"
 
 /*
@@ -24,19 +24,11 @@
  * HKDF-SHA512 being much faster than HKDF-SHA256, as the longer digest size of
  * SHA-512 causes HKDF-Expand to only need to do one iteration rather than two.
  */
-#define HKDF_HASHLEN		SHA512_DIGEST_SIZE
 
 /*
- * HKDF consists of two steps:
- *
- * 1. HKDF-Extract: extract a pseudorandom key of length HKDF_HASHLEN bytes from
- *    the input keying material and optional salt.
- * 2. HKDF-Expand: expand the pseudorandom key into output keying material of
- *    any length, parameterized by an application-specific info string.
- *
  * HKDF-Extract can be skipped if the input is already a pseudorandom key of
- * length HKDF_HASHLEN bytes.  However, cipher modes other than AES-256-XTS take
- * shorter keys, and we don't want to force users of those modes to provide
+ * length SHA512_DIGEST_SIZE bytes.  However, cipher modes other than AES-256-XTS
+ * take shorter keys, and we don't want to force users of those modes to provide
  * unnecessarily long master keys.  Thus fscrypt still does HKDF-Extract.  No
  * salt is used, since fscrypt master keys should already be pseudorandom and
  * there's no way to persist a random salt per master key from kernel mode.
@@ -50,13 +42,7 @@
 void fscrypt_init_hkdf(struct hmac_sha512_key *hkdf, const u8 *master_key,
 		       unsigned int master_key_size)
 {
-	static const u8 default_salt[HKDF_HASHLEN];
-	u8 prk[HKDF_HASHLEN];
-
-	hmac_sha512_usingrawkey(default_salt, sizeof(default_salt),
-				master_key, master_key_size, prk);
-	hmac_sha512_preparekey(hkdf, prk, sizeof(prk));
-	memzero_explicit(prk, sizeof(prk));
+	hkdf_sha512_extract(hkdf, NULL, 0, master_key, master_key_size);
 }
 
 /*
@@ -73,28 +59,12 @@ void fscrypt_hkdf_expand(const struct hmac_sha512_key *hkdf, u8 context,
 			 const u8 *info, unsigned int infolen,
 			 u8 *okm, unsigned int okmlen)
 {
-	struct hmac_sha512_ctx ctx;
-	u8 counter = 1;
-	u8 tmp[HKDF_HASHLEN];
-
-	WARN_ON_ONCE(okmlen > 255 * HKDF_HASHLEN);
+	const struct hkdf_seg info_segs[] = {
+		{ .data = "fscrypt\0", .len = 8 },
+		{ .data = &context, .len = 1 },
+		{ .data = info, .len = infolen },
+	};
 
-	for (unsigned int i = 0; i < okmlen; i += HKDF_HASHLEN) {
-		hmac_sha512_init(&ctx, hkdf);
-		if (i != 0)
-			hmac_sha512_update(&ctx, &okm[i - HKDF_HASHLEN],
-					   HKDF_HASHLEN);
-		hmac_sha512_update(&ctx, "fscrypt\0", 8);
-		hmac_sha512_update(&ctx, &context, 1);
-		hmac_sha512_update(&ctx, info, infolen);
-		hmac_sha512_update(&ctx, &counter, 1);
-		if (okmlen - i < HKDF_HASHLEN) {
-			hmac_sha512_final(&ctx, tmp);
-			memcpy(&okm[i], tmp, okmlen - i);
-			memzero_explicit(tmp, sizeof(tmp));
-		} else {
-			hmac_sha512_final(&ctx, &okm[i]);
-		}
-		counter++;
-	}
+	hkdf_sha512_expand(hkdf, info_segs, ARRAY_SIZE(info_segs),
+			   okm, okmlen);
 }
-- 
2.43.0


