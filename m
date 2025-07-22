Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32B3C83F1A
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jul 2025 05:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kry8fcora5aaZe57efVkCvytS5S90yVJ9IiGZOOnjk4=; b=rkmq9Ge8debzEvlWdvzMz3fBDg
	JoTnD01d2D7821+gKqdO5zLOCWfjCcfdEJ2IUuLU/oGW3WIG04kyclMJbaxpYfszT16qGmKZJibM9
	zKgU4xUv7UBffF/5LIGkU1xjW/jb4cmBE65DBg6bEQH27ibY+iDdqUYd+H4UWFb8+YfdX/c7GzHVq
	byWpSrwbJADoG22tNVsogSCfwii9RR4LeByEL/6hybMK7srmvMWT6TbkHZ6my8EotQd5jDrNWUTNd
	R7xBpReJTWPbam0EW109j3PjKrK+pXsseRAAdRRDF2orCPkYyCeaehE5oVAPRiffP788HPmhHLgB6
	r2W4CagQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue60H-00000001NRv-3S2g;
	Tue, 22 Jul 2025 05:57:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue5wf-00000001N2h-1WCX
	for linux-nvme@lists.infradead.org;
	Tue, 22 Jul 2025 05:53:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9AC0768AA6; Tue, 22 Jul 2025 07:53:39 +0200 (CEST)
Date: Tue, 22 Jul 2025 07:53:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, leonro@nvidia.com
Subject: Re: [PATCHv2 1/7] blk-mq-dma: move the bio and bvec_iter to
 blk_dma_iter
Message-ID: <20250722055339.GB13634@lst.de>
References: <20250720184040.2402790-1-kbusch@meta.com> <20250720184040.2402790-2-kbusch@meta.com> <20250721074223.GF32034@lst.de> <aH74XluC0BnerBaQ@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH74XluC0BnerBaQ@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_225345_681209_40CAD0B2 
X-CRM114-Status: GOOD (  22.43  )
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

On Mon, Jul 21, 2025 at 08:33:02PM -0600, Keith Busch wrote:
> On Mon, Jul 21, 2025 at 09:42:23AM +0200, Christoph Hellwig wrote:
> > On Sun, Jul 20, 2025 at 11:40:34AM -0700, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > The req_iterator just happens to have a similar fields to what the dma
> > > iterator needs, but we're not necessarily iterating a bio_vec here. Have
> > > the dma iterator define its private fields directly. It also helps to
> > > remove eyesores like "iter->iter.iter".
> > 
> > Going back to this after looking at the later patches.  The level
> > for which this iter exists is only called blk_map_* as there is
> > nothing dma specific about, just mapping to physical addresses.
> > 
> > So maybe call it blk_map_iter instead?
> 
> But the structure yields "dma_addr_t" type values to the consumer.
> Whether those are physical addresses or remapped io virtual addresses,
> they're still used for direct memory access, so I think the name as-is
> is a pretty good fit.

There's two layers:

The lower layer implemented by blk_map_iter_next just yields a phys_vec.

The upper layer built on top does the dma mapping in case of the new
blk_rq_dma_map_iter_start / blk_rq_dma_map_iter_next API.  But in case of
the old __blk_rq_map_sg API it doesn't even directly do the DMA mapping
yet.  And some drivers at least historically used the blk_map_sg without
then doing a DMA mapping, either for MMIO or platform specific things
using physical address.  My hope was to eventually migrate them to use
blk_map_iter_next.

