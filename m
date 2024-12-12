Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8960E77180
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 08:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/HDUpFqxbFvW95X1CgbEmRhBJD1E3aCZPj7LRuLMxi0=; b=ujBWxftfrliQzEm8NIfgU2Z2LT
	PqmmsUUHqmOmc2ZVWlQ//5at0db3x9SK8vHHotl2k89y/2uE2H+Pn06Wjlor1P1noSFLprDVMCdpI
	nqekEK6XfEzCGFJPhc+S3mn+qJlRLU9bAzRmBf09x7i7cd9+ZhnZqwdo0qL/Xwd59f+IL527Y4o2p
	7kS9byaSVVwzZ8oNcH/zkoAmp6m0tEAr6pSey/5maEk/0opEgPDav4aDekKjxbFq0LfTewlywrV/8
	AtFlqQH3CqxKakteXZuGkrIF1LDsd73w+68mHvC9vgC9btJROe7EVTKSJtLjT5K7J4a+pluPj4mAt
	op9bxMTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLezy-0000000HOO1-1YCA;
	Thu, 12 Dec 2024 08:56:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLesY-0000000HMs5-1e2W
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 08:49:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 594C268D1E; Thu, 12 Dec 2024 09:48:57 +0100 (CET)
Date: Thu, 12 Dec 2024 09:48:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leonro@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
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
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 11/18] mm/hmm: let users to tag specific PFN with
 DMA mapped bit
Message-ID: <20241212084856.GE9376@lst.de>
References: <cover.1733398913.git.leon@kernel.org> <e4551571fc10d9c73ab9e38a75ea701c1b492686.1733398913.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4551571fc10d9c73ab9e38a75ea701c1b492686.1733398913.git.leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_004902_562624_130699A8 
X-CRM114-Status: GOOD (  16.91  )
X-Mailman-Approved-At: Thu, 12 Dec 2024 00:56:29 -0800
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

On Thu, Dec 05, 2024 at 03:21:10PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Introduce new sticky flag (HMM_PFN_DMA_MAPPED), which isn't overwritten
> by HMM range fault. Such flag allows users to tag specific PFNs with information
> if this specific PFN was already DMA mapped.

Missing line wrap at 73 characters here.

>  
> @@ -253,14 +262,14 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
>  			cpu_flags = HMM_PFN_VALID;
>  			if (is_writable_device_private_entry(entry))
>  				cpu_flags |= HMM_PFN_WRITE;
> -			*hmm_pfn = swp_offset_pfn(entry) | cpu_flags;
> +			*hmm_pfn = (*hmm_pfn & HMM_PFN_INOUT_FLAGS) | swp_offset_pfn(entry) | cpu_flags;

Please avoid the overly long line here.

That being said I hate the structure here.  Can't we just have a local
variable for the actual new pfn value, and then a single goto label
at the end that takes the keeper flags from the argument and assigning
the new out value to *hmm_pfn instead of duplicating this in half a
dozen places?


