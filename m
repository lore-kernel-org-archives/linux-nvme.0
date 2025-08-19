Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03602CA0EFA
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 03:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rPawf4MAOK3K2lEjypEKyp/U3T0IFN68PxzTHE3J6/E=; b=v+N9vxCSE3cnn+JGlfyE7Za36Z
	5SYZTnTiDW4ZgLbgmN7RM7WB/0MKu/b3rCu8vETDBnh3UXMSSwVqUZprEsR7NTMCpxYUXsfpzDfmC
	5vJwnoKei454kAeA8D5ZeFlOKaLEzwjLDH0nVAhw0qmlWDfyWzVGiBZ4hPebfllxZcUy8/P6j5zGE
	uY7TvlfJ9Hps2EQ82Q+TxrnWPYCH6HX0TubD6I5NxNQ78bcwxdZnHMcLpmBuWhT4SdCDF+pTuoOdC
	SbIIOEyugNe1Du+B+h9C43XuYM9WKc04viLueR2Y6aC3RLsSwXEGORrXVP4KKN6ryvos4ATOds2xf
	WX4Sh01Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uowE4-0000000FhZH-2B81;
	Thu, 21 Aug 2025 03:44:32 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoQyh-0000000BHSF-0j7t
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 18:22:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 594E960209;
	Tue, 19 Aug 2025 18:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8557CC4CEF1;
	Tue, 19 Aug 2025 18:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755627754;
	bh=VSqn6WSqLVd/XpfzgudXSJRo0uPOQ5wyv2bWmCBBnJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=alN6/hwHpvzthoP/KrllDuyPfF9f8yAYQER8+ba4p7ZAaMRpwoXt8rvK6QE3L0ekl
	 bNm+CTndacGb+nR2BKXPNUnvE9okK+nJN6vWKLBypTEbMKpjdWZnobeyYbTdlJBwG3
	 eQhAlRfAJUiGmqIDHRjbObolLDa17Te4yFQpGASd/eKfIFxPevya5z3Kg7b9O2j2pW
	 xGJZckYIQxAQDMxUtnVFWJEEUia3gPTM6PRono+D9/zC602CQuuuu0N45uS/29jmmO
	 kxle5BpRno+jkLFSoQGxLhrpEA9gCkuIidPS0ZJ3bdNRJ1LR7RUOVZQkLijjuMZ2fZ
	 kFmTbvgXjx5hQ==
Date: Tue, 19 Aug 2025 12:22:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>,
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
Subject: Re: [PATCH v4 11/16] dma-mapping: export new dma_*map_phys()
 interface
Message-ID: <aKTA5i1IZquRBolf@kbusch-mbp>
References: <cover.1755624249.git.leon@kernel.org>
 <bb979e4620b3bdf2878e29b998d982185beefee0.1755624249.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb979e4620b3bdf2878e29b998d982185beefee0.1755624249.git.leon@kernel.org>
X-Mailman-Approved-At: Wed, 20 Aug 2025 20:44:16 -0700
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

On Tue, Aug 19, 2025 at 08:36:55PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Introduce new DMA mapping functions dma_map_phys() and dma_unmap_phys()
> that operate directly on physical addresses instead of page+offset
> parameters. This provides a more efficient interface for drivers that
> already have physical addresses available.
> 
> The new functions are implemented as the primary mapping layer, with
> the existing dma_map_page_attrs()/dma_map_resource() and
> dma_unmap_page_attrs()/dma_unmap_resource() functions converted to simple
> wrappers around the phys-based implementations.
> 
> In case dma_map_page_attrs(), the struct page is converted to physical
> address with help of page_to_phys() function and dma_map_resource()
> provides physical address as is together with addition of DMA_ATTR_MMIO
> attribute.
> 
> The old page-based API is preserved in mapping.c to ensure that existing
> code won't be affected by changing EXPORT_SYMBOL to EXPORT_SYMBOL_GPL
> variant for dma_*map_phys().

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

