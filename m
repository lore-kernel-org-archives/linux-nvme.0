Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13FBC43334
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jun 2022 14:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WeFMv24k4lhBdnDvAc7pKc1iADaxm74/8MBrjnx6hiA=; b=Gwu0IA5czlOu7gMYNnA6s1GuYl
	GCWw1GRfu/3XBoJI5O1CL0pydaYvawIAOt/4QGFmoxAdlQMVSYqLssi/BsSrZyJZsKzJUnlTrLBj3
	CYK/Qk5D2XC5fIT7Ma6VHVXxvljFmGrYQ+OziOE67xnOj5qUElfcnucLYeNEK7PaJtmzEaunMHEWF
	/Ru9uUCFTjKy7jkqRqi8W2ysyBWSx4A/wqnq9ePYLFNj1sWyvzCSlUnilUJ4tSDFjPASMzLKnRcv7
	gLWDWVyScXUZXieDsVkcB6YoYySsaVZSW6FueLpfiMgI0Yk199wFOwVMgSPMbl1CtwT1xl6jn3jhV
	BPltTb5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nywwN-00Djg1-Dv; Wed, 08 Jun 2022 14:45:47 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyww3-00DjXf-MI
	for linux-nvme@lists.infradead.org; Wed, 08 Jun 2022 14:45:29 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 9542721AD7;
	Wed,  8 Jun 2022 14:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654699524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WeFMv24k4lhBdnDvAc7pKc1iADaxm74/8MBrjnx6hiA=;
	b=CtDqHYZuJ9X4hoqPl19W70bYnxcfB1Hs3zNSfbwXJUsLAb2xgCpKNIroPlVEQjgCdP9qNU
	U6ALlwzXQ/bCLltcGceH61XDDkWd776qEk6dbkpe5dyZysBc/oP8rUvxqqKk5CvMEvAcRW
	sCoWkh+mlkVUlLGnZCCmNsEgv+Y+x8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654699524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WeFMv24k4lhBdnDvAc7pKc1iADaxm74/8MBrjnx6hiA=;
	b=NQ1mFiv59luKxtHRCIeg/sQvbpQirRUJub0KGGF0yVv2jYQvZHtWexalJ24bgLP6PU/Ml0
	4avUu12xFyetWuBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 3F8A72C141;
	Wed,  8 Jun 2022 14:45:22 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id D2FDD51949A4; Wed,  8 Jun 2022 16:45:22 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 01/11] crypto: add crypto_has_shash()
Date: Wed,  8 Jun 2022 16:45:08 +0200
Message-Id: <20220608144518.67607-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220608144518.67607-1-hare@suse.de>
References: <20220608144518.67607-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220608_074527_990841_18D80AB2 
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

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
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


