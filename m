Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D40C3DA70
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sj48i6a9WRG+I3zSlR8hkVtLUXld5h6tybkGhVRnXwc=; b=dFWKwqegAGQr2di0lvaA+GjM4A
	y03b6wXfrp29Teo8ei6ctApy6oKBr1SE2btUVTXhyVNbj4G4XqJUvTxG3ohnDB1bXPRtd7WPMgEAY
	ageRZmPmALohPdVIWMDGv73pkI8sxlL9cKvZmOktJfbTAxz4V7M6I5WsJbwwOQFNaxDXJukK3M+9j
	clN6Y4a6831Cn/XUpcRbMi9yIJQ+lCFOVNPwhNZCPCvodPHD9OLuTFY4JxAX2Mv7kfpYr8Tib5VgM
	ZNZ/Hnm6sYCDuw7seX0k+tmpPiqqQOT9f0R2/V6Qktc97RZr2s9s2oggylQ2LEcWN7BbsV1Mcr9mm
	qRhWfDNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVtvX-00000009lFn-2B12;
	Mon, 22 Jul 2024 14:22:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVtvU-00000009lCt-0hJg
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 14:22:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 982A160B5A;
	Mon, 22 Jul 2024 14:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2145C4AF18;
	Mon, 22 Jul 2024 14:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721658127;
	bh=w2AvYri72oTsUs/0JTyA110TEn2lqSudOuEV4wiLsXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ELoSdDsk8UqUvMBQIb5XbUuZATiIFBKMCYdca+7KEJdcZDl5Rm9iCZ3WjVj+mGU+U
	 WTHyFgAXzwh3v+vG7Dy7s6xpaUNITPbuB4W0YbkzdtfhDjUDgORC1YV++TkZByPVdZ
	 8Aq7TtVs0ouENH/IoUCCk4hgSIhvTd2yJl/3axpVu2PixxlSosaVjR85z1Pevyf+mx
	 +KK6AZo71gZGeYH41X/PHwtNmEizTdPTH0nsTezWTUIT22Kb3SeJj0YNykK5nPOPdP
	 oY/J4SXUsDtC7MKWG3Bc/ZTCDNd/90NUqikx1XarvF0zxB68TUY38e0JkLpQ2b/7Dv
	 B2Vz9Wpm70dpA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/9] nvme: add nvme_auth_generate_digest()
Date: Mon, 22 Jul 2024 16:21:16 +0200
Message-Id: <20240722142122.128258-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240722142122.128258-1-hare@kernel.org>
References: <20240722142122.128258-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_072208_315484_8D5158DC 
X-CRM114-Status: GOOD (  16.10  )
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

Add a function to calculate the PSK digest as specified in TP8018.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/common/auth.c | 126 +++++++++++++++++++++++++++++++++++++
 include/linux/nvme-auth.h  |   2 +
 2 files changed, 128 insertions(+)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index f6d21960b140..7e40f205d3e4 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -558,5 +558,131 @@ int nvme_auth_generate_psk(u8 hmac_id, u8 *skey, size_t skey_len,
 }
 EXPORT_SYMBOL_GPL(nvme_auth_generate_psk);
 
+/*
+ * Generate a TLS PSK digest as specified in TP8018 Section 3.6.1.3:
+ *   TLS PSK and PSK identity Derivation
+ *
+ * The PSK digest shall be computed by encoding in Base64 (refer to RFC 4648)
+ * the result of the application of the HMAC function using the hash function
+ * specified in item 4 above (ie the hash function of the cipher suite associated
+ * with the PSK identity) with the PSK as HMAC key to the concatenation of:
+ * - the NQN of the host (i.e., NQNh) not including the null terminator;
+ * - a space character;
+ * - the NQN of the NVM subsystem (i.e., NQNc) not including the null terminator;
+ * - a space character; and
+ * - the seventeen ASCII characters "NVMe-over-Fabrics"
+ * (i.e., <PSK digest> = Base64(HMAC(PSK, NQNh || " " || NQNc || " " || "NVMe-over-Fabrics"))).
+ * The length of the PSK digest depends on the hash function used to compute
+ * it as follows:
+ * - If the SHA-256 hash function is used, the resulting PSK digest is 44 characters long; or
+ * - If the SHA-384 hash function is used, the resulting PSK digest is 64 characters long.
+ */
+int nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
+		char *subsysnqn, char *hostnqn, u8 **ret_digest)
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *shash;
+	u8 *digest, *hmac;
+	const char *hmac_name;
+	size_t digest_len, hmac_len;
+	int ret;
+
+	if (WARN_ON(!subsysnqn || !hostnqn))
+		return -EINVAL;
+
+	hmac_name = nvme_auth_hmac_name(hmac_id);
+	if (!hmac_name) {
+		pr_warn("%s: invalid hash algoritm %d\n",
+			__func__, hmac_id);
+		return -EINVAL;
+	}
+
+	switch (nvme_auth_hmac_hash_len(hmac_id)) {
+	case 32:
+		hmac_len = 44;
+		break;
+	case 48:
+		hmac_len = 64;
+		break;
+	default:
+		pr_warn("%s: invalid hash algorithm '%s'\n",
+			__func__, hmac_name);
+		return -EINVAL;
+	}
+
+	hmac = kzalloc(hmac_len + 1, GFP_KERNEL);
+	if (!hmac)
+		return -ENOMEM;
+
+	tfm = crypto_alloc_shash(hmac_name, 0, 0);
+	if (IS_ERR(tfm)) {
+		ret = PTR_ERR(tfm);
+		goto out_free_hmac;
+	}
+
+	digest_len = crypto_shash_digestsize(tfm);
+	digest = kzalloc(digest_len, GFP_KERNEL);
+	if (!digest) {
+		ret = -ENOMEM;
+		goto out_free_tfm;
+	}
+
+	shash = kmalloc(sizeof(struct shash_desc) +
+			crypto_shash_descsize(tfm),
+			GFP_KERNEL);
+	if (!shash) {
+		ret = -ENOMEM;
+		goto out_free_digest;
+	}
+
+	shash->tfm = tfm;
+	ret = crypto_shash_setkey(tfm, psk, psk_len);
+	if (ret)
+		goto out_free_shash;
+
+	ret = crypto_shash_init(shash);
+	if (ret)
+		goto out_free_shash;
+
+	ret = crypto_shash_update(shash, hostnqn, strlen(hostnqn));
+	if (ret)
+		goto out_free_shash;
+
+	ret = crypto_shash_update(shash, " ", 1);
+	if (ret)
+		goto out_free_shash;
+
+	ret = crypto_shash_update(shash, subsysnqn, strlen(subsysnqn));
+	if (ret)
+		goto out_free_shash;
+
+	ret = crypto_shash_update(shash, " NVMe-over-Fabrics", 18);
+	if (ret)
+		goto out_free_shash;
+
+	ret = crypto_shash_final(shash, digest);
+	if (ret)
+		goto out_free_shash;
+
+	ret = base64_encode(digest, digest_len, hmac);
+	if (ret < hmac_len)
+		ret = -ENOKEY;
+	*ret_digest = hmac;
+	ret = 0;
+
+out_free_shash:
+	kfree_sensitive(shash);
+out_free_digest:
+	kfree_sensitive(digest);
+out_free_tfm:
+	crypto_free_shash(tfm);
+out_free_hmac:
+	if (ret)
+		kfree_sensitive(hmac);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_generate_digest);
+
 MODULE_DESCRIPTION("NVMe Authentication framework");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index b13884b04dfd..998f06bf10fd 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -43,5 +43,7 @@ int nvme_auth_gen_shared_secret(struct crypto_kpp *dh_tfm,
 int nvme_auth_generate_psk(u8 hmac_id, u8 *skey, size_t skey_len,
 			   u8 *c1, u8 *c2, size_t hash_len,
 			   u8 **ret_psk, size_t *ret_len);
+int nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
+		char *subsysnqn, char *hostnqn, u8 **ret_digest);
 
 #endif /* _NVME_AUTH_H */
-- 
2.35.3


