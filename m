Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626ACC7EE30
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jun 2025 16:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H2BHNquuxPzYxdQRWCXmEYYBzeVnffmFBvPy29h981Q=; b=h2w2+zyb/K0RYQracBDx7qGpka
	NrNK26pqZjhsEpVmgzuixRgbeybn1ZDVX1fhagj8EaLP5Key9F7BWQgYEW2yACQeugn5HhC3m/nRL
	xakUxAKY5PY1k+WjspmMDak/13pN63cGqn+P7SoFPBvb2YQHKrkcUFbI9OwMRcUFZqtFwBaNezXUQ
	TqWpRR8KffI+IbbuK4mTuBAoo77KRf5o7UnA55t7Go8wm8jkm81k3Pv8MD9M66kPHlxMDRXYp6MoA
	uf4qOS4LpiSkD1D48dzcIk+yB09OLEhdu7+JeOJP1pWHC1P9MHmXzgobHDcaEfKKUMG+zDMrzlH97
	OomgWJkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUpFt-0000000CEeE-3QVy;
	Thu, 26 Jun 2025 16:15:17 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUoXU-0000000C7K9-2fBk
	for linux-nvme@lists.infradead.org;
	Thu, 26 Jun 2025 15:29:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BFBCA613A9;
	Thu, 26 Jun 2025 15:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D598C4CEEB;
	Thu, 26 Jun 2025 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750951763;
	bh=ElEOJA+GpbmROzW8/am8i24XqYdH7x06DjdDYK4lklo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAAuUgotkhEkgyE3iL+YR3cZVnS4NYG5YvOc4YVUcb6Kv4SbiORTcO3jFJQ1eQafs
	 LPnLzORfTqy/i57XqtX0VHC+aa0dUIFpmTCfkYdZ6iSmUDcUxv1PbNHP7Oeks2jRX5
	 UVcy8IeMIZX+bkdg5wKwGTUgsKuem4AFSo5tr5Bdd0VbvxEhnItvrhBEWVQ6sW+x/Q
	 g1Q5Ft9yL/9Fhk+kpzQMhGf+e4k/zSqXUx2b4unmBHdAwb6kW5utkHiNA8jGRvs96/
	 9KqewAut9M2PSRMNem3I64MIp/6HdYFY30Fi+1m85EOU7Ed9HX3YvMX7ieishrWnx8
	 aBSQNCbbH4Mmg==
Date: Thu, 26 Jun 2025 09:29:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: uring_cmd specific request_queue for SGLs
Message-ID: <aF1nUYSXvLE33osR@kbusch-mbp>
References: <20250624211444.2835077-1-kbusch@meta.com>
 <20250625060915.GB9391@lst.de>
 <aFxzXOZUFtt6hyPA@kbusch-mbp>
 <20250626051413.GC23248@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626051413.GC23248@lst.de>
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

On Thu, Jun 26, 2025 at 07:14:13AM +0200, Christoph Hellwig wrote:
> On Wed, Jun 25, 2025 at 04:08:28PM -0600, Keith Busch wrote:
> > 
> > It looks straight forward to add merging while we iterate for the direct
> > mapping result if it returns mergable iova's, but I think we'd have to
> > commit to using SGL over PRP for everything but the simple case, and
> > drop the PRP imposed virt boundary. The downside might be we'd lose that
> > iova pre-allocation optimization (dma_iova_try_alloc) you have going on,
> > but I'm not sure how important that is. Could the direct mapping get too
> > fragmented to consistently produce contiguous iova's in this path?
> 
> I can't really parse this.  Direct mapping means not using an IOMMU
> mapping, either because there is none or because it is configured to
> do an identity mapping.  In that case we'll never use the IOVA path.

Okay, maybe I'm confused. The code looks like it defaults to the direct
mapping if it can't be coalesced. What if the IOMMU granularity is 8k
against nvme's 4k virt boundary? We still need the IOMMU dma mappings in
the direct mapping fallback, right? They should just appear as different
dma segments.

When it comes to integrity payloads, merged bio's are almost certainly
not eligible to be coalesced in iova space since they're usually
independently allocated in much smaller granularities, so again, I'd
expect we'd get multiple integrity dma segments.
 
> If an IOMMU is configured for dynamic IOMMU mappings we never use the
> direct mapping.  In that case we'd have to do one IOMMU mapping per
> segment with the IOVA mapping path that requires (IOMMU) page alignment,
> which will be very expensive.

