Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE50E6C5E3
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 00:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZaYz+ZQyV08Kd+vxMnRVSukoaQ0PcgoZ2oVFMzXPMrI=; b=SwgL78uWUFgoFjV9zc9X/7K7R6
	zUQ+1Z0B/caStbjQEhXlnz8d9tzNE7FiIh8xfB8W7ax40oSXiwoAwT8uD6jWyANTxNhofDrBKZyG6
	VuiRNHoSCOrX/ClTzlm1IOXl8u6zOqWg1qBaixgdnvF+pVUfJVk6b1kbk11ApKZFyELepPiBDxHWJ
	BtxCJtSAEMk2tC2CiVNoYSmz/K5zbf9+hDhiL24m6KuSb+ZF34uqwWc7BocCwDNAHsAE0qXptgDdR
	QM4QabekAngzJ6y8YerQcE59gry6Nuky82E7PBhGvX25sGHslNq0lk1r6xiXX/4co0KhihCtDhGV4
	1mCsNAQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIGrn-00000007pOi-3rr4;
	Tue, 03 Dec 2024 00:34:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIGqw-00000007pHH-3RIb
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 00:33:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5C23568BEB; Tue,  3 Dec 2024 01:33:12 +0100 (CET)
Date: Tue, 3 Dec 2024 01:33:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH 2/2] nvme-pci: use dma_alloc_noncontigous if possible
Message-ID: <20241203003312.GA6890@lst.de>
References: <20241101044016.405265-1-hch@lst.de> <20241101044016.405265-3-hch@lst.de> <20241202190541.GA2434798@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202190541.GA2434798@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_163322_999982_6268197C 
X-CRM114-Status: GOOD (  29.18  )
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

On Mon, Dec 02, 2024 at 09:05:41PM +0200, Leon Romanovsky wrote:
> On Fri, Nov 01, 2024 at 05:40:05AM +0100, Christoph Hellwig wrote:
> > Use dma_alloc_noncontigous to allocate a single IOVA-contigous segment
> > when backed by an IOMMU.  This allow to easily use bigger segments and
> > avoids running into segment limits if we can avoid it.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/nvme/host/pci.c | 58 +++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 53 insertions(+), 5 deletions(-)
> 
> <...>
> 
> > +static int nvme_alloc_host_mem_multi(struct nvme_dev *dev, u64 preferred,
> >  		u32 chunk_size)
> >  {
> >  	struct nvme_host_mem_buf_desc *descs;
> > @@ -2049,9 +2086,18 @@ static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
> >  	u64 hmminds = max_t(u32, dev->ctrl.hmminds * 4096, PAGE_SIZE * 2);
> >  	u64 chunk_size;
> >  
> > +	/*
> > +	 * If there is an IOMMU that can merge pages, try a virtually
> > +	 * non-contiguous allocation for a single segment first.
> > +	 */
> > +	if (!(PAGE_SIZE & dma_get_merge_boundary(dev->dev))) {
> > +		if (!nvme_alloc_host_mem_single(dev, preferred))
> > +			return 0;
> > +	}
> 
> We assume that the addition of the lines above are the root cause of the
> following panic during boot. It is happening when we are trying to allocate
> 61 MiB chunk.

We should not hit this path for dma-direct, but only dma-iommu that can
do discotigous allocations.  If we hit it with dma-direct I got my math
on the boundary check above wrong.  I'll try to figure out what is
wrong, but I'm actually in Japan for meetings, so things will not only
be delayed but also in a weird time zone.

> -       if (!(PAGE_SIZE & dma_get_merge_boundary(dev->dev))) {
> +       if (!(PAGE_SIZE & dma_get_merge_boundary(dev->dev)) && preferred < max_chunk) {

That would basically be a revert of the new funtionality..

