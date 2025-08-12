Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1177CA0EC4
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Aug 2025 22:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t05WtJPN/xLNb3BIpZ/WbQHHm1HWVFCs96hRIv2dnDw=; b=UCcIjmTsDY40zYsfBsFgs4s4/S
	HPrriN+ZEiVrgz3cyZ1gt/EZQa+xpi3P0rGgr6Fh5e2uooOC0XT575dumHmKUP1n0+rJ5VgYlFTHF
	5c1ALun7NcT+zmOq5/sM1vX/Lotd8XyFcrkE0PDUFTJm/Qu8XILlP8ua1w6AZntgnZEFxBY1gTF9Y
	5btOE28VNl0TswgVKayr/uAlWeynIARqKmMaP+pgRVLjh8S9cWnvMYbvhQzRyZRkhtC8o66SbGpBa
	HMm+qaZ1R7o/NGbTR1zwMvXpeh7Y+W+sO8dNBNAO+CV/3bp6V0hRpUXs+xIKFaMwuu7q10OacJnoI
	fhaosszA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulxDV-0000000C8U2-17ck;
	Tue, 12 Aug 2025 22:11:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulxDS-0000000C8Ti-1g6g
	for linux-nvme@lists.infradead.org;
	Tue, 12 Aug 2025 22:11:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755036693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t05WtJPN/xLNb3BIpZ/WbQHHm1HWVFCs96hRIv2dnDw=;
	b=dM/uJPDPzC7Wms29gxXAeFVoW8C6dbyo/rGhOm2TQO5suBVxyLoZf+ZSSGl/ZcAxtuF8vj
	2JwPwrIPwU1TKSv4xniKUXDwQsnca4/fZ0IW1t65hIOIZwprZLjK3/PQFCvR2b6d8HRaxk
	4YFg/QSqY8GSmSprLSF+iFQvoNDiHK8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-4JrA41XQMEmygEkMDKPL9w-1; Tue,
 12 Aug 2025 18:11:31 -0400
X-MC-Unique: 4JrA41XQMEmygEkMDKPL9w-1
X-Mimecast-MFC-AGG-ID: 4JrA41XQMEmygEkMDKPL9w_1755036690
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DC1B1800352;
	Tue, 12 Aug 2025 22:11:30 +0000 (UTC)
Received: from my-developer-toolbox-latest.redhat.com (unknown [10.2.17.22])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5986B195608F;
	Tue, 12 Aug 2025 22:11:29 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	John Meneghini <jmeneghi@redhat.com>
Subject: [RFC PATCH 1/2] crypto: hkdf: add hkdf_expand_label()
Date: Tue, 12 Aug 2025 15:11:13 -0700
Message-ID: <20250812221113.313763-1-cleech@redhat.com>
In-Reply-To: <20250721021718.1159879-1-cleech@redhat.com>
References: <20250721021718.1159879-1-cleech@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JCLZqEjcJUFrtmWThEd2uwmbi3qXnqa9ngQyxR3xWMY_1755036690
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_151134_514761_E54D12F0 
X-CRM114-Status: GOOD (  20.21  )
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

Provide an implementation of RFC 8446 (TLS 1.3) HKDF-Expand-Label

Signed-off-by: Chris Leech <cleech@redhat.com>
---
 crypto/hkdf.c         | 55 +++++++++++++++++++++++++++++++++++++++++++
 include/crypto/hkdf.h |  4 ++++
 2 files changed, 59 insertions(+)

diff --git a/crypto/hkdf.c b/crypto/hkdf.c
index 82d1b32ca6ce4..465bad6e6c93e 100644
--- a/crypto/hkdf.c
+++ b/crypto/hkdf.c
@@ -11,6 +11,7 @@
 #include <crypto/sha2.h>
 #include <crypto/hkdf.h>
 #include <linux/module.h>
+#include <linux/unaligned.h>
 
 /*
  * HKDF consists of two steps:
@@ -129,6 +130,60 @@ int hkdf_expand(struct crypto_shash *hmac_tfm,
 }
 EXPORT_SYMBOL_GPL(hkdf_expand);
 
+/**
+ * hkdf_expand_label - HKDF-Expand-Label (RFC 8846 section 7.1)
+ * @hmac_tfm: hash context keyed with pseudorandom key
+ * @label: ASCII label without "tls13 " prefix
+ * @label_len: length of @label
+ * @context: context bytes
+ * @contextlen: length of @context
+ * @okm: output keying material
+ * @okmlen: length of @okm
+ *
+ * Build the TLS 1.3 HkdfLabel structure and invoke hkdf_expand().
+ *
+ * Returns 0 on success with output keying material stored in @okm,
+ * or a negative errno value otherwise.
+ */
+int hkdf_expand_label(struct crypto_shash *hmac_tfm,
+		const u8 *label, unsigned int labellen,
+		const u8 *context, unsigned int contextlen,
+		u8 *okm, unsigned int okmlen)
+{
+	int err;
+	u8 *info;
+	unsigned int infolen;
+	static const char tls13_prefix[] = "tls13 ";
+	unsigned int prefixlen = sizeof(tls13_prefix) - 1; /* exclude NUL */
+
+	if (WARN_ON(labellen > (255 - prefixlen)))
+		return -EINVAL;
+	if (WARN_ON(contextlen > 255))
+		return -EINVAL;
+
+	infolen = 2 + (1 + prefixlen + labellen) + (1 + contextlen);
+	info = kzalloc(infolen, GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	/* HkdfLabel.Length */
+	put_unaligned_be16(okmlen, info);
+
+	/* HkdfLabel.Label */
+	info[2] = prefixlen + labellen;
+	memcpy(info + 3, tls13_prefix, prefixlen);
+	memcpy(info + 3 + prefixlen, label, labellen);
+
+	/* HkdfLabel.Context */
+	info[3 + prefixlen + labellen] = contextlen;
+	memcpy(info + 4 + prefixlen + labellen, context, contextlen);
+
+	err = hkdf_expand(hmac_tfm, info, infolen, okm, okmlen);
+	kfree_sensitive(info);
+	return err;
+}
+EXPORT_SYMBOL_GPL(hkdf_expand_label);
+
 struct hkdf_testvec {
 	const char *test;
 	const u8 *ikm;
diff --git a/include/crypto/hkdf.h b/include/crypto/hkdf.h
index 6a9678f508f5d..5e75d17a58abe 100644
--- a/include/crypto/hkdf.h
+++ b/include/crypto/hkdf.h
@@ -17,4 +17,8 @@ int hkdf_extract(struct crypto_shash *hmac_tfm, const u8 *ikm,
 int hkdf_expand(struct crypto_shash *hmac_tfm,
 		const u8 *info, unsigned int infolen,
 		u8 *okm, unsigned int okmlen);
+int hkdf_expand_label(struct crypto_shash *hmac_tfm,
+		const u8 *label, unsigned int labellen,
+		const u8 *context, unsigned int contextlen,
+		u8 *okm, unsigned int okmlen);
 #endif
-- 
2.49.0


From 17e645b802bd61b4f3182195c15935e2fa1155ad Mon Sep 17 00:00:00 2001
From: Chris Leech <cleech@redhat.com>
Date: Tue, 12 Aug 2025 12:41:08 -0700
Subject: [RFC PATCH 2/2] nvme-auth: use hkdf_expand_label()

When generating keying material during an authentication transaction
(secure channel concatenation), the HKDF-Expand-Label function is part
of the specified key derivation process.

The current open-coded implementation misses the length prefix
requirements on the HkdfLabel label and context variable-length vectors
(RFC 8446 Section 3.4).

Instead, use the hkdf_expand_label() function.

Signed-off-by: Chris Leech <cleech@redhat.com>
---
 drivers/nvme/common/auth.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 91e273b89fea3..bfa6f0a82d3e9 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -715,10 +715,10 @@ int nvme_auth_derive_tls_psk(int hmac_id, u8 *psk, size_t psk_len,
 {
 	struct crypto_shash *hmac_tfm;
 	const char *hmac_name;
-	const char *psk_prefix = "tls13 nvme-tls-psk";
 	static const char default_salt[HKDF_MAX_HASHLEN];
-	size_t info_len, prk_len;
-	char *info;
+	size_t prk_len;
+	const char *label = "nvme-tls-psk";
+	const char *ctx;
 	unsigned char *prk, *tls_key;
 	int ret;
 
@@ -758,36 +758,30 @@ int nvme_auth_derive_tls_psk(int hmac_id, u8 *psk, size_t psk_len,
 	if (ret)
 		goto out_free_prk;
 
-	/*
-	 * 2 additional bytes for the length field from HDKF-Expand-Label,
-	 * 2 additional bytes for the HMAC ID, and one byte for the space
-	 * separator.
-	 */
-	info_len = strlen(psk_digest) + strlen(psk_prefix) + 5;
-	info = kzalloc(info_len + 1, GFP_KERNEL);
-	if (!info) {
+	/* Context is ASCII: "<hash-id-two-digits> <base64-digest>" */
+	ctx = kasprintf(GFP_KERNEL, "%02d %s", hmac_id, psk_digest);
+	if (!ctx) {
 		ret = -ENOMEM;
 		goto out_free_prk;
 	}
 
-	put_unaligned_be16(psk_len, info);
-	memcpy(info + 2, psk_prefix, strlen(psk_prefix));
-	sprintf(info + 2 + strlen(psk_prefix), "%02d %s", hmac_id, psk_digest);
-
 	tls_key = kzalloc(psk_len, GFP_KERNEL);
 	if (!tls_key) {
 		ret = -ENOMEM;
-		goto out_free_info;
+		goto out_free_ctx;
 	}
-	ret = hkdf_expand(hmac_tfm, info, info_len, tls_key, psk_len);
+	ret = hkdf_expand_label(hmac_tfm,
+				label, strlen(label),
+				ctx, strlen(ctx),
+				tls_key, psk_len);
 	if (ret) {
 		kfree(tls_key);
-		goto out_free_info;
+		goto out_free_ctx;
 	}
 	*ret_psk = tls_key;
 
-out_free_info:
-	kfree(info);
+out_free_ctx:
+	kfree(ctx);
 out_free_prk:
 	kfree(prk);
 out_free_shash:
-- 
2.49.0


