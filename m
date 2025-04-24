Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77252C369D5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 16:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tZWbCJXHjo38J7VbRbR+2vYQ4wLkNzWtqg5EEa2ZAIw=; b=kBvnOsTEGIPlS19jKwowUSdknV
	VDBLZjlvuf1W+8BDJbzzGZo7vZ8+i1yZb9jXxDytFdghUNNuxbJ9xwZtZVVR4lo4Ys3EIxdW42Xs8
	ejcbZm//MRfmskkAgyzLiI90mJPYEhExUWY/6raMfeSdgXIUP5vFVTByK3Cy1ITLVzDjPFHwikojk
	kd8oAna9B0YDXvsJh4fD7jrFTLcX35ehPCnYH0fWm8q9YBjSynBbHkGS0ncAKozzx6TlFuBiCgoig
	/mbxFFeTERfdPZGwGBrYlfo04EJaWESn2Fxhj4x4EK3Xfxf31nQcGpZbYMPECtWyMj23w+bYultWy
	w/hFfV6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7z3h-0000000Eao9-1ISd;
	Thu, 24 Apr 2025 16:04:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7w2e-0000000E5c3-2HfH
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 12:51:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5A9FC5C635E;
	Thu, 24 Apr 2025 12:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73038C4CEE8;
	Thu, 24 Apr 2025 12:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745499057;
	bh=8H9DLsIGypKjg5EA6FxGNO666pgvRrUO/QmIpk1Dbt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NF+hNjrGDHMWirFNyLpGK+CGY/Wtnrcaz8GKXJy/bE0XGkdVLaecqnHgHaxGfEhML
	 7jpVM/H7S49o+1K+eHQ2EgfO2HX4uAVtcvGRrWZJiMPUTyBYsPFQrSWaQDyWiksE4I
	 zYCVGwUO0Zy3g+Q9YtT5JjZ6L4/EJc4YcANsfzc5P8J46J4DvIu422Ekpr+LWz/xu5
	 1tDTRL8fevCgQaBA+DwfgEVIfNxbm2kn1CppO/72VC+Bxe/6aX19AeSe+j5ZVvsX6c
	 jKIeV1sk1Atk76qflMRZe3BT+0W+nn49+KZBrII6YRZh59RXG6gb+f1yfN7sBXtrbi
	 XI5m2BF99M4Cw==
Date: Thu, 24 Apr 2025 15:50:52 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>,
	Mika =?iso-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Jake Edge <jake@lwn.net>, Jonathan Corbet <corbet@lwn.net>,
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
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 10/24] mm/hmm: let users to tag specific PFN with DMA
 mapped bit
Message-ID: <20250424125052.GS48485@unreal>
References: <cover.1745394536.git.leon@kernel.org>
 <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>
 <7185c055-fc9e-4510-a9bf-6245673f2f92@redhat.com>
 <20250423181706.GT1213339@ziepe.ca>
 <36891b0e-d5fa-4cf8-a181-599a20af1da3@redhat.com>
 <20250423233335.GW1213339@ziepe.ca>
 <20250424080744.GP48485@unreal>
 <20250424081101.GA22989@lst.de>
 <20250424084626.GQ48485@unreal>
 <20250424120703.GY1213339@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424120703.GY1213339@ziepe.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_055100_669706_5FDE0C59 
X-CRM114-Status: GOOD (  17.81  )
X-Mailman-Approved-At: Thu, 24 Apr 2025 07:04:07 -0700
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

On Thu, Apr 24, 2025 at 09:07:03AM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 24, 2025 at 11:46:26AM +0300, Leon Romanovsky wrote:
> > On Thu, Apr 24, 2025 at 10:11:01AM +0200, Christoph Hellwig wrote:
> > > On Thu, Apr 24, 2025 at 11:07:44AM +0300, Leon Romanovsky wrote:
> > > > > I see, so yes order occupies 5 bits [-4,-5,-6,-7,-8] and the
> > > > > DMA_MAPPED overlaps, it should be 9 not 7 because of the backwardness.
> > > > 
> > > > Thanks for the fix.
> > > 
> > > Maybe we can use the chance to make the scheme less fragile?  i.e.
> > > put flags in the high bits and derive the first valid bit from the
> > > pfn order?
> >
> > It can be done too. This is what I got:
> 
> Use genmask:

I can do it too, will change.

> 
> enum hmm_pfn_flags {
> 	HMM_FLAGS_START = BITS_PER_LONG - PAGE_SHIFT,
> 	HMM_PFN_FLAGS = GENMASK(BITS_PER_LONG - 1, HMM_FLAGS_START),
> 
> 	/* Output fields and flags */
> 	HMM_PFN_VALID = 1UL << HMM_FLAGS_START + 0,
> 	HMM_PFN_WRITE = 1UL << HMM_FLAGS_START + 1,
> 	HMM_PFN_ERROR = 1UL << HMM_FLAGS_START + 2,
> 	HMM_PFN_ORDER_MASK = GENMASK(HMM_FLAGS_START + 7, HMM_FLAGS_START + 3),
> 
> 	/* Input flags */
> 	HMM_PFN_REQ_FAULT = HMM_PFN_VALID,
> 	HMM_PFN_REQ_WRITE = HMM_PFN_WRITE,
> };
> 
> Jason

