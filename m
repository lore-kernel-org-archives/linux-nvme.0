Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4B3C4828A
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jan 2024 09:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CfLeZjC6HIbq+3jqLQ/2ulVQmn85Kt9pk4e4lE3Rux0=; b=YZcBCrq5xlUdKV2tJ4MZK//ZBx
	TuGd9JHVwwFGXS31z8ncFY30+KcBpHPWf4vDIJO/1oW4rv+ElVfedcI25mXi1i8xazB2hTYlrJ0jE
	2EvAF6pw5SsOihJhJu1K9vONt96RxwEO0SFXaocgUom9V/slbOi6CBckOaz7V3jxinWKyZZ5qyUPC
	p9UDg4ffNhhpCdqODmvAqOTYWU0n8b7DNaY93/kqV5hDXLAmuP4Yqzhtf6+7tnZJ0dQmrDdj4+48O
	PcPwPk1vDSGpSRsnTszetMNBYeEW4RAeTL9GtrbFokgNEiHMhnC4GveI0IzjG3f7RsCGiEsrxYktd
	d2WdwO4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf1x-00000007FVr-0gAe;
	Sat, 27 Jan 2024 09:31:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf1q-00000007FRg-2obK
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jan 2024 09:31:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3455D60C0B;
	Sat, 27 Jan 2024 09:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8BEC433F1;
	Sat, 27 Jan 2024 09:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706347869;
	bh=RT/cZpjq4Z/ZdX8YbrO7RfKvbHu/M5rQEwofaIyCxZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ibh8Vec74WrmbLSj28WvqTV7P4UYOF2PaTDpTUEOVmJa98TrgvCO8CYpU/VSq8d36
	 OTRCJ3ymJ1ilA8ko95r779tNQiZdpwVx3ZmXnAO6ojbwuPeA8tuJFXDdjr7tC7CjZa
	 8LhlB2t1Nz3NnpwKoQMz5k/PTcJ9OuwqVUz6H7dfY7RX/l5KLQSZMPIN+pE/4D5rkk
	 m7KCQhnesGRWHUyb4X/dsWIvO0b9s6cJG2Wr+PNY6GEd2Si8k+p9pasxosrOHVLGPX
	 a8tbKc+9tI8K/r9DAVJln5YQNYEuH7lnl5bfuj8zFnJONaSDKQlKrclf442/ZnZuA4
	 LZj1b3p7R9yQg==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 04/13] nvme: add nvme_auth_derive_tls_psk()
Date: Sat, 27 Jan 2024 10:30:49 +0100
Message-Id: <20240127093058.15699-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240127093058.15699-1-hare@kernel.org>
References: <20240127093058.15699-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_013110_879993_21B08441 
X-CRM114-Status: GOOD (  11.81  )
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
index 87e095fe3852..20eb809929e2 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -652,4 +652,75 @@ u8 *nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
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


