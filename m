Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357E6C02181
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jan 2025 16:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nc/VbRJRD7/RTZ4vM0lAWDhPm/kJIC/mYgkTq/VwIqQ=; b=yhZ55HIB/mvXz/bJd4CJ7hYblM
	kKmx21lm98aLOKNRLLcc1HVFr0rsXvhdHtJ1oDkcTgAm44KzNwNXwYC7MDJQvwoXNPe/8HSrv6okJ
	E/laUiIcK4bPG0A4KETaAZpaASao39JbFxqxnf2/tsGHPVepN+i5PAXox2X8uf741Xw9NPbzdyqMR
	31R5eMmQ/RSsQU4/W/RuY1appuLwyA5+YS8PQromGNeMvfErxTk93vhtfTLYIybg46RqJ3Eg+c6od
	Z+QuJO5M7I3omdwGkdshsZ4lup/L7yDbRwXFQs//zV44jAbIbHXtcbk715PkNIizAh1HjsUYwDc3E
	r+MJ8HtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tae4L-0000000An1c-10uG;
	Wed, 22 Jan 2025 16:59:09 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tae4H-0000000AmyH-2YbX
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jan 2025 16:59:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6B2ADA4290D;
	Wed, 22 Jan 2025 16:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5491AC4CED6;
	Wed, 22 Jan 2025 16:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737565144;
	bh=5MESGcBJSs/q9xIEgsfwIo9xkThDTLFnAEHvdo1wQRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A1hdp93jhQL1Yi6N/CYdDLoypmeTRw562bf8n6Rr210Ql0TVgg3uVo2kZ/wS5iv6T
	 e8NHBWtB2VrzpWgsGiE+oTDWOP045Z5Sr7hK50Z6paodt0fykuq8qDH8Hhw6p8mmJa
	 Y2n/5ln4O9n5wG+8PhC0bP7BIqZo143DRSWQA2WOV73krnEZXFk8ShFP7Ub1uOn0h7
	 W9YNEegu4prGqubXIMQj0zc4xOJaCRiiu+lrm80Wz30zGp0XUwatQ0thvj1Bxup3NC
	 NrGGdrK5K9vNmOfJE5jBMirK1BKYnBnbKK9cS2F8ExlI9AYwqmqN2swhfFI3VuFqAb
	 dJJgLoDKuztWA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 04/10] nvme: add nvme_auth_derive_tls_psk()
Date: Wed, 22 Jan 2025 17:58:23 +0100
Message-Id: <20250122165829.11603-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250122165829.11603-1-hare@kernel.org>
References: <20250122165829.11603-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250122_085905_787796_70A9B356 
X-CRM114-Status: GOOD (  16.41  )
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
 drivers/nvme/common/Kconfig |   1 +
 drivers/nvme/common/auth.c  | 111 ++++++++++++++++++++++++++++++++++++
 include/linux/nvme-auth.h   |   2 +
 3 files changed, 114 insertions(+)

diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
index 244432e0b73d..da963e4f3f1f 100644
--- a/drivers/nvme/common/Kconfig
+++ b/drivers/nvme/common/Kconfig
@@ -12,3 +12,4 @@ config NVME_AUTH
 	select CRYPTO_SHA512
 	select CRYPTO_DH
 	select CRYPTO_DH_RFC7919_GROUPS
+	select CRYPTO_HKDF
diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 616465bc8e79..2ae5b6ae59fc 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -15,6 +15,8 @@
 #include <linux/nvme.h>
 #include <linux/nvme-auth.h>
 
+#define HKDF_MAX_HASHLEN 64
+
 static u32 nvme_dhchap_seqnum;
 static DEFINE_MUTEX(nvme_dhchap_mutex);
 
@@ -708,5 +710,114 @@ int nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
 }
 EXPORT_SYMBOL_GPL(nvme_auth_generate_digest);
 
+/**
+ * nvme_auth_derive_tls_psk - Derive TLS PSK
+ * @hmac_id: Hash function identifier
+ * @psk: generated input PSK
+ * @psk_len: size of @psk
+ * @psk_digest: TLS PSK digest
+ * @ret_psk: Pointer to the resulting TLS PSK
+ *
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
+ *
+ * Returns 0 on success with a valid psk pointer in @ret_psk or a negative
+ * error number otherwise.
+ */
+int nvme_auth_derive_tls_psk(int hmac_id, u8 *psk, size_t psk_len,
+		u8 *psk_digest, u8 **ret_psk)
+{
+	struct crypto_shash *hmac_tfm;
+	const char *hmac_name;
+	const char *psk_prefix = "tls13 nvme-tls-psk";
+	static const char default_salt[HKDF_MAX_HASHLEN];
+	size_t info_len, prk_len;
+	char *info;
+	unsigned char *prk, *tls_key;
+	int ret;
+
+	hmac_name = nvme_auth_hmac_name(hmac_id);
+	if (!hmac_name) {
+		pr_warn("%s: invalid hash algorithm %d\n",
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
+	if (WARN_ON(prk_len > HKDF_MAX_HASHLEN)) {
+		ret = -EINVAL;
+		goto out_free_prk;
+	}
+	ret = hkdf_extract(hmac_tfm, psk, psk_len,
+			   default_salt, prk_len, prk);
+	if (ret)
+		goto out_free_prk;
+
+	ret = crypto_shash_setkey(hmac_tfm, prk, prk_len);
+	if (ret)
+		goto out_free_prk;
+
+	info_len = strlen(psk_digest) + strlen(psk_prefix) + 5;
+	info = kzalloc(info_len, GFP_KERNEL);
+	if (!info) {
+		ret = -ENOMEM;
+		goto out_free_prk;
+	}
+
+	put_unaligned_be16(psk_len, info);
+	memcpy(info + 2, psk_prefix, strlen(psk_prefix));
+	sprintf(info + 2 + strlen(psk_prefix), "%02d %s", hmac_id, psk_digest);
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


