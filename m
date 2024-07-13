Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644D3C3DA45
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Jul 2024 05:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3TDikD6pp2ycIS8/CpN/B+ZNO+YZyR7OgGYextyu2fo=; b=lljgV0OWGZosrCrr3LQEgXb4Ht
	WCi9Y8bkndmXQ1V8JbrqaOLV1dAWQl5nuMAF/roV2eegm1jS9yKHjFkXGB40Au1InQuaofgoUA4Kf
	5/djL1KOYQUs5WHMI5mU3nZA7YrqbOeR7vdXjsmtxcZY3vSVUaiVA6s7UjCH1edzUCEOxzLDGfsEK
	/6AgzLCj8SbeCGtHhDZ0OsvNMSCd4EtsdWuLAd2E6viXow8Evfuc8ziGhKPklBojcOcEErHBD2OUT
	ZshXTQbpVb72BV1Iq60bzoOBajh6zmPJ1l1kIaqzC327PFsPnc+xuX6dUbe47gimntAe7wFo2UxKS
	fo9tKxGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSVFC-00000001vo9-0meV;
	Sat, 13 Jul 2024 05:24:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSVF8-00000001vkv-3fFd
	for linux-nvme@lists.infradead.org;
	Sat, 13 Jul 2024 05:24:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5CE8768B05; Sat, 13 Jul 2024 07:24:09 +0200 (CEST)
Date: Sat, 13 Jul 2024 07:24:08 +0200
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
Message-ID: <20240713052408.GA25890@lst.de>
References: <cover.1719909395.git.leon@kernel.org> <20240705063910.GA12337@lst.de> <20240708235721.GF14050@ziepe.ca> <20240709062015.GB16180@lst.de> <20240709190320.GN14050@ziepe.ca> <20240710062212.GA25895@lst.de> <20240711232917.GR14050@ziepe.ca> <20240712045422.GA4774@lst.de> <20240712124237.GX14050@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712124237.GX14050@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240712_222423_074729_E8F8E17C 
X-CRM114-Status: GOOD (  20.42  )
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

On Fri, Jul 12, 2024 at 09:42:37AM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 12, 2024 at 06:54:22AM +0200, Christoph Hellwig wrote:
> 
> > This is all purely hypothetical, and I'm happy to just check for it
> > and reject it for it now.
> 
> I do know a patch set is cooking to allow mixing ZONE_DEVICE P2P and
> anon memory in the same VMA ala HMM with transparent migration of
> ZONE_DEVICE to anon.
> 
> In this situation userspace will be generating IO with no idea about
> any P2P/!P2P boundaries.

Yes.  And as said from the beginning of these discussion I think the
right way is to change the gup code so that for a single call to
get/pin_user_pages it always returns either only P2P pages or non-P2P
pages only, with the FOLL_PCI_P2PDMA just allowing P2P pages at all.
Similarly they could easily just return one kind of P2P pages per
call only.

