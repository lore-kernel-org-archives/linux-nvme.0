Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B141D58E7E
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 08:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jT8SAjoRIwnJFYglXrHrV9vZcRcaeggXr3+vQHnkfQ4=; b=mX5TexuvgBkGpcvEkBM4Mmi9jz
	wAGHybYzHW4bfaz1vvAl8S3SCBCX06dZpw7CCmIxCGxdM8NRFg7IKNdoLQ9lsjuo3Yz7YCxdJSI2z
	/cfA/5bZEX24uTvWZEWaGxQryY0IlyJCbbp/SyLQo25fmxaTsGfiXfbI18zerRlcFtOHs3+iwwal/
	807u6gXlCH0hjOyyxXDxU1RW9H/ng/RRBeyRYHMQeArf/IvjQ32Ttvsd61fytEhLrNGPMheK4gxTP
	vpWTbSQCOj2Z/WYefD8YZbM3tL8FkY+8uMevMvbW/6AuEgDVmQE0kbHAP2GKS9HsFjPZ0O4YrgY04
	IxqJOnQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDY-0000000CSfT-1bJ4;
	Mon, 02 Mar 2026 08:01:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDU-0000000CSZ1-1aZE
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 08:01:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CCE766013E;
	Mon,  2 Mar 2026 08:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB6EC2BCB5;
	Mon,  2 Mar 2026 08:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772438483;
	bh=bjsE/c+5TFoj0rL/sw+wLvSH57oqh6wELi161NQyhDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tJI0vx94fIn/70pLXINnQh8QSCxhSj9loE/ehLjrwWuaqhugNNn3uzQXOj+9kStn+
	 zkrTRAzWRXsxFQZrKHIx9Mu7R2CygtQ2/s5EBEKBMwcj3R4BoA7ilu2R9AdprhQTzO
	 GDUsnbH63zeE/uKvOjmxK9nybpE27IKF3kJQanr4pmVOj3G7EpXgraDD6Qyggwa3t/
	 omj0V0aUM+7ZKfXFLVGKE3KiQn42mKJw3oE+gFQmgWFUGoGJo+3vK8M8JUk4solmHY
	 43xQ7NRsyeASF0T/9oj4SenrgxaG0M1X3jHFJHcGU7ARwc2ylkKpk1t18Psfcc8zCM
	 z+PPTj5qNjWRg==
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
Subject: [PATCH 09/21] nvme-auth: common: use crypto library in nvme_auth_augmented_challenge()
Date: Sun,  1 Mar 2026 23:59:47 -0800
Message-ID: <20260302075959.338638-10-ebiggers@kernel.org>
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

For the hash and HMAC computations in nvme_auth_augmented_challenge(),
use the crypto library instead of crypto_shash.  This is simpler,
faster, and more reliable.  Notably, this eliminates two crypto
transformation object allocations for every call, which was very slow.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/nvme/common/auth.c | 96 ++++++++++++++------------------------
 1 file changed, 36 insertions(+), 60 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 321d6e11c2751..be5bc5fcafc63 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -298,10 +298,41 @@ void nvme_auth_hmac_final(struct nvme_auth_hmac_ctx *hmac, u8 *out)
 	/* Unreachable because nvme_auth_hmac_init() validated hmac_id */
 	WARN_ON_ONCE(1);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_hmac_final);
 
+static int nvme_auth_hmac(u8 hmac_id, const u8 *key, size_t key_len,
+			  const u8 *data, size_t data_len, u8 *out)
+{
+	struct nvme_auth_hmac_ctx hmac;
+	int ret;
+
+	ret = nvme_auth_hmac_init(&hmac, hmac_id, key, key_len);
+	if (ret == 0) {
+		nvme_auth_hmac_update(&hmac, data, data_len);
+		nvme_auth_hmac_final(&hmac, out);
+	}
+	return ret;
+}
+
+static int nvme_auth_hash(u8 hmac_id, const u8 *data, size_t data_len, u8 *out)
+{
+	switch (hmac_id) {
+	case NVME_AUTH_HASH_SHA256:
+		sha256(data, data_len, out);
+		return 0;
+	case NVME_AUTH_HASH_SHA384:
+		sha384(data, data_len, out);
+		return 0;
+	case NVME_AUTH_HASH_SHA512:
+		sha512(data, data_len, out);
+		return 0;
+	}
+	pr_warn("%s: invalid hash algorithm %d\n", __func__, hmac_id);
+	return -EINVAL;
+}
+
 struct nvme_dhchap_key *nvme_auth_transform_key(
 		const struct nvme_dhchap_key *key, const char *nqn)
 {
 	struct nvme_auth_hmac_ctx hmac;
 	struct nvme_dhchap_key *transformed_key;
@@ -332,76 +363,21 @@ struct nvme_dhchap_key *nvme_auth_transform_key(
 	nvme_auth_hmac_final(&hmac, transformed_key->key);
 	return transformed_key;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_transform_key);
 
-static int nvme_auth_hash_skey(int hmac_id, const u8 *skey, size_t skey_len,
-			       u8 *hkey)
-{
-	const char *digest_name;
-	struct crypto_shash *tfm;
-	int ret;
-
-	digest_name = nvme_auth_digest_name(hmac_id);
-	if (!digest_name) {
-		pr_debug("%s: failed to get digest for %d\n", __func__,
-			 hmac_id);
-		return -EINVAL;
-	}
-	tfm = crypto_alloc_shash(digest_name, 0, 0);
-	if (IS_ERR(tfm))
-		return -ENOMEM;
-
-	ret = crypto_shash_tfm_digest(tfm, skey, skey_len, hkey);
-	if (ret < 0)
-		pr_debug("%s: Failed to hash digest len %zu\n", __func__,
-			 skey_len);
-
-	crypto_free_shash(tfm);
-	return ret;
-}
-
 int nvme_auth_augmented_challenge(u8 hmac_id, const u8 *skey, size_t skey_len,
 				  const u8 *challenge, u8 *aug, size_t hlen)
 {
-	struct crypto_shash *tfm;
-	u8 *hashed_key;
-	const char *hmac_name;
+	u8 hashed_key[NVME_AUTH_MAX_DIGEST_SIZE];
 	int ret;
 
-	hashed_key = kmalloc(hlen, GFP_KERNEL);
-	if (!hashed_key)
-		return -ENOMEM;
-
-	ret = nvme_auth_hash_skey(hmac_id, skey,
-				  skey_len, hashed_key);
-	if (ret < 0)
-		goto out_free_key;
-
-	hmac_name = nvme_auth_hmac_name(hmac_id);
-	if (!hmac_name) {
-		pr_warn("%s: invalid hash algorithm %d\n",
-			__func__, hmac_id);
-		ret = -EINVAL;
-		goto out_free_key;
-	}
-
-	tfm = crypto_alloc_shash(hmac_name, 0, 0);
-	if (IS_ERR(tfm)) {
-		ret = PTR_ERR(tfm);
-		goto out_free_key;
-	}
-
-	ret = crypto_shash_setkey(tfm, hashed_key, hlen);
+	ret = nvme_auth_hash(hmac_id, skey, skey_len, hashed_key);
 	if (ret)
-		goto out_free_hash;
-
-	ret = crypto_shash_tfm_digest(tfm, challenge, hlen, aug);
-out_free_hash:
-	crypto_free_shash(tfm);
-out_free_key:
-	kfree_sensitive(hashed_key);
+		return ret;
+	ret = nvme_auth_hmac(hmac_id, hashed_key, hlen, challenge, hlen, aug);
+	memzero_explicit(hashed_key, sizeof(hashed_key));
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_augmented_challenge);
 
 int nvme_auth_gen_privkey(struct crypto_kpp *dh_tfm, u8 dh_gid)
-- 
2.53.0


