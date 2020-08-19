Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8BCC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 07:05:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3DB2054F
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 07:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GitcF/eF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mO0h3/QJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3DB2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AM8SNzkyXCnngGxpoGlmYUj899VRA9GcWjWxqQcgpTQ=; b=GitcF/eFY8tP6tn8uYuwZnh4H
	RmlFyyrtQvsqcOsLRlphVwpnn+f9UITF6js2n9sQfEqwcLQHTnaXjn834z0o3arqP6sXujgXH45rJ
	DFkF8VFMK8LnK6NmKfnfLTRR5CQlsvc4x5ZTVuxAHTIOpbubWz5K07xsNYeZJAZAhtjXeBX5JJvOW
	pls+35bEjnnw6VnmCX1D+pGSudfOVoet14C1wFpTvec8IYPCXFrauKKZKYSz/1bYodv7vzdFZ4Ch3
	LVFYp5Dkm26TdYmCJY+stUI/EwevSJKTjvqGIKHqzH+wqErYWIEuQFVgkkfQRkCWN/SPtYdr1r3Mw
	agKGnaIGQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8I9z-0000cO-61; Wed, 19 Aug 2020 07:05:23 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8I1h-0005Cx-GQ; Wed, 19 Aug 2020 06:56:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=RFTX12/6vaWoRhhjSqpC5wgk9pFG99OSZ6G21Gj4zUk=; b=mO0h3/QJQ4IMJcw7idTzxUEyfy
 FuPqv+qEDbTDPKK7FEenUd7ionlcjYL5GNBSYPlMCFwiQJm5+2rN19erxYXKVTBf390ZI8EWPbL0a
 ab7QtB66NQzyOAGNH+ofzZrE9kkefR1unxsPvJ5aJmbuHVe11Py2x1Qkb3NICIBaF7SLnVjd2jf1j
 WogQQTRrOF5qGuiMHBe3WOb95aMfkixb9aeUOuDYPDLOtubIROb53k2qV4Kd5JURqGiFRezaphnme
 D+80I4GP/SkvHK3cjj0XcV7p+d8ZZ2xWBwT2HC7Kew3oBm8FRsyQUXwUGkUv2IaqYMxBQPG/p6CP2
 xIzfAfMg==;
Received: from [2001:4bb8:198:f3b2:86b6:2277:f429:37a1] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8I1e-0008V1-Rd; Wed, 19 Aug 2020 06:56:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Pawel Osciak <pawel@osciak.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matt Porter <mporter@kernel.crashing.org>, iommu@lists.linux-foundation.org
Subject: [PATCH 22/28] sgiseeq: convert from dma_cache_sync to
 dma_sync_single_for_device
Date: Wed, 19 Aug 2020 08:55:49 +0200
Message-Id: <20200819065555.1802761-23-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819065555.1802761-1-hch@lst.de>
References: <20200819065555.1802761-1-hch@lst.de>
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>, alsa-devel@alsa-project.org,
 linux-samsung-soc@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use the proper modern API to transfer cache ownership for incoherent DMA.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/net/ethernet/seeq/sgiseeq.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/seeq/sgiseeq.c b/drivers/net/ethernet/seeq/sgiseeq.c
index 39599bbb5d45b6..f91dae16d69a19 100644
--- a/drivers/net/ethernet/seeq/sgiseeq.c
+++ b/drivers/net/ethernet/seeq/sgiseeq.c
@@ -112,14 +112,18 @@ struct sgiseeq_private {
 
 static inline void dma_sync_desc_cpu(struct net_device *dev, void *addr)
 {
-	dma_cache_sync(dev->dev.parent, addr, sizeof(struct sgiseeq_rx_desc),
-		       DMA_FROM_DEVICE);
+	struct sgiseeq_private *sp = netdev_priv(dev);
+
+	dma_sync_single_for_cpu(dev->dev.parent, VIRT_TO_DMA(sp, addr),
+			sizeof(struct sgiseeq_rx_desc), DMA_BIDIRECTIONAL);
 }
 
 static inline void dma_sync_desc_dev(struct net_device *dev, void *addr)
 {
-	dma_cache_sync(dev->dev.parent, addr, sizeof(struct sgiseeq_rx_desc),
-		       DMA_TO_DEVICE);
+	struct sgiseeq_private *sp = netdev_priv(dev);
+
+	dma_sync_single_for_device(dev->dev.parent, VIRT_TO_DMA(sp, addr),
+			sizeof(struct sgiseeq_rx_desc), DMA_BIDIRECTIONAL);
 }
 
 static inline void hpc3_eth_reset(struct hpc3_ethregs *hregs)
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
