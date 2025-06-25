Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A24C77B7C
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 06:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X6Ef0O3gYrMk/P6td9PtDKZFCO3stW/ImJ+YuSe7GPc=; b=jzvTi9jXBdOxLPLH1uchpDJ703
	5SnI0nUelJO8BKMnigKxZ+pDO5RjYLtuAUv1qhkdVRCHqPqcBHwOpDKHEcni+saF7mDlu9cDW+2Uq
	WXMofqiP1AYRTnomBwtRKL7lOEG7unYx4Z6L0nhA6FuQ7ujqJxiEwNmtSFIHgB1XjeIDogVQE9dmh
	Ej66y/9utKGKOoOELP5EV3RSF/StAAuLTPtJTm4qD30uu33rcvnr7u1KzlppkdF6HHMOR9oe6izcI
	BzbtEl4OVWwQmP3nniVlvBQj0wzHc05mCJdzGbpGe8XCZgN105fbzF23n2OL9pstCdsNBGBMa0mlD
	TKgPLQKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUJNn-00000007dQu-3I2a;
	Wed, 25 Jun 2025 06:13:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUJJw-00000007d7u-359L
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 06:09:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 06E76227A88; Wed, 25 Jun 2025 08:09:16 +0200 (CEST)
Date: Wed, 25 Jun 2025 08:09:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: uring_cmd specific request_queue for SGLs
Message-ID: <20250625060915.GB9391@lst.de>
References: <20250624211444.2835077-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624211444.2835077-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_230920_912990_C9359438 
X-CRM114-Status: GOOD (  20.48  )
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

On Tue, Jun 24, 2025 at 02:14:44PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> User space passthrough IO commands are committed to using the SGL
> transfer types if the device supports it. The virt_boundary_mask is a
> PRP specific constraint, and this limit causes kernel bounce buffers to
> be used when a user vector could have been handled directly. Avoiding
> unnecessary copies is important for uring_cmd usage as this is a high
> performance interface.

Not really more high performance than the normal I/O path.

> For devices that support SGL, create a new request_queue that drops the
> virt_boundary_mask so that vectored user requests can be used with
> zero-copy performance. Normal read/write will still use the old boundary
> mask, as we can't be sure if forcing all IO to use SGL over PRP won't
> cause unexpected regressions for some devices.

Note that this directly conflict with the new DMA API.  There we do
rely on the virt boundary to gurantee that the IOMMU path can always
coalesce the entire request into a single IOVA mapping.  We could still
do it for the direct mapping path, where it makes a difference, but
we really should do that everywhere, i.e. revist the default
sgl_threshold and see if we could reduce it to 2 * PAGE_SIZE or so
so that we'd only use PRPs for the simple path where we can trivially
do the virt_boundary check right in NVMe.

