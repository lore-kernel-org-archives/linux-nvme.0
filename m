Return-Path: <SRS0=DfP6=K5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DEFC4709D
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 17:14:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59AC3613F6
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 17:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59AC3613F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2VQFO0w5vEFl31hfyhvoteoNWU4r7Zp6D2wEfgavQyo=; b=czw0ZVsGRpRpQX
	BqtLP7q6H0gihxALMGbN19ksyGk16S77C7aghnkASDZ9TmZ8IJdSFM1jnEU1m04MQ3uNbtCZj+Bbw
	ZtA3R4dRGFpuzc1ai98GrVL6QEQQpT2iLI+c/XgoW18ThAdjTGK84QnzQhNfj4i4/lBTmWn/IIZo4
	En4CRIzYhkcssTWTPiMgOTqgXgjI6qQ8aaZHs0IEkI5A/4UVD+bzDVkxCKpzax8dIcgOEZw3I+aJa
	wMqCOIEIwwBQ5H+WRyiS54HOiPqJdSs1nP3gpPzM5f8DlNFB29F0iBGedyTRXRQOYpeBJRZOJy1jo
	/KORmJ/fTAj/w0OHYOAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loqvZ-009nEc-79; Thu, 03 Jun 2021 17:14:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loqqx-009kpF-Uh
 for linux-nvme@lists.infradead.org; Thu, 03 Jun 2021 17:09:57 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C079761422;
 Thu,  3 Jun 2021 17:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622740195;
 bh=ZcE9PpXHCn4O0oMyM7g8LoUcwic1ehwjmPutK4onjzI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eotBB3AWNP93pMClfid0fWj3unicIeqZSuw6w3LxlcvsbNOUeUzM9M6fgY7WR1Gnr
 bifcyLVR0W+kMBLFCFvKkHmV3FKRddIfsBAHpE1qmOfju3qydk3XDl87OehleL9uiS
 LRhItxmTS/9XS8HUCvwV/QXdfjtHg68cMdeyRkSAVV1QR140bcY6XJLmW+e6yAlO40
 tihSmPmV1Hh1H/t3/kQDNi5Wdd+33Jt2o8LXAaQ45/ue7efRqj1W6oR+kVdFa5dFqr
 inoGxIxQbs39QuZ8rZN3dfxcdmJvbsrabq882LFGcNLwCqEZL0FpHxWdYhPDPQtQEz
 fl1+08A5Zy8xQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 29/31] nvme-tcp: remove incorrect Kconfig dep in
 BLK_DEV_NVME
Date: Thu,  3 Jun 2021 13:09:17 -0400
Message-Id: <20210603170919.3169112-29-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603170919.3169112-1-sashal@kernel.org>
References: <20210603170919.3169112-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210603_100956_070161_D80C6846 
X-CRM114-Status: UNSURE (   9.73  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 042a3eaad6daeabcfaf163aa44da8ea3cf8b5496 ]

We need to select NVME_CORE.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 7b3f6555e67b..cf0ae71c489e 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -62,7 +62,8 @@ config NVME_FC
 config NVME_TCP
 	tristate "NVM Express over Fabrics TCP host driver"
 	depends on INET
-	depends on BLK_DEV_NVME
+	depends on BLOCK
+	select NVME_CORE
 	select NVME_FABRICS
 	select CRYPTO
 	select CRYPTO_CRC32C
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
