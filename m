Return-Path: <SRS0=M30F=P7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C694C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 13:01:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C756108E
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 13:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C4C756108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1VamOQcU1OrVu4tiACiA0zdumWt9PK7vtnP5toK1J7M=; b=PfL4XtrI5DUs5kCiC9t7iBSRz6
	+qdtS2V0kes4z3fDuWJv+F9z+VyKOlkOalKoCOq+Fwjnlu7IoFYy0ayGvovxKZKhOzWzjhu380Eqi
	h1aqhrx7201bJJ+Krf7aeseLsUXNB8eLn2hiTgZqcGl9Uc5iqI6jNeIVBmLzYGsE/cPXh9Zb4RVJm
	/0t5o0/advo0L/ZSj9vpMQhFjIazhgKXK0Y+X0tlniECqO1nAa49ROPmSp2hHiLZRooJa/7p+Legb
	A8dav5ZlhPB77T8QCL5ojsFZAEN0Q/nmfLTHJIWPxuOFFl2B0yWQRd4n9FmtvuvO5NpHSbyBpqxGB
	j2hOJCaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlWB0-00ARbZ-Nk; Fri, 12 Nov 2021 13:01:06 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlW9d-00ARDf-HN
 for linux-nvme@lists.infradead.org; Fri, 12 Nov 2021 12:59:47 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 9E40A1FD5E;
 Fri, 12 Nov 2021 12:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636721977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1VamOQcU1OrVu4tiACiA0zdumWt9PK7vtnP5toK1J7M=;
 b=T1TLc/sr0/Ula2/wjGQFFmkbQ56bDK7pymlf23pI682zOSZFsl99GlzMYPWsYCU4yF5ZYc
 w1Yqmgu0ZUqxviSZmm+RW2UIbsanrSjZP3Gcl3ezKKEf7dx+ijeeIClc6U27gI/z1NY+Tx
 HXs6So/tV0iSBnHU2EmVtdPPlybuYWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636721977;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1VamOQcU1OrVu4tiACiA0zdumWt9PK7vtnP5toK1J7M=;
 b=ehOweIeBKkXATQBXFuGuEdCeyPM6OGRv3PnuUT0+ldrkuEQrIhN+30GSb6p3sQdnEp4z7V
 P4GKj1pSqjw2fmCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 56218A3B84;
 Fri, 12 Nov 2021 12:59:36 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 201065191257; Fri, 12 Nov 2021 13:59:36 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 02/12] crypto: add crypto_has_kpp()
Date: Fri, 12 Nov 2021 13:59:18 +0100
Message-Id: <20211112125928.97318-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211112125928.97318-1-hare@suse.de>
References: <20211112125928.97318-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211112_045941_799084_5FEC92E3 
X-CRM114-Status: GOOD (  10.97  )
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

Add helper function to determine if a given key-agreement protocol
primitive is supported.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 crypto/kpp.c         | 6 ++++++
 include/crypto/kpp.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/crypto/kpp.c b/crypto/kpp.c
index 313b2c699963..416e8a1a03ee 100644
--- a/crypto/kpp.c
+++ b/crypto/kpp.c
@@ -87,6 +87,12 @@ struct crypto_kpp *crypto_alloc_kpp(const char *alg_name, u32 type, u32 mask)
 }
 EXPORT_SYMBOL_GPL(crypto_alloc_kpp);
 
+int crypto_has_kpp(const char *alg_name, u32 type, u32 mask)
+{
+	return crypto_type_has_alg(alg_name, &crypto_kpp_type, type, mask);
+}
+EXPORT_SYMBOL_GPL(crypto_has_kpp);
+
 static void kpp_prepare_alg(struct kpp_alg *alg)
 {
 	struct crypto_alg *base = &alg->base;
diff --git a/include/crypto/kpp.h b/include/crypto/kpp.h
index cccceadc164b..24d01e9877c1 100644
--- a/include/crypto/kpp.h
+++ b/include/crypto/kpp.h
@@ -104,6 +104,8 @@ struct kpp_alg {
  */
 struct crypto_kpp *crypto_alloc_kpp(const char *alg_name, u32 type, u32 mask);
 
+int crypto_has_kpp(const char *alg_name, u32 type, u32 mask);
+
 static inline struct crypto_tfm *crypto_kpp_tfm(struct crypto_kpp *tfm)
 {
 	return &tfm->base;
-- 
2.29.2


