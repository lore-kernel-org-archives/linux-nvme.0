Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA2DC3DA5D
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 14:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FQvrczrROQge6dxV0HPn4RrV5eWyUKfhfLX7D7n5S8M=; b=wQEHO+imuL2UqFBGtvoMQfzCbt
	/4nZaj9JT1k1Lt8RuoxdsK8cvmlZyx8Un2Kb3MsWyqOpOc8hZHeIPF1Dw/mEENIMDk0MpIz8ac+Jq
	+rS5LWwyPSHsjnnvlzO7mKZyMQDHVawX9BMEW7XjvGxDUqkt8jXDa/qAHY3YwnBIFPjuF5nmQ1GZY
	KKmMuaQoRZH5JyZXOJRHyPpGIIjaKGrxDWbOJhFMJUamIsPM1npcRtbjLU/paHdF0O8RExWUrpdYk
	/Rq8o5cZ45Aa2oa7ZoR78k7OzasfVStrYoHufAF5CpNMNoaL7Ly/Uge1pShLvkt8jsB7iVNwElv3M
	UTImZ8Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVtvT-00000009lCn-37MA;
	Mon, 22 Jul 2024 14:22:07 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVtvQ-00000009lBO-1e1N
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 14:22:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 81BE6609E9;
	Mon, 22 Jul 2024 14:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981B2C4AF0E;
	Mon, 22 Jul 2024 14:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721658123;
	bh=r5ZDBk4HmRPtpcmmR1xIehiRjqgNNPB10LyJvpl6WDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OR4hk/VeSoklnIfsmf8qTnC6m2GoLCsILEIJ9SqPzoBiLiFXqz6XkRf+FDREqt25D
	 MJnOuSoiP1A8XYBH6CUNHakAUFpFrIOW4D+iF/xZl6JrdjvnbK7JTRpUi/94JnyWC1
	 OvkmkDJQgiYOiz8KDmr46IUcHuyJADooS9g96bEsuWNd39imELqlT4qwIAhTYliASb
	 SgByFPD1vFe13GKVusSwNTA6wEM6fo1K5lQYqeX3R354TUThazMTOF+dDhtNAG704H
	 jR5olO6Lx+rOukQV3JCsGwnch3iRDtEkX6L6XKzbe3tvDvAxl5b0wiNfp0i8WjNT5A
	 FEfpWnwWJj6Qg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/9] crypto,fs: Separate out hkdf_extract() and hkdf_expand()
Date: Mon, 22 Jul 2024 16:21:14 +0200
Message-Id: <20240722142122.128258-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240722142122.128258-1-hare@kernel.org>
References: <20240722142122.128258-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_072204_771399_439926D9 
X-CRM114-Status: GOOD (  22.80  )
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

Separate out the HKDF functions into a separate file to make them
available to other callers.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org
---
 crypto/Makefile       |   1 +
 crypto/hkdf.c         | 112 ++++++++++++++++++++++++++++++++++++++++++
 fs/crypto/hkdf.c      |  68 ++++---------------------
 include/crypto/hkdf.h |  18 +++++++
 4 files changed, 140 insertions(+), 59 deletions(-)
 create mode 100644 crypto/hkdf.c
 create mode 100644 include/crypto/hkdf.h

diff --git a/crypto/Makefile b/crypto/Makefile
index edbbaa3ffef5..b77fc360f0ff 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_CRYPTO_ECHAINIV) += echainiv.o
 
 crypto_hash-y += ahash.o
 crypto_hash-y += shash.o
+crypto_hash-y += hkdf.o
 obj-$(CONFIG_CRYPTO_HASH2) += crypto_hash.o
 
 obj-$(CONFIG_CRYPTO_AKCIPHER2) += akcipher.o
diff --git a/crypto/hkdf.c b/crypto/hkdf.c
new file mode 100644
index 000000000000..22e343851c0b
--- /dev/null
+++ b/crypto/hkdf.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Implementation of HKDF ("HMAC-based Extract-and-Expand Key Derivation
+ * Function"), aka RFC 5869.  See also the original paper (Krawczyk 2010):
+ * "Cryptographic Extraction and Key Derivation: The HKDF Scheme".
+ *
+ * This is used to derive keys from the fscrypt master keys.
+ *
+ * Copyright 2019 Google LLC
+ */
+
+#include <crypto/hash.h>
+#include <crypto/sha2.h>
+#include <crypto/hkdf.h>
+
+/*
+ * HKDF consists of two steps:
+ *
+ * 1. HKDF-Extract: extract a pseudorandom key of length HKDF_HASHLEN bytes from
+ *    the input keying material and optional salt.
+ * 2. HKDF-Expand: expand the pseudorandom key into output keying material of
+ *    any length, parameterized by an application-specific info string.
+ *
+ */
+
+/* HKDF-Extract (RFC 5869 section 2.2), unsalted */
+int hkdf_extract(struct crypto_shash *hmac_tfm, const u8 *ikm,
+		 unsigned int ikmlen, u8 *prk)
+{
+	unsigned int prklen = crypto_shash_digestsize(hmac_tfm);
+	u8 *default_salt;
+	int err;
+
+	default_salt = kzalloc(prklen, GFP_KERNEL);
+	if (!default_salt)
+		return -ENOMEM;
+	err = crypto_shash_setkey(hmac_tfm, default_salt, prklen);
+	if (!err)
+		err = crypto_shash_tfm_digest(hmac_tfm, ikm, ikmlen, prk);
+
+	kfree(default_salt);
+	return err;
+}
+EXPORT_SYMBOL_GPL(hkdf_extract);
+
+/*
+ * HKDF-Expand (RFC 5869 section 2.3).
+ * This expands the pseudorandom key, which was already keyed into @hmac_tfm,
+ * into @okmlen bytes of output keying material parameterized by the
+ * application-specific @info of length @infolen bytes.
+ * This is thread-safe and may be called by multiple threads in parallel.
+ */
+int hkdf_expand(struct crypto_shash *hmac_tfm,
+		const u8 *info, unsigned int infolen,
+		u8 *okm, unsigned int okmlen)
+{
+	SHASH_DESC_ON_STACK(desc, hmac_tfm);
+	unsigned int i, hashlen = crypto_shash_digestsize(hmac_tfm);
+	int err;
+	const u8 *prev = NULL;
+	u8 counter = 1;
+	u8 *tmp;
+
+	if (WARN_ON(okmlen > 255 * hashlen))
+		return -EINVAL;
+
+	tmp = kzalloc(hashlen, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	desc->tfm = hmac_tfm;
+
+	for (i = 0; i < okmlen; i += hashlen) {
+
+		err = crypto_shash_init(desc);
+		if (err)
+			goto out;
+
+		if (prev) {
+			err = crypto_shash_update(desc, prev, hashlen);
+			if (err)
+				goto out;
+		}
+
+		err = crypto_shash_update(desc, info, infolen);
+		if (err)
+			goto out;
+
+		BUILD_BUG_ON(sizeof(counter) != 1);
+		if (okmlen - i < hashlen) {
+			err = crypto_shash_finup(desc, &counter, 1, tmp);
+			if (err)
+				goto out;
+			memcpy(&okm[i], tmp, okmlen - i);
+			memzero_explicit(tmp, sizeof(tmp));
+		} else {
+			err = crypto_shash_finup(desc, &counter, 1, &okm[i]);
+			if (err)
+				goto out;
+		}
+		counter++;
+		prev = &okm[i];
+	}
+	err = 0;
+out:
+	if (unlikely(err))
+		memzero_explicit(okm, okmlen); /* so caller doesn't need to */
+	shash_desc_zero(desc);
+	kfree(tmp);
+	return err;
+}
+EXPORT_SYMBOL_GPL(hkdf_expand);
diff --git a/fs/crypto/hkdf.c b/fs/crypto/hkdf.c
index 5a384dad2c72..9c2f9aca9412 100644
--- a/fs/crypto/hkdf.c
+++ b/fs/crypto/hkdf.c
@@ -11,6 +11,7 @@
 
 #include <crypto/hash.h>
 #include <crypto/sha2.h>
+#include <crypto/hkdf.h>
 
 #include "fscrypt_private.h"
 
@@ -44,20 +45,6 @@
  * there's no way to persist a random salt per master key from kernel mode.
  */
 
-/* HKDF-Extract (RFC 5869 section 2.2), unsalted */
-static int hkdf_extract(struct crypto_shash *hmac_tfm, const u8 *ikm,
-			unsigned int ikmlen, u8 prk[HKDF_HASHLEN])
-{
-	static const u8 default_salt[HKDF_HASHLEN];
-	int err;
-
-	err = crypto_shash_setkey(hmac_tfm, default_salt, HKDF_HASHLEN);
-	if (err)
-		return err;
-
-	return crypto_shash_tfm_digest(hmac_tfm, ikm, ikmlen, prk);
-}
-
 /*
  * Compute HKDF-Extract using the given master key as the input keying material,
  * and prepare an HMAC transform object keyed by the resulting pseudorandom key.
@@ -118,61 +105,24 @@ int fscrypt_hkdf_expand(const struct fscrypt_hkdf *hkdf, u8 context,
 			u8 *okm, unsigned int okmlen)
 {
 	SHASH_DESC_ON_STACK(desc, hkdf->hmac_tfm);
-	u8 prefix[9];
-	unsigned int i;
+	u8 *prefix;
 	int err;
-	const u8 *prev = NULL;
-	u8 counter = 1;
-	u8 tmp[HKDF_HASHLEN];
 
 	if (WARN_ON_ONCE(okmlen > 255 * HKDF_HASHLEN))
 		return -EINVAL;
 
+	prefix = kzalloc(okmlen + 9, GFP_KERNEL);
+	if (!prefix)
+		return -ENOMEM;
 	desc->tfm = hkdf->hmac_tfm;
 
 	memcpy(prefix, "fscrypt\0", 8);
 	prefix[8] = context;
+	memcpy(prefix + 9, info, infolen);
 
-	for (i = 0; i < okmlen; i += HKDF_HASHLEN) {
-
-		err = crypto_shash_init(desc);
-		if (err)
-			goto out;
-
-		if (prev) {
-			err = crypto_shash_update(desc, prev, HKDF_HASHLEN);
-			if (err)
-				goto out;
-		}
-
-		err = crypto_shash_update(desc, prefix, sizeof(prefix));
-		if (err)
-			goto out;
-
-		err = crypto_shash_update(desc, info, infolen);
-		if (err)
-			goto out;
-
-		BUILD_BUG_ON(sizeof(counter) != 1);
-		if (okmlen - i < HKDF_HASHLEN) {
-			err = crypto_shash_finup(desc, &counter, 1, tmp);
-			if (err)
-				goto out;
-			memcpy(&okm[i], tmp, okmlen - i);
-			memzero_explicit(tmp, sizeof(tmp));
-		} else {
-			err = crypto_shash_finup(desc, &counter, 1, &okm[i]);
-			if (err)
-				goto out;
-		}
-		counter++;
-		prev = &okm[i];
-	}
-	err = 0;
-out:
-	if (unlikely(err))
-		memzero_explicit(okm, okmlen); /* so caller doesn't need to */
-	shash_desc_zero(desc);
+	err = hkdf_expand(hkdf->hmac_tfm, prefix, infolen + 8,
+			  okm, okmlen);
+	kfree(prefix);
 	return err;
 }
 
diff --git a/include/crypto/hkdf.h b/include/crypto/hkdf.h
new file mode 100644
index 000000000000..bf06c080d7ed
--- /dev/null
+++ b/include/crypto/hkdf.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * HKDF: HMAC-based Key Derivation Function (HKDF), RFC 5869
+ *
+ * Extracted from fs/crypto/hkdf.c, which has
+ * Copyright 2019 Google LLC
+ */
+
+#ifndef _CRYPTO_HKDF_H
+#define _CRYPTO_HKDF_H
+
+int hkdf_extract(struct crypto_shash *hmac_tfm, const u8 *ikm,
+		 unsigned int ikmlen, u8 *prk);
+int hkdf_expand(struct crypto_shash *hmac_tfm,
+		const u8 *info, unsigned int infolen,
+		u8 *okm, unsigned int okmlen);
+
+#endif
-- 
2.35.3


