Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B75C5DF6D
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 08:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cLX+uN7UxmwBRboiEpJjQnWXOn06YT26pdmB84vnlr4=; b=Svo1I9FRcOCV60ey4tE4P7gTih
	CTG5as+1NpuFkiFYzNIrBzEnviNAvCWnKGjvmzlyG+0W23tdgEk8T7HIzIH6rH3G5oBO6WqLvjv9j
	xC1JU9cWN8/aavJ3nU4mGQsGpHqBbSMdRAFGn4KuTQ7cVeUbV5FSSet5KflJ2H+szunoEzSqoXjHt
	vUerkA9oguoDreJhcdQCa6ogoXQ2Es3n9fiVija92MFIk9EJtRMER0t/v8jxdK95h0saYpOKL+EX9
	lqdYMULMjyELx3+O9wQaq0zhF3Hwgacf7n9qbRdxn4TWe0rVnOpHXKTcLtW0iQTrqIBIHwVwZC24W
	Amk/0XxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwc7A-00000009MAt-1RWo;
	Wed, 19 Aug 2026 08:57:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwc77-00000009MAL-2f1o
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 08:57:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DF20268C7B; Wed, 19 Aug 2026 10:57:32 +0200 (CEST)
Date: Wed, 19 Aug 2026 10:57:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	Adrian Huang <ahuang12@lenovo.com>
Subject: Re: dma_opt_mapping_size returns way too low sizes when using IOMMU
Message-ID: <20260819085732.GA8649@lst.de>
References: <20260817083654.GA23414@lst.de> <86f7fbdc-3c7f-4d84-871e-52ed3cfe8d58@oracle.com> <20260817091840.GA26843@lst.de> <8b7e86a7-6cb1-4007-bd99-1c4be8e6828e@oracle.com> <3ac5346a-485f-4c1a-8c3a-ad649f2c76f0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ac5346a-485f-4c1a-8c3a-ad649f2c76f0@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_015737_830387_8065A73E 
X-CRM114-Status: GOOD (  27.24  )
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

[adding Adrian who originall added the cap to NVMe to work around a
softlockup, see commit 3710e2b056cb ("nvme-pci: clamp max_hw_sectors
based on DMA optimized limitation")]

On Mon, Aug 17, 2026 at 06:04:24PM +0100, Robin Murphy wrote:
>> page order, i.e. the idea was that we should not be getting streaming IOs 
>> larger than that value. But in looking at lore, 8 was very originally 
>> proposed, but I can't see any discussion on why that changed or any 
>> relation to page max order.
>
> From a quick skim I can't spot any specific mention in the original threads 
> or accompanying paper, but I have a feeling it was as much about just 
> balancing memory consumption with observable performance improvement, and 
> larger sizes weren't significantly impactful to the original testing, which 
> did seem to be focused on networking rather than storage.

Yeah, network transfer sizes tend to be much lower than those for
storage.

> Since these days we have the flexibly-sized depot, and now even 
> lazy-allocation of the CPU magazines, we might be in a better position to 
> consider scaling IOVA_RANGE_CACHE_MAX_SIZE up without too much inherent 
> overhead (I guess the base cost per level will just be 2*NR_CPUS + 1 
> pointers now).

That would be useful.  Is just incrementing it enough or do we need more
fine tuning?

> The larger sizes we cache, though, the more it's also going 
> to blow up IOVA consumption if freeing/reallocation isn't well balanced 
> across CPUs, so for devices/systems with limited IOVA space, at some point 
> the flush_rcache case is liable to start adding more overhead than the 
> caching itself saves...

Storage drivers tend to steer I/O completions to the submitting CPU by
default.  There are some exceptions, though.  For example polling with
a dedicated polling thread will usually not do this.  Then again the
overlap of polled I/O and IOMMU usage should be about 0 right now.
This could change with the dmabuf I/O path, but that would lock down
the IOVA for the lifetime of the dmabuf and sidestep the entire
issue here.

> FWIW, my understanding of the idea we settled on for opt_mapping_size was 
> that it was never meant to be an absolute target, just a boundary between 
> where callers can expect "ideal" mapping performance, and where it may 
> start scaling with size/contention/etc., and thus it's for the callers to 
> judge whether larger sizes are still worth it for their particular 
> use-case.

That would suggest the approach done in the SAS transport class makes
more sense and NVMe should just cap to the max mapping size.  Of course
even that might be the wrong answer.  For example for HDD we really do
want much larger I/O sizes even if it slows down the IOMMU, but right
now HDD on NVMe isn't really beyond the proof of concept stage, at
least discounting things like smart NICs as an in-between layer.

