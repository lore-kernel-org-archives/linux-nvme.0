Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049E6C369C2
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 16:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JELX5TFBl1qb68aHJWaauT5yp5eUlZ8uHJX0n8eWjOo=; b=3xLDbBgt+tqaDS1sOyEh4nF1Ea
	7qr80rwd7nw/QC9BO4dpP7U/bB8L1od0Yc+bi2vFgYaVjSH71MxKiK+NOp6Sia/MU0yW77Yc5mbie
	PFq9xX6abnPNdJ8/k+YW5c93x+9woAFs+zEWeiFlLXCL9+KzqpeBQe4QEFY+lNt/jWCOVxs+omjuW
	6HH0H85vYIRv+Vnus5NF/lIElwP+ShfOwFIsoKkXxohHlWSePJ4HrSNRNUF/nRYrCgqSWP0CFnTQ2
	VPww6mveGAxKu9JlK9/1fwcl1Ya0kM6Oyr13xIdOIaUJHgVkbbJFC9ZNKX/9f/xdpGRf2ziAuzc/z
	XNe9FEQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7z4n-0000000EcXe-1FFn;
	Thu, 24 Apr 2025 16:05:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7xK0-0000000EKTy-1Xjz
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 14:13:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 748D468AFE; Thu, 24 Apr 2025 16:12:49 +0200 (CEST)
Date: Thu, 24 Apr 2025 16:12:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] nvme/pci: make PRP list DMA pools per-NUMA-node
Message-ID: <20250424141249.GA18970@lst.de>
References: <20250422220952.2111584-1-csander@purestorage.com> <20250422220952.2111584-4-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422220952.2111584-4-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_071300_544036_A545D2C5 
X-CRM114-Status: GOOD (  15.75  )
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

On Tue, Apr 22, 2025 at 04:09:52PM -0600, Caleb Sander Mateos wrote:
> NVMe commands with more than 4 KB of data allocate PRP list pages from
> the per-nvme_device dma_pool prp_page_pool or prp_small_pool.

That's not actually true.  We can transfer all of the MDTS without a
single pool allocation when using SGLs.

> Each call
> to dma_pool_alloc() and dma_pool_free() takes the per-dma_pool spinlock.
> These device-global spinlocks are a significant source of contention
> when many CPUs are submitting to the same NVMe devices. On a workload
> issuing 32 KB reads from 16 CPUs (8 hypertwin pairs) across 2 NUMA nodes
> to 23 NVMe devices, we observed 2.4% of CPU time spent in
> _raw_spin_lock_irqsave called from dma_pool_alloc and dma_pool_free.
> 
> Ideally, the dma_pools would be per-hctx to minimize
> contention. But that could impose considerable resource costs in a
> system with many NVMe devices and CPUs.

Should we try to simply do a slab allocation first and only allocate
from the dmapool when that fails?  That should give you all the
scalability from the slab allocator without very little downsides.


