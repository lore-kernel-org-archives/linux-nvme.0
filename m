Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB8BD4922A
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 14:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E6C369fXebc/lJiBXk0WQK+y7FNVjbbitA7vYiVXXh4=; b=JKOhMjXzEG5/T7oI0yVWFVesSv
	fLIYpsYBOImyYlWbz1p2uYUtI5WAg0H/OiDiYOoygQGqAFvTpYPJPHweEXGxYTalz88mLjqP+/z2s
	UQmoRYBAxFFL1p72l8FJlMfU/bFtYn5UB37VuItKCk+eBejNAEAEfoU+2yzZeJy87ZEq4+A5LcCut
	TjKBfiW9QyjYqRkFzkQiJmqlClSYbZik9/Bhr2ghw+gxkyek3Xm5nDo09nrzFsdKQVY3XkGTZl+Mu
	pFhs2qaHvwdgmOleft25CDhsDC1rsAbhSASnGhEWWljraCExPs1X5qrmPrmAM6Sol/FA0yB4SmRPZ
	LsLkdEFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tD31R-00000009o3E-3QCf;
	Mon, 18 Nov 2024 14:46:37 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tD31O-00000009o1Q-2lNZ
	for linux-nvme@lists.infradead.org;
	Mon, 18 Nov 2024 14:46:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 02DA25C4819;
	Mon, 18 Nov 2024 14:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2885AC4CECC;
	Mon, 18 Nov 2024 14:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731941193;
	bh=nNisB9deNFEifWbAA1Dvw/hHdpmPPX8zsLH5xbacxY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gcqYJFjERDxmTKO3Jzdv0vArTE/dXSGOuwdgyjk2yJn/d2ltrlEq3xcV6A9UTOQQs
	 4fk2tk5dJmkt6KttbPce7YR877xgwmsSgBNTIhehvPSLAWTNhJeG+CoHLygfSzT2FF
	 vwP2mTJFky9C4OAfWLy5n+S05ganaVPqDQ6hjxvnLdaX1EWpuwxWgQbbn4NLMVL+Ai
	 OegOfG2sPWxlDxbnltGRDouKx9glSiedeWMI/9xjbdN+wzO2Ul86ef9SOlufRt1uKG
	 qlmTelutMmqg5UjnfQf6N3ovc/FxuMiHsWW+rvK0cqbLErHhUmeNyIRWNX24IY7jCi
	 u6pMfsD6X9UYg==
Date: Mon, 18 Nov 2024 14:46:25 +0000
From: Will Deacon <will@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 03/17] iommu: generalize the batched sync after map
 interface
Message-ID: <20241118144624.GA27795@willie-the-truck>
References: <cover.1731244445.git.leon@kernel.org>
 <589adb3a4b53121942e9a39051ae49a27f7a074c.1731244445.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <589adb3a4b53121942e9a39051ae49a27f7a074c.1731244445.git.leon@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_064634_733331_761C8794 
X-CRM114-Status: GOOD (  17.80  )
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

On Sun, Nov 10, 2024 at 03:46:50PM +0200, Leon Romanovsky wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> For the upcoming IOVA-based DMA API we want to use the interface batch the
> sync after mapping multiple entries from dma-iommu without having a
> scatterlist.
> 
> For that move more sanity checks from the callers into __iommu_map and
> make that function available outside of iommu.c as iommu_map_nosync.
> 
> Add a wrapper for the map_sync as iommu_sync_map so that callers don't
> need to poke into the methods directly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 65 +++++++++++++++++++------------------------
>  include/linux/iommu.h |  4 +++
>  2 files changed, 33 insertions(+), 36 deletions(-)

I was a little worried that exposing iommu_map_nosync() directly could
expose driver bugs where the range being sync'd was assumed to be mapped,
but I couldn't spot anything obvious from a quick check, so:

Acked-by: Will Deacon <will@kernel.org>

Will

