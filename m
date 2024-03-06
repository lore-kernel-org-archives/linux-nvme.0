Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263F4C54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 16:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OzO/9AzUna+R5zeXsIy0wzPXoaVBkJN8YgW56YBfzG4=; b=YtrSaT6kIITushbFRu8UPFhE1f
	iPkmrYfvx4/VGOz5+a6ypz6sGq3NPHo8y1UJuKAKBmnWRZrOdphv8RL7xst6qDD3n4i9ifebAZhz9
	YweKI+qnTBpEVX+a7oi744IDl+fQ2j/lKi5sTDaW5D/d6OS9Ku6DOfqwARC7IxtLjWrDpI2WRME1R
	2tYldMc8XuC65M4vc3p5R5B0K+940dkRgdtpKtnNvGKpMBmIyAujZWE2bhUuGEWsL9KYh5aJt5KOp
	Lx/CXEyU0P4W7BjN9Gbk5DipXEUAm7+BUjeXpX309oQZP3QptG6w5yRw8bVQaJ2NbVmhZKRvyyELK
	a/utdjRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riGJ3-00000005Q6Z-1dr5;
	Thu, 07 Mar 2024 16:09:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhtuo-00000000wvj-2gKG
	for linux-nvme@lists.infradead.org;
	Wed, 06 Mar 2024 16:14:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 339E968C4E; Wed,  6 Mar 2024 17:14:39 +0100 (CET)
Date: Wed, 6 Mar 2024 17:14:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [RFC RESEND 16/16] nvme-pci: use blk_rq_dma_map() for NVMe SGL
Message-ID: <20240306161438.GA28427@lst.de>
References: <cover.1709635535.git.leon@kernel.org> <016fc02cbfa9be3c156a6f74df38def1e09c08f1.1709635535.git.leon@kernel.org> <Zec_nAQn1Ft_ZTHH@kbusch-mbp.dhcp.thefacebook.com> <20240306143321.GA19711@lst.de> <20240306150518.GL9225@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306150518.GL9225@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_081446_959629_782043B6 
X-CRM114-Status: GOOD (  22.43  )
X-Mailman-Approved-At: Thu, 07 Mar 2024 08:09:15 -0800
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

On Wed, Mar 06, 2024 at 11:05:18AM -0400, Jason Gunthorpe wrote:
> > Yes.  And this whole proposal also seems clearly confused (not just
> > because of the gazillion reposts) but because it mixes up the case
> > where we can coalesce CPU regions into a single dma_addr_t range
> > (iommu and maybe in the future swiotlb) and one where we need a
> 
> I had the broad expectation that the DMA API user would already be
> providing a place to store the dma_addr_t as it has to feed that into
> the HW. That memory should simply last up until we do dma unmap and
> the cases that need dma_addr_t during unmap can go get it from there.

Well.  The dma_addr_t needs to be fed into the hardware somehow
obviously.  But for a the coalesced case we only need one such
field, not Nranges.

> We can't do much on the map side as single range doesn't imply
> contiguous range, P2P and alignment create discontinuities in the
> dma_addr_t that still have to be delt with.

For alignment the right answer is almost always to require the
upper layers to align to the iommu granularity.  We've been a bit
lax about that due to the way scatterlists are designed, but
requiring the proper alignment actually benefits everyone.

