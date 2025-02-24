Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E87C021BE
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 13:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xBizKz3V1RXT7T7Mxp7K/+Vm2o/FvUtVkQ6OGDBQ99Q=; b=Ct4CyG9b039Th7UEJuzQtRnY0o
	CkOeVgx2yzWAHCEPUOeyHLLAzkS8obH3lk1Gwd/RJJam5kYIMLHLZh+A7vB9EIpaBlCnI4NTPFMuf
	1bN+JsJVdGjuKOEcJb4ZAB5ePxZAeg/Ap7kRfizRnzlKfIxzXsXTLaIqZMdDSU96mZIBWo7VQshb2
	y4wGhjjlfA+/KPeF11j0JKwKl7z/ToE/A47eNCbWqLsPxz5v4pUVQcBWyjGWiMdUghA3rUoP5v/UK
	3/N2rC3JSimaYlvrhPtohzv0pDHTJoQQh8WIIZ9PmVv9vfElu2FQOPtlSQCMQRIEoabbzuII4/ER7
	dVDrC+IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmYHu-0000000Do26-46oL;
	Mon, 24 Feb 2025 13:14:22 +0000
Received: from tor.source.kernel.org ([2600:3c04::f03c:95ff:fe5e:7468])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmXjK-0000000DiXu-3oNe
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 12:38:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6045C611BB;
	Mon, 24 Feb 2025 12:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982D4C4CEE6;
	Mon, 24 Feb 2025 12:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740400717;
	bh=kuBoonkf53zdsrZHLFtNd31u4Cgy8Ye3WIch799qs28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=esWWZegurV4NTyY/r1rR8Y5EeG5AkBBbyMZI0RVV3aCXDERBY6+ukiPuMVNATtHYJ
	 gIxtjYW6NesAtKt85YpCxyKdvnL+7auTQ/k5H+OctSU9eEz21UWCrlfKBzc2SaBNxl
	 0cxtsjufQBAYXWFtSRovRBaWNWDcTDIViQlc13c5xnoVdK4O38MkabBnDgf+lHfi19
	 TYfRG8dOTUeU+KSCymQILySR+24G6lNu1lV2zP1GVQehCq7hTkdQ8QS6PmIeyuavhN
	 QDC81Mkxp/I0hVQmmWA1UNy7GVB31BqPDCFonB0jEiMvN4fjcL2AxkFpFoSwxrwORe
	 wx59cdD0ORllA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 02/10] nvme: add nvme_auth_generate_psk()
Date: Mon, 24 Feb 2025 13:38:10 +0100
Message-Id: <20250224123818.42218-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250224123818.42218-1-hare@kernel.org>
References: <20250224123818.42218-1-hare@kernel.org>
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

Add a function to generate a NVMe PSK from the shared credentials
negotiated by DH-HMAC-CHAP.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/common/auth.c | 87 ++++++++++++++++++++++++++++++++++++++
 include/linux/nvme-auth.h  |  3 ++
 2 files changed, 90 insertions(+)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 9b7126e1a19d..76e4a12f005e 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -11,6 +11,7 @@
 #include <linux/unaligned.h>
 #include <crypto/hash.h>
 #include <crypto/dh.h>
+#include <crypto/hkdf.h>
 #include <linux/nvme.h>
 #include <linux/nvme-auth.h>
 
@@ -471,5 +472,91 @@ int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key)
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
+ * Generate a PSK for TLS as specified in NVMe base specification, section
+ * 8.13.5.9: Generated PSK for TLS
+ *
+ * The generated PSK for TLS shall be computed applying the HMAC function
+ * using the hash function H( ) selected by the HashID parameter in the
+ * DH-HMAC-CHAP_Challenge message with the session key KS as key to the
+ * concatenation of the two challenges C1 and C2 (i.e., generated
+ * PSK = HMAC(KS, C1 || C2)).
+ *
+ * Returns 0 on success with a valid generated PSK pointer in @ret_psk and
+ * the length of @ret_psk in @ret_len, or a negative error number otherwise.
+ */
+int nvme_auth_generate_psk(u8 hmac_id, u8 *skey, size_t skey_len,
+		u8 *c1, u8 *c2, size_t hash_len, u8 **ret_psk, size_t *ret_len)
+{
+	struct crypto_shash *tfm;
+	SHASH_DESC_ON_STACK(shash, tfm);
+	u8 *psk;
+	const char *hmac_name;
+	int ret, psk_len;
+
+	if (!c1 || !c2)
+		return -EINVAL;
+
+	hmac_name = nvme_auth_hmac_name(hmac_id);
+	if (!hmac_name) {
+		pr_warn("%s: invalid hash algorithm %d\n",
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
+	shash->tfm = tfm;
+	ret = crypto_shash_setkey(tfm, skey, skey_len);
+	if (ret)
+		goto out_free_psk;
+
+	ret = crypto_shash_init(shash);
+	if (ret)
+		goto out_free_psk;
+
+	ret = crypto_shash_update(shash, c1, hash_len);
+	if (ret)
+		goto out_free_psk;
+
+	ret = crypto_shash_update(shash, c2, hash_len);
+	if (ret)
+		goto out_free_psk;
+
+	ret = crypto_shash_final(shash, psk);
+	if (!ret) {
+		*ret_psk = psk;
+		*ret_len = psk_len;
+	}
+
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


