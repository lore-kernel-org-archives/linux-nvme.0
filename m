Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9A9C54E4A
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Mar 2024 16:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TPfk3/rg5x7LQCu6CiycFoix8G7EBd+0lpqcx+Dlhh0=; b=k3Yu6pc/PYc4vwdtozNwgi/0i1
	y06WNxR83qmLHryJm/nchvI48Jxvsb2MclJw2XMl/iUE5FdaxXpLPbuYBkaVlEAK+quuPP0xu9z8N
	eU9GmYF9tcexfqg9XnT4UbmA+6jAuGFd98PYNzb2r9OIqR7PW9gRIaM2W+yy68EVZJcshzb5WmRXq
	iNUURoAawajfJObGnDa6MLNMniOJJsAvGAfhJYBXi/BfsdWotaeSPsG6Chki9So9CLjBdaXgXn5KE
	8IrFT6ByIitLhTGNiWUCC4er7ZvUwDbCIcaGjXHVCjZa6kLxBtLvAIozTL0DE26qFU5JcFA83ibWa
	WPXS8IgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhtnB-00000000uoU-1rzR;
	Wed, 06 Mar 2024 16:06:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhsKm-00000000aql-1vBp
	for linux-nvme@lists.infradead.org;
	Wed, 06 Mar 2024 14:33:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 378F068C4E; Wed,  6 Mar 2024 15:33:22 +0100 (CET)
Date: Wed, 6 Mar 2024 15:33:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <20240306143321.GA19711@lst.de>
References: <cover.1709635535.git.leon@kernel.org> <016fc02cbfa9be3c156a6f74df38def1e09c08f1.1709635535.git.leon@kernel.org> <Zec_nAQn1Ft_ZTHH@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zec_nAQn1Ft_ZTHH@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_063328_738518_D06E9AFB 
X-CRM114-Status: GOOD (  16.90  )
X-Mailman-Approved-At: Wed, 06 Mar 2024 08:06:47 -0800
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

On Tue, Mar 05, 2024 at 08:51:56AM -0700, Keith Busch wrote:
> On Tue, Mar 05, 2024 at 01:18:47PM +0200, Leon Romanovsky wrote:
> > @@ -236,7 +236,9 @@ struct nvme_iod {
> >  	unsigned int dma_len;	/* length of single DMA segment mapping */
> >  	dma_addr_t first_dma;
> >  	dma_addr_t meta_dma;
> > -	struct sg_table sgt;
> > +	struct dma_iova_attrs iova;
> > +	dma_addr_t dma_link_address[128];
> > +	u16 nr_dma_link_address;
> >  	union nvme_descriptor list[NVME_MAX_NR_ALLOCATIONS];
> >  };
> 
> That's quite a lot of space to add to the iod. We preallocate one for
> every request, and there could be millions of them. 

Yes.  And this whole proposal also seems clearly confused (not just
because of the gazillion reposts) but because it mixes up the case
where we can coalesce CPU regions into a single dma_addr_t range
(iommu and maybe in the future swiotlb) and one where we need a
dma_addr_t range per cpu range (direct misc cruft).

