Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB4CE77180
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 08:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BwiohXe2LpqwSbaayvK5WRdb0Es7ZzhHmd4u+kN1o34=; b=kD0gAi6UrDtxcwos7f6jy+BR5p
	lH4aTb+iTqAYD+MuvXVD7yYNn/U/se0XLHceNc/IpAnwFPy8O7LR/IOU2McgX+VoJEl/Yc0pr6RqO
	QM7R6ikRjUG6xurKYh1q+SyxYDkPsO9F7zfdMwf7hPmVMA6LV3K/MKJIUtJa+YDOlcUnL4EUjAJWQ
	rzZFTFIOhmD6PpGdhyIvoBbq09dmh6ACcg6IG9izZd4TNYcqlCLHEIYS4MpbOZFP+VmHDu8+4NG1p
	8h/YcNCdf512yqrN2IpicfnsePKBnhB/6q+yJSj+GazbOE3WuxpCaVTUTebVCbyKcidiBK34znY4u
	zV469Cpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLeyM-0000000HO1V-0k6P;
	Thu, 12 Dec 2024 08:55:02 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLeyI-0000000HNyw-08nS
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 08:54:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E5021A426B8;
	Thu, 12 Dec 2024 08:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6C8C4CECE;
	Thu, 12 Dec 2024 08:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733993696;
	bh=Fy4YngrVcpagRsu5yXaXhy6khObq1+63mtDUkXZu0Hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ojj28dCCyJsYWCQ3nZtMUHqqKD7pLZ/ITymNq/65CKEPSxvMwaKmSBEcXxLYPPKy0
	 bCCF3nZPaJ7k//9SBQ/rYhvwJimsjRdm+91sZWCtORRbzPjDtteY0DSoFIUcv1x+Lr
	 1CBtlVjnuOx8tTbgfpy+LEAsfWvTLFFTYZp7gkMuh4x2UvzAENWOExWVLSc4743UO9
	 JCTRe0c+Y4hkv7hgXehu2a9IN4oO88rQf5qeTV3yngqTzQ8uA8ZEtTJYYWl8RkEd5C
	 CPaD72/jVRnOkLoezb3tHNft0IcASYCJ/ywixjCc6QTi7fbpx3tk7LTpPjb2MxQzXP
	 gZjbGel83uyhg==
Date: Thu, 12 Dec 2024 10:54:52 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
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
Subject: Re: [PATCH v4 11/18] mm/hmm: let users to tag specific PFN with DMA
 mapped bit
Message-ID: <20241212085452.GI1245331@unreal>
References: <cover.1733398913.git.leon@kernel.org>
 <e4551571fc10d9c73ab9e38a75ea701c1b492686.1733398913.git.leon@kernel.org>
 <20241212084856.GE9376@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212084856.GE9376@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_005458_136031_A0BD2BFF 
X-CRM114-Status: GOOD (  18.06  )
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

On Thu, Dec 12, 2024 at 09:48:56AM +0100, Christoph Hellwig wrote:
> On Thu, Dec 05, 2024 at 03:21:10PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Introduce new sticky flag (HMM_PFN_DMA_MAPPED), which isn't overwritten
> > by HMM range fault. Such flag allows users to tag specific PFNs with information
> > if this specific PFN was already DMA mapped.
> 
> Missing line wrap at 73 characters here.
> 
> >  
> > @@ -253,14 +262,14 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
> >  			cpu_flags = HMM_PFN_VALID;
> >  			if (is_writable_device_private_entry(entry))
> >  				cpu_flags |= HMM_PFN_WRITE;
> > -			*hmm_pfn = swp_offset_pfn(entry) | cpu_flags;
> > +			*hmm_pfn = (*hmm_pfn & HMM_PFN_INOUT_FLAGS) | swp_offset_pfn(entry) | cpu_flags;
> 
> Please avoid the overly long line here.
> 
> That being said I hate the structure here.  Can't we just have a local
> variable for the actual new pfn value, and then a single goto label
> at the end that takes the keeper flags from the argument and assigning
> the new out value to *hmm_pfn instead of duplicating this in half a
> dozen places?

Yes, sure, it makes sense, will do.

> 

