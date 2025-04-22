Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C40C369D3
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hiz0XZWPT72LbrWLyfmBYt1lYoLQTeN12HPNWRdYzoc=; b=p8eRW2GBN2y3rJU3PrjolencQs
	cB55FWFmqv7XY2bAqTf3M7/4bN5aegtu+gqRw8HVZJwSR3aUqotZW+ysLrYcBxrhs3LR7hTqLJZFn
	vwbs5cnY2A60fo79hNYC+QqYe4+j3sb+G6HmSR3tFuj8yeg/t02TIsc8c+8sWR1ac6nDq/0VLrlrk
	2srMGhMuE2l3Rkbqv3TtUI8qbPko2bsQ1wkoxA1XTq5N6g8UOlzF/9+T6N9nPKHG/EFhsbK4Dp0BI
	vYDk7lNfIuQ5x4OV20UjnQLQSTaQDuyeV+9taW5D44ZZN2WGn1dLWJH62uG0dD/oxDXkjhQ7WcSkv
	LiaSzx2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7EjC-00000007WcN-3PBU;
	Tue, 22 Apr 2025 14:36:02 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u781E-000000066uK-2Atb
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 07:26:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A30A3A4B932;
	Tue, 22 Apr 2025 07:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2DEC4CEE9;
	Tue, 22 Apr 2025 07:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745306771;
	bh=xN+WXXtReip5UqyzmA8L0bQhenwCbDjSz9Q+yfqmAMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T+kjxQ3DEPfKwlnz4ZsUDQJrurgBpYIvnlrJCi1o7bGuhNceV40t7HE/1xO8wR9Yb
	 XqXYR6OJwsS92ouacGloivohWNsdc7yQTCXlieXHyMZSDeI4gKtISD5bdXJ7qypls6
	 6bZi9HB9VfNpBB8VY/FRmXpBsoECeH0PTBRIxfT9fPPKnqee23MIdkAqBcDi3rUZ+4
	 /BJqBQFefNqgzuto6SdwGElfoODTNQUBkGR4gebKND6VNauPo2sYytZqQICgsqeqij
	 kpC9oyp1tE0IjwFexsb18IzStSzuJpdjBQFiXvjt/3to/J7JYYIZd8gnhECeIAhlc7
	 0z3AdWi9XN8uA==
Date: Tue, 22 Apr 2025 10:26:06 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Jake Edge <jake@lwn.net>, Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v8 23/24] nvme-pci: convert to blk_rq_dma_map
Message-ID: <20250422072606.GC48485@unreal>
References: <cover.1744825142.git.leon@kernel.org>
 <f06a04098cb14e1051bddec8a7bdebe1c384d983.1744825142.git.leon@kernel.org>
 <20250422050050.GB28077@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422050050.GB28077@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_002612_692034_ECD6FD9B 
X-CRM114-Status: GOOD (  28.21  )
X-Mailman-Approved-At: Tue, 22 Apr 2025 07:26:59 -0700
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

On Tue, Apr 22, 2025 at 07:00:50AM +0200, Christoph Hellwig wrote:
> > +	dma_len = min_t(u32, length, NVME_CTRL_PAGE_SIZE - (dma_addr & (NVME_CTRL_PAGE_SIZE - 1)));
> 
> And overly long line slipped in here during one of the rebases.
> 
> > +		/*
> > +		 * We are in this mode as IOVA path wasn't taken and DMA length
> > +		 * is morethan two sectors. In such case, mapping was perfoormed
> > +		 * per-NVME_CTRL_PAGE_SIZE, so unmap accordingly.
> > +		 */
> 
> Where does this comment come from?  Lots of spelling errors, and I
> also don't understand what it is talking about as setors are entirely
> irrelevant here.

I'm trying to say when this do {} while is taken and sector is a wrong
word to describe NVME_CTRL_PAGE_SIZE. Let's remove this comment.

> 
> > +	if (!blk_rq_dma_unmap(req, dev->dev, &iod->dma_state, iod->total_len)) {
> > +		if (iod->cmd.common.flags & NVME_CMD_SGL_METABUF)
> > +			nvme_free_sgls(dev, req);
> 
> With the addition of metadata SGL support this also needs to check
> NVME_CMD_SGL_METASEG.
> 
> The commit message should also really mentioned that someone
> significantly altered the patch for merging with latest upstream,
> as I as the nominal author can't recognize some of that code.

Someone :), I thought that adding my SOB is enough.

> 
> > +	unsigned int entries = req->nr_integrity_segments;
> >  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> >  
> > +	if (!blk_rq_dma_unmap(req, dev->dev, &iod->dma_meta_state,
> > +			      iod->total_meta_len)) {
> > +		if (entries == 1) {
> > +			dma_unmap_page(dev->dev, iod->meta_dma,
> > +				       rq_integrity_vec(req).bv_len,
> > +				       rq_dma_dir(req));
> > +			return;
> >  		}
> >  	}
> >  
> > +	dma_pool_free(dev->prp_small_pool, iod->meta_list, iod->meta_dma);
> 
> This now doesn't unmap for entries > 1 in the non-IOVA case.

I forgot to unmap SGL metadata, in non-SGL, the metadata is the size of
one entry. There is no "entries > 1" for non-SGL path.

WDYT?

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a9c298a45bf1..73dbedd7daf6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -839,13 +839,21 @@ static __always_inline void nvme_unmap_metadata(struct nvme_dev *dev,
 {
        unsigned int entries = req->nr_integrity_segments;
        struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+       struct nvme_sgl_desc *sg_list = iod->meta_list;
+       enum dma_data_direction dir = rq_dma_dir(req);

        if (!blk_rq_dma_unmap(req, dev->dev, &iod->dma_meta_state,
                              iod->total_meta_len)) {
-               if (entries == 1) {
+               if (iod->cmd.common.flags & NVME_CMD_SGL_METASEG) {
+                       unsigned int i;
+
+                       for (i = 0; i < entries; i++)
+                               dma_unmap_page(dev->dev,
+                                      le64_to_cpu(sg_list[i].addr),
+                                      le32_to_cpu(sg_list[i].length), dir);
+               } else {
                        dma_unmap_page(dev->dev, iod->meta_dma,
-                                      rq_integrity_vec(req).bv_len,
-                                      rq_dma_dir(req));
+                                      rq_integrity_vec(req).bv_len, dir);
                        return;
                }
        }



> 

