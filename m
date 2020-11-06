Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABA9C388F2
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:03:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8509E20720
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="y0EqGJP2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="E/wOw3kN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8509E20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=irf6L22VojzJgl0+kI0A2omOuLuZlyJRW5lahAOc1kk=; b=y0EqGJP2hUn6gzGH4d8N5C1gO
	szBqi6vHuB5lRnF3GNP6MpKACoPXNWnegABCxhS/vAZyt/zJeMOTz1acvLM+50O54c/ygine5iXj1
	uYAkk1N7SDol0H7PAyboJbJLyllY1rPey40PgvCcMQK1Z1FFwd2FqrdNWORYqF0FIJLuShnABqxxt
	e37nMtvFKzirAPoG9bw8huFPoIwVgQwUTAkpSwzGqBu/X6g7mkIOygrkYQMvNiGldjUQ88OjJVcUh
	Wtlha/8OyKLNfIIxZCX2WDzyeCN1V/3QehrqWoLBeITCWVUuiCMK5Y92GQFGq7ExwItPjrMX0XfHN
	R4Np0tEiw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb58g-000271-Dc; Fri, 06 Nov 2020 17:03:02 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb56m-0000xy-W4
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 17:01:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7ZcZGtWvTkVsTVUpkhext4YPtK8jbBrBUEsKJaygiKM=; b=E/wOw3kNyO6V3futeClVovyVEi
 0ofnTLpBwpRI12gOy55UDZsn4lgqLbjIrlVDUk5jitjZfiHHi9Uon94ml5xkCw/H9JdFFq0TAR87L
 drBag+pE3zEJ5UoXM0JywhZX7DgNTUweeo3Jp+DZGgj1gj9d3/9MmGQAvfaWLOn0vLUeAtb5X5+Zs
 M+ojMJrWn8vEzJ1QUnE2xRy+wNXpVwIkOukWFon2TazamH6LxZD9rDChqhxdoWuUXPusbmpaDrpyS
 laIGUKQxC+ZCaPc5GDRuDocCPvYNgCrSDMGr9vpm8Sj4MyggVUbqRxnvG4nlrwwCSGtib6yuVDp5S
 DpoLEf9g==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kb56h-0002PX-HK; Fri, 06 Nov 2020 10:01:00 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kb56V-0004tE-5g; Fri, 06 Nov 2020 10:00:47 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Fri,  6 Nov 2020 10:00:30 -0700
Message-Id: <20201106170036.18713-10-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106170036.18713-1-logang@deltatee.com>
References: <20201106170036.18713-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, dan.j.williams@intel.com,
 iweiny@intel.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org,
 daniel.vetter@ffwll.ch, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [RFC PATCH 09/15] nvme-pci: Convert to using dma_map_sg for p2pdma
 pages
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_120105_500018_6E7B4F4A 
X-CRM114-Status: GOOD (  16.63  )
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
Cc: John Hubbard <jhubbard@nvidia.com>, Ira Weiny <iweiny@intel.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Don Dutile <ddutile@redhat.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Switch to using sg_dma_p2pdma_len() in places where sg_dma_len() is
used. Then replace the calls to pci_p2pdma_[un]map_sg() with calls
to dma_[un]map_sg() with DMA_ATTR_P2PDMA.

This should be equivalent, though support will be somewhat less
(only dma-direct and dma-iommu are currently supported).

Using DMA_ATTR_P2PDMA is safe because the block layer restricts
requests to be much less than 2GB, thus there's no way for a
segment to be greater than 2GB.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/pci.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ef7ce464a48d..26976bdf4af0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -528,12 +528,8 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 
 	WARN_ON_ONCE(!iod->nents);
 
-	if (is_pci_p2pdma_page(sg_page(iod->sg)))
-		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
-				    rq_dma_dir(req));
-	else
-		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
-
+	dma_unmap_sg_attrs(dev->dev, iod->sg, iod->nents, rq_dma_dir(req),
+			   DMA_ATTR_P2PDMA);
 
 	if (iod->npages == 0)
 		dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
@@ -570,7 +566,7 @@ static void nvme_print_sgl(struct scatterlist *sgl, int nents)
 		pr_warn("sg[%d] phys_addr:%pad offset:%d length:%d "
 			"dma_address:%pad dma_length:%d\n",
 			i, &phys, sg->offset, sg->length, &sg_dma_address(sg),
-			sg_dma_len(sg));
+			sg_dma_p2pdma_len(sg));
 	}
 }
 
@@ -581,7 +577,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 	struct dma_pool *pool;
 	int length = blk_rq_payload_bytes(req);
 	struct scatterlist *sg = iod->sg;
-	int dma_len = sg_dma_len(sg);
+	int dma_len = sg_dma_p2pdma_len(sg);
 	u64 dma_addr = sg_dma_address(sg);
 	int offset = dma_addr & (NVME_CTRL_PAGE_SIZE - 1);
 	__le64 *prp_list;
@@ -601,7 +597,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 	} else {
 		sg = sg_next(sg);
 		dma_addr = sg_dma_address(sg);
-		dma_len = sg_dma_len(sg);
+		dma_len = sg_dma_p2pdma_len(sg);
 	}
 
 	if (length <= NVME_CTRL_PAGE_SIZE) {
@@ -650,7 +646,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 			goto bad_sgl;
 		sg = sg_next(sg);
 		dma_addr = sg_dma_address(sg);
-		dma_len = sg_dma_len(sg);
+		dma_len = sg_dma_p2pdma_len(sg);
 	}
 
 done:
@@ -670,7 +666,7 @@ static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
 		struct scatterlist *sg)
 {
 	sge->addr = cpu_to_le64(sg_dma_address(sg));
-	sge->length = cpu_to_le32(sg_dma_len(sg));
+	sge->length = cpu_to_le32(sg_dma_p2pdma_len(sg));
 	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
 }
 
@@ -814,14 +810,12 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	if (!iod->nents)
 		goto out;
 
-	if (is_pci_p2pdma_page(sg_page(iod->sg)))
-		nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
-				iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
-	else
-		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
-					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
-	if (!nr_mapped)
+	nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
+			rq_dma_dir(req), DMA_ATTR_NO_WARN | DMA_ATTR_P2PDMA);
+	if (!nr_mapped) {
+		ret = BLK_STS_IOERR;
 		goto out;
+	}
 
 	iod->use_sgl = nvme_pci_use_sgls(dev, req);
 	if (iod->use_sgl)
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
