Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7A0D5AE71
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 08:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7VYcQSgARTMWilP+aj3J8qRXLCQdx+VA4mtxRoStmpo=; b=UVUYvsc5otTH2mnkagodnK7xJ9
	dBsLBCfA5upFcydroF4gWzXFzgPmOPrSO1YKH/hCAmdSmXDyI3OwjD7P/E7AUW+CfRa5j3bkTiToA
	eZ+O6eTfbzN7MMtpBs9tC1aXWasYjvwxZ4sGXD7CA9b/ZdchpR7yX7mMEv1/WPbGbcZMrY82qSd/s
	2nZMWl4GdHKPHvIl5jqeRavhAM2uNEayFZ7zUswnRaDY+FUjROJFAocbBRH96Z/Oj+YJlirFma2/l
	G0mPBDgfMpLsziBJg1+OkD36fGVHZzA2QKuc+qXExzqHM780sRbxVMvPngEDOb0NuUf3S6PJuEdfO
	ZBNw6Axw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8xwx-000000067uh-3i7X;
	Thu, 07 Nov 2024 08:33:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8xwv-000000067tz-23rU
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 08:33:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B5FAE68AA6; Thu,  7 Nov 2024 09:32:56 +0100 (CET)
Date: Thu, 7 Nov 2024 09:32:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
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
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
Message-ID: <20241107083256.GA9071@lst.de>
References: <cover.1730298502.git.leon@kernel.org> <3567312e-5942-4037-93dc-587f25f0778c@arm.com> <20241104095831.GA28751@lst.de> <20241105195357.GI35848@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105195357.GI35848@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_003305_698958_A16F986F 
X-CRM114-Status: GOOD (  25.18  )
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

On Tue, Nov 05, 2024 at 03:53:57PM -0400, Jason Gunthorpe wrote:
> > Yeah, I don't really get the struct page argument.  In fact if we look
> > at the nitty-gritty details of dma_map_page it doesn't really need a
> > page at all. 
> 
> Today, if you want to map a P2P address you must have a struct page,
> because page->pgmap is the only source of information on the P2P
> topology.
> 
> So the logic is, to get P2P without struct page we need a way to have
> all the features of dma_map_sg() but without a mandatory scatterlist
> because we cannot remove struct page from scatterlist.

Well, that is true but also not the point.  The hard part is to
find the P2P routing information without the page.  After that
any physical address based interface will work, including a trivial
dma_map_phys.

> > At least for the block code we have a nice little core wrapper that is
> > very easy to use, and provides a great reduction of memory use and
> > allocations.  The HMM use case I'll let others talk about.
> 
> I saw the Intel XE team make a complicated integration with the DMA
> API that wasn't so good. They were looking at an earlier version of
> this and I think the feedback was positive. It should make a big
> difference, but we will need to see what they come up and possibly
> tweak things.

Not even sure what XE is, but do you have a pointer to it?  It would
really be great if people having DMA problems talked to the dma-mapping
and iommu maintaines / list..


