Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765B7C3271E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jul 2024 18:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lToYZLoiuINaAb/IkHIpgUQUKB5UoDoSeS3yxKSywpk=; b=sGIlaPdPkoLDtslcYgS5VlX/B7
	qAM42yifgEmAKgj4jt6OEkQD9AQKzjQM+erkMbRJqiCRwzfeHYDtp06N3CwpB9e8hLAQVhlwNDNY0
	zGL3NNimZo6YWxoR0H1QalIs5rwcw2YNmWvKrLRPpjxYDf4hkySDIjeTB2+qhfn/Gx7sa1+aRuoe5
	WZAfgoKwJmt9zlyewwCmuD7XLQyIm3Cn80mavAkk1cNIWvKjN7+YAgcm68jrJjUJKe+uFFSxTEtJU
	2naJ38aHIwKLKeAjOsHSeVn7y2FZuseZUVC07aycr8RyBleWxVxe239KBKvBsDO+Jg3zaFY1EP0SQ
	qUEHjRUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPnzQ-0000000Gf3T-3q8f;
	Fri, 05 Jul 2024 18:49:00 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPnzN-0000000Gf22-2XD3
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jul 2024 18:48:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4B2D8CE3EA6;
	Fri,  5 Jul 2024 18:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17E5C116B1;
	Fri,  5 Jul 2024 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720205331;
	bh=3gQdxm9rrq4HH+3IgyK33e5U18PihTEsMAv3ZFMKGl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ht2Sg2t2ndCjMGA6QKO2lqpTrzx5fDYVZJW7Ovgfr1eplx4adbkUHrvVY0Fu92JLt
	 mU5W84MEOLzWeruLzCzFJBMcezP+9RWb4w2qbxVzYCrWWzfG7s4lg/Gv7+t1mLvgfO
	 2fdSWrA5Q1UyDcQM7GTChwnkpqlcbSPsNUt/V748Qr4OW0E18YwIXE9gUZ8xqbm3Pa
	 QZ5HR5+kS74PefChnaUbAqlutm/0zUWk4Ir6koict+0o/SIMktXHfmKvALkPRAwy7e
	 60A1hFUaIMAvaXkUU5Xx3C78C3VfTgwAozfACG4DXiep2AGvT26MouaYytY3hJ3pYn
	 tSYLgRXYv+5hA==
Date: Fri, 5 Jul 2024 21:48:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 18/18] nvme-pci: use new dma API
Message-ID: <20240705184846.GF95824@unreal>
References: <cover.1719909395.git.leon@kernel.org>
 <47eb0510b0a6aa52d9f5665d75fa7093dd6af53f.1719909395.git.leon@kernel.org>
 <249ec228-4ffd-4121-bd51-f4a19275fee1@arm.com>
 <20240704171602.GE95824@unreal>
 <20240705055806.GA11885@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705055806.GA11885@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240705_114857_847601_22C8CF6E 
X-CRM114-Status: GOOD (  11.61  )
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

On Fri, Jul 05, 2024 at 07:58:06AM +0200, Christoph Hellwig wrote:
> > This is exactly how dma_map_sg() works.
> 
> Which dma_map_sg?  swiotlb handling is implemented in the underlying
> ops, dma-direct and dma-iommu specifically.
> 
> dma-direct just iterates over the entries and calls dma_direct_map_page,
> which does a per-entry decision to bounce based on
> is_swiotlb_force_bounce, dma_capable and dma_kmalloc_needs_bounce.

dma-direct is not going to have "use_iova" flag. Robin pointed to
dma-iommu path.

In that case the flow is dma_map_sg()->iommu_dma_map_sg()->dev_use_sg_swiotlb().

Thanks

> 
> 

