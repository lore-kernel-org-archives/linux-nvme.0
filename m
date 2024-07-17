Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D64C3DA42
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 09:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z5g/Hga+CffFGurLDVGLBRVTCQGcNt/lsasBQIaZsCI=; b=Z28H7KERKYL/h5kVDvjHDm7jwM
	IkzqbXnGwnfjWAgkzn4i9t7q9SOfS3W1wXrDYSg3+OZUMMvwXihMPXBm0eipVC5R3axK3701TxOBX
	CLISIb2PK8ACPhVrM32cSUQXT5WNdk4thmJwRF9AfhZ2TOifrK1v1Je/f4teUA9NVvYsU7LqP0QKQ
	ySQjOdwPYKi33kUI8c62tPF3QwvICCrhBWHnjcFi+GZpN9tBsuwMFpEnUEnc3m3tdX6KE72SI6Gpz
	iKXkdANjI3riq5bla2NaS1oih1RES9M7SsAfJhxK/lWicEGlph3de1rBdDbkjhwK12/Mi92b6VVje
	UYgOdrZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0hG-0000000DGA1-2Cib;
	Wed, 17 Jul 2024 09:11:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0gd-0000000DFuF-2VmZ
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 09:11:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E042B61316;
	Wed, 17 Jul 2024 09:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC5DC4AF0D;
	Wed, 17 Jul 2024 09:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721207458;
	bh=lu9n/kNuVWBe0EWBRPJF++mCKg4S2n6Wj94+HSd4QVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a1oD5VhgBoU/QVInPGKSB/7Azx4ZXjtGs4VZY3WIUZ0QgHT+fK3/iW+1V4r56wGHk
	 fxO9aFnF5v4gsa4YgrHS7ho1/OjTQnuMtgVSnqEiq1TCJ8eP7iSfGlDZYErDj8w88K
	 ZyrtCsNxn9lFsvp8SzaD6Cpp9L3ZEZEXK8VZrIf4WvPKzcJ/BbKKYJgxBp/LClHVwU
	 mGYz3C4rdSUTV2VKruQEYj23KPz2aNoSUbAjQMYPzfkZa2u4CTQoyOVs6bynrPle8e
	 w3T2PS33TTb8zZofGnvwVOs9bVEvxOyE6tVYNgNN6F8RxXYRUNLjNSdB9yGHfYzTFn
	 rDHGBX3xCLqjg==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 10/16] nvme: add nvme_auth_derive_tls_psk()
Date: Wed, 17 Jul 2024 11:10:25 +0200
Message-Id: <20240717091031.143188-11-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240717091031.143188-1-hare@kernel.org>
References: <20240717091031.143188-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_021059_818817_6931C05C 
X-CRM114-Status: GOOD (  14.84  )
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

Add a function to derive the TLS PSK as specified TP8018.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/auth.c | 90 ++++++++++++++++++++++++++++++++++++++
 include/linux/nvme-auth.h  |  2 +
 2 files changed, 92 insertions(+)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 891079c3dbd5..a4ccc4e76581 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -684,5 +684,95 @@ int nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
 }
 EXPORT_SYMBOL_GPL(nvme_auth_generate_digest);
 
+/*
+ * Derive a TLS PSK as specified in TP8018 Section 3.6.1.3:
+ *   TLS PSK and PSK identity Derivation
+ *
+ * The TLS PSK shall be derived as follows from an input PSK
+ * (i.e., either a retained PSK or a generated PSK) and a PSK
+ * identity using the HKDF-Extract and HKDF-Expand-Label operations
+ * (refer to RFC 5869 and RFC 8446) where the hash function is the
+ * one specified by the hash specifier of the PSK identity:
+ * 1. PRK = HKDF-Extract(0, Input PSK); and
+ * 2. TLS PSK = HKDF-Expand-Label(PRK, "nvme-tls-psk", PskIdentityContext, L),
+ * where PskIdentityContext is the hash identifier indicated in
+ * the PSK identity concatenated to a space character and to the
+ * Base64 PSK digest (i.e., "<hash> <PSK digest>") and L is the
+ * output size in bytes of the hash function (i.e., 32 for SHA-256
+ * and 48 for SHA-384).
+ */
+int nvme_auth_derive_tls_psk(int hmac_id, u8 *psk, size_t psk_len,
+		u8 *psk_digest, u8 **ret_psk)
+{
+	struct crypto_shash *hmac_tfm;
+	const char *hmac_name;
+	const char *psk_prefix = "tls13 nvme-tls-psk";
+	size_t info_len, prk_len;
+	char *info;
+	unsigned char *prk, *tls_key;
+	int ret;
+
+	hmac_name = nvme_auth_hmac_name(hmac_id);
+	if (!hmac_name) {
+		pr_warn("%s: invalid hash algoritm %d\n",
+			__func__, hmac_id);
+		return -EINVAL;
+	}
+	if (hmac_id == NVME_AUTH_HASH_SHA512) {
+		pr_warn("%s: unsupported hash algorithm %s\n",
+			__func__, hmac_name);
+		return -EINVAL;
+	}
+
+	hmac_tfm = crypto_alloc_shash(hmac_name, 0, 0);
+	if (IS_ERR(hmac_tfm))
+		return PTR_ERR(hmac_tfm);
+
+	prk_len = crypto_shash_digestsize(hmac_tfm);
+	prk = kzalloc(prk_len, GFP_KERNEL);
+	if (!prk) {
+		ret = -ENOMEM;
+		goto out_free_shash;
+	}
+
+	ret = hkdf_extract(hmac_tfm, psk, psk_len, prk);
+	if (ret)
+		goto out_free_prk;
+
+	ret = crypto_shash_setkey(hmac_tfm, prk, prk_len);
+	if (ret)
+		goto out_free_prk;
+
+	info_len = strlen(psk_digest) + strlen(psk_prefix) + 1;
+	info = kzalloc(info_len, GFP_KERNEL);
+	if (!info)
+		goto out_free_prk;
+
+	memcpy(info, psk_prefix, strlen(psk_prefix));
+	memcpy(info + strlen(psk_prefix), psk_digest, strlen(psk_digest));
+
+	tls_key = kzalloc(psk_len, GFP_KERNEL);
+	if (!tls_key) {
+		ret = -ENOMEM;
+		goto out_free_info;
+	}
+	ret = hkdf_expand(hmac_tfm, info, strlen(info), tls_key, psk_len);
+	if (ret) {
+		kfree(tls_key);
+		goto out_free_info;
+	}
+	*ret_psk = tls_key;
+
+out_free_info:
+	kfree(info);
+out_free_prk:
+	kfree(prk);
+out_free_shash:
+	crypto_free_shash(hmac_tfm);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_derive_tls_psk);
+
 MODULE_DESCRIPTION("NVMe Authentication framework");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index 998f06bf10fd..60e069a6757f 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -45,5 +45,7 @@ int nvme_auth_generate_psk(u8 hmac_id, u8 *skey, size_t skey_len,
 			   u8 **ret_psk, size_t *ret_len);
 int nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
 		char *subsysnqn, char *hostnqn, u8 **ret_digest);
+int nvme_auth_derive_tls_psk(int hmac_id, u8 *psk, size_t psk_len,
+		u8 *psk_digest, u8 **ret_psk);
 
 #endif /* _NVME_AUTH_H */
-- 
2.35.3


