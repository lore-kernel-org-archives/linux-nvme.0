Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06762C8302D
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 14:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nMeHtIARNBSvKcrlVPDQ4mHoB5VzWY36zYgHE3yom1M=; b=VIFmF/lWE9OC4iKsVoizMfxwDU
	KXHZZ3fLHrMCBeNByXhzx6P+wOMBwhfTPsJbgZ6ZN4k9t4oyK2qvwmSn/Q20S40DoihQUCkkMga9Z
	HLaPN/qlAddfvC0shHJ6rDWG7g2BgSePI9tMomlcVe2AaObkUzFmpsrIKFkI/NhTpEGba3RHstjzF
	G/73iEEd3TzBT/EJDzlAxFjA4IdUd0FiFayQRSazNW0qqSSxfcIl/sCRUWFVv2NgZO3g05HjXdklb
	WMUOcyPozgZrD/3w5KYyD3FTHGGxhW9l3Gx5KkD0/Sv0m4AmrIRtNHAdSx12n31s7LJaSY/DsEJag
	2osV2F/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWF89-00000002Tqp-1xYc;
	Mon, 30 Jun 2025 14:05:09 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWF7r-00000002Tlb-1rab
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 14:04:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9E0BA613AA;
	Mon, 30 Jun 2025 14:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448F9C4CEEF;
	Mon, 30 Jun 2025 14:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751292289;
	bh=cb0NLHM8lRjNQjenrZx1Hlo+6uEazzfX5W/jp81norg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IJb/iF1nZaJDjtPV41XGWxVTD+Dremo/+sysNAIGmKXgcfNAP1l6RW0/1Rj6aLlfX
	 sbJ6/gKpKN8qHtucKsJc/zPL2ia7bFjDSSz39uCWFKR+R29IKziMDryWffaiP3dU1T
	 /KvXX8x4dGasmoIZSY2vl4tWa3E9h/iB2TdZY9t/k5nZJm3K5WJbcTB/ELH4szwwTZ
	 OF0tMuCmVDrcO3DJF5ddMk7OJ+0tgS+9HmG29Mxq+p2mubLx8OSA5dmpI4HPVGEA5X
	 vghXPCcQykuVSLfqdfNT09mm+HnT7M4TdmZ5sryYTVTUpGNYzCfxw92mGLk2Nw6DZT
	 x2WZ0nALszs2A==
Date: Mon, 30 Jun 2025 08:04:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: uring_cmd specific request_queue for SGLs
Message-ID: <aGKZf5gX7_JPe4-g@kbusch-mbp>
References: <20250624211444.2835077-1-kbusch@meta.com>
 <20250625060915.GB9391@lst.de>
 <aFxzXOZUFtt6hyPA@kbusch-mbp>
 <20250626051413.GC23248@lst.de>
 <aF1nUYSXvLE33osR@kbusch-mbp>
 <20250627072524.GA1329@lst.de>
 <aF66IGSMATG9-sLy@kbusch-mbp>
 <20250630060016.GA28775@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630060016.GA28775@lst.de>
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

On Mon, Jun 30, 2025 at 08:00:16AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 27, 2025 at 09:34:56AM -0600, Keith Busch wrote:
> > Back to this patch, I get that this uring_cmd path wouldn't be able to
> > use the more efficient coalesced mapping when the IOMMU is on, and
> > instead map each segment indiviually. I think that's still better than
> > the alternative, though.
> 
> My back on the envelope calculations (for 8 byte metadata chunks)
> suggests otherwise, but I never got around fully benchmarking it.
> If you do have a representation workload that you care about I'd love to
> see the numbers.

Metadata isn't actually the important part of this patch.

The workload just receives data from a iouring zero-copy network and
writes them out to disk using uring_cmd. The incoming data can have
various offsets, so it often sends an iovec with page gaps.

Currently the kernel provides a bounce buffer when there are page gaps.
That's obviously undesirable when the hardware is capable of handling
the original vector directly.

The options to avoid the copies are either:

  a. Force the application to split each iovec into a separate command

  b. Relax the kernel's limits to match the hardware's capabilities

This patch is trying to do "b".

