Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE68C54E71
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 15:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jtpAXqj2dBwwYOS2CCu3s+ZPF/4Vd+je6vmnBMund6Q=; b=VO957OoqRU5uIGcyW07b3Eq3d8
	bz5fGc+5GDeDXWYCXQk6S3i7vXBNHHZEsbn5mxsrVxE+wp1orEfhSRn9EZZrVxFiDxKYkMzjKk9ba
	UcU0Q4f/AEV5XPHLQJJrThJb9+4ybyh+I7gQhlqu8iIeI5TyasJ0GX8HBa1KAdy3c0EjxHPOyIOXK
	Qrj/mYlvUagH9G+0dm92T8hgzhFXlQ6eal2zcW/xTHmaSGDeezR6CmFfH0aG7NiTyBAiDe4YVE1kd
	+dOOyy7ZmospG4p8+/qTdeceRCrzQlmbQQKjgnab/lPmXlLV75mzaao5aYM0VYiCG+UVQd4Mv0b3h
	Z5umRIYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWg-00000008uKX-1XLw;
	Mon, 18 Mar 2024 15:03:46 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWZ-00000008uF5-0jm0
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 15:03:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8A21ACE0A64;
	Mon, 18 Mar 2024 15:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84700C433F1;
	Mon, 18 Mar 2024 15:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710774216;
	bh=MfgBNREgFiH89Gsu+iw1LDCv2/TPkSU+wxt0GLvMGME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t+SKCU2eoXJyAV+7aHQPvoD0lSS1pddpO5Tu5F5QV1Qw6UNknlylSAhm1YXZHEaWd
	 gd31ke+TuoX5H6a+om0n7VlcGg93N1s7rNobNoxT7jcAvb0yAnbBGTgFleMpyAOBQj
	 ONJoaX9fDCULfAXwPi0r8MG3Gph1xLZ/V1MuMypiFPVZ37aoaVMF0A++VwCouAq4Ht
	 a8TojfGq51qaaGPt6aA/1PnoB0ObAEo4W6FHsOzZ6Kq5oZsWft6fJ5cUfvai1wj96b
	 xHpCBppmlm08/3o+mBaDfZSgxwXxUVF+1FxlIoZMzn239x9TWr+357QN4i8W+O/N8/
	 SLFOtU/huqPUQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 04/17] nvme: add nvme_auth_generate_psk()
Date: Mon, 18 Mar 2024 16:03:03 +0100
Message-Id: <20240318150316.138501-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240318150316.138501-1-hare@kernel.org>
References: <20240318150316.138501-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_080339_650490_EC5AAFAF 
X-CRM114-Status: GOOD (  12.79  )
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

Add a function to generate a NVMe PSK from the shared credentials
negotiated by DH-HMAC-CHAP.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/common/auth.c | 76 ++++++++++++++++++++++++++++++++++++++
 include/linux/nvme-auth.h  |  2 +
 2 files changed, 78 insertions(+)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index a3455f1d67fa..7a4b6589351d 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -11,6 +11,7 @@
 #include <asm/unaligned.h>
 #include <crypto/hash.h>
 #include <crypto/dh.h>
+#include <crypto/hkdf.h>
 #include <linux/nvme.h>
 #include <linux/nvme-auth.h>
 
@@ -471,5 +472,80 @@ int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
 
+u8 *nvme_auth_generate_psk(u8 hmac_id, u8 *skey, size_t skey_len,
+			   u8 *c1, u8 *c2, size_t hash_len, size_t *ret_len)
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *shash;
+	u8 *psk;
+	const char *hmac_name;
+	int ret, psk_len;
+
+	if (!c1 || !c2) {
+		pr_warn("%s: invalid parameter\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	hmac_name = nvme_auth_hmac_name(hmac_id);
+	if (!hmac_name) {
+		pr_warn("%s: invalid hash algoritm %d\n",
+			__func__, hmac_id);
+		return ERR_PTR(-EINVAL);
+	}
+
+	tfm = crypto_alloc_shash(hmac_name, 0, 0);
+	if (IS_ERR(tfm))
+		return (u8 *)tfm;
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
+	if (!ret)
+		*ret_len = psk_len;
+
+out_free_shash:
+	kfree_sensitive(shash);
+out_free_psk:
+	if (ret) {
+		kfree_sensitive(psk);
+		psk = NULL;
+	}
+out_free_tfm:
+	crypto_free_shash(tfm);
+
+	return ret ? ERR_PTR(ret) : psk;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_generate_psk);
+
 MODULE_DESCRIPTION("NVMe Authentication framework");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index c1d0bc5d9624..31dc1db2d4d6 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -40,5 +40,7 @@ int nvme_auth_gen_pubkey(struct crypto_kpp *dh_tfm,
 int nvme_auth_gen_shared_secret(struct crypto_kpp *dh_tfm,
 				u8 *ctrl_key, size_t ctrl_key_len,
 				u8 *sess_key, size_t sess_key_len);
+u8 *nvme_auth_generate_psk(u8 hmac_id, u8 *skey, size_t skey_len,
+			   u8 *c1, u8 *c2, size_t hash_len, size_t *ret_len);
 
 #endif /* _NVME_AUTH_H */
-- 
2.35.3


