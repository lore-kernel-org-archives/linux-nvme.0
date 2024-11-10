Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2C4D12D43
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Nov 2024 15:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jxs4kysxWU+cS7ZGrKin2S+Ic5F229JOfoeAFTxtSEk=; b=nAgxRsA8LtugC4s8rVzQLoIfQV
	1zeaHdyAFWd/1vbbwbwwX5N0+Q5+2IntnT6L67fBMgkNp2bOTov264wo0hvbcG7iCQxFMB/WgXfdL
	QRRftE8EkoJwXueVnuSuS6ZTrDy+TaowUgHbYEEbdppE9RqEC7ZD7vsps5XCndDWBH9miS8IiS7Rw
	rDQq7Q5eV5Id8W3iApTC2OhDkdzQuXLrTDYiJbcTVY0b4Qci4ngufmjnYiMyjL1RgJ2VklLWN2QjB
	aWadGiomT419HdZJWSanXFcWlRU79m2lw2qtdzYXyG42fmMNhScqCXilPTV77z4HN8K7GqyCjR5fo
	muaPTbzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tA9T0-0000000F5BE-3lhv;
	Sun, 10 Nov 2024 15:03:06 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tA9Sx-0000000F5A0-2Xbt
	for linux-nvme@lists.infradead.org;
	Sun, 10 Nov 2024 15:03:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A4D085C575A;
	Sun, 10 Nov 2024 15:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3832C4CECD;
	Sun, 10 Nov 2024 15:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731250981;
	bh=H99CbGRSaGSXRVVV52m+AMob/IL4Q3/JGWfnpSNKENA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TVwmLxWUT7636wtSIn/3F7AHWh+dZu3txdkZkItxm0unJgeW4KtiXZiL58gs803AM
	 cTpgx0WCmXHbvyxIBCXr9DzDU8JA5n8/NOqsyMf5XRKN9MrEZC2eZCOvpczcv9ACHK
	 v7ZXQN5CjinJIlrQeu407CMxIv4Jwpdh7jkYYY9OFwo/6QpZFHmzzoIZf8RnJccdNf
	 NsWv7ffb0rNdugoOgO3buFkBdpsGyVD3In32RFY7yDdnQdNmmNQN/FpOXboCyQtddN
	 XvDtXEENeXdPZpCAoONbZK5EEPQYRj2pbnVHWqVbQ1EghtJIyvMAcCNVr1Iw+r0JLN
	 5lMdfUvidgOnQ==
Date: Sun, 10 Nov 2024 17:02:55 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v3 00/17] Provide a new two step DMA mapping API
Message-ID: <20241110150255.GC50588@unreal>
References: <cover.1731244445.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731244445.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_070303_708378_58E4202E 
X-CRM114-Status: GOOD (  12.80  )
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

On Sun, Nov 10, 2024 at 03:46:47PM +0200, Leon Romanovsky wrote:
> Changelog:
> v3:

<...>

> Christoph Hellwig (6):
>   PCI/P2PDMA: Refactor the p2pdma mapping helpers
>   dma-mapping: move the PCI P2PDMA mapping helpers to pci-p2pdma.h
>   iommu: generalize the batched sync after map interface
>   iommu/dma: Factor out a iommu_dma_map_swiotlb helper
>   dma-mapping: add a dma_need_unmap helper
>   docs: core-api: document the IOVA-based API
> 
> Leon Romanovsky (11):
>   dma-mapping: Add check if IOVA can be used
>   dma: Provide an interface to allow allocate IOVA
>   dma-mapping: Implement link/unlink ranges API
>   mm/hmm: let users to tag specific PFN with DMA mapped bit
>   mm/hmm: provide generic DMA managing logic

This patch detached from thread and can be found here.
https://lore.kernel.org/all/a42f5a1ede10d4181c5cab3c88ed43a04be79565.1731245995.git.leon@kernel.org

Thanks

>   RDMA/umem: Store ODP access mask information in PFN
>   RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page
>     linkage
>   RDMA/umem: Separate implicit ODP initialization from explicit ODP
>   vfio/mlx5: Explicitly use number of pages instead of allocated length
>   vfio/mlx5: Rewrite create mkey flow to allow better code reuse
>   vfio/mlx5: Enable the DMA link API

