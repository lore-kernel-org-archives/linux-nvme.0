Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A542C3600B
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Mar 2025 16:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v6NsHOMRWFTrliJNfIkuFn1sRc8cJTevfMV6ugxpisw=; b=sWIWO7nCJGT9Sztbvxgk1rPDXY
	wNxprDWGzrKd1lk25+DewOh+IypC7ktqFmsz3MviORoNmLFJwIqxa9gkSTBSBv91Rpq+eSYP8FDgM
	cUfJ/lUc8XU/Gj47VFwdaWPAL+IwX+2FJ6BWI7vGCyh0+0wMfYeGcd/DCpKGJJVEtAovlZoFjhoro
	MWQ/wGfch+OeJDk1n3YaQZb0s6Ty2VXfZBGKq25UH1tfrFMJ0U99JRodydOS2UX7pTvdXUQBYCOeA
	/mb8/tk419x2/mnli6eWr81IxXmyj9mAPfiJAHtmqcfC71yghYxwZ5q4J01rqCEExsZDvLlnraOQ5
	lGTWPhUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx7X4-00000006XmX-0rtB;
	Tue, 25 Mar 2025 16:53:42 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx5Tc-00000006EEG-43mG
	for linux-nvme@lists.infradead.org;
	Tue, 25 Mar 2025 14:42:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C3543A4A725;
	Tue, 25 Mar 2025 14:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4707DC4CEE4;
	Tue, 25 Mar 2025 14:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742913719;
	bh=oJti1ermRV1uUgJ8pfTRGamayM8FuQAkNzrsrS5yAe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ngMssWMXx+k8rjAGS+vZ41iCzKScU7HoG1cd+9tapyfHg4Qil/6pMj9dymbkVElx5
	 TfHngtwSqwgeCOEiqbXqQ4/7oBQ6SpuELO5d0Z0v98cKHmN60spAJqrYnwqcgIJW1+
	 UtswMpNtmAeS8qCW2H67yx2jhZcTg572DF8E9cBIAxzdFzZ3+mVBzlyHDnnNJBcFCL
	 gNTmqwJCFUNMIOFG6/sUjHCBzGjZJBgpvg5a0VChAjAUm9ScR+R+ztSQpZuWPxEtVj
	 O6j5iJZbrcFhxtdioLYqFkmCn9tQL1ros4DiQlqru1txpE0J4bVQ7RUSEc9TwwB944
	 SJiTsVHoVSSgg==
Date: Tue, 25 Mar 2025 16:41:58 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
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
Subject: Re: [PATCH v7 00/17] Provide a new two step DMA mapping API
Message-ID: <20250325144158.GA4558@unreal>
References: <cover.1738765879.git.leonro@nvidia.com>
 <20250220124827.GR53094@unreal>
 <1166a5f5-23cc-4cce-ba40-5e10ad2606de@arm.com>
 <20250302085717.GO53094@unreal>
 <e024fe3d-bddf-4006-8535-656fd0a3fada@arm.com>
 <Z+KjVVpPttE3Ci62@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+KjVVpPttE3Ci62@ziepe.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250325_074201_075564_2474ADD4 
X-CRM114-Status: GOOD (  11.14  )
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

On Tue, Mar 25, 2025 at 09:36:37AM -0300, Jason Gunthorpe wrote:
> On Fri, Mar 21, 2025 at 04:05:22PM +0000, Robin Murphy wrote:

<...>

> > So what is it now, a layering violation in a hat with still no clear path to
> > support SWIOTLB?
> 
> I was under the impression Leon had been testing SWIOTLB?

Yes, SWIOTLB works and Christoph said it more than once that he tested
NVMe conversion patches and they worked.

Thanks

