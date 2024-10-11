Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1D2D0EE12
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2024 16:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a+jRh6mi/fsUZQmxqgLFeZvMPb+vKcR16kuk9Wb/S4g=; b=wFOc9kIL1WIfOi6QgfxVY1caWL
	M9M7qx3B2mJfrRva9Ghc5nP3pQBl5qMJPydJfu4PZ18BdCjECQ0QhpgdowsvclYCxUjIcrj+/Ucun
	G14MJh2xC/Sy+w9/rmITowrZSc/akpQBBDRhWmYBBjAPLFjf7pL1mm6GSfIJ52h5Ud3c5zOZO1ynu
	q6FqxB8sgQDtjJS+iKHaI6F9YXfV8lsm2Yl/QaUMrhSA5OuNzY2MPbG+0EtLSNe5vKA0wTtidleZR
	pZ0WjwbnkLBrGZALm4a/f82dLWjIw9XkbhkfZsccv/uIDcylZ8tXhQQopjqHB6cjU5JOAINFUagRD
	tHOIc97g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szI53-0000000GtqT-0xMz;
	Fri, 11 Oct 2024 16:01:29 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szHyf-0000000Gsvx-2p3h
	for linux-nvme@lists.infradead.org;
	Fri, 11 Oct 2024 15:54:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1CAE5A40278;
	Fri, 11 Oct 2024 15:54:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB922C4CECF;
	Fri, 11 Oct 2024 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728662092;
	bh=0H0FdYFNiU+Qd/nXDqI0qStv1VsnV0r/zF9hqLf7QyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1ldGDNKjwVgdanXpAcvSdXEUY3apPjcSXXcd9vokzSsVv8u3XruvAMLubC2aLLxx
	 /ToFIydvXmbZJDqTpHFQCicR/oOCz8mxjmBA7BOMWOsWnBo1+sLogBOyLefnWhKQJg
	 0x7jqcfKhQ60Yfd2bQW1vILfClPZ5hzVmm7fij8SSiI2avSRgm2tYOHHlxQzr5hePZ
	 HxJRa6vUeOwGdH8vfMaH3IALOhswR0cLVD73D+92UY6LX9hfjcvCHinq48fSDkDOov
	 cFiB7LHGfs6ZV0GdL5EVAVOioi/c0AQsnxpzGVmZ9AbyCJ287rPnkkS8ndCAEyaFaa
	 JnGXDusm8TXQg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/9] nvme: add nvme_auth_generate_psk()
Date: Fri, 11 Oct 2024 17:54:23 +0200
Message-Id: <20241011155430.43450-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241011155430.43450-1-hare@kernel.org>
References: <20241011155430.43450-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_085453_872592_32FBB82C 
X-CRM114-Status: GOOD (  15.30  )
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

Add a function to generate a NVMe PSK from the shared credentials
negotiated by DH-HMAC-CHAP.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/common/auth.c | 98 ++++++++++++++++++++++++++++++++++++++
 include/linux/nvme-auth.h  |  3 ++
 2 files changed, 101 insertions(+)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index a3455f1d67fa..8448bd195ff1 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -11,6 +11,7 @@
 #include <asm/unaligned.h>
 #include <crypto/hash.h>
 #include <crypto/dh.h>
+#include <crypto/hkdf.h>
 #include <linux/nvme.h>
 #include <linux/nvme-auth.h>
 
@@ -471,5 +472,102 @@ int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
 
+/**
+ * nvme_auth_generate_psk - Generate a PSK for TLS
+ * @hmac_id: Hash function identifier
+ * @skey: Session key
+ * @skey_len: Length of @skey
+ * @c1: Value of challenge C1
+ * @c2: Value of challenge C2
+ * @hash_len: Hash length of the hash algorithm
+ * @ret_psk: Pointer too the resulting generated PSK
+ * @ret_len: length of @ret_psk
+ *
+ * Generate a PSK for TLS as specified in NVMe base specification, section 8.13.5.9:
+ *    Generated PSK for TLS
+ *
+ * The generated PSK for TLS shall be computed applying the HMAC function using the
+ * hash function H( ) selected by the HashID parameter in the DH-HMAC-CHAP_Challenge
+ * message with the session key KS as key to the concatenation of the two challenges
+ * C1 and C2 (i.e., generated PSK = HMAC(KS, C1 || C2)).
+ *
+ * Returns 0 on success with a valid generated PSK pointer in @ret_psk and the length
+ * of @ret_psk in @ret_len, or a negative error number otherwise.
+ */
+int nvme_auth_generate_psk(u8 hmac_id, u8 *skey, size_t skey_len,
+		u8 *c1, u8 *c2, size_t hash_len, u8 **ret_psk,size_t *ret_len)
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *shash;
+	u8 *psk;
+	const char *hmac_name;
+	int ret, psk_len;
+
+	if (!c1 || !c2) {
+		pr_warn("%s: invalid parameter\n", __func__);
+		return -EINVAL;
+	}
+
+	hmac_name = nvme_auth_hmac_name(hmac_id);
+	if (!hmac_name) {
+		pr_warn("%s: invalid hash algoritm %d\n",
+			__func__, hmac_id);
+		return -EINVAL;
+	}
+
+	tfm = crypto_alloc_shash(hmac_name, 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	psk_len = crypto_shash_digestsize(tfm);
+	psk = kzalloc(psk_len, GFP_KERNEL);
+	if (!psk) {
+		ret = -ENOMEM;
+		goto out_free_tfm;
+	}
+
+	shash = kmalloc(sizeof(struct shash_desc) +
+			crypto_shash_descsize(tfm),
+			GFP_KERNEL);
+	if (!shash) {
+		ret = -ENOMEM;
+		goto out_free_psk;
+	}
+
+	shash->tfm = tfm;
+	ret = crypto_shash_setkey(tfm, skey, skey_len);
+	if (ret)
+		goto out_free_shash;
+
+	ret = crypto_shash_init(shash);
+	if (ret)
+		goto out_free_shash;
+
+	ret = crypto_shash_update(shash, c1, hash_len);
+	if (ret)
+		goto out_free_shash;
+
+	ret = crypto_shash_update(shash, c2, hash_len);
+	if (ret)
+		goto out_free_shash;
+
+	ret = crypto_shash_final(shash, psk);
+	if (!ret) {
+		*ret_psk = psk;
+		*ret_len = psk_len;
+	}
+
+out_free_shash:
+	kfree_sensitive(shash);
+out_free_psk:
+	if (ret)
+		kfree_sensitive(psk);
+out_free_tfm:
+	crypto_free_shash(tfm);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_generate_psk);
+
 MODULE_DESCRIPTION("NVMe Authentication framework");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index c1d0bc5d9624..b13884b04dfd 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -40,5 +40,8 @@ int nvme_auth_gen_pubkey(struct crypto_kpp *dh_tfm,
 int nvme_auth_gen_shared_secret(struct crypto_kpp *dh_tfm,
 				u8 *ctrl_key, size_t ctrl_key_len,
 				u8 *sess_key, size_t sess_key_len);
+int nvme_auth_generate_psk(u8 hmac_id, u8 *skey, size_t skey_len,
+			   u8 *c1, u8 *c2, size_t hash_len,
+			   u8 **ret_psk, size_t *ret_len);
 
 #endif /* _NVME_AUTH_H */
-- 
2.35.3


