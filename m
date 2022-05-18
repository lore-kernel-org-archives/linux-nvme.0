Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53514C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 11:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9B8sPMF28jSzwvV8lb9uEoWchTIWoNyC8tE+OdUet84=; b=RomFnlsW33RIVt/ZktteI16SHH
	upHBs02gBzMQnHjSyjmHzHkVYSAf6AsYN/vz2D/T0iZnxHH9ohSVQkTAIJMBsUrgLvxM6lZw5RKW/
	HfMC0zisO9izurTIZxObBkm8fkfs+BSvgm9gw9EfKYrVrC3zl93OfUxuUHvejSStuaR0k4F7J6GWQ
	6Ixgq5AqgNei2p6Fjbce3BwazovQ1rTXZ4E7MCDt5Lm1Ihu9ekJtLVV9DRHD5MTuGAdzPwK+6/fZE
	4TndFoEhzYE3hu2LH0kq07/6eXaKqY43ZaH0/Xivc1nhXCHXJoTwkFO1IPuUKwY9sYQyKfffgQ+ru
	VK//S9SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrHoh-001WVV-An; Wed, 18 May 2022 11:26:11 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrHle-001UyX-Jr
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 11:23:04 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E35F61F9AF;
 Wed, 18 May 2022 11:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652872973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9B8sPMF28jSzwvV8lb9uEoWchTIWoNyC8tE+OdUet84=;
 b=TogrF9ay7t/s54DVD50GArrahPOX88i3xpkGYr0ODCn+4g8ijAW64b5NA/9geS6GaCr6PZ
 12EyKcLfbWC1waExfTX9USdWppkBvtx3fIn0T0M1AQC4ZOMbGfznhmwrPeFgjo3WVD9Dki
 QHxBqJZYfClz7T44d+ma3P01v5jOVAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652872973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9B8sPMF28jSzwvV8lb9uEoWchTIWoNyC8tE+OdUet84=;
 b=yNjxED+yUUkCGSFt6jVETC0r/KWZ8OlisGPWsZYzNhbC4/10lGn2ETLVZYQegXZMD4muUG
 +1oxHu8JkuGnnMDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id D16642C153;
 Wed, 18 May 2022 11:22:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 71C045194507; Wed, 18 May 2022 13:22:52 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Herbert Xu <herbert@gondor.apana.org.au>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 01/11] crypto: add crypto_has_shash()
Date: Wed, 18 May 2022 13:22:24 +0200
Message-Id: <20220518112234.24264-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220518112234.24264-1-hare@suse.de>
References: <20220518112234.24264-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_042302_865763_300CDAE2 
X-CRM114-Status: GOOD (  10.13  )
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

Add helper function to determine if a given synchronous hash is supported.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 crypto/shash.c        | 6 ++++++
 include/crypto/hash.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/crypto/shash.c b/crypto/shash.c
index 0a0a50cb694f..4c88e63b3350 100644
--- a/crypto/shash.c
+++ b/crypto/shash.c
@@ -521,6 +521,12 @@ struct crypto_shash *crypto_alloc_shash(const char *alg_name, u32 type,
 }
 EXPORT_SYMBOL_GPL(crypto_alloc_shash);
 
+int crypto_has_shash(const char *alg_name, u32 type, u32 mask)
+{
+	return crypto_type_has_alg(alg_name, &crypto_shash_type, type, mask);
+}
+EXPORT_SYMBOL_GPL(crypto_has_shash);
+
 static int shash_prepare_alg(struct shash_alg *alg)
 {
 	struct crypto_alg *base = &alg->base;
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index f140e4643949..f5841992dc9b 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -718,6 +718,8 @@ static inline void ahash_request_set_crypt(struct ahash_request *req,
 struct crypto_shash *crypto_alloc_shash(const char *alg_name, u32 type,
 					u32 mask);
 
+int crypto_has_shash(const char *alg_name, u32 type, u32 mask);
+
 static inline struct crypto_tfm *crypto_shash_tfm(struct crypto_shash *tfm)
 {
 	return &tfm->base;
-- 
2.29.2


