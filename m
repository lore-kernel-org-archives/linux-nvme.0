Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369F4C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 17:52:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C302080C
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 17:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qKcFix9h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LNwBydPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C302080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rd2mObKQLAnA0A+vQNc5UIyZeHNpTMAW2yzRJzvaol4=; b=qKcFix9hZ7ucIteUIsirxZLdb7
	9zbQsW0TV6Jqz7cIA4RIiJ4JRKqW5dQidpUp+Ef/NHhsPib5BS7naTdXjrxlEidLakUYruuDuIe5O
	xrJA6//9Lp7zyad5eBBo7pWucZW3UD4lflmUV6DApYxqi/o/9V8u4/66xJ0Tn/ShBjec29AMf7Ynb
	78Wg7N+4Vg86op8oIk86wR8pLSFoS3PFESh1wr0oISYV8TcEfsGu7rYqvaLw3BDhvZU/fmrl8nUrh
	/FwoTRlHVqTarHmuqK0sdTEYfdiSuJPf+tyi8fgoKEybpXw2C5Nr9m0lO97r7D8EyM/X7MJy25t/j
	IgiyfZPg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k85mH-0005Qj-2m; Tue, 18 Aug 2020 17:52:05 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k85mF-0005QQ-Vn
 for linux-nvme@merlin.infradead.org; Tue, 18 Aug 2020 17:52:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=n4jQXphtlWRBonOsn2A/IyhKyng5urQ9vpv5ufSXxPk=; b=LNwBydPThNvXezWCgxEwFkaQ0p
 L7zCnskXol+vAzzBi1mb9aIsbEd7m6dwVKt2XwXSuJ0MFXkBBjC9VNtLj9ItWdcUVvhXQyKyfYIVB
 tWBUFLMz28xenvXy7kv7eR7JUTUF8rMgHwpLEJQet/LS0Fd83mfyTZLQWhtmhkFtBZAy7VrHd/ARR
 XVaSCY8oTWJVXQ2lcj4+DF/zHIHk18Xo9i57SvUALgI7ivn7CMWmm3UMkhF67TxPuoSd1aqZOa2IC
 0Aa7yN+QHWOPYejQeSoFMDhoLUb3xCCsY2wOj89SNG3CnLquTAcJv8Q+HCoBWPCB6sf6Te1CrWBeq
 wb0/lajg==;
Received: from [2001:4bb8:198:f3b2:a8c9:886a:f150:c8c6] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k85mE-00077I-4h; Tue, 18 Aug 2020 17:52:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Subject: [PATCH] nvme-pci: fix PRP pool size
Date: Tue, 18 Aug 2020 19:51:59 +0200
Message-Id: <20200818175159.1727735-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

All operations are based on the controller, not the host page size.
Switch the dma pool to use the controller page size as well to avoid
massive overallocations on large page size systems.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ba725ae47305ef..a33adab62acbaf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2460,7 +2460,8 @@ static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
 static int nvme_setup_prp_pools(struct nvme_dev *dev)
 {
 	dev->prp_page_pool = dma_pool_create("prp list page", dev->dev,
-						PAGE_SIZE, PAGE_SIZE, 0);
+						NVME_CTRL_PAGE_SIZE,
+						NVME_CTRL_PAGE_SIZE, 0);
 	if (!dev->prp_page_pool)
 		return -ENOMEM;
 
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
