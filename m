Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221C5CA0EE4
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Aug 2025 16:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B3LuiEZXTU5HOjRdk69N6t/53G6b/PJMIeTc2G5XpW8=; b=wTCL4v+3pO1nC/RfOifgYfDL76
	5tCRWj/0/2cuWKARisYYq8CcXrp05VwTmwUQ5u40qjCuEHKyWY1X51F0Acf+5HgP1OVaPlRqxeg3C
	kYf8beQm/LqCtp1Zj9ydbERBO+pn1aSHR9RXsa7ixt0JFbmYgKwNPUiSgfDhBXO2Rp3bnA0vwU3lm
	E8Z/55pfC9PbAEqrmx9v0gnlTqqj7DWm4ZbsEUXmr82Y020/otW+qvw7df2aK69Ydb4XymMpVg+ih
	3i0LcM8rP7jaaxIarIng4bn5fNLCVxDPBSqDVvTzuOxDoPht1dx4EX2CGk+PJRxtwEoyVWqcklgU6
	uTo3TLGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umacP-000000000E6-1P11;
	Thu, 14 Aug 2025 16:15:57 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umXAm-0000000GrMw-2u2q
	for linux-nvme@lists.infradead.org;
	Thu, 14 Aug 2025 12:35:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2039F40C46;
	Thu, 14 Aug 2025 12:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3623FC4CEED;
	Thu, 14 Aug 2025 12:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755174912;
	bh=5hXrpmcmtYiZJx4oU8qkI207P6Gx3hYundw5EKylrIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N2g2BIJ8YPB3KdUqlIQ+3sf88XYTAU5YzXsxCIMkq+b9inEW2vgp9A4ivccGvjwfF
	 AV/wNRHN7Rl4BZfB83b4YqKem1VH+FiuolX5SiQ0hmKku6kJ9fzYlnSHRYR/hZfo4A
	 t7RgKyvSz54/20bp9OQxBJ3FdHTZ28zI3/O5nihwLrWH4XxMFsh7ImLJrid7kdNvXc
	 dxHzSoTZ0eAkBFydpLdrAEROqaFVHC+xn4DDTCz/hN4fLyFBvzVlWYglA0CvtcModo
	 8sk1zeTQvWBfTVENe6sc6PZjsbCDpigaPftEIsijKrs4a0DqSYC9HgT0MWUqY4ie5R
	 dAHYa4zIponFg==
Date: Thu, 14 Aug 2025 15:35:06 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1 08/16] kmsan: convert kmsan_handle_dma to use physical
 addresses
Message-ID: <20250814123506.GD310013@unreal>
References: <cover.1754292567.git.leon@kernel.org>
 <5b40377b621e49ff4107fa10646c828ccc94e53e.1754292567.git.leon@kernel.org>
 <20250807122115.GH184255@nvidia.com>
 <20250813150718.GB310013@unreal>
 <20250814121316.GC699432@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814121316.GC699432@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_053512_770738_8B79A69D 
X-CRM114-Status: GOOD (  25.93  )
X-Mailman-Approved-At: Thu, 14 Aug 2025 08:29:04 -0700
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

On Thu, Aug 14, 2025 at 09:13:16AM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 13, 2025 at 06:07:18PM +0300, Leon Romanovsky wrote:
> > > >  /* Helper function to handle DMA data transfers. */
> > > > -void kmsan_handle_dma(struct page *page, size_t offset, size_t size,
> > > > +void kmsan_handle_dma(phys_addr_t phys, size_t size,
> > > >  		      enum dma_data_direction dir)
> > > >  {
> > > >  	u64 page_offset, to_go, addr;
> > > > +	struct page *page;
> > > > +	void *kaddr;
> > > >  
> > > > -	if (PageHighMem(page))
> > > > +	if (!pfn_valid(PHYS_PFN(phys)))
> > > >  		return;
> > > 
> > > Not needed, the caller must pass in a phys that is kmap
> > > compatible. Maybe just leave a comment. FWIW today this is also not
> > > checking for P2P or DEVICE non-kmap struct pages either, so it should
> > > be fine without checks.
> > 
> > It is not true as we will call to kmsan_handle_dma() unconditionally in
> > dma_map_phys(). The reason to it is that kmsan_handle_dma() is guarded
> > with debug kconfig options and cost of pfn_valid() can be accommodated
> > in that case. It gives more clean DMA code.
> 
> Then check attrs here, not pfn_valid.

attrs are not available in kmsan_handle_dma(). I can add it if you prefer.

> 
> > So let's keep this patch as is.
> 
> Still need to fix the remarks you clipped, do not check PageHighMem
> just call kmap_local_pfn(). All thie PageHighMem stuff is new to this
> patch and should not be here, it is the wrong way to use highmem.

Sure, thanks

> 
> Jason
> 

