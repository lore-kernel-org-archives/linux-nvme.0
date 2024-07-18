Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB98C3DA49
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 15:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4gE1e4w8Xafwi6LX6+EykBjUSgDkKm19Lm8i3+mlFS8=; b=rOIYki41NZlr9o3Y/PLVEh4EQn
	AO0IPJNnU4gTQWrY/Xa1BAIwZOSTIcjM9M6Dw79/ga5CvXpyVrNOxhZPHxEVQAYadK0B5dCEixS4A
	J3hYx76Q8xfi3VrcTCcGUMByw6Ip4cTFQbetwZfcbzoTfkJTqjWkLeA2/Fwx/yG8KHnZRSzLNrM4z
	uLbnggKqv3R6f/fY/iDgkTACA3ctJzkX+awZaKF2MPExCObJuUBUfawgsDqyhuFfJocnlLsz9ohhw
	lh+4wpWRh+cWlqIS4ec96uTOf0ADR7gVwFtymATswOzj+nhf6kSNGUKDJT4ysNIiI7o4YtTorqex4
	3zUuNA7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSj7-0000000HO4E-0sPG;
	Thu, 18 Jul 2024 15:07:25 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSj3-0000000HO1W-2YN8
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 15:07:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 133486199A;
	Thu, 18 Jul 2024 15:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B773C4AF0D;
	Thu, 18 Jul 2024 15:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721315240;
	bh=28iWTpGgJQZACHrKP438Mo3qa8pSKYOIzwL8Ms+F4hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CttJQz9/pW5GJQPlX6Lgeo0CVo03AJVPcroR6KiFI5ml6PzlNoLwrTmtclhDdIzF0
	 hc6+7224G/+D3lhctekg22uTS0EWXtN3fvex+nW0ktxyldwpIH0yMRzQ5BZ3Zuj0o/
	 32XwawlSQ8mwqsbADB94TnOb85Re8SO8FB967W9jYHH0WziOxg50ZpJ/ZnoBoit8Fj
	 cVNG6FhjvVg9AzOtm4Bol69RX+jG2uYNGlUg0RBV6yjI2Mf7VCwO1j+L+ietFiVtZQ
	 uF+dygLcTGh/PmmObKcuR1AZWpiY9jssklYINfp4iRr/vPqtE99Z5LBZ1etPyRWcoN
	 hte7JZM14aYvw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/8] nvme: add nvme_auth_derive_tls_psk()
Date: Thu, 18 Jul 2024 17:06:54 +0200
Message-Id: <20240718150658.99580-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240718150658.99580-1-hare@kernel.org>
References: <20240718150658.99580-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_080721_778079_D5B84C20 
X-CRM114-Status: GOOD (  14.13  )
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/common/auth.c | 90 ++++++++++++++++++++++++++++++++++++++
 include/linux/nvme-auth.h  |  2 +
 2 files changed, 92 insertions(+)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 7e40f205d3e4..0b000a562c0f 100644
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


