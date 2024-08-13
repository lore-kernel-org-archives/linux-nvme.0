Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5610AC52D7C
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Aug 2024 11:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a+jRh6mi/fsUZQmxqgLFeZvMPb+vKcR16kuk9Wb/S4g=; b=pKTKt3H1/WGa0n8fcSma2151U6
	Pch3/gV/QbzKtOJrw7wf/+5EXyn0xieLlZdaG6hW2mSmMqL+kxSaap9mdG8OuHOk0NcZGXXOdbB7Q
	iVJ/5j9ZnF4GfrqmdXnYiHqkfpZVK33AxxLqO8FeZsfcRlINZmIFh8zgeyOjVE8Gp43vswwRVlZFT
	O1eJRGCZUC5vfe827nbYFKMyyDqA7GpPIfIlXKw9owuvyXt68B4aedWcHG4T7ltUKc94t6pSpHovt
	mxiTWIHugwOmNO7NLLM5l8BOqMPqzDicUFXMN9rK5CC25rgNSmr5KSAMJinwMRJHoCnIFMLk4ZpmQ
	I+UGDYAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdpV3-00000003TLQ-414b;
	Tue, 13 Aug 2024 11:15:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdpV1-00000003TKX-21AC
	for linux-nvme@lists.infradead.org;
	Tue, 13 Aug 2024 11:15:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CE28361632;
	Tue, 13 Aug 2024 11:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E1EC4AF0B;
	Tue, 13 Aug 2024 11:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723547734;
	bh=0H0FdYFNiU+Qd/nXDqI0qStv1VsnV0r/zF9hqLf7QyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ni3qdRBmB/LXv/pHvu7B6jCh9Z29SvaaMWBFXFPEobzCwycgZspm6L9CZRQXUk2Qd
	 p9uzMOHYpDXBOL/HSdLfuIwkN55bpNGiMaPG3gl4cfmxLPT559fvM5djg2XK0UL+6e
	 CzH9LslanVdlnXLxlZL15MFcwpwHhiDZPOTMnH3WjUGF/pa8e+MRThH1DDVDYxXRIw
	 6QoWhtlbppSz0NKLGbEWgndE4aXigQxHCPJNU9l/P6jTcs+A9T3edsdwPy2lQ9fpki
	 SEbbHX5khigaRp474uQAdUouMqfnfHXhTkNtl2lCbZKrfdajjlFq3SqlP8yCzmkJpI
	 rD2hG/4ShtH9Q==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/9] nvme: add nvme_auth_generate_psk()
Date: Tue, 13 Aug 2024 13:15:05 +0200
Message-Id: <20240813111512.135634-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240813111512.135634-1-hare@kernel.org>
References: <20240813111512.135634-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_041535_674533_CF618C69 
X-CRM114-Status: GOOD (  15.77  )
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


