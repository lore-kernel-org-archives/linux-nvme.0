Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FB3C369C2
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 16:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8bYjJFvQS35SDJcCJWORo0DhaNJBhkeJWgzxAxJLxJQ=; b=Cci3KsF3sGmfoDHGkZ1twPOJVm
	dsz97DnVvjnKA8aJsflUve2IWC1wyDiY8S1+A63wBW49KCw9EIsETj7JPXL3gdGdunY1YEELpsSVj
	e6li7HVDa3MeCycv+Gnf0+SERUwun+qkL+1IRONJl8uv4d0FjW7gTufBWVIXJf7EaOHw9rfZy/ttO
	7S14x/NdXKDZOvK1zvxq0rk6CIeBJpU5YrdzIkraWYNzVAqntYSm6MIiLbKrG6FhIY0U0jQQZQAtT
	mkMky9r3akgprOQQclgtEU5CdSrTAllh8Oi2TJqLu86iEPCvZkWg0UXA6mfQl95DCvSkS0hWYZihh
	XesQ5RKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7z71-0000000Efuz-3uAi;
	Thu, 24 Apr 2025 16:07:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ygY-0000000EWU9-0sls
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 15:40:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8B2DA6845D;
	Thu, 24 Apr 2025 15:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A503BC4CEE3;
	Thu, 24 Apr 2025 15:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745509221;
	bh=m79yZBVMxE4AA+f552+EtExtizaGN1TqMSESd2aS1SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4SnX1SpGM96KuxInmm2t03yLng6qqivRc2wHB4xd8CtP+uvMU7jkKFpKZe45BteH
	 zqcj1DUZMShku6uzUtSBDI5rx5uEh1QHaFhgPxUGwXNZbuShRbDVG+xHDAzy3OPROr
	 rU+2l58DxT4fbGkZO8xoTv6BlTIx00VCgB+eat7UHHYIaDKSumURqvQC09O/ZPdBkK
	 0HQGmwElb4FhGgmcEB25UvRzoltQujcCwEWIvnR1GDjHtHFmnfnlwYXFHVMuRoNIDH
	 x9AJZp8qsMfWve6AsPQDHkOEovPrQ+qb5dceT168S5fh8FnQW7YJsliQPupcjWm/1m
	 HGS+iQba20kDw==
Date: Thu, 24 Apr 2025 09:40:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] nvme/pci: make PRP list DMA pools per-NUMA-node
Message-ID: <aApbYhyeYcCifoYI@kbusch-mbp.dhcp.thefacebook.com>
References: <20250422220952.2111584-1-csander@purestorage.com>
 <20250422220952.2111584-4-csander@purestorage.com>
 <20250424141249.GA18970@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424141249.GA18970@lst.de>
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

On Thu, Apr 24, 2025 at 04:12:49PM +0200, Christoph Hellwig wrote:
> On Tue, Apr 22, 2025 at 04:09:52PM -0600, Caleb Sander Mateos wrote:
> > NVMe commands with more than 4 KB of data allocate PRP list pages from
> > the per-nvme_device dma_pool prp_page_pool or prp_small_pool.
> 
> That's not actually true.  We can transfer all of the MDTS without a
> single pool allocation when using SGLs.

Let's just change it to say discontiguous data, then.

Though even wtih PRP's, you could transfer up to 8k without allocating a
list, if its address is 4k aligned.
 
> > Each call
> > to dma_pool_alloc() and dma_pool_free() takes the per-dma_pool spinlock.
> > These device-global spinlocks are a significant source of contention
> > when many CPUs are submitting to the same NVMe devices. On a workload
> > issuing 32 KB reads from 16 CPUs (8 hypertwin pairs) across 2 NUMA nodes
> > to 23 NVMe devices, we observed 2.4% of CPU time spent in
> > _raw_spin_lock_irqsave called from dma_pool_alloc and dma_pool_free.
> > 
> > Ideally, the dma_pools would be per-hctx to minimize
> > contention. But that could impose considerable resource costs in a
> > system with many NVMe devices and CPUs.
> 
> Should we try to simply do a slab allocation first and only allocate
> from the dmapool when that fails?  That should give you all the
> scalability from the slab allocator without very little downsides.

The dmapool allocates dma coherent memory, and it's mapped for the
remainder of lifetime of the pool. Allocating slab memory and dma
mapping per-io would be pretty costly in comparison, I think.

