Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF64C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 18:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BApKWh98f8P6jTcZKKxbTt2xnuQNFrkhYUwkGsfJr3g=; b=z0zaNIzR5UMM5Q1Rdbnp8I8D9O
	bxNB1v+H/Z4Rd54TK9kUyUGHmvef8UR1R15RKBoE64g35fIgnIBDM/OGoAtHUd5qWiR0AkDqBOVno
	O0a0G4MRWIFQeKDbcEj17GVupsYWxacP1jAAFn9UcPNiMKImV8VZd3ITLHY0Q/lkZu25oXxHiieLU
	E/5IcWkLLqYhWeopnEOYaqSs2p6K+L5yQdcXQ8OStPsPYAPmI3gg7Vaaz6f8Kg6rcXp1rlayOU9yG
	jA7M27nIj4bTCQxE5y2yUr0n3MP/pE9wUQIqB/ZzqUBjHJFONRV7mPJZO541SpfsWsk/1X+a1EJi3
	IBqvRtag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whtJk-00000003DKl-2itf;
	Thu, 09 Jul 2026 18:17:48 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whtJj-00000003DKU-2eqf
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 18:17:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F3B9541918;
	Thu,  9 Jul 2026 18:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818C81F000E9;
	Thu,  9 Jul 2026 18:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783621066;
	bh=BApKWh98f8P6jTcZKKxbTt2xnuQNFrkhYUwkGsfJr3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IZDqFWGeNzg2/HaC28FeDvJ6hd+C+3+3gv+/EfvJTv9+yYPMc0lObxWcRVKXjfmR1
	 uBVvYcIpM8qFcBkn8kQ3r6AQxyYgSqWtxAcv3vjFptcOmLoORW8sz1tGa1El8lJCrM
	 M5gZeN2jV5bWgQcykmWmaGAtWhTjeLwBfWBF9C7BX/7MLnjk8/IHWu+wl0VtNI6w3f
	 GVwGkVGhibsaLvOZXLoOLo2YGcRbCntSHbTDVnR2GOoNQ9B6hFMEnfDnim0Dv9MfuE
	 sq2JkoB2AtkFwo0fwmAk/yKgqpnAhChCyqdIcQbTb3MacAln6sJJrfwAFLhq9M/Q9F
	 g88XfV3WTL8zw==
Date: Thu, 9 Jul 2026 12:17:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao S <coshi036@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH] nvme: bound the freeze drain in passthrough commands
Message-ID: <ak_lyGi_2n9Qeikw@kbusch-mbp>
References: <20260527055923.456769-1-coshi036@gmail.com>
 <ahcR2vy8k2FZAp9D@kbusch-mbp>
 <CACd_6n2vT8RiWGL6g2aasEgzpdnOFz5NnwF42vwzO0gEd=cu1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACd_6n2vT8RiWGL6g2aasEgzpdnOFz5NnwF42vwzO0gEd=cu1g@mail.gmail.com>
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

On Tue, Jun 23, 2026 at 06:28:49PM -0400, Chao S wrote:
> Timeout fires, abort is accepted, reset starts, reset reaches the
> "IO queues lost" branch (drivers/nvme/host/pci.c).  Then nvme_reset_work
> itself blocks at
> 
>   nvme_mark_namespaces_dead -> blk_mark_disk_dead -> blk_report_disk_dead
>     -> bdev_mark_dead(bdev, true) -> sync_blockdev -> folio_wait_writeback
>
> i.e. the unconditional sync_blockdev in bdev_mark_dead's bare-bdev
> else-branch (block/bdev.c) is itself waiting on the writeback that the
> reset was supposed to drain.

But sync_blockdev is *not* unconditional. It's conditional on this not
being a surprise removal, and blk_mark_disk_dead() is considered a
surprise, so I am not sure you've identified the right sequence.
 
> So in this report, the IO timeout did its job, but the reset that the
> timeout kicks off cannot complete, and nvme_passthru_start (which is
> already in nvme_wait_freeze at this point) has no way to back out.

I guess what may have happened is that the timeout handler requeued the
IO  on a quiesced queue so it does reach frozen state. Just move the
unquiesce to before the call to nvme_mark_namespaces_dead(). But I still
don't think it should be needed because nvme_mark_namespaces_dead()
shouldn't block.

> 1. The reset path has several ways to fail to drain in
>    nvme_io_timeout: abort can be rejected, the admin tag for abort
>    can be unavailable, the controller can be wedged before abort
>    lands, an in-progress reset can outlast nvme_io_timeout, or (as
>    here) reset itself can block.  Each leaves nvme_passthru_start
>    waiting forever, holding ctrl->scan_lock + subsys->lock + every
>    namespace's freeze ref, which then fans out on bd_disk->open_mutex
>    via any concurrent bdev_open/release or BLKRRPART.

No, that's not what happens.

If abort fails, then the command times out a 2nd time, then we escalate
to reset.

If we can't get an abort tag, then that means an abort is in progress.
If it doesn't completely timely, then we escalate to reset.

> 2. The same pattern is already established in the tree.  pci shutdown
>    (drivers/nvme/host/pci.c), nvme-tcp reset, nvme-rdma reset,
>    nvme-apple, and Daniel Wagner's 2021 nvme-fc series
>    (20210818120530.130501-1-dwagner@suse.de) all use
>    nvme_wait_freeze_timeout(NVME_IO_TIMEOUT) for exactly this reason.
>    nvme_passthru_start is the only userspace-reachable caller still
>    on the unbounded variant.

Those are for entirely different cases where we're in the last line of
recovery and have to guarantee forward progress.

