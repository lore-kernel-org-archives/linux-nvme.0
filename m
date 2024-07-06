Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DDEC2BD09
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Jul 2024 06:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Br5SZctjoUMzAffZCZmcdpuen31MiKKvH6XM2nEAT5o=; b=oBzZkBDw5wKwSMFE8XAIEA0yzq
	sjSOwU4eGiI3gkARGLHTm9/k12VBmK2Tr3tzJ6KnpncS1HIRRZXZfFvG/HxNUjztHGNPoJwXbae0E
	noOMH1Hmi9fxAyTe2P+vQm8yvSTy6TKjwFwrG99BYdSD6x8+mt7k0U9IWogldxdDejwrxkuj1p/PO
	RuVcXxJpDPkuyumVZYj11fSo0fcZQdfPsbhyF0jjzIcsZkiLycpGygnZJlfFwi4DcBUvC+85D8JI2
	KLhHrELU0xiUxBTXp41F9LbINyfvWyuwDSS5HJUhNChHy8fxRvU9tnAFFtoGX6vfCndo4TQ83NjMn
	TstCy2Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPzBx-0000000HQyd-0ueh;
	Sat, 06 Jul 2024 06:46:41 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPzBt-0000000HQxw-0iMN
	for linux-nvme@lists.infradead.org;
	Sat, 06 Jul 2024 06:46:39 +0000
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WGLQX276HzxSF4;
	Sat,  6 Jul 2024 14:41:56 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id E111F180AA6;
	Sat,  6 Jul 2024 14:46:26 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 6 Jul 2024 14:46:26 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <hare@suse.de>, <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
	<axboe@kernel.dk>, <cuigaosheng1@huawei.com>
CC: <linux-nvme@lists.infradead.org>
Subject: [PATCH -next] nvmet-auth: Fix the error handling path in nvmet_auth_host_hash and nvmet_auth_ctrl_hash
Date: Sat, 6 Jul 2024 14:46:25 +0800
Message-ID: <20240706064625.447744-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200011.china.huawei.com (7.221.188.251)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240705_234637_411819_456A2BC2 
X-CRM114-Status: UNSURE (   9.12  )
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

If we fail to call nvme_auth_augmented_challenge, or fail to kmalloc
for shash, we should free the memory allocation for challenge, so add
err path out_free_challenge to fix the memory leak.

Fixes: 7a277c37d352 ("nvmet-auth: Diffie-Hellman key exchange support")
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 drivers/nvme/target/auth.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 7d2633940f9b..8bc3f431c77f 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -314,7 +314,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 						    req->sq->dhchap_c1,
 						    challenge, shash_len);
 		if (ret)
-			goto out_free_response;
+			goto out_free_challenge;
 	}
 
 	pr_debug("ctrl %d qid %d host response seq %u transaction %d\n",
@@ -325,7 +325,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 			GFP_KERNEL);
 	if (!shash) {
 		ret = -ENOMEM;
-		goto out_free_response;
+		goto out_free_challenge;
 	}
 	shash->tfm = shash_tfm;
 	ret = crypto_shash_init(shash);
@@ -361,9 +361,10 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 		goto out;
 	ret = crypto_shash_final(shash, response);
 out:
+	kfree(shash);
+out_free_challenge:
 	if (challenge != req->sq->dhchap_c1)
 		kfree(challenge);
-	kfree(shash);
 out_free_response:
 	nvme_auth_free_key(transformed_key);
 out_free_tfm:
@@ -427,14 +428,14 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 						    req->sq->dhchap_c2,
 						    challenge, shash_len);
 		if (ret)
-			goto out_free_response;
+			goto out_free_challenge;
 	}
 
 	shash = kzalloc(sizeof(*shash) + crypto_shash_descsize(shash_tfm),
 			GFP_KERNEL);
 	if (!shash) {
 		ret = -ENOMEM;
-		goto out_free_response;
+		goto out_free_challenge;
 	}
 	shash->tfm = shash_tfm;
 
@@ -471,9 +472,10 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 		goto out;
 	ret = crypto_shash_final(shash, response);
 out:
+	kfree(shash);
+out_free_challenge:
 	if (challenge != req->sq->dhchap_c2)
 		kfree(challenge);
-	kfree(shash);
 out_free_response:
 	nvme_auth_free_key(transformed_key);
 out_free_tfm:
-- 
2.25.1


