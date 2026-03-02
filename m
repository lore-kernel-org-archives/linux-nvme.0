Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C13D58E7A
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 08:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M4QlJhwWSV4R2UN8uTm1e7DSETbmPeXOcUePbsaukNw=; b=fic/tiGr/JpysZ4bg0QdhHQJzz
	QgNeaYebXBiz9Zkcn5Cwbte5Zk76cPivxcjbFeG9LSliao8aAiRD4hwHZ1Nq7e3G7rv6Jr8gM8qlv
	4UU7ZIBdEWEFwhkI663CPuXJ3mhPtMG2gRSyybFLB6vRM7B4IUfzhHiA/LqZQzV5d8pb0YGG9RCA6
	v6uF3B+JTK7pPRZKWyAP+TIlxdtBV4hR3cuh6IcEual5wJT1QVeBdd4C2Ji7cdr571SPXTzwLcuLF
	xIUuNRliR83iSit+an6Pn3bCPxamwu9z86k4zWw+buit6yVku8xjW5GOOcy1rxc9h7+YMHzpUefax
	lrWMlGHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDa-0000000CSiy-3LQf;
	Mon, 02 Mar 2026 08:01:30 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDV-0000000CSbM-3edW
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 08:01:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4C72A6013F;
	Mon,  2 Mar 2026 08:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C56C2BC87;
	Mon,  2 Mar 2026 08:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772438485;
	bh=dNdPRig21sFR+x6dbCLvKLyN21dOYek1+K0kwFGxmo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dXdm3DZLWAqPrSuY+1YAxcgNedkwZSm+GXwV9Cz63Jq1tzsxmKjVVkPm0X8/nxTUM
	 K3e5X3PZ2946nAa74HAP5oCbN7slVOCaKCoQyJ/6XniRBjyOZSpplse4iEcbWP05SG
	 LCulxhL0GgQAHBATEt/1md5/nDRZV1MZaeapSzZi1VsQm9DQA4/fMDO5ZnqwMNjZol
	 5GQOTA0x1tU7Dz7IEE+GexGzm5gKVteaIV9wAuUjANxkpBTn0Azev1EePzI+c3dzqi
	 QD++TGKTz0SQUKL91fcZWo25W5B9rhFI6N5ThHWGA+v5iyY+NMFKTp6idS4hUniZOs
	 GooPHXk0mmeFg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 12/21] nvme-auth: common: use crypto library in nvme_auth_derive_tls_psk()
Date: Sun,  1 Mar 2026 23:59:50 -0800
Message-ID: <20260302075959.338638-13-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302075959.338638-1-ebiggers@kernel.org>
References: <20260302075959.338638-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

For the HKDF-Expand-Label computation in nvme_auth_derive_tls_psk(), use
the crypto library instead of crypto_shash and crypto/hkdf.c.

While this means the HKDF "helper" functions are no longer utilized,
they clearly weren't buying us much: it's simpler to just inline the
HMAC computations directly, and this code needs to be tested anyway.  (A
similar result was seen in fs/crypto/.  As a result, this eliminates the
last user of crypto/hkdf.c, which we'll be able to remove as well.)

As usual this is also a lot more efficient, eliminating the allocation
of a transformation object and multiple other dynamic allocations.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/nvme/common/auth.c | 156 +++++++++++++------------------------
 1 file changed, 53 insertions(+), 103 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index f0b4e1c6ade7e..5be86629c2d41 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -7,13 +7,11 @@
 #include <linux/crc32.h>
 #include <linux/base64.h>
 #include <linux/prandom.h>
 #include <linux/scatterlist.h>
 #include <linux/unaligned.h>
-#include <crypto/hash.h>
 #include <crypto/dh.h>
-#include <crypto/hkdf.h>
 #include <crypto/sha2.h>
 #include <linux/nvme.h>
 #include <linux/nvme-auth.h>
 
 static u32 nvme_dhchap_seqnum;
@@ -619,63 +617,10 @@ int nvme_auth_generate_digest(u8 hmac_id, const u8 *psk, size_t psk_len,
 	memzero_explicit(digest, sizeof(digest));
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_generate_digest);
 
-/**
- * hkdf_expand_label - HKDF-Expand-Label (RFC 8846 section 7.1)
- * @hmac_tfm: hash context keyed with pseudorandom key
- * @label: ASCII label without "tls13 " prefix
- * @labellen: length of @label
- * @context: context bytes
- * @contextlen: length of @context
- * @okm: output keying material
- * @okmlen: length of @okm
- *
- * Build the TLS 1.3 HkdfLabel structure and invoke hkdf_expand().
- *
- * Returns 0 on success with output keying material stored in @okm,
- * or a negative errno value otherwise.
- */
-static int hkdf_expand_label(struct crypto_shash *hmac_tfm,
-		const u8 *label, unsigned int labellen,
-		const u8 *context, unsigned int contextlen,
-		u8 *okm, unsigned int okmlen)
-{
-	int err;
-	u8 *info;
-	unsigned int infolen;
-	const char *tls13_prefix = "tls13 ";
-	unsigned int prefixlen = strlen(tls13_prefix);
-
-	if (WARN_ON(labellen > (255 - prefixlen)))
-		return -EINVAL;
-	if (WARN_ON(contextlen > 255))
-		return -EINVAL;
-
-	infolen = 2 + (1 + prefixlen + labellen) + (1 + contextlen);
-	info = kzalloc(infolen, GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
-
-	/* HkdfLabel.Length */
-	put_unaligned_be16(okmlen, info);
-
-	/* HkdfLabel.Label */
-	info[2] = prefixlen + labellen;
-	memcpy(info + 3, tls13_prefix, prefixlen);
-	memcpy(info + 3 + prefixlen, label, labellen);
-
-	/* HkdfLabel.Context */
-	info[3 + prefixlen + labellen] = contextlen;
-	memcpy(info + 4 + prefixlen + labellen, context, contextlen);
-
-	err = hkdf_expand(hmac_tfm, info, infolen, okm, okmlen);
-	kfree_sensitive(info);
-	return err;
-}
-
 /**
  * nvme_auth_derive_tls_psk - Derive TLS PSK
  * @hmac_id: Hash function identifier
  * @psk: generated input PSK
  * @psk_len: size of @psk
@@ -702,88 +647,93 @@ static int hkdf_expand_label(struct crypto_shash *hmac_tfm,
  * error number otherwise.
  */
 int nvme_auth_derive_tls_psk(int hmac_id, const u8 *psk, size_t psk_len,
 			     const char *psk_digest, u8 **ret_psk)
 {
-	struct crypto_shash *hmac_tfm;
-	const char *hmac_name;
-	const char *label = "nvme-tls-psk";
 	static const u8 default_salt[NVME_AUTH_MAX_DIGEST_SIZE];
-	size_t prk_len;
-	const char *ctx;
-	u8 *prk, *tls_key;
+	static const char label[] = "tls13 nvme-tls-psk";
+	const size_t label_len = sizeof(label) - 1;
+	u8 prk[NVME_AUTH_MAX_DIGEST_SIZE];
+	size_t hash_len, ctx_len;
+	u8 *hmac_data = NULL, *tls_key;
+	size_t i;
 	int ret;
 
-	hmac_name = nvme_auth_hmac_name(hmac_id);
-	if (!hmac_name) {
+	hash_len = nvme_auth_hmac_hash_len(hmac_id);
+	if (hash_len == 0) {
 		pr_warn("%s: invalid hash algorithm %d\n",
 			__func__, hmac_id);
 		return -EINVAL;
 	}
 	if (hmac_id == NVME_AUTH_HASH_SHA512) {
 		pr_warn("%s: unsupported hash algorithm %s\n",
-			__func__, hmac_name);
+			__func__, nvme_auth_hmac_name(hmac_id));
 		return -EINVAL;
 	}
 
-	if (psk_len != nvme_auth_hmac_hash_len(hmac_id)) {
+	if (psk_len != hash_len) {
 		pr_warn("%s: unexpected psk_len %zu\n", __func__, psk_len);
 		return -EINVAL;
 	}
 
-	hmac_tfm = crypto_alloc_shash(hmac_name, 0, 0);
-	if (IS_ERR(hmac_tfm))
-		return PTR_ERR(hmac_tfm);
+	/* HKDF-Extract */
+	ret = nvme_auth_hmac(hmac_id, default_salt, hash_len, psk, psk_len,
+			     prk);
+	if (ret)
+		goto out;
+
+	/*
+	 * HKDF-Expand-Label (RFC 8446 section 7.1), with output length equal to
+	 * the hash length (so only a single HMAC operation is needed)
+	 */
 
-	prk_len = crypto_shash_digestsize(hmac_tfm);
-	prk = kzalloc(prk_len, GFP_KERNEL);
-	if (!prk) {
+	hmac_data = kmalloc(/* output length */ 2 +
+			    /* label */ 1 + label_len +
+			    /* context (max) */ 1 + 3 + 1 + strlen(psk_digest) +
+			    /* counter */ 1,
+			    GFP_KERNEL);
+	if (!hmac_data) {
 		ret = -ENOMEM;
-		goto out_free_shash;
+		goto out;
 	}
-
-	if (WARN_ON(prk_len > NVME_AUTH_MAX_DIGEST_SIZE)) {
+	/* output length */
+	i = 0;
+	hmac_data[i++] = hash_len >> 8;
+	hmac_data[i++] = hash_len;
+
+	/* label */
+	static_assert(label_len <= 255);
+	hmac_data[i] = label_len;
+	memcpy(&hmac_data[i + 1], label, label_len);
+	i += 1 + label_len;
+
+	/* context */
+	ctx_len = sprintf(&hmac_data[i + 1], "%02d %s", hmac_id, psk_digest);
+	if (ctx_len > 255) {
 		ret = -EINVAL;
-		goto out_free_prk;
+		goto out;
 	}
-	ret = hkdf_extract(hmac_tfm, psk, psk_len,
-			   default_salt, prk_len, prk);
-	if (ret)
-		goto out_free_prk;
+	hmac_data[i] = ctx_len;
+	i += 1 + ctx_len;
 
-	ret = crypto_shash_setkey(hmac_tfm, prk, prk_len);
-	if (ret)
-		goto out_free_prk;
-
-	ctx = kasprintf(GFP_KERNEL, "%02d %s", hmac_id, psk_digest);
-	if (!ctx) {
-		ret = -ENOMEM;
-		goto out_free_prk;
-	}
+	/* counter (this overwrites the NUL terminator written by sprintf) */
+	hmac_data[i++] = 1;
 
 	tls_key = kzalloc(psk_len, GFP_KERNEL);
 	if (!tls_key) {
 		ret = -ENOMEM;
-		goto out_free_ctx;
+		goto out;
 	}
-	ret = hkdf_expand_label(hmac_tfm,
-				label, strlen(label),
-				ctx, strlen(ctx),
-				tls_key, psk_len);
+	ret = nvme_auth_hmac(hmac_id, prk, hash_len, hmac_data, i, tls_key);
 	if (ret) {
-		kfree(tls_key);
-		goto out_free_ctx;
+		kfree_sensitive(tls_key);
+		goto out;
 	}
 	*ret_psk = tls_key;
-
-out_free_ctx:
-	kfree(ctx);
-out_free_prk:
-	kfree(prk);
-out_free_shash:
-	crypto_free_shash(hmac_tfm);
-
+out:
+	kfree_sensitive(hmac_data);
+	memzero_explicit(prk, sizeof(prk));
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_derive_tls_psk);
 
 MODULE_DESCRIPTION("NVMe Authentication framework");
-- 
2.53.0


