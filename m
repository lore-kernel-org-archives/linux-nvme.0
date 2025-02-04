Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4CBC0218F
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2025 06:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tHnaxwqdNPk5NX9nFB+CSaSgebLCaMXK+G71iKCz6Ww=; b=xVant408AXK3ZWT0cRPJ330IFs
	q7N0wiA8PaVortBtKeBttDhLcqTz9jBIsX4k3r9P1IpSK0FPvyDnSA23BGJmcvIH/rLI/aNq/nfqF
	W7MBvvOaq35L+gvrjt8L9UrTGmZ2uiudX0puVIqdRCGDz2YncgPnLNKXTESbVU54NpmL08CTM02Vx
	QN2/YL5d63vIYKmWdESRwYFyMUHq3A83YTNsPRtwNkZ7M2hyQ180IlOwfrSS67yQETs/BIFEOqZzP
	RTaprk3VOiouLXQ3rOR3b9TQLT839yhqDmMa2Ew1K5cH+6zkI3h58zygvmihkENNGQg0PQgC0xaXN
	KK/5K/Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfCO1-0000000HMXX-2D4V;
	Tue, 04 Feb 2025 06:26:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfCNy-0000000HMWd-1222
	for linux-nvme@lists.infradead.org;
	Tue, 04 Feb 2025 06:26:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 077F668AFE; Tue,  4 Feb 2025 07:26:06 +0100 (CET)
Date: Tue, 4 Feb 2025 07:26:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Christoph Hellwig <hch@lst.de>, Bruno Gravato <bgravato@gmail.com>,
	Stefan <linux-kernel@simg.de>, Keith Busch <kbusch@kernel.org>,
	bugzilla-daemon@kernel.org, Adrian Huang <ahuang12@lenovo.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of
 AsRock X600M-STX + Ryzen 8700G
Message-ID: <20250204062605.GB29300@lst.de>
References: <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de> <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info> <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de> <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com> <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info> <20250117080507.GA25953@lst.de> <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info> <20250117095522.GA2391@lst.de> <266965cf-9cf9-4434-be42-458e92d7366d@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <266965cf-9cf9-4434-be42-458e92d7366d@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_222614_433477_7CA0D5CD 
X-CRM114-Status: GOOD (  24.85  )
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

On Fri, Jan 17, 2025 at 11:30:47AM +0100, Thorsten Leemhuis wrote:
> >> Side note: that "PCI-DMA: Using software bounce buffering for IO
> >>>> (SWIOTLB)" message does show up on two other AMD machines I own as
> >> well. One also has a Ryzen 8000, the other one a much older one.

The message will aways show with > 4G of memory.  It only implies swiotlb
is initialized, not that any device actually uses it.

> >> And BTW a few bits of the latest development in the bugzilla ticket
> >> (https://bugzilla.kernel.org/show_bug.cgi?id=219609 ):
> >>
> >> * iommu=pt and amd_iommu=off seems to work around the problem (in
> >> addition to disabling the iommu in the BIOS setup).

iommu_pt calls iommu_set_default_passthrough, which sets
iommu_def_domain_type to IOMMU_DOMAIN_IDENTITY.  I.e. the hardware
IOMMu is left on, but treated as a 1:1 mapping by Linux.

amd_iommu=off sets amd_iommu_disabled, which calls disable_iommus,
which from a quick read disables the hardware IOMMU.

In either case we'll end up using dma-direct instead of dma-iommu.

> > 
> > That suggests the problem is related to the dma-iommu code, and
> > my strong suspect is the swiotlb bounce buffering for untrusted
> > device.  If you feel adventurous, can you try building a kernel
> > where dev_use_swiotlb() in drivers/iommu/dma-iommu.c is hacked
> > to always return false?
> 
> Tried that, did not help: I still get corrupted data.

.. which together with this implies that the problem only happens
when using the dma-iommu code (with or without swiotlb buffering
for unaligned / untrusted data), and does not happen with
dma-direct.

If we assume it also is related to the optimal dma size, which
the original report suggests, the values for that might be
interesting.  For dma-iommu this is:

	PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);

where IOVA_RANGE_CACHE_MAX_SIZE is 6, i.e.

	PAGE_SIZE << 5 or 131072 for x86_64.

for dma-direct it falls back to dma_max_mapping_size, which is
SIZE_MAX without swiotlb, or swiotlb_max_mapping_size, which
is a bit complicate due to minimum alignment, but in this case
should evaluate to: 258048, which is almost twice as big.

And all this unfortunately leaves me really confused.  If someone is
interested in playing around with at the risk of data corruption it would
be interesting to hack hardcoded values into dma_opt_mapping_size, e.g.
plug in the 131072 used by dma-iommu while using dma-direct with the
above iommu disable options.

