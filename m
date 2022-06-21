Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAF6C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 17:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5RJ63CLs3oV0ICZ8ISS4uCZZA5d4FnkG5Lgm4OqAftc=; b=NvWTWg0ifPvCSOHEySOT4b/tJE
	/5Cm9Netj6A9ik+wh2neeCq/MEsI0wkQgnvTlqicIi6TLa4nkwj8UXixr4LO08Csa+xTzLCg16QMH
	qPJSqrY/TGrFd4t1TnKwCmELKX/YtOl3aJG6l5ePKaO29e0fpSwOGLkcat1U6jydYwi7ykpl7O1gM
	arvblsldt2vaxdlHXmkxLru4GmAGwEWhOxo57spAXzWF6qqABfryOgihG/tQGr7tZ0CatxCoTB4Tz
	FuDRODawczgAmOeQIpwhHWtDzxgaBAsipbWDy21fahLkfgJpUx0U8+JYWFeYKncYREn7WEVL5RbyR
	qkOCm3tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3hcD-006XEL-3Z; Tue, 21 Jun 2022 17:24:37 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3hcA-006XBw-Jc
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 17:24:36 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 31CC621C08;
	Tue, 21 Jun 2022 17:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655832271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5RJ63CLs3oV0ICZ8ISS4uCZZA5d4FnkG5Lgm4OqAftc=;
	b=0P0ft8Cdg3+hCF/yWs/p2fO/sCqojnh/ecvMSPTh+lNsw7Nu1JRM+YVxWXEg0ek3rXqx6n
	IuHDS5DCaHXWMHgNmcrVEnMksfgOXzsztwqmmQU6TFnArGYvdkAe/XEOiAnliTwB9y+OX7
	z5Z5A+ctPi1nSxd3wAZN6OeM07YWZF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655832271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5RJ63CLs3oV0ICZ8ISS4uCZZA5d4FnkG5Lgm4OqAftc=;
	b=O3/yaadaK5liOQ7T4sTsj4hoWthhgK7ne75wvi6y8g6BcJp3lN3RR6d7hnGm32qBo3Qwco
	vkk78N2yDJbZqABQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 637852C142;
	Tue, 21 Jun 2022 17:24:30 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 54F5C5194C7A; Tue, 21 Jun 2022 19:24:30 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 02/11] crypto: add crypto_has_kpp()
Date: Tue, 21 Jun 2022 19:24:05 +0200
Message-Id: <20220621172414.82847-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220621172414.82847-1-hare@suse.de>
References: <20220621172414.82847-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_102434_832311_403C2342 
X-CRM114-Status: UNSURE (   9.96  )
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

Add helper function to determine if a given key-agreement protocol
primitive is supported.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/kpp.c         | 6 ++++++
 include/crypto/kpp.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/crypto/kpp.c b/crypto/kpp.c
index 7aa6ba4b60a4..678e871ce418 100644
--- a/crypto/kpp.c
+++ b/crypto/kpp.c
@@ -104,6 +104,12 @@ int crypto_grab_kpp(struct crypto_kpp_spawn *spawn,
 }
 EXPORT_SYMBOL_GPL(crypto_grab_kpp);
 
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


