Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA75C38150
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jul 2024 06:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=is3clyWtBV4BLw0NVVUMoS+sRKP5gH+whCcYTcmsk4I=; b=GqESCVWhKJNFH9YYcz6tRPlE4+
	cdG69pvP7fw15q2uCalU/VGXewL2qj6e4VeKLJcv15A/bxiy8cATymwtODc0J7nvMmLVNmEb6ggPG
	cOpkgSYY+jMTjyNyi0oYWn1jf6fogT3jGdX/6IRmymE77w6mVoCNEhBCUv68AMxLjUSsggW1NjCYC
	Gc+O+BLbMAYyS9Zmn39jQU5LJbQcB2RUYdJyounKNifs/prMWCqUBypk/dlUUrBpkUpEIUekHfscr
	Gr/zWgu4tYgldSqP1hSVAL309OHcFdwkjzTnWDM2EljZkFY+uZB/ggt0ZJUtTQJ+ZOPYwITnCt6R3
	tYROYEiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRQif-00000009amD-1H0H;
	Wed, 10 Jul 2024 06:22:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRQic-00000009akl-1fDf
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jul 2024 06:22:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id ACBCC227A87; Wed, 10 Jul 2024 08:22:12 +0200 (CEST)
Date: Wed, 10 Jul 2024 08:22:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20240710062212.GA25895@lst.de>
References: <cover.1719909395.git.leon@kernel.org> <20240705063910.GA12337@lst.de> <20240708235721.GF14050@ziepe.ca> <20240709062015.GB16180@lst.de> <20240709190320.GN14050@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709190320.GN14050@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240709_232222_616051_841E985E 
X-CRM114-Status: GOOD (  17.25  )
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

On Tue, Jul 09, 2024 at 04:03:20PM -0300, Jason Gunthorpe wrote:
> > Except for the powerpc bypass IOMMU or not is a global decision,
> > and the bypass is per I/O.  So I'm not sure what else you want there?
> 
> For P2P we know if the DMA will go through the IOMMU or not based on
> the PCIe fabric path between the initiator (the one doing the DMA) and
> the target (the one providing the MMIO memory).

Oh, yes.  So effectively you are asking if we can arbitrarily mix
P2P sources in a single map request.  I think the only sane answer
from the iommu/dma subsystem perspective is: hell no.

But that means the upper layer need to split at such a boundary.
E.g. get_user_pages needs to look at this and stop at the boundary,
leaving the rest to the next call.

For the block layer just having one kind per BIO is fine right now,
although I could see use cases where people would want to combine
them.  We can probably defer that until it is needed, though.


