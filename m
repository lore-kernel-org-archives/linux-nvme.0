Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4250CC77B7F
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jun 2025 07:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iRMuW8N1jCKi3jw7/Qqp0ouVbUq9kvKNS0pzFK9kpJo=; b=xwNvOEEDDzi3DxNHM3YiPuCCTF
	SZxd7NRsXTMEsshSbgB5RAo/8rfbtpXUVz76wPQTow857OvETf4sG35AQAE0mSue2wiaetGwtYyiV
	UjZsW8BseZ3mRBoNhFzTMs13xUiL9ZO0Qy1h45SOn1q6T9DQ3IChY+NP40XDU9HPa6Ym2o6fG+Fvv
	vy5giL6UdqDucfqZX1TMTVLsBUDjWofhh+uMYoNObWurpn67wLUL/Sad/VlOhT3pPcr+1UU8HaKRe
	iG37n2RdUQ1bUcnKO/z4yaoUAY7IlQ0KrZP8Dftx76hUDG2itBcs4AaqqEwD1Fg71wj68KEU2x5tR
	VmtBiWEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV3gd-0000000Dqd3-2ytg;
	Fri, 27 Jun 2025 07:39:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV3Su-0000000DozJ-3ZBR
	for linux-nvme@lists.infradead.org;
	Fri, 27 Jun 2025 07:25:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 95CAB68AFE; Fri, 27 Jun 2025 09:25:24 +0200 (CEST)
Date: Fri, 27 Jun 2025 09:25:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: uring_cmd specific request_queue for SGLs
Message-ID: <20250627072524.GA1329@lst.de>
References: <20250624211444.2835077-1-kbusch@meta.com> <20250625060915.GB9391@lst.de> <aFxzXOZUFtt6hyPA@kbusch-mbp> <20250626051413.GC23248@lst.de> <aF1nUYSXvLE33osR@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF1nUYSXvLE33osR@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_002541_031245_E025722B 
X-CRM114-Status: GOOD (  21.23  )
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

On Thu, Jun 26, 2025 at 09:29:21AM -0600, Keith Busch wrote:
> > I can't really parse this.  Direct mapping means not using an IOMMU
> > mapping, either because there is none or because it is configured to
> > do an identity mapping.  In that case we'll never use the IOVA path.
> 
> Okay, maybe I'm confused. The code looks like it defaults to the direct
> mapping if it can't be coalesced.

Oh, you are referring to blk_dma_map_direct?  I guess that is a bit
misnamed, as it doesn't mean we're doing the dma-level concept of a
direct mapping, but anything that is not an iova-based coalesce
operation.

> What if the IOMMU granularity is 8k against nvme's 4k virt boundary?

Then we won't merge.  Note that most (maybe even all) relevant IOMMUs
support 4k mappings, including for system that have larger IOMMU page
sizes.

> We still need the IOMMU dma mappings in
> the direct mapping fallback, right? They should just appear as different
> dma segments.



> When it comes to integrity payloads, merged bio's are almost certainly
> not eligible to be coalesced in iova space since they're usually
> independently allocated in much smaller granularities, so again, I'd
> expect we'd get multiple integrity dma segments.

For the current user DMA that depends on how how user allocated it,
but unless they nicely chunk it up based on the IOMMIU page size: yes.

But when merging multiple bios with the block layer default integrity we
can get it now with the right max_sectors, and the same will
usually/always be true for the file system integrity work in progress.


