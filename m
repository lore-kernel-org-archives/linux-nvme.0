Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D65C54E6A
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 15:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cggb2QvmPnU+Ie9gh/ubDAJqN32f5o9CtdQApaY4Yks=; b=IQQysWgx5bdFcz9FiKjLa6gksA
	J0zGeP1Sby4vvrQbImExH5aCL1iEpq/b0f2sa/R5lRmNwutnFTLS17M/g09rn75OJ3h0/vkI2My83
	sHIKNTroiKOzZxrTaI7OjglNwPEUs4UE6bCBwwtOXq7blgaQATXjKC162sevXr9m3g0uv+vf1dUFR
	M1efrh4zM6LRZBr1zlWyQOMcxfMPK17EXGXa0s4zLQWmJpyLh0yWZUZ4gwfmwhuaMQ/zdC0evwP0+
	sdvW6RN6URntAglSTI7YBVGTHP1s7XfzQ+R0CPTRyJGdTIF6W9s2NoYMdkaa9yjqc+Z8VHvPqC6a5
	OIctJJFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWl-00000008uOc-173d;
	Mon, 18 Mar 2024 15:03:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWc-00000008uGw-1P4k
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 15:03:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BD00960C11;
	Mon, 18 Mar 2024 15:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA14C43390;
	Mon, 18 Mar 2024 15:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710774220;
	bh=mseDE4C/nOn5wD15MGV3OSzGcN1glYtIADEPYHuFyKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T44RKF3ZYuZ2zKj/ZjJvdZyNSq4r2Sl7F4Vz1vbOyMx6xQEQWUNCWJW8cnIV1SVib
	 K1O6XPeCGhu3rFoNpbaCWU3bUEXezRY9GuGabowk4CIZIpoFfkL07O2/YLHQXsfyOJ
	 FmNX3qltjohj8cc0PiVqi0W2K81OnpIgh4fn7qmJPM7rvfgy+/uTJjoUmxcpx7J7cU
	 kLy9fRIVkliTG9MVD7KcFAeV7grx6CHsuxnEoWZluimqNFDm+WF+fNCUvlcZbYVOmq
	 g2VvNzeu19CxkODaSwzj2jesC7amG3V5yXbKgywAVd3+6+PzD8NGVX2fBRrc4bzPjg
	 TyLO9pSRlXsmg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 06/17] nvme: add nvme_auth_derive_tls_psk()
Date: Mon, 18 Mar 2024 16:03:05 +0100
Message-Id: <20240318150316.138501-7-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240318150316.138501-1-hare@kernel.org>
References: <20240318150316.138501-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_080342_561060_E3DA05B7 
X-CRM114-Status: GOOD (  12.10  )
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

From: Hannes Reinecke <hare@suse.de>

Add a function to derive the TLS PSK as specified TP8018.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/common/auth.c | 71 ++++++++++++++++++++++++++++++++++++++
 include/linux/nvme-auth.h  |  1 +
 2 files changed, 72 insertions(+)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index f56f08a4461e..90d525afc240 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -652,5 +652,76 @@ u8 *nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
 }
 EXPORT_SYMBOL_GPL(nvme_auth_generate_digest);
 
+u8 *nvme_auth_derive_tls_psk(int hmac_id, u8 *psk, size_t psk_len, u8 *psk_digest)
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
+		return ERR_PTR(-EINVAL);
+	}
+	if (hmac_id == NVME_AUTH_HASH_SHA512) {
+		pr_warn("%s: unsupported hash algorithm %s\n",
+			__func__, hmac_name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	hmac_tfm = crypto_alloc_shash(hmac_name, 0, 0);
+	if (IS_ERR(hmac_tfm))
+		return (u8 *)hmac_tfm;
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
+	if (ret)
+		goto out_free_key;
+
+out_free_key:
+	kfree(tls_key);
+out_free_info:
+	kfree(info);
+out_free_prk:
+	kfree(prk);
+out_free_shash:
+	crypto_free_shash(hmac_tfm);
+
+	return ret ? ERR_PTR(ret) : tls_key;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_derive_tls_psk);
+
 MODULE_DESCRIPTION("NVMe Authentication framework");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index 2cbb9249a8b3..335236fb2b73 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -44,5 +44,6 @@ u8 *nvme_auth_generate_psk(u8 hmac_id, u8 *skey, size_t skey_len,
 			   u8 *c1, u8 *c2, size_t hash_len, size_t *ret_len);
 u8 *nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
 			      char *subsysnqn, char *hostnqn);
+u8 *nvme_auth_derive_tls_psk(int hmac_id, u8 *psk, size_t psk_len, u8 *psk_digest);
 
 #endif /* _NVME_AUTH_H */
-- 
2.35.3


