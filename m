Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9D5C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 17:07:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76FB361008
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 17:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76FB361008
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DOeCq7ZwxoP0Y/kc4S2F1V5uDU1AlrMMmjSs7CT3YGs=; b=OE0dvVqw8PSdDe
	WAtQLcP1W8JtfekHauAbI0d0xkwFQ8fvP09ThWJgQ/r8+6AHKX4yz0W72K11PWw7qmE9tZuHGjc36
	XwJ5GlD0NwTo65waiAM/bEh0dRAVSt34yeQFbt4pz4YrbslUzIvZn56zJ1rj9dMZjJpVb4K7XR3Vs
	WT3kqXWaa0qhG634A5RotjyWalf515dmTxQQnbyelShyq/PRnUzYlppADHDozvGLrM1Gf6ztsj91C
	cImDesk8rHbvnJ44g7DUsqimnmWsECo728XN4QArbZcyvAyHAsbudczt2uZf0V9cMqKvFGSYkvIZa
	+ZNllRabCFmHCcCH+WLg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUY7h-008jma-2J; Thu, 08 Apr 2021 17:07:17 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUY2G-008igH-3G
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 17:01:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=g9xBAi+F7zuYbb3gnefNIBW0Hb9qWvlDa8LJ/Rn/AY0=; b=PgV1DoTm1cSW2QgJfJD9aPPUI1
 szfOFtzh3wS66ohgqOFz7vKJmj1nOfuDthGtEul6Xv8OJvPll6Bkz5tBeFE+poapiK1WoB44d7jE1
 dKzrRL3LHjb6lYPSwRH2oy+VX/u04UlPGaNCRC/MqHdMa6svoXVruX1NRR5Oi2ENrAd0me90MvlnK
 hqwYIxlp5urvKOXRMAlaJ3CKT2tSC9/8wOHXgZEd754nEbPf5HDolFiAhvT2WWRosaTO14DbrccFM
 AXUjpn1f1Pvrr3eZX2+A6lzBb3MIBLiKJIcf5El5ijFBrVBvoosa+n4xIZRSA9hNxWR+iOP9yYoUP
 6r6v9qQw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lUY2A-0002Li-Bo; Thu, 08 Apr 2021 11:01:38 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lUY26-0002JL-Op; Thu, 08 Apr 2021 11:01:30 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Logan Gunthorpe <logang@deltatee.com>
Date: Thu,  8 Apr 2021 11:01:20 -0600
Message-Id: <20210408170123.8788-14-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408170123.8788-1-logang@deltatee.com>
References: <20210408170123.8788-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org,
 dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com,
 jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 13/16] nvme-pci: Convert to using dma_map_sg_p2pdma for p2pdma
 pages
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_180140_267734_C87741F2 
X-CRM114-Status: GOOD (  13.14  )
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

Convert to using dma_map_sg_p2pdma() for PCI p2pdma pages.

This should be equivalent but allows for heterogeneous scatterlists
with both P2PDMA and regular pages. However, P2PDMA support will be
slightly more restricted (only dma-direct and dma-iommu are currently
supported).

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/pci.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 14f092973792..a1ed07ff38b7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -577,17 +577,6 @@ static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
 
 }
 
-static void nvme_unmap_sg(struct nvme_dev *dev, struct request *req)
-{
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-
-	if (is_pci_p2pdma_page(sg_page(iod->sg)))
-		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
-				    rq_dma_dir(req));
-	else
-		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
-}
-
 static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -600,7 +589,7 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 
 	WARN_ON_ONCE(!iod->nents);
 
-	nvme_unmap_sg(dev, req);
+	dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
 	if (iod->npages == 0)
 		dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
 			      iod->first_dma);
@@ -868,14 +857,13 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	if (!iod->nents)
 		goto out_free_sg;
 
-	if (is_pci_p2pdma_page(sg_page(iod->sg)))
-		nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
-				iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
-	else
-		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
-					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
-	if (!nr_mapped)
+	nr_mapped = dma_map_sg_p2pdma_attrs(dev->dev, iod->sg, iod->nents,
+				     rq_dma_dir(req), DMA_ATTR_NO_WARN);
+	if (nr_mapped < 0) {
+		if (nr_mapped != -ENOMEM)
+			ret = BLK_STS_TARGET;
 		goto out_free_sg;
+	}
 
 	iod->use_sgl = nvme_pci_use_sgls(dev, req);
 	if (iod->use_sgl)
@@ -887,7 +875,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	return BLK_STS_OK;
 
 out_unmap_sg:
-	nvme_unmap_sg(dev, req);
+	dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
 out_free_sg:
 	mempool_free(iod->sg, dev->iod_mempool);
 	return ret;
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
