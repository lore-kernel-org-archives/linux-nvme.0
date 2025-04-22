Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3F4C369D8
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UnX3SwBrFlJmAEIyOKmv2MkVZ0z5pQYpYBguMGQREqw=; b=ZgV0XH2n0a0HTAro8mrichmFCF
	MJTcggW4bSJiwe1yMKdOcVDvTiIf2keVkX2ocbZOXlXSF5FT+PIodaM7jXvJv3IVfwc5L7hK/QSyi
	SQLSW14VSmyyZK1q618Pw6o4VGxlOi+6Xzc9p8J1gjgTLYFRHiuLyXDrJcl/dOR1iVbtKOJqXdKDz
	1bSErXFucHLI0kRSDzpQDDwIosiBmuWMger4Xz7oHm+VAByOyVBVjfmrgv3aZ5ngV4Eb4K0DS5r9U
	EvYW/W6ZZkobt8q3Y1ccPm5F8z75mkPSWR4aXyTTPt5inS+ypGdxickFZ6yFLsls5de3tMgkSz0x0
	tZZ06C7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7EjE-00000007Wdi-0lZS;
	Tue, 22 Apr 2025 14:36:04 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u78Ir-00000006AEE-2kme
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 07:44:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A085444996;
	Tue, 22 Apr 2025 07:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1566FC4CEE9;
	Tue, 22 Apr 2025 07:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745307865;
	bh=IkpCJe6iK3e0zmgzu4HOe7msfQx4RRcdkVXQ/zE59nM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UWT8zpQsdCGRmAI20Z+3AYlApwN36Cmhj6cwB5IbEbE/IARvNVu0tWdo4mIoQ7tla
	 jNP/ANqauZjnvPJUDWeJ8zADeaD5f36aQ2RWsAs+HUooXKhuTuo6yu/E07zazBROX6
	 xznqv+BPsU6Ncghg2SNTxJe37syfeyaxQcr9WAF/Foen5407hErRIFOLLYGI7pgvGN
	 CyJIqFICxTnqDUBmc1sGRXnHfviqEbMmgDyblOZ2xNZJFl02u19GY6Nbpt7EgtHA8c
	 CrDGpNwLguDhhfqO7ogHBVTsHjC7XaO9VuKIwQLJaY5iHytN6aNXhIGafF6/jV6lt1
	 HqZxDZY2NWy3Q==
Date: Tue, 22 Apr 2025 10:44:19 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Kanchan Joshi <joshi.k@samsung.com>, Jake Edge <jake@lwn.net>,
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
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v8 24/24] nvme-pci: optimize single-segment handling
Message-ID: <20250422074419.GD48485@unreal>
References: <cover.1744825142.git.leon@kernel.org>
 <670389227a033bd5b7c5aa55191aac9943244028.1744825142.git.leon@kernel.org>
 <20250422043955.GA28077@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422043955.GA28077@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_004425_730500_DD941151 
X-CRM114-Status: GOOD (  25.55  )
X-Mailman-Approved-At: Tue, 22 Apr 2025 07:26:59 -0700
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

On Tue, Apr 22, 2025 at 06:39:56AM +0200, Christoph Hellwig wrote:
> On Fri, Apr 18, 2025 at 09:47:54AM +0300, Leon Romanovsky wrote:
> > From: Kanchan Joshi <joshi.k@samsung.com>
> > 
> > blk_rq_dma_map API is costly for single-segment requests.
> > Avoid using it and map the bio_vec directly.
> 
> This needs to be folded into the earlier patches or split prep patches
> instead of undoing work done earlier, preferably combined with a bit
> of code movement so that the new nvme_try_setup_prp_simple stays in
> the same place as before and the diff shows it reusing code.
> 
> E.g. change
> 
> "nvme-pci: use a better encoding for small prp pool allocations" to
> already use the flags instead of my boolean, and maybe include 
> abort in the flags instead of using a separate bool so that we
> don't increase hte iod size.
> 
> Slot in a new patch after that that dropping the single SGL segment
> fastpath if we think we don't need that, although if we need the PRP
> one I suspect that one would still be very helpful as well.
> 
> Add a patch if we want the try_ version of, although when keeping
> the optimization for SGLs as well that are will look a bit different.
> 
> I'm happy to give away my patch authorship credits if that helps with
> the folding.

I used this patch separation for two reasons:
1. Your conversion patch is absolutely correct and this patch is an
optimization.
2. Wanted to make sure that I'll post to the ML the code exactly as it
was tested.

I'll try to split/fold this patch now.

Thanks

