Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB4BC369DC
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 13:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Gr3w/d1UJKZquNXHZ8lAWaGO2oZ25Rf2nCXz2l8Hzo=; b=lI1IM6j95bU7GRKFuYE/Z+/qp1
	z2HRIMEgOsX0hiPEh6MQnJ/DZ2hEHi9gLOt73kUdOdzzvyHCeM3zSJL7uKeajShDttmHCqXqgX7qp
	KE2nYXLZVSyRfRmLOfzeQm0SIh04Jv8Wl+vvCxF5rd++7Th1sH0F2i1sKrc/RW77n1pPl2HrpUP21
	pni9FULptajz/xhtuuXegyJsfU1vYKdclePFcDd6fy8fimOgXvUnR1wE8zRqJhwRwSG/xh+mIz0lt
	u88Zl1XJ1Kt+0bwG6hK03aH7Q8mVxbYGuWXHXOtF9olR7A+HbRok2yjAKGHLdeNh+q5X57TMB3e1c
	0MSaoU1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9O9b-00000006JOT-01aV;
	Mon, 28 Apr 2025 13:04:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8U7m-00000001En7-3hu3
	for linux-nvme@lists.infradead.org;
	Sat, 26 Apr 2025 01:14:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EC4EF5C7080;
	Sat, 26 Apr 2025 01:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45A8C4CEE4;
	Sat, 26 Apr 2025 01:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745630073;
	bh=2LCUrZMeV2HZzBU2CuLrVTRtvZm5lDggJtqpE4KrVpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5DnBKuzNiqtvCl6bt5OSuQ4Tc06r1bDEkNLVpzhjD6vhR5V5lliPHNnef8KwuRTG
	 YUUrqLo48zbTsbToeDLKvt7DHSn7KOpZkaC7YPm/XMeVJox3cmAD22GhCnSbz8Hgep
	 eMz7yioUwd3EDW+jW9mv2QPglXm4OO5jDGi7umHe0BslaXl3e3veXTl+YrY1kifVHi
	 4XQITuMZUb873n0U8G2mYYDyiy9Fz5rUgdyja1NzYtgg1qwPX5nxLWdauAOlbasW+s
	 3b6rwAUYeWMKhP2es1RmPrWaM/kXo2KHDrF5OfYVP4QcQ83jMavfxt/JRQoUA1WruP
	 ddvaSB+syb4UQ==
Date: Fri, 25 Apr 2025 18:14:31 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
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
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v9 06/24] iommu/dma: Factor out a iommu_dma_map_swiotlb
 helper
Message-ID: <aAwzd_PE6U4ukQQp@bombadil.infradead.org>
References: <cover.1745394536.git.leon@kernel.org>
 <9ef79ed6c24d12cfea7e6f491da48ae170a5f3f3.1745394536.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef79ed6c24d12cfea7e6f491da48ae170a5f3f3.1745394536.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_181434_963701_C17BAC74 
X-CRM114-Status: GOOD (  11.74  )
X-Mailman-Approved-At: Mon, 28 Apr 2025 05:19:58 -0700
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

On Wed, Apr 23, 2025 at 11:12:57AM +0300, Leon Romanovsky wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Split the iommu logic from iommu_dma_map_page into a separate helper.
> This not only keeps the code neatly separated, but will also allow for
> reuse in another caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

