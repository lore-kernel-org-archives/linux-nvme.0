Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BA2C3ABC5
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 09:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ha0cIFV4DOTkT9rXzX6s5nJfxmpaIKycH5iYIejY5yg=; b=bAI7u8ySLAgJg6CR5yNXBTKp+Q
	jwgj1GyNw7laEYGlGWWBvBklxZSH1VukrJ9NWdokxXIuRmEKGQ+nAabm4G4M7VjMZNwLFSzamWiZa
	AHbrawF9ybWuyhoo+E0K5bl2OUucjTs8xDmxYnlH+C+OISkpF/p7RCNG4x/5jH34kCp5FQLTHKHqj
	aADq4jFUQR8JJBgvNWkHY1lbshSCIecwWXb2Dp0LzEpIZnohZvM5CqoxDxks2hafvwwG3sJsLbaqp
	tHntmezSXg7PTgLXR23zx+lU2DoUKgionR27kdUAR5K2ZN5CHbBe8USvEDi3bCmWQwjxY7eWDQCWe
	0mOoanTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCaxR-0000000EvHM-0WS7;
	Wed, 07 May 2025 09:20:53 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCa99-0000000EjzA-0c4c
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 08:28:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5A2C55C5CF3;
	Wed,  7 May 2025 08:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB24C4CEEB;
	Wed,  7 May 2025 08:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746606534;
	bh=XCkRHquF+4xi7r89VTmkcrIvSO0S7Rw56H/NbemDvcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A5LNrUKm5+3VS/jmH0+ZXoj70f3kWYodvdPNaeA1p9itWclp2W8HLHhWt7NIY2QhZ
	 ZH9J0NWysvsW+WYLg7PJBj3FtAzHKU2TEBJxslpZHWojdGf4N0zAMTrO7ebz5Vhfqw
	 3xEHBFX8XwCXwc6nNH23au3ibUbfD4sA5zZ4U4HhibzgYMHMzvE+6iVapQXPg+TRq6
	 z7txvvO+5W7uLtp6nPAhboDtbtp7I9M5EIIQrUZ4jL7qNcPhGh1BNouOV66FjcY9Bk
	 LRpKA+kFhLXo8whS8BX5FY0QWSfTCgAUeekbZC00UdUStlk43xU6A/EpTzf2C+TQ/x
	 OKTjGp4+rAYiQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/2] nvme-auth: use SHASH_DESC_ON_STACK
Date: Wed,  7 May 2025 10:28:17 +0200
Message-Id: <20250507082818.46157-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250507082818.46157-1-hare@kernel.org>
References: <20250507082818.46157-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_012855_237446_C082354F 
X-CRM114-Status: GOOD (  11.29  )
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
 drivers/nvme/common/auth.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 2c092ec8c0a9..3b6d759bcdf2 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -242,7 +242,7 @@ struct nvme_dhchap_key *nvme_auth_transform_key(
 {
 	const char *hmac_name;
 	struct crypto_shash *key_tfm;
-	struct shash_desc *shash;
+	SHASH_DESC_ON_STACK(shash, key_tfm);
 	struct nvme_dhchap_key *transformed_key;
 	int ret, key_len;
 
@@ -267,19 +267,11 @@ struct nvme_dhchap_key *nvme_auth_transform_key(
 	if (IS_ERR(key_tfm))
 		return ERR_CAST(key_tfm);
 
-	shash = kmalloc(sizeof(struct shash_desc) +
-			crypto_shash_descsize(key_tfm),
-			GFP_KERNEL);
-	if (!shash) {
-		ret = -ENOMEM;
-		goto out_free_key;
-	}
-
 	key_len = crypto_shash_digestsize(key_tfm);
 	transformed_key = nvme_auth_alloc_key(key_len, key->hash);
 	if (!transformed_key) {
 		ret = -ENOMEM;
-		goto out_free_shash;
+		goto out_free_key;
 	}
 
 	shash->tfm = key_tfm;
@@ -299,15 +291,12 @@ struct nvme_dhchap_key *nvme_auth_transform_key(
 	if (ret < 0)
 		goto out_free_transformed_key;
 
-	kfree(shash);
 	crypto_free_shash(key_tfm);
 
 	return transformed_key;
 
 out_free_transformed_key:
 	nvme_auth_free_key(transformed_key);
-out_free_shash:
-	kfree(shash);
 out_free_key:
 	crypto_free_shash(key_tfm);
 
-- 
2.35.3


