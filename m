Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF8DC77B7F
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jun 2025 05:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YGcw1Y3/hdu8Z6kJSg6FA5WdlaH3M+DTa0ZUgdcP+Xs=; b=k50vbBqX3MS970RGhT2Xg1MdqR
	JzC4ViNdGE50edJxZ1WFLIKnh90LLVVIKcBPxxt+B39gDTGnUHW2a9jU3r4ueEGD/AEwrnxedqZmi
	ByIwM85JD5JNiVM+p1Nni5phnTxtR+pc+58XL+hpzFL4C3ysRSJ4UjZPdJ6Ci0RSNTB8KEoT9P93y
	ui/DYIBkoXx2ONZTUF/3m7O/E/Imlmfz/Lqah9UmKsrbq1IUGPhf+acCp1wlgLcUMwX4/oBBBAyKJ
	vlZsEonZ0C9hZFS4FwJdmBTFAa3wXhONOvMRQJqq8kCP9fb3QFsGdM9WRZF6HCS8sA/CJxfEZI6Qp
	vNh7IYig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUewL-0000000Ad3r-0NDB;
	Thu, 26 Jun 2025 05:14:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUewI-0000000Ad2z-26g0
	for linux-nvme@lists.infradead.org;
	Thu, 26 Jun 2025 05:14:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A040368B05; Thu, 26 Jun 2025 07:14:13 +0200 (CEST)
Date: Thu, 26 Jun 2025 07:14:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: uring_cmd specific request_queue for SGLs
Message-ID: <20250626051413.GC23248@lst.de>
References: <20250624211444.2835077-1-kbusch@meta.com> <20250625060915.GB9391@lst.de> <aFxzXOZUFtt6hyPA@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFxzXOZUFtt6hyPA@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_221422_681014_70390E30 
X-CRM114-Status: GOOD (  29.44  )
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

On Wed, Jun 25, 2025 at 04:08:28PM -0600, Keith Busch wrote:
> If you send a readv/writev with a similar iovec to a O_DIRECT block
> device, then it will just get split on the gapped virt boundaries but it
> still uses it directly without bouncing. We can't split passthrough
> requests though, so it'd be preferable to use the iovec in a single
> command if the hardware supports it rather than bounce it.

True.

> > Note that this directly conflict with the new DMA API.  There we do
> > rely on the virt boundary to gurantee that the IOMMU path can always
> > coalesce the entire request into a single IOVA mapping.  We could still
> > do it for the direct mapping path, where it makes a difference, but
> > we really should do that everywhere, i.e. revist the default
> > sgl_threshold and see if we could reduce it to 2 * PAGE_SIZE or so
> > so that we'd only use PRPs for the simple path where we can trivially
> > do the virt_boundary check right in NVMe.
> 
> Sure, that sounds okay if you mean 2 * NVME_CTRL_PAGE_SIZE.
> 
> It looks straight forward to add merging while we iterate for the direct
> mapping result if it returns mergable iova's, but I think we'd have to
> commit to using SGL over PRP for everything but the simple case, and
> drop the PRP imposed virt boundary. The downside might be we'd lose that
> iova pre-allocation optimization (dma_iova_try_alloc) you have going on,
> but I'm not sure how important that is. Could the direct mapping get too
> fragmented to consistently produce contiguous iova's in this path?

I can't really parse this.  Direct mapping means not using an IOMMU
mapping, either because there is none or because it is configured to
do an identity mapping.  In that case we'll never use the IOVA path.

If an IOMMU is configured for dynamic IOMMU mappings we never use the
direct mapping.  In that case we'd have to do one IOMMU mapping per
segment with the IOVA mapping path that requires (IOMMU) page alignment,
which will be very expensive.

