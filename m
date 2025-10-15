Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F1CCCD190
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Oct 2025 06:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=auunI0/37qF6NYUN6nxDlrENS7jjxznB0SXSNgwl44U=; b=xybLpWW1UsLFS+BTuwFTPvsgnI
	T8a9v+7Nd257Ub3N8xhTUq0gymEeaSuKiP7nlZdmDj/mxpgfpjd6AndYOCDCrNnjwA1NJ0HQ9d6oW
	GKVmdhEictO6laxD5x3CHdL2CYGIGj3iycl9G3+9rmouu12OkgUJEKl87x4aqA7FjohI+VGiXkChR
	kIZCpj0ncieymvBRtqYcc/KRtp2lttnFIrAMpgQaBaQUYNsfcnOruf46KJFXR3uEXo6rF10pzaUCy
	EBJDi75g1GTA2bn8/5hLWNnDdPvCKOUMwNgyTKvAhmxvx8DX3kH+XRYfc+DN/K4dVzteHsGs2M88t
	/6Tc+efg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8vFD-00000000coI-1ePo;
	Wed, 15 Oct 2025 06:44:19 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8vFA-00000000cnq-2y4R
	for linux-nvme@lists.infradead.org;
	Wed, 15 Oct 2025 06:44:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CACC248E88;
	Wed, 15 Oct 2025 06:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A47FC4CEF8;
	Wed, 15 Oct 2025 06:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760510655;
	bh=Ng/TpONxqJIcYfHCXWiNhUnJ8g9KU2/KbXEEA1wmwyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0xFHOo/AodCLJYuRhRDGNzyP0paUpB7BlbhboayGDkqaPpBf2LUvibc9K3xiWAsg
	 nZU8URiUNXMeQpHnVJ+BIygtX0nOCdJcZHhOSYHXr1vrLYkvM+/ZAF9qVHpsK/Ty7+
	 cV331e+Xpi92a4efrSS3XoxTq5XD8shJWnm1cQRl/hyUIgQCfV4QDsZKVB36cO60U4
	 r1GZFJjGj2E90EF36n3p+J2zO+oATDtSXGIeLCyc8Tl846NMAawQ0j1WHBzQeOoQM6
	 zAS8LLHydG0A2Xp0dqQA9TlmBmd/ZNoj3o994bLTsx8M0Y5tNneBcJmpSgnPKMjieE
	 OOl6e2KdPSqKg==
Date: Wed, 15 Oct 2025 09:44:11 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 4/4] nvme-pci: unmap MMIO pages with appropriate interface
Message-ID: <20251015064411.GA6393@unreal>
References: <cover.1760369219.git.leon@kernel.org>
 <6522567376d50f71425ccc4950552fca48e4f57f.1760369219.git.leon@kernel.org>
 <20251015042053.GC7073@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015042053.GC7073@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251014_234416_764015_F0E07E49 
X-CRM114-Status: GOOD (  20.00  )
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

On Wed, Oct 15, 2025 at 06:20:53AM +0200, Christoph Hellwig wrote:
> On Mon, Oct 13, 2025 at 06:34:12PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Block layer maps MMIO memory through dma_map_phys() interface
> > with help of DMA_ATTR_MMIO attribute. There is a need to unmap
> > that memory with the appropriate unmap function, something which
> > wasn't possible before adding new REQ attribute to block layer in
> > previous patch.
> 
> This should go into the same patch that switches to dma_map_phys.

I don't think so, dma_map_phys() patch [1] doesn't change any behavior
and dma_map_page() is equal to dma_map_phys(... , attr = 0),

> Unless I'm missing something it also misses passing the flag for
> the metadata mapping.

Yes, I didn't realize that same request can have both metadata and data
payloads.

> 
> Btw, where is all this going?  Are you trying to remove the auto
> detection of P2P in the low-level dma mapping routines?  If so that
> should probably go into at very least the cover lttter, but probably also
> the commit logs.

It is an outcome of multiple things:
1. We missed setting of IOMMU_MMIO flag in dma-iommu.c flow for p2p pages
and for that we need some external indication as memory type is already
known to the callers.
2. Robin expressed concerns about overloading DMA_ATTR_SKIP_CPU_SYNC.

[1] https://lore.kernel.org/all/a40705f38a9f3c757f30228b9b848ce0a87cbcdd.1760369219.git.leon@kernel.org/
[2] https://lore.kernel.org/all/751e7ece-8640-4653-b308-96da6731b8e7@arm.com/

