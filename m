Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF44C4452A
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 15:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6R8eBTLkrETgyOEttNTrUn5THk6zYfHWY39DWocm7bQ=; b=Jnj/wWrVNMHo0abYVdmKbrER6y
	tGs46MO24UAVbwVJHrWFNTWPhOK1OcZGdSOkT3cBNXgTL0qNDImTvDCzYwumxgzjM6PNZJ3lsY+m+
	TifJYbdIJG8vSr2Md0IG/yYUA/4JArXn7jt16Fgh9iGGlsvhdvGX7bmUzeAN7jX3hGYcR6Dafa7Gm
	wR7Y6PEr+kDAY26JvZOoyuT7yQhnhZZcqB8O2GBHuajKIzH56C63zPmKpEHB3DlteQc/6cHRLDg4A
	z7eSGpM0gbnpNf3osO4jR1PLQ8WLXojoHigyUEJlCefOpzKHKxJK3Gd5D7W9MoJwG/vTuUd2y+xsA
	PSR1zwaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlpYw-000000074tt-0IBY;
	Mon, 20 Jul 2026 15:05:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlpYt-000000074t8-3MbW
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 15:05:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8911968C4E; Mon, 20 Jul 2026 17:05:39 +0200 (CEST)
Date: Mon, 20 Jul 2026 17:05:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Jun Zeng <jun1.zeng@intel.com>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
	gang.cao@intel.com, jun.i.jin@intel.com, yong.hu@intel.com,
	Liang Fang <liang.a.fang@intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH v1 1/1] nvme-pci: adaptive interrupt coalescing
Message-ID: <20260720150539.GB17986@lst.de>
References: <20260715075703.15578-1-jun1.zeng@intel.com> <20260715075703.15578-2-jun1.zeng@intel.com> <allEmTmXCFosxIOr@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <allEmTmXCFosxIOr@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_080543_987683_A87717E9 
X-CRM114-Status: GOOD (  19.12  )
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

On Thu, Jul 16, 2026 at 02:52:41PM -0600, Keith Busch wrote:
> On Wed, Jul 15, 2026 at 03:57:03PM +0800, Jun Zeng wrote:
> > Add adaptive interrupt coalescing to improve IOPS for high-throughput
> > workloads. Monitor IO pressure periodically and enable/disable coalescing
> > automatically based on IOPS, queue depth, and inflight IO thresholds.
> > This feature is enabled by default, can be controlled through debugfs
> > variable during runtime.
> 
> Can't you do all this from user space? You'd maybe need the blk-mq
> debugfs to get access to the individual hctx dispatch numbers, but maybe
> that's okay?

Having these kinds of interfaces where we rely on a userspace daemon
to be in sync with the kernel implementation are a mess, and really
lock us out of future improvements in this area.

> The atomic_long_inc where you placed it is especially harmful to polled
> queues.

We really should be able to do this without any counters, as blk-mq keeps
more than enough statistics.  And of course for polled queues nothing
related to interrupt coalescing is actually need.

And we should take a page from the networking playbook and look into
adaptively switching to polling under high load instead of just
mitigating interrupts.  An important part of that is to move the CQ
reaping from irq context to thread context.

But modulo all these caveats adaptive interrupt coalescing / 
moderation is something we absolute need right now and even more so
going foward.

Note that a few month ago there also was as an interesting patchset
that does global interrupt moderation at the IRQ controller level.
I don't remember what happened to it and can't find a link to it,
but adding the interrupt maintainer in case he remembers.

