Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1621BC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 09:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WeFMv24k4lhBdnDvAc7pKc1iADaxm74/8MBrjnx6hiA=; b=BIOwjHbGlVPNQvxMt2y9vugPDv
	z6PKQsQUkyKvU7cg5TQDOvpiKqY8hHKVZCdgxS9QOx1AX9ofeL9YaMFUy+Vx1qv7aOst5UnQ+/AmX
	fAa9DJzqzUDi2Pt4YbC9bSSCh+/NSn4cHIcvtyEiU0jEIsHbL5Z0AruPnEgTlBZjOREqYFFGdZz+L
	v+Wu53vJ+o8vtqrC1pMBU9N/P7A6YqsF2tv4pzySFX0oG27zooS54e09Wv/B7i5J1cceMoVAPDdy6
	qzErM0larKMvwBqRkWJ3VQx47xQpbu2qHF3TqLTH9f6OzJgPjfWVBba7HG1Eu7Kc/oNGW4hasGQud
	mXkTla5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5lRV-00HV7e-Is; Mon, 27 Jun 2022 09:54:05 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5lPr-00HUFo-MA
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 09:52:32 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 305411FAD6;
	Mon, 27 Jun 2022 09:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1656323538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WeFMv24k4lhBdnDvAc7pKc1iADaxm74/8MBrjnx6hiA=;
	b=pnyhmYTUl3/Iyg7M4zhq7OFhxKw+6zTMFxryMt1/klrj9eu4S2fhwpq+ZYEjvbxo7Wjidz
	yOmMJcQep8qu++yXPoh74qmUZT9o+qrjleivnpkbz1vqn1HripVH0yAFEO1SGqQDwu1abq
	lvodUoyY5Gvq7wls1KmAgAr+rBbljac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1656323538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WeFMv24k4lhBdnDvAc7pKc1iADaxm74/8MBrjnx6hiA=;
	b=zcRqD0+/gmdVBrHLeoNJmQgNDOQx/mQPG/9HmAB5kEhzs5X6/loe150mefF5MRfP09TzfP
	Tmt+/tKav9UBRADA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 2839E2C153;
	Mon, 27 Jun 2022 09:52:17 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id BDA15519830D; Mon, 27 Jun 2022 11:52:17 +0200 (CEST)
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
Date: Mon, 27 Jun 2022 11:51:57 +0200
Message-Id: <20220627095207.105201-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220627095207.105201-1-hare@suse.de>
References: <20220627095207.105201-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_025223_925937_A2FA3704 
X-CRM114-Status: GOOD (  10.05  )
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


