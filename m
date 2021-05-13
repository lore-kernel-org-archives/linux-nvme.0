Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72867C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:41:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7EFC610EA
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7EFC610EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eIDJ2zViv0C1pOkZCAcSWLRssbQxxMrYyaFrt1JpYlc=; b=BiX7pd+IEe99SY
	ypx0WQPCrLWt8zbx/2MOGO6v5AnOCuMpk4tjbkpcwLht6tFotb2ce4KiByxOfEd5MJKum6hCmH0SZ
	SarmhTlfEOxMXaqQ3JiZXpauD4aGM9UCkdlV07JRy46W/aW+mnoSB8mfAbxlR+8UkUozVyjQo080Q
	OAYUeN5VGEXHj0LlegyaZATXbc3JXBV56UtPvWhZaw1gMVkmiorYfC7pDhdVz6Sg3+ZFGiKCKI4Ak
	OtOsPLj0UYtXRw2pe7W7w9SuN1T7aTwyYU/1dIvBl3F2U78yZn0DE26babgB+IIpcp5Xl1qClAPgL
	PpNhI32xvxTu2UlI9gMA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhK0w-006Zi1-5n; Thu, 13 May 2021 22:41:07 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsZ-006Yde-2v
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 22:32:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=8cZgBhr0Anv3Gd0FTXDyBK4ezUzJ6Tr6W4sIgchu1Qw=; b=RfW+0t8eP7TRrp3iuoXTzO/GLt
 oKNJsujwdXRMbv/jymG/DQ+pXphgp1/lUhh2K/I49Tk8a1kwraiv5jDCrVn5mxHcRToUxlL8UFHVQ
 AXo+Z3kOdUoCGwpa6SVP26P0yXGoIoMCm+N+cw3N0FcoFoWz1lFfnW7jlJehPb2k1BiiifEZiLclW
 aQLTUdOggRWo7VmrN5kQMI5NdeuP648Wov28vpE/5DbSK0GRrRIsUb+p7wl4WkqiOSNVYj8Nok544
 BoHdrbxWD2toizrp10SillApnx+RX31gdBibqEmtrMpK32hD3CekUbvcr+FIz3KeJ2M5kfsiCCtSK
 owHJGnZA==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsW-00BZEA-FO
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 22:32:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=8cZgBhr0Anv3Gd0FTXDyBK4ezUzJ6Tr6W4sIgchu1Qw=; b=AUNDX9/y6tYezRRfrqP5yxg7z1
 BC2HKE/th8j2APTmC0Jca7xFx7wMPgR3kzTM+HmPCRyRt8+u8FAqs5ghp+ivuYi9pRvXwyy1HxVqB
 oHQyCVYR0/+PledAYETok41jxSB+kMmiP+LInOi3xvFuKM3uuqYV1/ivDKJIJcAvfo1WrPyJITnAS
 yPt8WJApIz1349JThkaHjy2sgnp7t8Mm656nCS4OHvDIpJ18n4AJ5kyfkAukJr8ZjwU9HtBHYqRkb
 9MfP9N8QexopsKQGu/HoUeAh3ExiwG/8UzTufgkNDYfrLbNzS+xK++tRpU5KW6EdPIET8BjypLTHw
 yUzlCZRA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsV-0000nC-1E; Thu, 13 May 2021 16:32:23 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsH-0001Sz-Ap; Thu, 13 May 2021 16:32:09 -0600
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
Date: Thu, 13 May 2021 16:31:52 -0600
Message-Id: <20210513223203.5542-12-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210513223203.5542-1-logang@deltatee.com>
References: <20210513223203.5542-1-logang@deltatee.com>
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
Subject: [PATCH v2 11/22] dma-iommu: Return error code from iommu_dma_map_sg()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_153224_555167_1FC856D7 
X-CRM114-Status: GOOD (  13.38  )
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

Pass through appropriate error codes from iommu_dma_map_sg() now that
the error code will be passed through dma_map_sgtable().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/iommu/dma-iommu.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7bcdd1205535..0d69f509a95d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -970,7 +970,7 @@ static int iommu_dma_map_sg_swiotlb(struct device *dev, struct scatterlist *sg,
 
 out_unmap:
 	iommu_dma_unmap_sg_swiotlb(dev, sg, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
-	return 0;
+	return -EINVAL;
 }
 
 /*
@@ -991,11 +991,14 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	dma_addr_t iova;
 	size_t iova_len = 0;
 	unsigned long mask = dma_get_seg_boundary(dev);
+	ssize_t ret;
 	int i;
 
-	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
-	    iommu_deferred_attach(dev, domain))
-		return 0;
+	if (static_branch_unlikely(&iommu_deferred_attach_enabled)) {
+		ret = iommu_deferred_attach(dev, domain);
+		if (ret)
+			return ret;
+	}
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
@@ -1043,14 +1046,17 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	}
 
 	iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
-	if (!iova)
+	if (!iova) {
+		ret = -ENOMEM;
 		goto out_restore_sg;
+	}
 
 	/*
 	 * We'll leave any physical concatenation to the IOMMU driver's
 	 * implementation - it knows better than we do.
 	 */
-	if (iommu_map_sg_atomic(domain, iova, sg, nents, prot) < iova_len)
+	ret = iommu_map_sg_atomic(domain, iova, sg, nents, prot);
+	if (ret < iova_len)
 		goto out_free_iova;
 
 	return __finalise_sg(dev, sg, nents, iova);
@@ -1059,7 +1065,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	iommu_dma_free_iova(cookie, iova, iova_len, NULL);
 out_restore_sg:
 	__invalidate_sg(sg, nents);
-	return 0;
+	return ret;
 }
 
 static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
