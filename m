Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC1FD58E7D
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 08:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JPXx855IT9SsRqz21MwbnPsPolZV82e7WvRD7YJ5c6o=; b=uN354ap1/S4i6gKnvVx5mC6hsb
	8BrqXtCCoUos3tcd3Jqxn1Lyf50hDKHQbO65QiRaGL9PoUVsy2AGibpX6fghnwfHtZUzwlLGhBx/c
	XPtCFIks1r57BTvPKCOAmL8xCcviwherjAWR0ro8nTmaeP1wjoB/Vj7kbsJINXBHo/MrIkPZ+trGB
	b+XUIg2z6KJiGtxAT0ivqEFQ0i2w3YZCidqAynFfrFi6s0GOUO4JqGknm4frAp/8Me311Q2LA2fxi
	tBe4Q8jDYg4q7QUxSWOAgSDDgtH9rcUdvVnIPP6Wv8y17hfhwCpOCGfcJnI1zeVUVI61E/+q85VoJ
	t7IjgyVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDX-0000000CSeQ-3mZX;
	Mon, 02 Mar 2026 08:01:27 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDT-0000000CSYs-3rq7
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 08:01:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5C8B0600C4;
	Mon,  2 Mar 2026 08:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A5AC2BC87;
	Mon,  2 Mar 2026 08:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772438483;
	bh=5/axZn97VN14i0ECtfuuOtnlWLVE2t/3hoi4aTeGtQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cLW0TKaF/ttr/9aUX7QLxRTmYBWfr9QLaJdd+lL1REj+LxIJS/yTE9bsOcxwaiJZt
	 9zHyFA4qjxFg8nx3fQZLVW5h2tcdHzz4H47fHl29445XFzbVNM4rdyr5TPMNaDhtQr
	 1Ibr8nTuaxuv2M7XoXKNV8Ad3nsHqphOQwoH8OukwU29Toz4mrozBwDjTfdmjRrJQu
	 nBTU6uyXEzX3f2ndEgPut56N7PS+FaxeyUpv1ik1GkPvlPIyzbJ/P2YOkzQKQ82j8a
	 u8YO0D7ri4EdWmWwOlqP2SSEOkO6J32kOemAbBeNxuak5FKEbEKBiWYi5sc8V4cM7B
	 Xwo/8dsB1+TmA==
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
Subject: [PATCH 08/21] nvme-auth: common: use crypto library in nvme_auth_transform_key()
Date: Sun,  1 Mar 2026 23:59:46 -0800
Message-ID: <20260302075959.338638-9-ebiggers@kernel.org>
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

For the HMAC computation in nvme_auth_transform_key(), use the crypto
library instead of crypto_shash.  This is simpler, faster, and more
reliable.  Notably, this eliminates the transformation object allocation
for every call, which was very slow.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/nvme/common/auth.c | 53 +++++++-------------------------------
 1 file changed, 10 insertions(+), 43 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 00f21176181f6..321d6e11c2751 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -301,13 +301,11 @@ void nvme_auth_hmac_final(struct nvme_auth_hmac_ctx *hmac, u8 *out)
 EXPORT_SYMBOL_GPL(nvme_auth_hmac_final);
 
 struct nvme_dhchap_key *nvme_auth_transform_key(
 		const struct nvme_dhchap_key *key, const char *nqn)
 {
-	const char *hmac_name;
-	struct crypto_shash *key_tfm;
-	SHASH_DESC_ON_STACK(shash, key_tfm);
+	struct nvme_auth_hmac_ctx hmac;
 	struct nvme_dhchap_key *transformed_key;
 	int ret, key_len;
 
 	if (!key) {
 		pr_warn("No key specified\n");
@@ -318,54 +316,23 @@ struct nvme_dhchap_key *nvme_auth_transform_key(
 		transformed_key = kmemdup(key, key_len, GFP_KERNEL);
 		if (!transformed_key)
 			return ERR_PTR(-ENOMEM);
 		return transformed_key;
 	}
-	hmac_name = nvme_auth_hmac_name(key->hash);
-	if (!hmac_name) {
-		pr_warn("Invalid key hash id %d\n", key->hash);
-		return ERR_PTR(-EINVAL);
-	}
-
-	key_tfm = crypto_alloc_shash(hmac_name, 0, 0);
-	if (IS_ERR(key_tfm))
-		return ERR_CAST(key_tfm);
-
-	key_len = crypto_shash_digestsize(key_tfm);
+	ret = nvme_auth_hmac_init(&hmac, key->hash, key->key, key->len);
+	if (ret)
+		return ERR_PTR(ret);
+	key_len = nvme_auth_hmac_hash_len(key->hash);
 	transformed_key = nvme_auth_alloc_key(key_len, key->hash);
 	if (!transformed_key) {
-		ret = -ENOMEM;
-		goto out_free_key;
+		memzero_explicit(&hmac, sizeof(hmac));
+		return ERR_PTR(-ENOMEM);
 	}
-
-	shash->tfm = key_tfm;
-	ret = crypto_shash_setkey(key_tfm, key->key, key->len);
-	if (ret < 0)
-		goto out_free_transformed_key;
-	ret = crypto_shash_init(shash);
-	if (ret < 0)
-		goto out_free_transformed_key;
-	ret = crypto_shash_update(shash, nqn, strlen(nqn));
-	if (ret < 0)
-		goto out_free_transformed_key;
-	ret = crypto_shash_update(shash, "NVMe-over-Fabrics", 17);
-	if (ret < 0)
-		goto out_free_transformed_key;
-	ret = crypto_shash_final(shash, transformed_key->key);
-	if (ret < 0)
-		goto out_free_transformed_key;
-
-	crypto_free_shash(key_tfm);
-
+	nvme_auth_hmac_update(&hmac, nqn, strlen(nqn));
+	nvme_auth_hmac_update(&hmac, "NVMe-over-Fabrics", 17);
+	nvme_auth_hmac_final(&hmac, transformed_key->key);
 	return transformed_key;
-
-out_free_transformed_key:
-	nvme_auth_free_key(transformed_key);
-out_free_key:
-	crypto_free_shash(key_tfm);
-
-	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_transform_key);
 
 static int nvme_auth_hash_skey(int hmac_id, const u8 *skey, size_t skey_len,
 			       u8 *hkey)
-- 
2.53.0


