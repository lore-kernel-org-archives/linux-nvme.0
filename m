Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F2BC48BC3
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Feb 2024 01:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FMs8otkL/0Jd1KeHkEmksoEQgRdaqCRV71xQ7tvAXUg=; b=x2P5VMhWvbk6SEgrxhD/JY3RCR
	PFf97p3lbdCJEAckzKtVfruY39CflWMndjHnt+lWeP+xYb/5MORdmiA61LNS9sbGT2u/HdrpeWbqU
	uMUQQo4ag4EvMIN7s8do+2wqFDvoj5RLxBg03WfOpu9BiNpRXqILIY04l+YAhZeRyXDWzuSEVe97o
	Nhm0YtvNzzsuegyWHZ51uP1owGoLcNlj31vLZ9+EgPtcxYM5bPcEHaLSQ/cgTzFgDtlD5C4HAW/f6
	OMHKA7jybXXZOqmsI4EKClqnA8QTpuxXQQJFPHkBIFwhv71L9FNDKVOZRVDJpV/O4tEtG9Oxdduhv
	+F/dErWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raQgD-0000000Elrx-0cPa;
	Thu, 15 Feb 2024 01:36:49 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raQgB-0000000ElrH-0Q5J
	for linux-nvme@lists.infradead.org;
	Thu, 15 Feb 2024 01:36:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BF9236125A;
	Thu, 15 Feb 2024 01:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874ECC433C7;
	Thu, 15 Feb 2024 01:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707961002;
	bh=pPliZncdA3i95L/mjXLvn7u/pxryzDw1zgs434SpmLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aIYWwiOSIjt8sT6wPq0tPs6lzJB8PGB3UrjsTwGEdZ462ubWUs53385RoWRztfpKY
	 XG0JoA3wLh4Wc2H4zDw+7lcU17Icm139JzEIuZeTUeHsi9EQ7By5RIaGxqsnfuOztl
	 sdFmFEDfoyWQDH3HoINL7MREAW/vdjH9EpNuoWPf2ik97lqwP5/+tScSXTY71AG9RL
	 XJNeTL/JM5u3doGRsGqGJeh25Ng2ltElGKFffdfrPxqdN0+R9yGkwPZ7INbI/CnrO4
	 2iltwab2NtxLSevGVysR/HLmtk8yWHBW2JrAKu7v0m3cQFn74pLaQmyF8UONu7dPj5
	 LiseI3mLMtenw==
Date: Wed, 14 Feb 2024 18:36:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, will@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, jgg@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, murphyt7@tcd.ie, baolu.lu@linux.intel.com
Subject: Re: [PATCH v1 2/2] nvme-pci: Fix iommu map (via swiotlb) failures
 when PAGE_SIZE=64KB
Message-ID: <Zc1qpr4zCy1N0OND@kbusch-mbp>
References: <cover.1707851466.git.nicolinc@nvidia.com>
 <60bdcc29a2bcf12c6ab95cf0ea480d67c41c51e7.1707851466.git.nicolinc@nvidia.com>
 <Zcv7uI6VrMc2EuGT@kbusch-mbp>
 <ZcxZD2GXmR5+vC/k@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcxZD2GXmR5+vC/k@Asurada-Nvidia>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_173647_205805_BB208A63 
X-CRM114-Status: GOOD (  16.37  )
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

On Tue, Feb 13, 2024 at 10:09:19PM -0800, Nicolin Chen wrote:
> On Tue, Feb 13, 2024 at 04:31:04PM -0700, Keith Busch wrote:
> > On Tue, Feb 13, 2024 at 01:53:57PM -0800, Nicolin Chen wrote:
> > > @@ -2967,7 +2967,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
> > >               dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
> > >       else
> > >               dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> > > -     dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
> > > +     dma_set_min_align_mask(&pdev->dev, PAGE_SIZE - 1);
> > >       dma_set_max_seg_size(&pdev->dev, 0xffffffff);
> > 
> > I recall we had to do this for POWER because they have 64k pages, but
> > page aligned addresses IOMMU map to 4k, so we needed to allow the lower
> > dma alignment to efficiently use it.
> 
> Thanks for the input!
> 
> In that case, we might have to rely on iovad->granule from the
> attached iommu_domain:

I explored a bit more, and there is some PPC weirdness that lead to
NVME_CTRL_PAGE_SIZE, I don't find the dma min align mask used in that
path. It looks like swiotlb is the only user for this, so your original
patch may be just fine.

