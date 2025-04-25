Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFB0C369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 14:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eRgyWaTCnXTJn4ybjkzyDK/I4iuHXsx7IJBf2P1l8tk=; b=Cn3/rVoQG2HPOsgHUqvFUxl6VK
	RxnLXeP98oc7qLM1L6odoibBxKd07t0pl2T7MIWsvsOMpUl3kmLXtzXoTlM/ohl2qMZBLpnkuEjfH
	OlLfnMqL85HHLyt+xCEFnLB8O5QcKk3+B+S0tDlgQpzC5KwHe5UAIRRF+CrzPcwl/4es7u5ENYhrt
	Dto/rVE2y5SiRCtgsBJ8doF/CBiTDUEp7l87Ijc5ru7BsiPnrNHCTT3O+Mkv/btX1YLmQCUJKR1qz
	h1FRzwRjVqb7zm7BMVXUoHMaHtgKddWYBc4op4Y0NM4DTsHneUiBHeuQohr7kGt3DVdllpl0S41ML
	LuVOKo9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8JmD-0000000HOLD-0rd0;
	Fri, 25 Apr 2025 14:11:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8IzV-0000000HG95-3K6C
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 13:21:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 596F968B05; Fri, 25 Apr 2025 15:21:12 +0200 (CEST)
Date: Fri, 25 Apr 2025 15:21:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] nvme/pci: make PRP list DMA pools per-NUMA-node
Message-ID: <20250425132111.GA5797@lst.de>
References: <20250422220952.2111584-1-csander@purestorage.com> <20250422220952.2111584-4-csander@purestorage.com> <20250424141249.GA18970@lst.de> <aApbYhyeYcCifoYI@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aApbYhyeYcCifoYI@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_062117_973131_AB1413ED 
X-CRM114-Status: GOOD (  20.69  )
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

On Thu, Apr 24, 2025 at 09:40:18AM -0600, Keith Busch wrote:
> On Thu, Apr 24, 2025 at 04:12:49PM +0200, Christoph Hellwig wrote:
> > On Tue, Apr 22, 2025 at 04:09:52PM -0600, Caleb Sander Mateos wrote:
> > > NVMe commands with more than 4 KB of data allocate PRP list pages from
> > > the per-nvme_device dma_pool prp_page_pool or prp_small_pool.
> > 
> > That's not actually true.  We can transfer all of the MDTS without a
> > single pool allocation when using SGLs.
> 
> Let's just change it to say discontiguous data, then.
> 
> Though even wtih PRP's, you could transfer up to 8k without allocating a
> list, if its address is 4k aligned.

Yeah.

> > Should we try to simply do a slab allocation first and only allocate
> > from the dmapool when that fails?  That should give you all the
> > scalability from the slab allocator without very little downsides.
> 
> The dmapool allocates dma coherent memory, and it's mapped for the
> remainder of lifetime of the pool. Allocating slab memory and dma
> mapping per-io would be pretty costly in comparison, I think.

True.  Although we don't even need dma coherent memory, a single
cache writeback after writing the PRPs/SGLs would probably be more
efficient on not cache coherent platforms.  But no one really cares
about performance on those anyway..

