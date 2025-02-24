Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB68BC021A6
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 13:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mz5iN+AzIUlb46vnJjVMcMmrpBF+mmj47fBGj/gzqf0=; b=aulH663NFLs60PXKuehOY85Mh0
	ug5yCRKEH1fqshDk5FME71uTx2pnthM2uJ/aGKssznnk/TfDANpuCYksOsKq3YoQTgv/vqOHuV2oe
	Xcpfm7jqI3ER11CTi3AJ11XDhG//XJ23UbsJBA+mbQlbbu/F0orBXyw2MwfZoPnPlcUvteyeiYeca
	t+VGytmOisz8SC2TiI3gWI3m5avUxtKNLUgxmANdMgZB81yHB7vMsZF0Oq3b6oji34cy4sN0Hi19m
	se+cYg5Ff0CsMhoJ7Wrh4ghenXOCxQYi7Awoa+u7SCSDQJAwk/nri/IcfIzqZ88THRrjWouwSym2x
	RbmI0wxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmYHx-0000000Do7j-0hVc;
	Mon, 24 Feb 2025 13:14:25 +0000
Received: from tor.source.kernel.org ([2600:3c04::f03c:95ff:fe5e:7468])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmXjM-0000000DiYP-1zZ6
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 12:38:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 17D25611AF;
	Mon, 24 Feb 2025 12:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF14C4CEEA;
	Mon, 24 Feb 2025 12:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740400719;
	bh=m3XUBLtRwyiqt3HDzwl1Yrz39vYSL+eqquLvQQS8rr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EtG7WFPgc6F5U3ag+GIo18Nb2X7Hqh00pLakr2kY8SKVdmzYYR9ykbioOAhhvLtmX
	 xwIongyQk7Y0cB6hfv4vW/UnFUhLlAKFsQTg8ox9P9Z93oCj7qZkAXdz1+Ke6iTpWU
	 Gos6uRNEGI/aBrtKGPi1fw/ktiGHvNtVxn5lScLX2Yo4nRd4GfDOE8yZ8Mv34i3y1I
	 AowbeNF3qJMn9ph0Br4B4a0Ss8d00Aw0TjwDJ8deVYR9Al3Lzar+UOHCYCrDohvePy
	 Iz/n3N0IMydO0u9MVwSU0vzEqkrYEEmc3gbmLRcoRMdF3mNulsokTSDh8INxeVi+pt
	 Clp/odduMvgwA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 03/10] nvme: add nvme_auth_generate_digest()
Date: Mon, 24 Feb 2025 13:38:11 +0100
Message-Id: <20250224123818.42218-4-hare@kernel.org>
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

Add a function to calculate the PSK digest as specified in TP8018.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/common/auth.c | 134 +++++++++++++++++++++++++++++++++++++
 include/linux/nvme-auth.h  |   2 +
 2 files changed, 136 insertions(+)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 76e4a12f005e..54b75d177101 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -558,5 +558,139 @@ int nvme_auth_generate_psk(u8 hmac_id, u8 *skey, size_t skey_len,
 }
 EXPORT_SYMBOL_GPL(nvme_auth_generate_psk);
 
+/**
+ * nvme_auth_generate_digest - Generate TLS PSK digest
+ * @hmac_id: Hash function identifier
+ * @psk: Generated input PSK
+ * @psk_len: Length of @psk
+ * @subsysnqn: NQN of the subsystem
+ * @hostnqn: NQN of the host
+ * @ret_digest: Pointer to the returned digest
+ *
+ * Generate a TLS PSK digest as specified in TP8018 Section 3.6.1.3:
+ *   TLS PSK and PSK identity Derivation
+ *
+ * The PSK digest shall be computed by encoding in Base64 (refer to RFC
+ * 4648) the result of the application of the HMAC function using the hash
+ * function specified in item 4 above (ie the hash function of the cipher
+ * suite associated with the PSK identity) with the PSK as HMAC key to the
+ * concatenation of:
+ * - the NQN of the host (i.e., NQNh) not including the null terminator;
+ * - a space character;
+ * - the NQN of the NVM subsystem (i.e., NQNc) not including the null
+ *   terminator;
+ * - a space character; and
+ * - the seventeen ASCII characters "NVMe-over-Fabrics"
+ * (i.e., <PSK digest> = Base64(HMAC(PSK, NQNh || " " || NQNc || " " ||
+ *  "NVMe-over-Fabrics"))).
+ * The length of the PSK digest depends on the hash function used to compute
+ * it as follows:
+ * - If the SHA-256 hash function is used, the resulting PSK digest is 44
+ *   characters long; or
+ * - If the SHA-384 hash function is used, the resulting PSK digest is 64
+ *   characters long.
+ *
+ * Returns 0 on success with a valid digest pointer in @ret_digest, or a
+ * negative error number on failure.
+ */
+int nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
+		char *subsysnqn, char *hostnqn, u8 **ret_digest)
+{
+	struct crypto_shash *tfm;
+	SHASH_DESC_ON_STACK(shash, tfm);
+	u8 *digest, *enc;
+	const char *hmac_name;
+	size_t digest_len, hmac_len;
+	int ret;
+
+	if (WARN_ON(!subsysnqn || !hostnqn))
+		return -EINVAL;
+
+	hmac_name = nvme_auth_hmac_name(hmac_id);
+	if (!hmac_name) {
+		pr_warn("%s: invalid hash algorithm %d\n",
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
+	enc = kzalloc(hmac_len + 1, GFP_KERNEL);
+	if (!enc)
+		return -ENOMEM;
+
+	tfm = crypto_alloc_shash(hmac_name, 0, 0);
+	if (IS_ERR(tfm)) {
+		ret = PTR_ERR(tfm);
+		goto out_free_enc;
+	}
+
+	digest_len = crypto_shash_digestsize(tfm);
+	digest = kzalloc(digest_len, GFP_KERNEL);
+	if (!digest) {
+		ret = -ENOMEM;
+		goto out_free_tfm;
+	}
+
+	shash->tfm = tfm;
+	ret = crypto_shash_setkey(tfm, psk, psk_len);
+	if (ret)
+		goto out_free_digest;
+
+	ret = crypto_shash_init(shash);
+	if (ret)
+		goto out_free_digest;
+
+	ret = crypto_shash_update(shash, hostnqn, strlen(hostnqn));
+	if (ret)
+		goto out_free_digest;
+
+	ret = crypto_shash_update(shash, " ", 1);
+	if (ret)
+		goto out_free_digest;
+
+	ret = crypto_shash_update(shash, subsysnqn, strlen(subsysnqn));
+	if (ret)
+		goto out_free_digest;
+
+	ret = crypto_shash_update(shash, " NVMe-over-Fabrics", 18);
+	if (ret)
+		goto out_free_digest;
+
+	ret = crypto_shash_final(shash, digest);
+	if (ret)
+		goto out_free_digest;
+
+	ret = base64_encode(digest, digest_len, enc);
+	if (ret < hmac_len) {
+		ret = -ENOKEY;
+		goto out_free_digest;
+	}
+	*ret_digest = enc;
+	ret = 0;
+
+out_free_digest:
+	kfree_sensitive(digest);
+out_free_tfm:
+	crypto_free_shash(tfm);
+out_free_enc:
+	if (ret)
+		kfree_sensitive(enc);
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


