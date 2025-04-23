Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6717DC369CB
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 18:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IO21pmrwIRca1fPgD174SCTD3P5B2ca9Ykqyd/DD35Q=; b=VzRZo8QPsA+Ur/plHtLCXrJkn4
	j15rX7bA2a2pXjfiCZtIu3aQCH0PEmxis3i9nKgPwZ1jkSnn+MSWmtxht0jZ2jKlyO0QgUmEZWyXf
	+JCCr9TLLP1kimvaAt0uvJynyMh0k1UIAsLDTK1PyDhRNVgRT5g6Qr4AEGtALAwGn5GpwxTxS8f3H
	FCMsEKr0J2Ab3+hbKuhyJMPUid7C/9LQOqRqgfTpPc4EqHLTEu1Lqb+TekjR4+nlEK8O+EOTu8NVq
	/ccbg4tSLBG2L8BeSAuBZBEHcYloDq4dsu54irkzJt2d3JHTidAqLHMUxTpzj68xjKS/dYoo1DpDS
	846QE/FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7f7r-0000000Bd74-3MnU;
	Wed, 23 Apr 2025 18:47:15 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7du6-0000000BGfY-3eBk
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 17:29:00 +0000
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-476a304a8edso1008561cf.3
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 10:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745429338; x=1746034138; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IO21pmrwIRca1fPgD174SCTD3P5B2ca9Ykqyd/DD35Q=;
        b=AuelOR7FNpdsgDZkFWW1pIwFj4QTu/Y5gbZwrmVi/BbaazvDI5O2fEhrDhF9/8fPNa
         gnwFZ6Rel1hTpzIvFnA25sKs7I9Ox9ni7buYMNgIukcdQIDlVbZvAR7Arfd7BPCqUidM
         R3ysQUAREU9bqp7so/B/qXKB1vxueNidn34M7drvh9755dw4SAqU8+EQfgqOYGjkoUQ5
         gYRUpbYglDoXzRP44kVtq70SVQdDnPes50M5ot0A52jV6rsawnMigiGZFo8v/hXdtdny
         9JGLJNsz9FbbpEPWZDsUR/C9nGDCq1cFOxhr/cxMmg8+85txMapy+vVQ+Sg4lvHHTjxF
         8f7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429338; x=1746034138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IO21pmrwIRca1fPgD174SCTD3P5B2ca9Ykqyd/DD35Q=;
        b=tj/3DGYz12e/Qeh0ivs9BYXqlk7ssExDLNDuKUeySUS+pBLqVJWRA1B6WmB6pgBJ8T
         fy1j+m0azFm74x2GdHJdT51vajucpK9zQKC2sxAnvICaN79399zqdLPlyCkGY8YBnzhD
         Dsn0/q5nkZztdvtjgchIAYmjFk3ItSueTl5E9HDPR7X/TvKjka+rMZtIkpurVbYvxt8O
         0UdntMMEBANq7rqECprTlNeHom4gKWZd4nqqddSCuVy83xXGByPOZ8whW4Wj1UTE0dPk
         gDN18gSVCi+IZn/2BDPnRrxQs6dzuuyJkPu4ILBkVxg+lsxkwypvsx4waKm/tazOKR2e
         8WLA==
X-Forwarded-Encrypted: i=1; AJvYcCV0sLw63gNoZOsjC1jV0lsyqyYbO/WUBibfFB3YbqZ7V1IyoM6boeqYBH2KZ7jJvWdstzm6xjOwFR0x@lists.infradead.org
X-Gm-Message-State: AOJu0YyOmchMzSNZZEdhP85xf9t9Jk2BNpqXJnf0Pkb5MV9OVPsZ67TA
	jlJN+gSe8JEFgjXyUxS5OIGhMUeumyoIE6RAUbrEy+FE7NjOS71yQDKOxnSXdSo=
X-Gm-Gg: ASbGncsdhXa+sEGpd/E4PLktgDKzfKrhg7YdlDb2wV5klGxbRZzTuQi5O7yXBbXe/p8
	KWXNB3hwt1ncHY/3+mgqgifmFmhdOdO8eCxrWQpiEx/bLGYkIuNx4ZadLBQvDRASaWJYWDX/IzH
	CLWQtm1LKQXDe2PPYstNOtjN0uqwQNoT1T9Y0NrDB4W2Fwtclseb91nBJx6bUNhQY+r39ITtYnD
	jNpKBCJIA8IThlp1hE9hztGHK52eLJIdtWeD8alJ2ZxLDCam+7TvugiO/W19Rs5fPTe/w53+BkK
	G+ArtHhkceDsEuSH07ahNH+mcdLCxSOoVqqwPcIFVDPOc22YMC9eyFxdXi9MN4RhcSV4v8Q0zT8
	+Ugx6G2nWQrf8I7F7dYI=
X-Google-Smtp-Source: AGHT+IFhccZU7hwIpoqF9kdgyBZNm8CDnNWVmBsNPQQ6+B1QKTjLAh4Uz8aWpAuaS2cilFrr6VCiig==
X-Received: by 2002:a05:622a:18a6:b0:477:5c21:2e1f with SMTP id d75a77b69052e-47e77a9e41emr774971cf.34.1745429337818;
        Wed, 23 Apr 2025 10:28:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c3b5c3sm71026671cf.21.2025.04.23.10.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:28:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7du4-00000007LYP-3LLk;
	Wed, 23 Apr 2025 14:28:56 -0300
Date: Wed, 23 Apr 2025 14:28:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
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
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 11/24] mm/hmm: provide generic DMA managing logic
Message-ID: <20250423172856.GM1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <3abc42885831f841dd5dfe78d7c4e56c620670ea.1745394536.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3abc42885831f841dd5dfe78d7c4e56c620670ea.1745394536.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_102858_912959_0162F235 
X-CRM114-Status: GOOD (  19.73  )
X-Mailman-Approved-At: Wed, 23 Apr 2025 11:34:49 -0700
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

On Wed, Apr 23, 2025 at 11:13:02AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> HMM callers use PFN list to populate range while calling
> to hmm_range_fault(), the conversion from PFN to DMA address
> is done by the callers with help of another DMA list. However,
> it is wasteful on any modern platform and by doing the right
> logic, that DMA list can be avoided.
> 
> Provide generic logic to manage these lists and gave an interface
> to map/unmap PFNs to DMA addresses, without requiring from the callers
> to be an experts in DMA core API.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>

I don't think Jens tested the RDMA and hmm parts :)

> +	/*
> +	 * The HMM API violates our normal DMA buffer ownership rules and can't
> +	 * transfer buffer ownership.  The dma_addressing_limited() check is a
> +	 * best approximation to ensure no swiotlb buffering happens.
> +	 */

This is a bit unclear, HMM inherently can't do cache flushing or
swiotlb bounce buffering because its entire purpose is to DMA directly
and coherently to a mm_struct's page tables. There are no sensible
points we could put the required flushing that wouldn't break the
entire model.

FWIW I view that fact that we now fail back to userspace in these
cases instead of quietly malfunction to be a big improvement.

> +bool hmm_dma_unmap_pfn(struct device *dev, struct hmm_dma_map *map, size_t idx)
> +{
> +	struct dma_iova_state *state = &map->state;
> +	dma_addr_t *dma_addrs = map->dma_list;
> +	unsigned long *pfns = map->pfn_list;
> +	unsigned long attrs = 0;
> +
> +#define HMM_PFN_VALID_DMA (HMM_PFN_VALID | HMM_PFN_DMA_MAPPED)
> +	if ((pfns[idx] & HMM_PFN_VALID_DMA) != HMM_PFN_VALID_DMA)
> +		return false;
> +#undef HMM_PFN_VALID_DMA

If a v10 comes I'd put this in a const function level variable:

          const unsigned int HMM_PFN_VALID_DMA = HMM_PFN_VALID | HMM_PFN_DMA_MAPPED;

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

