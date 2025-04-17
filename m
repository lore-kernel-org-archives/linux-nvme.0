Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391FFC369CA
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 18:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ltLABshe6Cx1zIeke3836k6YTZN5Lnph02kqFueeWTg=; b=omhzdmrP94MngvqxABEIYiqA/+
	9wdFHWpqUtGbS5wQeCmonnr7JH3f4lZGZOOY+BUceWKGHAmUGAeJscxNYYDufSW56zcMFsS3EMDbm
	rn2Pnql3hS73a6KSaiQy1idX/b1lBSzXFNhhYSXPq5s1wc5vV7At2S9qpKQ6OuGpXwWzfMPWvVckd
	QVnagB4yyP6AfubWx+WQ3zVRIa1+1QsD/1qmjunXN6Y/t19HaEQnwWsVtF9zR6hWjeL8ILaU35wNP
	WXqRGjWngNsKlxXqV4c+okLlrFBONKpSQV5t5qvhNLaJM8J9GTI9iJ5xy/kqdojMYAORJiID+In56
	dxfalzBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5TXt-0000000Dwy6-1z90;
	Thu, 17 Apr 2025 18:01:05 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5T58-0000000DrUQ-2dYM
	for linux-nvme@lists.infradead.org;
	Thu, 17 Apr 2025 17:31:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A9E8C68455;
	Thu, 17 Apr 2025 17:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464BFC4CEE4;
	Thu, 17 Apr 2025 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744911081;
	bh=ltLABshe6Cx1zIeke3836k6YTZN5Lnph02kqFueeWTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=os8FKci9a3vMaktZEEMtcme4M6GBgCNEF8Qy7nSOpDNghPlGRhSCdH74O7fxXTDTa
	 2jaXZM9iux23R3/dSyJGKojqr54haZ7RzG2kjnqushBGPJeIXeaZgcpzP5LhrypGoq
	 XUPl0fApFD9bgkF+JVhd8MvQm93eW9WDlcDp7HUi3PO9sTetYV/wZmO7sutPcuvaz4
	 zl1L/J/iQhEBrhnidoAG5oO2d7Z0cXrxtNN8eW3ueZzhipfMw/w1ZHyyBWd47h1YCe
	 ETQOgEAbUzE4/rqytQFlZuzrqFEKVM6hWKcr5MFxWJugbRUScjd2G/ED3FVmMwi8KH
	 cR9MC9OwZxkzg==
Date: Thu, 17 Apr 2025 11:31:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: DMA pool lock contention
Message-ID: <aAE65sPWe45dVaxe@kbusch-mbp.dhcp.thefacebook.com>
References: <CADUfDZqa=OOTtTTznXRDmBQo1WrFcDw1hBA7XwM7hzJ-hpckcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUfDZqa=OOTtTTznXRDmBQo1WrFcDw1hBA7XwM7hzJ-hpckcA@mail.gmail.com>
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

On Thu, Apr 17, 2025 at 10:06:11AM -0700, Caleb Sander Mateos wrote:
> Hi Linux NVMe folks,
> On a 32 KB NVMe passthru read workload, we see 2.4% of CPU time is
> spent in _raw_spin_lock_irqsave called from dma_pool_alloc and
> dma_pool_free. It looks like each NVMe command with 32 KB of data
> allocates a PRP list from the per-nvme_dev prp_small_pool. And every
> call to dma_pool_alloc/dma_pool_free takes the dma_pool's lock. Since
> the workload submits commands to the same NVMe devices from many CPUs,
> it's not surprising that these global spinlocks are a significant
> source of contention. Is there anything that can be done to reduce
> this bottleneck? Would it be possible to give each nvme_queue its own
> dma_pool?

That's a bit unfortunate to hear. The locked section to alloc and free
from the dma_pool used to be much more costly than what it is now. The
driver is still using it under a shared lock here at the end of the day,
though.

It's possible to give each queue their own pool, but there could be
thousands of queues in a system, so could get pretty resource intensive.
Maybe we just set some arbitrary max amount of pools and divvy them up
among the CPUs.

