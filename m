Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCC0C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 06:05:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394726101A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 06:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 394726101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U8WkzUmbmgy7OfkhX05mVIuylggqw7DLNEh+TVuXpms=; b=qg9YKjo9Qgn6vd
	12FQ2gidZP2ya+l52SYGoi3vRbQ/VycFA6QJqDMiEsd/EajoCfC0woulAhNwHoIZ/NIrOmF2pnCXk
	z1+vUdiMU4FKYPA56K/el06fT8PJcrc9teFAuZ6JgDOUeAAHcvJ1UOhRr3YLlka793Y0ywwoX7m4U
	QtvtF4j6Sh3fJHsdsj+ParY1dxLJx7UivzNQl7Jl1ZpA+Y2rXNo3ygzCoBHMVssuLNXlSTLzYAvkh
	OpKgRwLIl75lq0wEEK2T95EpZXSeMJgdNRLjY8915m5gVM5Xu8evuKdEZ+/OhrQT12RP1IAS4Zb1A
	FaAuqtbXgpYyLyu/L24A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mV6En-005kZh-2Z; Tue, 28 Sep 2021 06:05:09 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mV6Dr-005kGd-HX
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 06:04:14 +0000
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
 by smtp-out1.suse.de (Postfix) with ESMTP id C32F322240;
 Tue, 28 Sep 2021 06:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632809047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQAKV/G2LGNuS/sfJa5NmKXWu/SnHCyYvEbPF+KVioA=;
 b=fSmvwDix5Ucf/4pDDfwfD4u5sPeXEYw2cInvHT7xFarKOrCGpMvgiuNqZPlato+rk3mN9k
 3Q75DEK592PQoW0VV9gYgAhQf3GtwRAQpJMglJ+/SLv3XybJdTm+nksnBKpFGvROvB8jPT
 QsUg+d/zhcktAEA/k5pCIb9u6hdWZCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632809047;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQAKV/G2LGNuS/sfJa5NmKXWu/SnHCyYvEbPF+KVioA=;
 b=xQh1fI5sI2OwkHZs12rA87/JdKZGdU2WkLhVntZr/EQIwl/tTALcfVErp2xQBIsE4MQ+mC
 5KVQWleY0qBumvBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay1.suse.de (Postfix) with ESMTP id 7A6E325E61;
 Tue, 28 Sep 2021 06:04:06 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 3F938518EE20; Tue, 28 Sep 2021 08:04:06 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 01/12] crypto: add crypto_has_shash()
Date: Tue, 28 Sep 2021 08:03:45 +0200
Message-Id: <20210928060356.27338-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210928060356.27338-1-hare@suse.de>
References: <20210928060356.27338-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_230411_759740_C17608A5 
X-CRM114-Status: GOOD (  11.80  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add helper function to determine if a given synchronous hash is supported.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
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


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
