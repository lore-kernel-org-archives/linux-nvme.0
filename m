Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6D9E7719A
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 00:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wLtv1wVQtSzP27/pcRbCdalCrrvua4lZefq09H7J/Bs=; b=3CtqsAqY5VkSbgJ6kRvyzv/CJe
	BPVg5XUpKJp3P/e/bLlz1QsYzEBZTyNBdHADBmFSuVGzHgtp3GIYJbRAjbSz0dopgDbQa39g8dBL+
	vbczLHjAKla0ktXPqcp/F+luQFguCew3ak3QYrZgnOaLXCUcqlKQscLfHoluNemBCUGYK0mPTs88b
	svgfvsQ+iOcL3mDgSK/mepmUXj93qBRMkNeymme0q3C4mMjBkwxoY2fMdIisuLDkcai4pHg9xyugL
	lET5XiCP552WRR/su7TNsWMK5P+e+hgpeQnW6i52RS1QZbwmsY563bQ46uU8Ya3xtf4/++aj++Rvr
	GR+kW7Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tW2bU-0000000Dc1T-0FGU;
	Fri, 10 Jan 2025 00:10:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tW2bQ-0000000Dc0V-3NgN
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 00:10:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B30DE5C057D;
	Fri, 10 Jan 2025 00:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CAFC4CED2;
	Fri, 10 Jan 2025 00:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736467815;
	bh=Y0Ev5vFJ6GI2V8OhWS1fMtIGvX6uJFWfskQrPfOqLoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8ddMMcOHDytrw8LpPlwyuzfeUNjRam3nGoUqXYlTGBsUDoSSmIRSIKaz3mn58tjf
	 imZ4xGWe7H/vJjfs9kL/evXzb0mklqLXTfHAj0LP3hNr6X5vDnU9ZyzFAPjckuwYev
	 shlD+oX6cugaJtXxYAoW4Gw9tyvRiSCpyJ3+TMw7kW9QXX5Rb/b+qqc5+e/pn2H+K5
	 osPCMoa4NbeLa39ylst2LNq9GsPnonbntrQIUYvq9Lqb0urIGm8XkNEXECOl1kAaYw
	 1FcQzqemS48nnOLyAiJtZqs5TzwmGRYlFNOc18VRtx080WmphedESbP6x6zh7u08TH
	 oBIKIhiSvYgpw==
Date: Thu, 9 Jan 2025 17:10:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Adrian Huang <ahuang12@lenovo.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX
Message-ID: <Z4BlZCWzu3OV3V2U@kbusch-mbp>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
 <Z36UsE5dj6j5HhkX@kbusch-mbp>
 <20250109082849.GC20724@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109082849.GC20724@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_161016_888683_0BECAE25 
X-CRM114-Status: GOOD (  19.05  )
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

On Thu, Jan 09, 2025 at 09:28:49AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 08, 2025 at 08:07:28AM -0700, Keith Busch wrote:
> > It should always be okay to do smaller transfers as long as everything
> > stays aligned the logical block size. I'm guessing the dma opt change
> > has exposed some other flaw in the nvme controller. For example, two
> > consecutive smaller writes are hitting some controller side caching bug
> > that a single larger trasnfer would have handled correctly. The host
> > could have sent such a sequence even without the patch reverted, but
> > happens to not be doing that in this particular test.
> 
> Yes.  This somehow reminds of the bug with an Intel SSD that got
> really upset with quickly following writes to different LBAs inside the
> same indirection unit.

Good old https://bugzilla.redhat.com/show_bug.cgi?id=1402533 ...

> But as the new smaller size is nicely aligned
> that seems unlikely.  Maybe the higher number of commands simply overloads
> the buggy firmware?

Maybe the higher size creates different splits that better straddle some
unreported internal boundary we don't know about. This all just points
to some probabilisitic scenario that somehow happens more often with
a lower transfer limit.

The bugzilla reports disabling VWC makes the problem go away. That may
be a timing thing or a caching thing, but suggests a kernel bug is less
likely (yay!?); not easy to tell so far. It's just concerning multiple
vendor devices are reporting a similiar observation, so maybe these are
not even the same root problem.

