Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802A1CA0EF8
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Aug 2025 11:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zf764fW4HCRFWEar8Aa0JvnnzRlophMZJ2GHF1X3HfY=; b=SNLCT85/C0M+iDL5fWbfZhHMh9
	5dhEevyhGLatticsH/8wjkvgFTHQju+VoJkumPuv5ew2ORQMszhs2SfeQA2BwZhqYcblx9iP0ATEK
	XRNE9PK0EWtN5rA8G0gDW6QNyYrRtjqF0JsqZNT1pgWGIzV0b4K8TiyqCkBZqIPRGHJyKnxLTdqZD
	1/9jIJKzcDCL8GHT/VYD9VZPDPMRTVAyknbcYvoj4LpjmFjnvhQwY6FFkjFbHIxQDYZ6x0TWMm/q+
	5+7NYn2zeS0MOSOgCguFgmN65BZZxk8n8/anrcDTfQzCrxDqie4Q+NYjPFWYGoeKUy+FodjsigIXR
	ZK3uUMTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uogbt-0000000DHby-2SYw;
	Wed, 20 Aug 2025 11:04:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoerp-0000000Crlk-1eA7
	for linux-nvme@lists.infradead.org;
	Wed, 20 Aug 2025 09:12:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 460815C6732;
	Wed, 20 Aug 2025 09:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BABC4CEEB;
	Wed, 20 Aug 2025 09:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755681144;
	bh=slj9QhQUoQ7qyERxsfyBXkhjpEIA2RFzqHogMhfjn6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Te8ewG0QHg0EBLd726x3Qfx0nVowU6yjcMFla1nkzspfl/OJRygLF+ymqG0/hq2wj
	 PjrisjLVFl2B4ezuPZcAJf658vQa0rUXb6Up3D8D9R/g7T4fGu2+hzu6uEAG73S/Gh
	 eWZ5H1x43jHDtoiK6Dn/mHAkhJbtF6P9MuJ/Ens2tgRumYHaymK3E3sLfiSV4xg9v/
	 Es7NWn7IaDcASKIetpjKFRveNxoncaHz3f1HTOiggfNrGa6gcJrYR0cmC4nlhbUC6T
	 sgEJ6bTB+VRXRpUhgBaYFdVQb2GNfsA1a91Cb2ZHEyDogKGY6+5cIvjCTZeLrwRQqC
	 3Wuqy1q+ek0zw==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Leech <cleech@redhat.com>,
	linux-nvme@lists.infradead.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/2] crypto: hkdf: add hkdf_expand_label()
Date: Wed, 20 Aug 2025 11:12:10 +0200
Message-ID: <20250820091211.25368-2-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820091211.25368-1-hare@kernel.org>
References: <20250820091211.25368-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_021225_515958_958D4B7D 
X-CRM114-Status: GOOD (  13.00  )
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

From: Chris Leech <cleech@redhat.com>

Provide an implementation of RFC 8446 (TLS 1.3) HKDF-Expand-Label

Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Chris Leech <cleech@redhat.com>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 crypto/hkdf.c         | 55 +++++++++++++++++++++++++++++++++++++++++++
 include/crypto/hkdf.h |  4 ++++
 2 files changed, 59 insertions(+)

diff --git a/crypto/hkdf.c b/crypto/hkdf.c
index 82d1b32ca6ce..465bad6e6c93 100644
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
index 6a9678f508f5..5e75d17a58ab 100644
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
2.43.0


