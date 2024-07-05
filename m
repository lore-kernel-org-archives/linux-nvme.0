Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A00C30658
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jul 2024 06:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W6V4Jl595UKk2ulLyZ6FqrjSl5HG/l3SMtmbZRoEqs4=; b=c92L6UJcfmtk04KDW0eXch7Qtq
	j2y4xg0ed79p4GibMenIKTQVzU9zEiMrudGi0tTG4rIfAZZkklbfLYa71/AaZK2YW1L1Yhwv2ELOS
	oW6OQZd5BeOW1/499mxj0X50I/eWEuuxTdljhcceg8K3KgfOmpj4MV5Wt/lF0PnydWY2+ebo0bdHm
	41HPutGTIvTZO1Wpx7YFg7fhJJCOyIph1D32xnSx7nusM5RthKTc+wQPyyu9vmfBXeMU+Gy7pf/+W
	dhwbrWRnrx8nZYxJcQuJqZrN0qsCZ3AzpBaAII3KZPS1l6ReeHsSJs+aNwZMTGOh7waDXBdqAq7PW
	qX/zW0Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPbzW-0000000EzJU-3ZHU;
	Fri, 05 Jul 2024 06:00:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPbzQ-0000000EzHT-00r0
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jul 2024 06:00:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CC81268AA6; Fri,  5 Jul 2024 08:00:04 +0200 (CEST)
Date: Fri, 5 Jul 2024 08:00:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Keith Busch <kbusch@kernel.org>, "Zeng, Oak" <oak.zeng@intel.com>,
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
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240705060003.GB11885@lst.de>
References: <cover.1719909395.git.leon@kernel.org> <20240703054238.GA25366@lst.de> <20240703105253.GA95824@unreal> <20240703143530.GA30857@lst.de> <20240703155114.GB95824@unreal> <20240704074855.GA26913@lst.de> <20240704131839.GD95824@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704131839.GD95824@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_230012_209023_1F7D000A 
X-CRM114-Status: GOOD (  13.26  )
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

On Thu, Jul 04, 2024 at 04:18:39PM +0300, Leon Romanovsky wrote:
> > 2) The amount of seemingly unrelated global headers pulled into other
> > global headers.  Some of this might just be sloppiness, e.g. I can't
> > see why dma-mapping.h would actually need iommu.h to start with,
> > but pci.h in dma-map-ops.h is a no-go.
> 
> pci.h was pulled because I needed to call to pci_p2pdma_map_type()
> in dma_can_use_iova().

No, that's not the reason.  The reason is actually that whole
dev_use_swiotlb mess which shouldn't exist in this form.

