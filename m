Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B68C54E58
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OLSx6bFdHn3AoT7c2e5Q4Vym18KoBpAJSfT1L676jU4=; b=ItptrLp262Zde/vyf98b3oyIl7
	qyoaIAqRybvIby0gxP3YGyMAOMuTfSTFW1ZznFHLBc6g03J3p1O4iZFVGVxxUckni6QqvZfAe3aMZ
	TtE8GX6cPPh+q+QGo04mkaovovQ8VVBsxAJdBUEehcIEq1N/vmljfYzceESc9Ml3f7TM8BW3dJ4jK
	iL6w5LtKYuI22QzEGn5GuOeXhsTvKHZ19ndVDtjjoOs8raBSoCcViR8SnLbVYiBnNHOS+ScVmI/MM
	0ITekhUrFDtcmEr4LSsOgYtCu3eX+omKvDNqC3Re/PGCqgDnlJtAb4sMU2gBA2DTg7KYHYd++l3xL
	cY35h9dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWi-00000008uLt-2wkh;
	Mon, 18 Mar 2024 15:03:48 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWa-00000008uGO-3fjk
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 15:03:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4D915CE09EF;
	Mon, 18 Mar 2024 15:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CB0C433C7;
	Mon, 18 Mar 2024 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710774218;
	bh=Q9DVc7X1+yJJrECF/Ik3pS9B541pTS3m8whNabR0qQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fYrlN7HlCnTi3NAWRlPEftDKBSgiqT3OiYJNA2ZyxIUmIbyocGIfSJny5dCLqcp8L
	 D/H4tkFp2dL7SMdADjo7cZtHmwd2q/+Qwo44samv5l6ytuSFjj/q+HiD5Wax7JceVZ
	 C7lzoPfNVfi5UNe3nsDT+R3rohIY/oNoOUA/v97AxZFfjTe6KOVrsR8FETYBZYAs2n
	 AYUljc6QXsH189eYXSvxlIFxni4rtqbl5ZEzhiV9UkmG9Ddh8fF7KEG7XEJJeFXa4k
	 prYurdPIeJf21DJgL6152/v/GU7w6UE4q/z9JCohAMlXYNQyz/gPXOFrpBn4RGihCx
	 QTHPpPv66c1nQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 05/17] nvme: add nvme_auth_generate_digest()
Date: Mon, 18 Mar 2024 16:03:04 +0100
Message-Id: <20240318150316.138501-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240318150316.138501-1-hare@kernel.org>
References: <20240318150316.138501-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_080341_619249_F30917C1 
X-CRM114-Status: GOOD (  12.82  )
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

Add a function to calculate the PSK digest as specified in TP8018.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/common/auth.c | 105 +++++++++++++++++++++++++++++++++++++
 include/linux/nvme-auth.h  |   2 +
 2 files changed, 107 insertions(+)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 7a4b6589351d..f56f08a4461e 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -547,5 +547,110 @@ u8 *nvme_auth_generate_psk(u8 hmac_id, u8 *skey, size_t skey_len,
 }
 EXPORT_SYMBOL_GPL(nvme_auth_generate_psk);
 
+u8 *nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
+			      char *subsysnqn, char *hostnqn)
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *shash;
+	u8 *digest, *hmac;
+	const char *hmac_name;
+	size_t digest_len, hmac_len;
+	int ret;
+
+	if (WARN_ON(!subsysnqn || !hostnqn))
+		return ERR_PTR(-EINVAL);
+
+	hmac_name = nvme_auth_hmac_name(hmac_id);
+	if (!hmac_name) {
+		pr_warn("%s: invalid hash algoritm %d\n",
+			__func__, hmac_id);
+		return ERR_PTR(-EINVAL);
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
+		return ERR_PTR(-EINVAL);
+	}
+
+	hmac = kzalloc(hmac_len + 1, GFP_KERNEL);
+	if (!hmac)
+		return ERR_PTR(-ENOMEM);
+
+	tfm = crypto_alloc_shash(hmac_name, 0, 0);
+	if (IS_ERR(tfm))
+		goto out_free_hmac;
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
+	ret = 0;
+
+out_free_shash:
+	kfree_sensitive(shash);
+out_free_digest:
+	kfree_sensitive(digest);
+out_free_tfm:
+	crypto_free_shash(tfm);
+out_free_hmac:
+	if (ret) {
+		kfree_sensitive(hmac);
+		hmac = NULL;
+	}
+	return ret ? ERR_PTR(ret) : hmac;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_generate_digest);
+
 MODULE_DESCRIPTION("NVMe Authentication framework");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index 31dc1db2d4d6..2cbb9249a8b3 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -42,5 +42,7 @@ int nvme_auth_gen_shared_secret(struct crypto_kpp *dh_tfm,
 				u8 *sess_key, size_t sess_key_len);
 u8 *nvme_auth_generate_psk(u8 hmac_id, u8 *skey, size_t skey_len,
 			   u8 *c1, u8 *c2, size_t hash_len, size_t *ret_len);
+u8 *nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
+			      char *subsysnqn, char *hostnqn);
 
 #endif /* _NVME_AUTH_H */
-- 
2.35.3


