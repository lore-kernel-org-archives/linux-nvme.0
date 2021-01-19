Return-Path: <SRS0=ulAu=GW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A56C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 21:24:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDBD222D08
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 21:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBD222D08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=67/bxjBbzbLkBFDsXPGEcmCouFo04xhmVMGhFhNBUmA=; b=TCXxu/7FE9VzhAALRQjATjU0u
	1QYsdvRwYDeqwi8ovJjunyo4+MhsE+r2Hq2qAxHhFqCsWZvcVbKjQ9OIpGzsYgmsKu9jJtKWGO8xm
	F9zSyvvWTVvZg/LIFITg+bNnXXnReC8gPvda8j0UzqFjCGxbwi09zJOAej7Wky1Nl8iGC6/ZMbX6c
	KgXxesMMBBTnjLtlMCjPko3+mbrIefZeEcULCIk//7FqIWnS3bKN0tmrkT3X9FpU5Y/ieGz/FLDkc
	RRhMxu/sB8JLqjJgMNZh5gGcxA0QtZ3U5A72Ho8mi/TuCgngb65MAMQM3gA0c/Bw0axPS4iubsoDy
	r/vShYRcw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1vIy-0002iu-Eh; Tue, 19 Jan 2021 18:00:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1vIv-0002hv-KT
 for linux-nvme@lists.infradead.org; Tue, 19 Jan 2021 18:00:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8D84068B02; Tue, 19 Jan 2021 19:00:24 +0100 (CET)
Date: Tue, 19 Jan 2021 19:00:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Marc Orr <marcorr@google.com>
Subject: Re: [PATCH] nvme: fix handling mapping failure
Message-ID: <20210119180024.GA28024@lst.de>
References: <20210119175336.4016923-1-marcorr@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210119175336.4016923-1-marcorr@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210119_130033_781827_F0AA7063 
X-CRM114-Status: GOOD (  20.09  )
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
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, stable@vger.kernel.org,
 kbusch@kernel.org, hch@lst.de, jxgao@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jan 19, 2021 at 09:53:36AM -0800, Marc Orr wrote:
> This patch ensures that when `nvme_map_data()` fails to map the
> addresses in a scatter/gather list:
> 
> * The addresses are not incorrectly unmapped. The underlying
> scatter/gather code unmaps the addresses after detecting a failure.
> Thus, unmapping them again in the driver is a bug.
> * The DMA pool allocations are not deallocated when they were never
> allocated.
> 
> The bug that motivated this patch was the following sequence, which
> occurred within the NVMe driver, with the kernel flag `swiotlb=force`.
> 
> * NVMe driver calls dma_direct_map_sg()
> * dma_direct_map_sg() fails part way through the scatter gather/list
> * dma_direct_map_sg() calls dma_direct_unmap_sg() to unmap any entries
>   succeeded.
> * NVMe driver calls dma_direct_unmap_sg(), redundantly, leading to a
>   double unmap, which is a bug.
> 
> Before this patch, I observed intermittent application- and VM-level
> failures when running a benchmark, fio, in an AMD SEV guest. This patch
> resolves the failures.

I think the right way to fix this is to just do a proper unwind insted
of calling a catchall function.  Can you try this patch?

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 25456d02eddb8c..47d7075053b6b2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -842,7 +842,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	sg_init_table(iod->sg, blk_rq_nr_phys_segments(req));
 	iod->nents = blk_rq_map_sg(req->q, req, iod->sg);
 	if (!iod->nents)
-		goto out;
+		goto out_free_sg;
 
 	if (is_pci_p2pdma_page(sg_page(iod->sg)))
 		nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
@@ -851,16 +851,25 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
 					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
 	if (!nr_mapped)
-		goto out;
+		goto out_free_sg;
 
 	iod->use_sgl = nvme_pci_use_sgls(dev, req);
 	if (iod->use_sgl)
 		ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw, nr_mapped);
 	else
 		ret = nvme_pci_setup_prps(dev, req, &cmnd->rw);
-out:
 	if (ret != BLK_STS_OK)
-		nvme_unmap_data(dev, req);
+		goto out_dma_unmap;
+	return BLK_STS_OK;
+
+out_dma_unmap:
+	if (is_pci_p2pdma_page(sg_page(iod->sg)))
+		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
+				    rq_dma_dir(req));
+	else
+		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
+out_free_sg:
+	mempool_free(iod->sg, dev->iod_mempool);
 	return ret;
 }
 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
