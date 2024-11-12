Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4833ED462D0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 16:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=25oXpcZ2jkS0BbcUFsntK7m8dNPJ0WJqodki5oK1oFE=; b=Pk7Y3l4ra/1sqcb4Jp4/R90D4G
	nktlOoke0muCnME/i+98KqY02q8jpRE/Dwq6fvQZX+X4D9xLfRiAM0E5aS5mUqo7m7uVyxJ16+h8M
	ZY+PxuJ1h9L9vNJd+2cVw6MY7XrY4YnBjHwtZsuA+MsqvRBkr5eSlRSjLgSJS1NqyU+24B9gGjqDC
	AK6Z/0ZupZTl1NHXISZGu0QFjqgULbomxtqsTKLHs7tX67VrcE2kQAUeYYLHIM5a1J3U9SK7utdCC
	sFOFrla2p5FCFi4Odq571hXNux4822JxbZTjZbYq5tf43gj9OlOTux183n5VX2BDKN/CjDJAcpiRl
	UB5RKjww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBFzi-00000007Pph-266g;
	Wed, 13 Nov 2024 16:13:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAjxn-00000002Iic-0Nu7
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 06:01:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A286768D09; Tue, 12 Nov 2024 07:01:08 +0100 (CET)
Date: Tue, 12 Nov 2024 07:01:08 +0100
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
	kvm@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com,
	Thomas.Hellstrom@linux.intel.com, brian.welty@intel.com,
	himal.prasad.ghimiray@intel.com, krishnaiah.bommu@intel.com,
	niranjana.vishwanathapura@intel.com
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
Message-ID: <20241112060108.GA10056@lst.de>
References: <20241104095831.GA28751@lst.de> <20241105195357.GI35848@ziepe.ca> <20241107083256.GA9071@lst.de> <20241107132808.GK35848@ziepe.ca> <20241107135025.GA14996@lst.de> <20241108150226.GM35848@ziepe.ca> <20241108150500.GA10102@lst.de> <20241108152537.GN35848@ziepe.ca> <20241108152956.GA12130@lst.de> <20241108153846.GO35848@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108153846.GO35848@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_220119_298457_C4ABA542 
X-CRM114-Status: GOOD (  17.08  )
X-Mailman-Approved-At: Wed, 13 Nov 2024 08:13:25 -0800
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

On Fri, Nov 08, 2024 at 11:38:46AM -0400, Jason Gunthorpe wrote:
> > > What I'm thinking about is replacing code like the above with something like:
> > > 
> > > 		if (p2p_provider)
> > > 			return DMA_MAPPING_ERROR;
> > > 
> > > And the caller is the one that would have done is_pci_p2pdma_page()
> > > and either passes p2p_provider=NULL or page->pgmap->p2p_provider.
> > 
> > And where do you get that one from?
> 
> Which one?

The p2p_provider thing (whatever that will actually be).


