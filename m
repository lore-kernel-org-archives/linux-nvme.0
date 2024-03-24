Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDCFC54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wdf6PUBzbOxshWuBwuNO7bfujr6oxShqhVnMFylPW/s=; b=LMwSw1qBZcjBlnwMXIt44PeBeP
	go+rT/9VNiCXqH52p4QGMvqhmNocaAJHIalNqmadzPW+cmegVS5DMLrfBv/ijZsXyFOINGn74wKKN
	aLp1VIFzbF/3uOhTI4nxfnGA8h6U3F1bjGSVZz9t5DeOLCUzifVzWYmAEa/sjZY5pD2DlrDGsklfQ
	J+4XxsgCAe7hGqPnPdCiuj9uMcPcQOTpkgREw+SgcFSQL3bSaSy6dwztJLD5pUtB8RSl3MaCjTFsD
	WoQ/EC6KTgPXqeQVNMFhhFHalawfzNXc6TAkXNynzFz0lqN7nRY/vTIT5v5ruMZMkElqzdlx6mKtA
	J3McIHRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rprM4-0000000ESJm-1UO9;
	Thu, 28 Mar 2024 15:07:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roXAU-0000000Dpo0-2sdZ
	for linux-nvme@lists.infradead.org;
	Sun, 24 Mar 2024 23:22:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 08B4F68D0F; Mon, 25 Mar 2024 00:22:16 +0100 (CET)
Date: Mon, 25 Mar 2024 00:22:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
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
	"jack@suse.com" <jack@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two
 steps
Message-ID: <20240324232215.GC20765@lst.de>
References: <20240306221400.GA8663@lst.de> <20240307000036.GP9225@ziepe.ca> <20240307150505.GA28978@lst.de> <20240307210116.GQ9225@ziepe.ca> <20240308164920.GA17991@lst.de> <20240308202342.GZ9225@ziepe.ca> <20240309161418.GA27113@lst.de> <20240319153620.GB66976@ziepe.ca> <20240321223910.GA22663@lst.de> <20240322184330.GL66976@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322184330.GL66976@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240324_162223_155793_CE193FA9 
X-CRM114-Status: GOOD (  30.37  )
X-Mailman-Approved-At: Thu, 28 Mar 2024 08:07:42 -0700
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

On Fri, Mar 22, 2024 at 03:43:30PM -0300, Jason Gunthorpe wrote:
> If we are going to make caller provided uniformity a requirement, lets
> imagine a formal memory type idea to help keep this a little
> abstracted?
> 
>  DMA_MEMORY_TYPE_NORMAL
>  DMA_MEMORY_TYPE_P2P_NOT_ACS
>  DMA_MEMORY_TYPE_ENCRYPTED
>  DMA_MEMORY_TYPE_BOUNCE_BUFFER  // ??
> 
> Then maybe the driver flow looks like:
> 
> 	if (transaction.memory_type == DMA_MEMORY_TYPE_NORMAL && dma_api_has_iommu(dev)) {

Add a nice helper to make this somewhat readable, but yes.

> 	} else if (transaction.memory_type == DMA_MEMORY_TYPE_P2P_NOT_ACS) {
> 		num_hwsgls = transcation.num_sgls;
> 		for_each_range(transaction, range) {
> 			hwsgl[i].addr = dma_api_p2p_not_acs_map(range.start_physical, range.length, p2p_memory_provider);
> 			hwsgl[i].len = range.size;
> 		}
> 	} else {
> 		/* Must be DMA_MEMORY_TYPE_NORMAL, DMA_MEMORY_TYPE_ENCRYPTED, DMA_MEMORY_TYPE_BOUNCE_BUFFER? */
> 		num_hwsgls = transcation.num_sgls;
> 		for_each_range(transaction, range) {
> 			hwsgl[i].addr = dma_api_map_cpu_page(range.start_page, range.length);
> 			hwsgl[i].len = range.size;
> 		}
>

And these two are really the same except that we call a different map
helper underneath.  So I think as far as the driver is concerned
they should be the same, the DMA API just needs to key off the
memory tap.

> And the hmm_range_fault case is sort of like:
> 
> 		struct dma_api_iommu_state state;
> 		dma_api_iommu_start(&state, mr.num_pages);
> 
> 		[..]
> 		hmm_range_fault(...)
> 		if (present)
> 			dma_link_page(&state, faulting_address_offset, page);
> 		else
> 			dma_unlink_page(&state, faulting_address_offset, page);
> 
> Is this looking closer?

Yes.

> > > So I take it as a requirement that RDMA MUST make single MR's out of a
> > > hodgepodge of page types. RDMA MRs cannot be split. Multiple MR's are
> > > not a functional replacement for a single MR.
> > 
> > But MRs consolidate multiple dma addresses anyway.
> 
> I'm not sure I understand this?

The RDMA MRs take a a list of PFNish address, (or SGLs with the
enhanced MRs from Mellanox) and give you back a single rkey/lkey.

> To go back to my main thesis - I would like a high performance low
> level DMA API that is capable enough that it could implement
> scatterlist dma_map_sg() and thus also implement any future
> scatterlist_v2, bio, hmm_range_fault or any other thing we come up
> with on top of it. This is broadly what I thought we agreed to at LSF
> last year.

I think the biggest underlying problem of the scatterlist based
DMA implementation for IOMMUs is that it's trying to handle to much,
that is magic coalescing even if the segments boundaries don't align
with the IOMMU page size.  If we can get rid of that misfeature I
think we'd greatly simply the API and implementation.

