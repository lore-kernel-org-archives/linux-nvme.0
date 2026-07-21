Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3E4C44532
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 14:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PfveWYmL1wr1ejdxu7QcFKBlI7qBe206HNsUNF0rK2g=; b=TDqQt3LylXc8AW42QG/3H4F0dg
	Q/byefxX5qDuarx2b47c7w4ZaCiP+aV/0YTDTQle6eZGpFNPTRXWS+cmS1EYwpOJUouOyuuZqjA3T
	FoRYyU7ofhVH1I76+mTleDc8v5fW9olitLXZmjAAX7N1/filHBcFmJqUiaEJwszKwJvsvQ+vBKsrp
	KjPNg0G8m94j5YuJ3EywYTpgKnMltZhnUJh4zTDPt9OJFIarf9Csnf9wKeqyx9tqg8LA3LymOPWQR
	+dapK57Ik7GSgErOElLI2vkWEtCTEDO8/XIkH4gP0P/3sgTSg3JvPcZtObSoJRvV9njzhIaCS+rfn
	hnUT0xDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmB93-00000009cH8-20yE;
	Tue, 21 Jul 2026 14:08:29 +0000
Received: from mout-b-210.mailbox.org ([2001:67c:2050:102:465::210])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmB91-00000009cFz-1g8u
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 14:08:28 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4h4K3r5d1tzFqxD;
	Tue, 21 Jul 2026 16:08:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1784642904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfveWYmL1wr1ejdxu7QcFKBlI7qBe206HNsUNF0rK2g=;
	b=cL4a3L8mR0lv9KaFycRZmerOTXMIv9TT/7LJ+4xNO43P5qUf1uuW4TbheXMhrZwiRl+BVQ
	P6O6HGF9p08K0XaAd9GO70H4Jz0fIHFn2CsRw3o26/PThQSRovBhyFBWh7w8PNwOmUnbTC
	AqUnysjkFsFw7aG9i7/8oETC3dV0ppw4YWf36O2wWo/usnlrAwgg41eLyQ+GCV8WVnzKD3
	TDjad9Fdk+LhsmiJJb09z4NjKc8vAiVGjQ9dMqxpV90AKqx02Yed09/baI8FmLppq59Fbz
	hvY4OvnqLcXmvvtzcBdOZ8OV2ng4X9XDv3doJtLNtlW++F5h7lA5f5jN3SYJNg==
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
Subject: [RFC PATCH 5/5] ovpn: use HKDF library functions for epoch key derivation
Date: Tue, 21 Jul 2026 16:06:44 +0200
Message-ID: <20260721140644.780006-6-marco@mandelbit.com>
In-Reply-To: <20260721140644.780006-1-marco@mandelbit.com>
References: <20260721140644.780006-1-marco@mandelbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4h4K3r5d1tzFqxD
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_070827_728467_87557DE1 
X-CRM114-Status: GOOD (  23.89  )
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

ovpn carries a local shash-based HKDF-Expand implementation for
deriving epoch PRKs, data keys, and implicit IVs. Replace it with
hkdf_sha256_expand() and feed the HkdfLabel bytes as an array of
segments processed as if concatenated. The derived keys are unchanged.

Store PRKs as prepared HMAC-SHA256 keys embedded in struct
ovpn_epoch_key instead of allocated shash transforms.
ovpn_epoch_set_prk() now handles initial setup as well as epoch
updates via hmac_sha256_preparekey(), replacing ovpn_epoch_init_key().
This removes the shash allocation and setkey failure paths. The
embedded keys are wiped in place where the transforms were previously
freed. The labels are compile-time constants, so check their encoded
sizes at build time and remove the corresponding runtime error paths.

Select CRYPTO_LIB_SHA256 instead of CRYPTO_HMAC and CRYPTO_SHA256, as
the HKDF code was ovpn's only shash user.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 drivers/net/Kconfig             |   3 +-
 drivers/net/ovpn/crypto_epoch.c | 168 ++++++++------------------------
 drivers/net/ovpn/crypto_epoch.h |  11 +--
 drivers/net/ovpn/crypto_key.c   |  50 +++-------
 4 files changed, 60 insertions(+), 172 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index cd4193ce51b4..6f958535e60e 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -109,8 +109,7 @@ config OVPN
 	select CRYPTO_AES
 	select CRYPTO_GCM
 	select CRYPTO_CHACHA20POLY1305
-	select CRYPTO_HMAC
-	select CRYPTO_SHA256
+	select CRYPTO_LIB_SHA256
 	select STREAM_PARSER
 	help
 	  This module enhances the performance of the OpenVPN userspace software
diff --git a/drivers/net/ovpn/crypto_epoch.c b/drivers/net/ovpn/crypto_epoch.c
index bfdf030bb0fb..f63537b3b9f5 100644
--- a/drivers/net/ovpn/crypto_epoch.c
+++ b/drivers/net/ovpn/crypto_epoch.c
@@ -7,7 +7,7 @@
  *		Antonio Quartulli <antonio@openvpn.net>
  */
 
-#include <crypto/hash.h>
+#include <crypto/hkdf.h>
 #include <linux/unaligned.h>
 
 #include "crypto_epoch.h"
@@ -17,111 +17,36 @@
 #define OVPN_EPOCH_DATA_IV_LABEL "data_iv"
 #define OVPN_EPOCH_UPDATE_LABEL "datakey upd"
 #define OVPN_EPOCH_LABEL_PREFIX "ovpn "
-#define OVPN_EPOCH_INFO_MAX_SIZE 21
 
-#define OVPN_EPOCH_HASH_ALG "hmac(sha256)"
+static_assert(OVPN_EPOCH_PRK_SIZE == SHA256_DIGEST_SIZE);
 
-static int ovpn_hkdf_expand(struct crypto_shash *shash, const u8 *info,
-			    size_t info_len, u8 *okm, size_t okm_len)
-{
-	unsigned int prev_len = 0, digest_len;
-	SHASH_DESC_ON_STACK(desc, shash);
-	u8 prev[OVPN_EPOCH_PRK_SIZE];
-	size_t copied = 0, todo;
-	u8 counter = 1;
-	int ret = 0;
-
-	digest_len = crypto_shash_digestsize(shash);
-	if (WARN_ON_ONCE(digest_len != sizeof(prev)))
-		return -EINVAL;
-
-	desc->tfm = shash;
-
-	/* T(0) is the empty string */
-	while (copied < okm_len) {
-		/* T(n) = HMAC-Hash(PRK, T(n-1) | info | n) */
-		ret = crypto_shash_init(desc);
-		if (ret)
-			goto out;
-		ret = crypto_shash_update(desc, prev, prev_len);
-		if (ret)
-			goto out;
-		ret = crypto_shash_update(desc, info, info_len);
-		if (ret)
-			goto out;
-		ret = crypto_shash_update(desc, &counter, sizeof(counter));
-		if (ret)
-			goto out;
-		ret = crypto_shash_final(desc, prev);
-		if (ret)
-			goto out;
-
-		prev_len = digest_len;
-		/* copy a full digest block or the final partial block */
-		todo = min_t(size_t, digest_len, okm_len - copied);
-		memcpy(okm + copied, prev, todo);
-		copied += todo;
-		counter++;
-	}
-
-out:
-	memzero_explicit(prev, sizeof(prev));
-	shash_desc_zero(desc);
-	return ret;
-}
-
-struct crypto_shash *ovpn_epoch_init_key(const u8 *key, size_t key_size)
-{
-	struct crypto_shash *shash;
-	int ret;
-
-	shash = crypto_alloc_shash(OVPN_EPOCH_HASH_ALG, 0, 0);
-	if (IS_ERR(shash))
-		return shash;
-
-	if (key_size != crypto_shash_digestsize(shash)) {
-		crypto_free_shash(shash);
-		return ERR_PTR(-EINVAL);
-	}
+/* The prefixed label length must fit its u8 field. */
+#define OVPN_EPOCH_FULL_LABEL_LEN(label) \
+	(sizeof(OVPN_EPOCH_LABEL_PREFIX) - 1 + sizeof(label) - 1)
 
-	/* store the PRK as the shash key so it can be advanced in place */
-	ret = crypto_shash_setkey(shash, key, key_size);
-	if (ret) {
-		crypto_free_shash(shash);
-		return ERR_PTR(ret);
-	}
-
-	return shash;
-}
+static_assert(OVPN_EPOCH_FULL_LABEL_LEN(OVPN_EPOCH_DATA_KEY_LABEL) <= U8_MAX);
+static_assert(OVPN_EPOCH_FULL_LABEL_LEN(OVPN_EPOCH_DATA_IV_LABEL) <= U8_MAX);
+static_assert(OVPN_EPOCH_FULL_LABEL_LEN(OVPN_EPOCH_UPDATE_LABEL) <= U8_MAX);
 
-static int ovpn_expand_label(struct crypto_shash *shash, const u8 *label,
-			     size_t label_len, u8 *okm, u16 okm_len)
+static void ovpn_expand_label(const struct hmac_sha256_key *prk,
+			      const u8 *label,
+			      size_t label_len, u8 *okm, u16 okm_len)
 {
 	static const u8 label_prefix[] = OVPN_EPOCH_LABEL_PREFIX;
-	u8 prefix_len = sizeof(label_prefix) - 1, full_len;
-	u8 info[OVPN_EPOCH_INFO_MAX_SIZE];
-	u16 info_len;
-	int ret;
-
-	if (WARN_ON_ONCE(!label_len || label_len > 250))
-		return -EINVAL;
-
-	full_len = prefix_len + label_len;
-	info_len = sizeof(okm_len) + full_len + 2;
-	if (WARN_ON_ONCE(info_len > sizeof(info)))
-		return -EINVAL;
-
-	/* encode length, "ovpn " label and empty context */
-	put_unaligned_be16(okm_len, info);
-	info[2] = full_len;
-	memcpy(&info[3], label_prefix, prefix_len);
-	memcpy(&info[3 + prefix_len], label, label_len);
-	info[3 + full_len] = 0;
-
-	ret = ovpn_hkdf_expand(shash, info, info_len, okm, okm_len);
-	memzero_explicit(info, info_len);
-
-	return ret;
+	static const u8 empty_context_len;
+	u8 hdr[3];
+	const struct hkdf_seg info[] = {
+		{ .data = hdr, .len = sizeof(hdr) },
+		{ .data = label_prefix, .len = sizeof(label_prefix) - 1 },
+		{ .data = label, .len = label_len },
+		{ .data = &empty_context_len, .len = 1 },
+	};
+
+	/* encode okm length and prefixed label length */
+	put_unaligned_be16(okm_len, hdr);
+	hdr[2] = sizeof(label_prefix) - 1 + label_len;
+
+	hkdf_sha256_expand(prk, info, ARRAY_SIZE(info), okm, okm_len);
 }
 
 /**
@@ -140,27 +65,18 @@ int ovpn_epoch_derive_next_prk(const struct ovpn_epoch_key *epoch_key,
 	if (unlikely(epoch_key->epoch == OVPN_MAX_EPOCH))
 		return -ERANGE;
 
-	if (WARN_ON_ONCE(OVPN_EPOCH_PRK_SIZE !=
-			 crypto_shash_digestsize(epoch_key->shash)))
-		return -EINVAL;
+	ovpn_expand_label(&epoch_key->prk, OVPN_EPOCH_UPDATE_LABEL,
+			  sizeof(OVPN_EPOCH_UPDATE_LABEL) - 1,
+			  next_prk, OVPN_EPOCH_PRK_SIZE);
 
-	return ovpn_expand_label(epoch_key->shash, OVPN_EPOCH_UPDATE_LABEL,
-				 sizeof(OVPN_EPOCH_UPDATE_LABEL) - 1,
-				 next_prk, OVPN_EPOCH_PRK_SIZE);
+	return 0;
 }
 
-int ovpn_epoch_set_prk(struct ovpn_epoch_key *epoch_key, const u8 prk[],
-		       u16 epoch)
+void ovpn_epoch_set_prk(struct ovpn_epoch_key *epoch_key, const u8 prk[],
+			u16 epoch)
 {
-	int ret;
-
-	ret = crypto_shash_setkey(epoch_key->shash, prk, OVPN_EPOCH_PRK_SIZE);
-	if (ret)
-		return ret;
-
+	hmac_sha256_preparekey(&epoch_key->prk, prk, OVPN_EPOCH_PRK_SIZE);
 	epoch_key->epoch = epoch;
-
-	return 0;
 }
 
 /**
@@ -182,7 +98,7 @@ int ovpn_epoch_iterate(struct ovpn_epoch_key *epoch_key)
 		goto out;
 
 	/* expose the next epoch only after its PRK is installed */
-	ret = ovpn_epoch_set_prk(epoch_key, key, epoch_key->epoch + 1);
+	ovpn_epoch_set_prk(epoch_key, key, epoch_key->epoch + 1);
 
 out:
 	memzero_explicit(key, sizeof(key));
@@ -203,21 +119,19 @@ int ovpn_epoch_iterate(struct ovpn_epoch_key *epoch_key)
 int ovpn_epoch_derive_key(const struct ovpn_epoch_key *epoch_key,
 			  u8 cipher_key[], u8 implicit_iv[])
 {
-	int ret;
-
 	if (WARN_ON_ONCE(!epoch_key->cipher_key_len ||
 			 epoch_key->cipher_key_len > OVPN_EPOCH_PRK_SIZE))
 		return -EINVAL;
 
 	/* derive the concrete AEAD key for the current epoch */
-	ret = ovpn_expand_label(epoch_key->shash, OVPN_EPOCH_DATA_KEY_LABEL,
-				sizeof(OVPN_EPOCH_DATA_KEY_LABEL) - 1,
-				cipher_key, epoch_key->cipher_key_len);
-	if (ret)
-		return ret;
+	ovpn_expand_label(&epoch_key->prk, OVPN_EPOCH_DATA_KEY_LABEL,
+			  sizeof(OVPN_EPOCH_DATA_KEY_LABEL) - 1,
+			  cipher_key, epoch_key->cipher_key_len);
 
 	/* derive the implicit IV paired with that AEAD key */
-	return ovpn_expand_label(epoch_key->shash, OVPN_EPOCH_DATA_IV_LABEL,
-				 sizeof(OVPN_EPOCH_DATA_IV_LABEL) - 1,
-				 implicit_iv, OVPN_NONCE_SIZE);
+	ovpn_expand_label(&epoch_key->prk, OVPN_EPOCH_DATA_IV_LABEL,
+			  sizeof(OVPN_EPOCH_DATA_IV_LABEL) - 1,
+			  implicit_iv, OVPN_NONCE_SIZE);
+
+	return 0;
 }
diff --git a/drivers/net/ovpn/crypto_epoch.h b/drivers/net/ovpn/crypto_epoch.h
index 0dce1e905917..c14b46a6728d 100644
--- a/drivers/net/ovpn/crypto_epoch.h
+++ b/drivers/net/ovpn/crypto_epoch.h
@@ -10,7 +10,7 @@
 #ifndef _NET_OVPN_OVPNEPOCH_H_
 #define _NET_OVPN_OVPNEPOCH_H_
 
-#include <crypto/hash.h>
+#include <crypto/sha2.h>
 #include <linux/limits.h>
 #include <linux/rcupdate.h>
 #include <linux/types.h>
@@ -21,11 +21,11 @@
 
 struct ovpn_key_ctx;
 
-/* crypto handle used for key derivation through HKDF-Expand-Label */
+/* key derivation state for HKDF-Expand-Label */
 struct ovpn_epoch_key {
 	u16 epoch;
 	unsigned int cipher_key_len;
-	struct crypto_shash *shash;
+	struct hmac_sha256_key prk;
 };
 
 /* ring buffer of prederived future epoch data keys */
@@ -46,11 +46,10 @@ ovpn_epoch_future_keys_count(const struct ovpn_future_keys *fk)
 	       OVPN_EPOCH_FUTURE_KEYS_COUNT;
 }
 
-struct crypto_shash *ovpn_epoch_init_key(const u8 *key, size_t key_size);
 int ovpn_epoch_derive_next_prk(const struct ovpn_epoch_key *epoch_key,
 			       u8 next_prk[]);
-int ovpn_epoch_set_prk(struct ovpn_epoch_key *epoch_key, const u8 prk[],
-		       u16 epoch);
+void ovpn_epoch_set_prk(struct ovpn_epoch_key *epoch_key, const u8 prk[],
+			u16 epoch);
 int ovpn_epoch_iterate(struct ovpn_epoch_key *epoch_key);
 int ovpn_epoch_derive_key(const struct ovpn_epoch_key *epoch_key,
 			  u8 cipher_key[], u8 implicit_iv[]);
diff --git a/drivers/net/ovpn/crypto_key.c b/drivers/net/ovpn/crypto_key.c
index 68ebf16c66c8..f07795fc62b9 100644
--- a/drivers/net/ovpn/crypto_key.c
+++ b/drivers/net/ovpn/crypto_key.c
@@ -8,7 +8,6 @@
  */
 
 #include <crypto/aead.h>
-#include <crypto/hash.h>
 #include <linux/workqueue.h>
 
 #include "ovpnpriv.h"
@@ -271,7 +270,6 @@ static void ovpn_refill_future_buffer(struct ovpn_crypto_key_slot *ks,
 	u16 replaced = 0, created = 0, free_slots, i;
 	const struct ovpn_epoch_key *source_key;
 	struct ovpn_epoch_key scratch_key = {};
-	size_t prk_size = OVPN_EPOCH_PRK_SIZE;
 	struct ovpn_future_keys *future_keys;
 	struct ovpn_epoch_key *epoch_key;
 	struct ovpn_key_ctx __rcu **slot;
@@ -304,26 +302,12 @@ static void ovpn_refill_future_buffer(struct ovpn_crypto_key_slot *ks,
 	/* derive new keys without holding the ring lock */
 	scratch_key.cipher_key_len = epoch_key->cipher_key_len;
 	for (created = 0; created < free_slots; created++) {
-		source_key = scratch_key.shash ? &scratch_key : epoch_key;
+		source_key = created ? &scratch_key : epoch_key;
 		ret = ovpn_epoch_derive_next_prk(source_key, next_prk);
 		if (ret)
 			goto err;
 
-		if (!scratch_key.shash) {
-			scratch_key.shash = ovpn_epoch_init_key(next_prk,
-								prk_size);
-			if (IS_ERR(scratch_key.shash)) {
-				ret = PTR_ERR(scratch_key.shash);
-				scratch_key.shash = NULL;
-				goto err;
-			}
-			scratch_key.epoch = epoch_key->epoch + 1;
-		} else {
-			ret = ovpn_epoch_set_prk(&scratch_key, next_prk,
-						 scratch_key.epoch + 1);
-			if (ret)
-				goto err;
-		}
+		ovpn_epoch_set_prk(&scratch_key, next_prk, source_key->epoch + 1);
 
 		new_futures[created] =
 			ovpn_key_ctx_create_epoch(encrypt, ks->alg_name,
@@ -334,9 +318,7 @@ static void ovpn_refill_future_buffer(struct ovpn_crypto_key_slot *ks,
 		}
 	}
 
-	ret = ovpn_epoch_set_prk(epoch_key, next_prk, scratch_key.epoch);
-	if (ret)
-		goto err;
+	ovpn_epoch_set_prk(epoch_key, next_prk, scratch_key.epoch);
 
 	/* insert generated keys under the selected ring lock */
 	spin_lock_bh(lock);
@@ -362,7 +344,7 @@ static void ovpn_refill_future_buffer(struct ovpn_crypto_key_slot *ks,
 	for (i = replaced; i < created; i++)
 		ovpn_key_ctx_put(new_futures[i]);
 
-	crypto_free_shash(scratch_key.shash);
+	memzero_explicit(&scratch_key.prk, sizeof(scratch_key.prk));
 	memzero_explicit(next_prk, sizeof(next_prk));
 
 	/* keep refilling until the ring is full */
@@ -374,8 +356,7 @@ static void ovpn_refill_future_buffer(struct ovpn_crypto_key_slot *ks,
 err:
 	for (i = 0; i < created; i++)
 		ovpn_key_ctx_put(new_futures[i]);
-	if (scratch_key.shash)
-		crypto_free_shash(scratch_key.shash);
+	memzero_explicit(&scratch_key.prk, sizeof(scratch_key.prk));
 	memzero_explicit(next_prk, sizeof(next_prk));
 }
 
@@ -409,10 +390,10 @@ void ovpn_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks)
 	ovpn_key_ctx_put(rcu_access_pointer(ks->decrypt));
 
 	if (ks->epoch_format) {
-		if (ks->epoch_key_send.shash)
-			crypto_free_shash(ks->epoch_key_send.shash);
-		if (ks->epoch_key_recv.shash)
-			crypto_free_shash(ks->epoch_key_recv.shash);
+		memzero_explicit(&ks->epoch_key_send.prk,
+				 sizeof(ks->epoch_key_send.prk));
+		memzero_explicit(&ks->epoch_key_recv.prk,
+				 sizeof(ks->epoch_key_recv.prk));
 		ovpn_key_ctx_put(rcu_access_pointer(ks->retiring_key));
 		for (i = 0; i < OVPN_EPOCH_FUTURE_KEYS_COUNT; i++) {
 			future = rcu_access_pointer(ks->future_tx_keys.keys[i]);
@@ -428,17 +409,12 @@ void ovpn_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks)
 static int ovpn_epoch_key_init(struct ovpn_epoch_key *epoch_key,
 			       const struct ovpn_epoch_prk *prk)
 {
-	int ret;
-
-	epoch_key->shash = ovpn_epoch_init_key(prk->key, prk->key_size);
-	if (IS_ERR(epoch_key->shash)) {
-		ret = PTR_ERR(epoch_key->shash);
-		epoch_key->shash = NULL;
-		return ret;
-	}
+	if (prk->key_size != OVPN_EPOCH_PRK_SIZE)
+		return -EINVAL;
 
 	/* epoch 0 is reserved for direct keys, so epoch keys start at 1 */
-	epoch_key->epoch = 1;
+	ovpn_epoch_set_prk(epoch_key, prk->key, 1);
+
 	epoch_key->cipher_key_len = prk->cipher_key_len;
 
 	return 0;
-- 
2.43.0


