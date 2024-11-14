Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8899CD68B3C
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 16:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YDnzyPYCMdR/4GH91n/AwIZTblf/bYA97QVS/THtZsI=; b=NqZgvmEw2sIQxCqJprZEzWwFgG
	jW/yikuNvJrYHMECnRIEDjqQ0ks7vOfj924Xb8KBb3tsUT7Ity9jqJNtSnNFEUY/T7DHSHQnKBD6c
	V+Z9nfYXQ2Ug85EfENZHOeuQ1xR6oWiRHGi14Wqj/8u2Mtu/Hz6F9Bw9hwsHKZX5r+/Sa8civ2acq
	JXdkkoLMdRW7cuttS31zhrTyK12px/PVrLaL8P5cYXgIOJ+/Ymxi/Tu1dgk77KvzQVd8hEANG+6Bs
	4TELC2joFN5zz3Gsu2/08W1gbpjgF0SNMbbO6qLnBnorjl3Nk6zKuYU9poDkO8Acq4s8/iaENEpKt
	jGwoRCdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBd1w-00000000Cav-3O74;
	Thu, 14 Nov 2024 16:49:16 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBd1F-00000000CMa-0npb
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 16:48:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 406B9A41854;
	Thu, 14 Nov 2024 16:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434D1C4CECD;
	Thu, 14 Nov 2024 16:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731602911;
	bh=Hx8YYfB1GiMgjudYqJkAl8tvbolgpNIbwv5wiDGpWKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oj9j4lFlZh6intpQ4wpfMP6Sm/OaAQmcYgcgKinj3ga8KXj+JnstzlbjR1onQ5Cql
	 hSESVrvCeEITPT1mzAD+bQIZnJP3n+ef6tQ3L6XpUr6ZjcQ3ncpVydh0ZqmXAgVioA
	 IYM0j5KeW4xRYkVPj3GHhOJ2aHGIoj16yfozYBJAX8MRkteE5t7gpf5o+hhm8/ZIy+
	 plLDS2dJdw/pCg8sGjF23ZIi88P1Q06aOxkhlyweHqHtB5s38blARUAmF+7JyurAZn
	 HdBH8z9Dk8/wOOhFIPwX8aM8JpTMq5Bu61qE+wN+1839i9DJ6rHjqJcZi/3moETGMu
	 ahRHoyu8lSKAw==
Date: Thu, 14 Nov 2024 18:48:23 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	ill Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
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
Subject: Re: [PATCH v3 00/17] Provide a new two step DMA mapping API
Message-ID: <20241114164823.GB606631@unreal>
References: <cover.1731244445.git.leon@kernel.org>
 <20241112072040.GG71181@unreal>
 <20241114133011.GA606631@unreal>
 <20241114163622.GA3121@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114163622.GA3121@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_084833_294395_011A2053 
X-CRM114-Status: GOOD (  20.83  )
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

On Thu, Nov 14, 2024 at 05:36:22PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 14, 2024 at 03:30:11PM +0200, Leon Romanovsky wrote:
> > > All technical concerns were handled and this series is ready to be merged.
> > > 
> > > Robin, can you please Ack the dma-iommu patches?
> > 
> > I don't see any response, so my assumption is that this series is ready
> > to be merged. Let's do it this cycle and save from us the burden of
> > having dependencies between subsystems.
> 
> Slow down, please.  Nothing of this complexity is going to get merged
> half a week before a release.

It is fine, but as a bare minimum, I would expect some sort of response,
so I won't sit and wait for unknown date when this API will be acknowledged/NACKed.

I would like to start to work on next step, e.g removing SG from RDMA,
and I need to know if this foundation is stable to do so.

> 
> No changs to dma-iommu.c are going to get merged without an explicit
> ACK from Robin, and while there is no 100% for the core dma-mapping
> code I will also not merge anything that hasn't been resolved with
> my most trusted reviewer first, not even code I wrote myself.

And do you know what is not resolved here? I don't.
All technical questions/issues were handled.

Thanks

