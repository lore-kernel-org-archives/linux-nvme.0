Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE70C44515
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 15:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h47FluPB0Lx0sJMaFu92NXe4FEFI2mlygxYVFCWL/Rk=; b=MQqRlF9N5xCLe+3OkhnM7SQdtw
	BogomSD0HqBoiRNQ+d1StsPLccMFA/6lhTQXhGwKWXC70IDx6pzGSsVbVsaAalpvoQbHTNeULsM4J
	HNhenxYS+u92Wb0GxPXOIQ/RdeJ9vfwlNw6jsdjrwS/MBzCozDlisdxG2XsMHl6TENNscmW0BgObx
	sVNmVm7HM+aniul3zoovfy2P5ok2B19wl34R63GcBKfAinAzkmw8xW8WZo8NFOLa4fRmRMYIEDphN
	UkpuW20EIktqqbaDrneiecEeCfEHLzeF/AFwoa7AGgoZqH9zqDuaJyRjda9wkZLh8RVo3x8XSMyFf
	KQsu/zHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlpsb-00000007BF3-1qAf;
	Mon, 20 Jul 2026 15:26:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlpsa-00000007BEp-3M83
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 15:26:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 68A9840DF7;
	Mon, 20 Jul 2026 15:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826831F00A3A;
	Mon, 20 Jul 2026 15:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784561164;
	bh=h47FluPB0Lx0sJMaFu92NXe4FEFI2mlygxYVFCWL/Rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OEFVkMmL6h8M4mk+Idh+5zhL/PDrcgvHiEgwCwiDtetRFpYnjYpVotLg1jpFp0J9V
	 zo+iF9k1mRpZHOg0negcrk8gowQnjfWsg4a4WL2nRezFfBQow2WiJ00eTHSG7XPGCt
	 qLHsT2sUBOMWNuX+Km8Y7PMPPlzpZYi4MjeBXFFzLxcNG1JQtG/XwwPQu/y9flReQ/
	 YMPlFF7uxAwku9vaBPNELvqXbLjv4zlIX/0LUec+Wa/qAXi0G6eDGBdpbfqm/Go4pM
	 5lJwLyP0XcmqNGuyP+fG2J6/1Sw29oTDPR6672ZZEaowWMjkaB7BazTXs+msIKrH/R
	 nAiLlugcJ398A==
Date: Mon, 20 Jul 2026 09:25:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jun Zeng <jun1.zeng@intel.com>, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	andriy.shevchenko@intel.com, gang.cao@intel.com,
	jun.i.jin@intel.com, yong.hu@intel.com,
	Liang Fang <liang.a.fang@intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH v1 1/1] nvme-pci: adaptive interrupt coalescing
Message-ID: <al4-ByMMJj89q_8I@kbusch-mbp>
References: <20260715075703.15578-1-jun1.zeng@intel.com>
 <20260715075703.15578-2-jun1.zeng@intel.com>
 <allEmTmXCFosxIOr@kbusch-mbp>
 <20260720150539.GB17986@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720150539.GB17986@lst.de>
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

On Mon, Jul 20, 2026 at 05:05:39PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 16, 2026 at 02:52:41PM -0600, Keith Busch wrote:
> > On Wed, Jul 15, 2026 at 03:57:03PM +0800, Jun Zeng wrote:
> > > Add adaptive interrupt coalescing to improve IOPS for high-throughput
> > > workloads. Monitor IO pressure periodically and enable/disable coalescing
> > > automatically based on IOPS, queue depth, and inflight IO thresholds.
> > > This feature is enabled by default, can be controlled through debugfs
> > > variable during runtime.
> > 
> > Can't you do all this from user space? You'd maybe need the blk-mq
> > debugfs to get access to the individual hctx dispatch numbers, but maybe
> > that's okay?
> 
> Having these kinds of interfaces where we rely on a userspace daemon
> to be in sync with the kernel implementation are a mess, and really
> lock us out of future improvements in this area.

We can't stop someone from doing this today, though.
 
> > The atomic_long_inc where you placed it is especially harmful to polled
> > queues.
> 
> We really should be able to do this without any counters, as blk-mq keeps
> more than enough statistics.  And of course for polled queues nothing
> related to interrupt coalescing is actually need.
> 
> And we should take a page from the networking playbook and look into
> adaptively switching to polling under high load instead of just
> mitigating interrupts.  An important part of that is to move the CQ
> reaping from irq context to thread context.

Totally. I had a proposal from I think 7 years ago to converge nvme's
threaded IRQ handling: reap the first X entries from hard-irq context,
and if there's more, return IRQ_WAKE_THREAD to poll the rest and future
completions with that queue's interrupt masked (this is one scenario
where NVMe's MSI masking is better than MSI-x, but it's not a big deal).
I can't find the patch though, so I guess it was in the gap that
infradead lost.

Anyway, I think combine that concept with the isolcpus proposal and you
can have full control over which CPUs can dispatch new IO without being
interrupted from CPUs reaping completions. Then we shouldn't need the
spec's coalescing feature.

> But modulo all these caveats adaptive interrupt coalescing / 
> moderation is something we absolute need right now and even more so
> going foward.
> 
> Note that a few month ago there also was as an interesting patchset
> that does global interrupt moderation at the IRQ controller level.
> I don't remember what happened to it and can't find a link to it,
> but adding the interrupt maintainer in case he remembers.

