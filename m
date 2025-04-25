Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7339FC369D1
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 11:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p2zo2UfRzUZaHqQ1QefSwwTrNtbpRRErBDV0I1xM50s=; b=r9VIGKC1+ApCR4NvtYN384tprE
	s7F/ndLF6wgTlQh/OhDQIFvqB96uY5REe6oz3RMf4dPuwWQmdo3CYHjBHzlNzyvknjF/rkqag6i7V
	AF3m4ZwN6Sn2IwGJMjyj4uRa1lyVLAK8DI485Vf11uPktnrMMwlr4Y9JmOnnhUEooR3gYK5zfjF8y
	TdNCbc59NTGVSNxFY6fafr8leSbQXRWEyNOfZOw1NwgFz5amPGaeS6Agghun9NDR3ppfnu6b/wieL
	yoDHJTtoEFDvUxHFbAhv9Qvrr5n1vAShd7NF4sDbX6xHSX6dvsWKtyTpgDrXfyyasqBbCkhrLBFR/
	rIctUWZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8H0S-0000000GtU4-3Q5g;
	Fri, 25 Apr 2025 11:14:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Fgo-0000000Gbrc-3k0B
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 09:49:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4B6325C64AE;
	Fri, 25 Apr 2025 09:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B4BC4CEEA;
	Fri, 25 Apr 2025 09:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745574586;
	bh=8TIDxXtmA4qujOvX3IUr3Ml+rVGSUwp/Saf9SNAh+ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJmMMpyzwlAYD4rsdkJvFBeIcloYrLxr6y4vOaF9vD343xmkbvAVO8YAmqQNQ3ozi
	 O9R34XR3/PwClHqmZwBuZB+YJnJ6PuIBTCDSLg4aY6ngY3FhfbElHtKpSfUEEV/FxC
	 As05wisPvogOGuiE20bwPlxdXG2EZPEdR34vVX0a1TUQ9B2KXtUu6jO/kDsyFmtQkZ
	 h/G0gHAAS6qxBoTfM21EzJTUoC+apkGC7N54ZQqQg1UzRdUoSjbRmjDLP6lsO61iW3
	 lz9fYVTl1Yebb9pTXD6UbQgl3jMagUPzAEWJTiEcvIUhsCQyVEzqb/ufIu4/CL9wen
	 mKmOWtBAPZPVQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 02/12] nvme-auth: use SHASH_DESC_ON_STACK
Date: Fri, 25 Apr 2025 11:49:17 +0200
Message-Id: <20250425094927.102656-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250425094927.102656-1-hare@kernel.org>
References: <20250425094927.102656-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_024946_972975_EA779261 
X-CRM114-Status: UNSURE (   9.77  )
X-CRM114-Notice: Please train this message.
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

Use SHASH_DESC_ON_STACK to avoid explicit allocation.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/auth.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index d6dfc4ff39a2..918c92cbd8c5 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -242,7 +242,7 @@ int nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn,
 {
 	const char *hmac_name;
 	struct crypto_shash *key_tfm;
-	struct shash_desc *shash;
+	SHASH_DESC_ON_STACK(shash, key_tfm);
 	u8 *transformed_data;
 	u8 *key_data;
 	size_t transformed_len;
@@ -287,39 +287,28 @@ int nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn,
 		goto out_free_tfm;
 	}
 
-	shash = kmalloc(sizeof(struct shash_desc) +
-			crypto_shash_descsize(key_tfm),
-			GFP_KERNEL);
-	if (!shash) {
-		ret = -ENOMEM;
-		goto out_free_transformed_data;
-	}
-
 	shash->tfm = key_tfm;
 	ret = crypto_shash_setkey(key_tfm, key->key, key->len);
 	if (ret < 0)
-		goto out_free_shash;
+		goto out_free_transformed_data;
 	ret = crypto_shash_init(shash);
 	if (ret < 0)
-		goto out_free_shash;
+		goto out_free_transformed_data;
 	ret = crypto_shash_update(shash, nqn, strlen(nqn));
 	if (ret < 0)
-		goto out_free_shash;
+		goto out_free_transformed_data;
 	ret = crypto_shash_update(shash, "NVMe-over-Fabrics", 17);
 	if (ret < 0)
-		goto out_free_shash;
+		goto out_free_transformed_data;
 	ret = crypto_shash_final(shash, transformed_data);
 	if (ret < 0)
-		goto out_free_shash;
+		goto out_free_transformed_data;
 
-	kfree(shash);
 	crypto_free_shash(key_tfm);
 	*transformed_secret = transformed_data;
 
 	return transformed_len;
 
-out_free_shash:
-	kfree(shash);
 out_free_transformed_data:
 	kfree(transformed_data);
 out_free_tfm:
-- 
2.35.3


