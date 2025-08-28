Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12B4C8303F
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 04:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nk21NoeFbSZuqbZYbv31DbqcJk0/VzI2uLLcHSo6RQc=; b=459m5YMHhg6/ZIzXtIHBElVz4g
	1ZB2wIaHmiSvjUEVa58jYiU9xN/KPeGN+d3gQYjFpAW2CiYGdsoez71J8UjJ4/47CGvH6Ix7fxkTr
	atgFWFhEvQ1OvCM3hHq4JQGcn+KFtZ1ySCVbuMoveKFFG6yxialA8AMN6wjx8L0JST0NT0GftpBsI
	HbHIEwKAWEDXxxHNNX+Jm7n8/oOdVC42Sqx/xkH6epvYDr7lOYoSLZopjOHzVKOT6lionJL0Q57AE
	HpOK0mBw65i5Sw/vvvUC/R5I0e2BH2kSRj2X//ZdsrWudsiuExjyK5bAoNQWe4Legd2N2xtc2DDCP
	cwUvBYLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urqyX-00000004PKb-1pOx;
	Fri, 29 Aug 2025 04:44:33 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urftR-00000002KA1-1kc2
	for linux-nvme@lists.infradead.org;
	Thu, 28 Aug 2025 16:54:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0F66D45196;
	Thu, 28 Aug 2025 16:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C34C4CEED;
	Thu, 28 Aug 2025 16:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756400072;
	bh=3QSqWFwhLXFpgIQB1AhDzeFYEFSsyOykW/t8YMcdvDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Utug3C4qHAngGkUPRUqPcVpMv2skHSOiyTR1dzioCxiyV/N0D3D3xwLMN4kKVhjRg
	 R1e3GaQ66/QDlvAbclIdn1b0xrBO+DODu7rLesJ54dZQOJ+qr4UwXmhZorK6X6L1pe
	 /mKnN3THYo/PX+SSQI5FBBXcz4a8pvxXQG8iBycA9jlkdj9zJMMNMWOCxqVVHcRMG0
	 jrJGkyKqRduB/ujzl45UowCIqtVEnLBTqm/vLH4mWU4+vwRxIYccg9OHedq9aiILZs
	 hmuixBFk7xqznER0ERf4UjMVjXknV66U4Y9wYKKHbgLQRBDuheIDJSUa9AzDEN/7Pr
	 p4K8MwEWQi7/w==
Date: Thu, 28 Aug 2025 19:54:27 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-nvme@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-trace-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v4 15/16] block-dma: properly take MMIO path
Message-ID: <20250828165427.GB10073@unreal>
References: <cover.1755624249.git.leon@kernel.org>
 <642dbeb7aa94257eaea71ec63c06e3f939270023.1755624249.git.leon@kernel.org>
 <aLBzeMNT3WOrjprC@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLBzeMNT3WOrjprC@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250828_095433_496666_261096FE 
X-CRM114-Status: GOOD (  17.01  )
X-Mailman-Approved-At: Thu, 28 Aug 2025 21:42:14 -0700
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

On Thu, Aug 28, 2025 at 09:19:20AM -0600, Keith Busch wrote:
> On Tue, Aug 19, 2025 at 08:36:59PM +0300, Leon Romanovsky wrote:
> > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> > index 09b99d52fd36..283058bcb5b1 100644
> > --- a/include/linux/blk_types.h
> > +++ b/include/linux/blk_types.h
> > @@ -387,6 +387,7 @@ enum req_flag_bits {
> >  	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
> >  	__REQ_ATOMIC,		/* for atomic write operations */
> >  	__REQ_P2PDMA,		/* contains P2P DMA pages */
> > +	__REQ_MMIO,		/* contains MMIO memory */
> >  	/*
> >  	 * Command specific flags, keep last:
> >  	 */
> > @@ -420,6 +421,7 @@ enum req_flag_bits {
> >  #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
> >  #define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
> >  #define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)
> > +#define REQ_MMIO	(__force blk_opf_t)(1ULL << __REQ_MMIO)
> 
> Now that my integrity metadata DMA series is staged, I don't think we
> can use REQ flags like this because data and metadata may have different
> mapping types. I think we should add a flags field to the dma_iova_state
> instead.

Before integrity metadata code was merged, the assumption was that request is
only one type or p2p or host. Is it still holding now?

And we can't store in dma_iova_state() as HMM/RDMA code works in page-based
granularity and one dma_iova_state() can mix different types.

Thanks

> 

