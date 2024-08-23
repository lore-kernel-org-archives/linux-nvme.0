Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B727C531DC
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 15:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PwPsAQt+Jv+gjry7cR7kuuKKSaGoJXMh6JrxMG8jXS0=; b=Q4kssAD1BAF/cCDQK0s0gRfpmi
	Ymp2R+PuyOVzUmwL4L+ndkqdECoCuoq4LXHlW4FFya9dRvmrbhVWGxJVY2BenfF77UyNE7tLzh6Mh
	ui1z8O5RFvexrg7NhOrSyiwUo/z8Wx/nic+skviUKksPW+AUGRUAmCARAb0bw1Srj3uXJJrA7/nC7
	YqjezPk8kLRITlCHBAaYLpSaxN2yhHxB5+5cwRwLOAe0fsof9UBDyqtZSQSUTxqPaa4vSdp5QWJPg
	U1cIe19nvnwQrukq6jAv2SIdfkZtTXq6Ia3WPGd/6KEzCrpksBWprjmWZrLiMJP2uDhtX7vcMjgVC
	GWEBBAOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shWZo-0000000HP4B-3OAQ;
	Fri, 23 Aug 2024 15:51:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shWZd-0000000HP21-3FK6
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 15:51:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0199560ED3;
	Fri, 23 Aug 2024 15:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F746C32786;
	Fri, 23 Aug 2024 15:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724428296;
	bh=dQuCzkYHaln+embwFMxiEp3sanc8aZRGEa31HMKiSs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kzzbb4TJZjd3qpqUZLQoRPEDMHtlfLRr3+NP6Jiz5cdVs1UZx11Bs1vkprImDuctb
	 hlvQ2K7lNTiv1huPRyC/Fhtjp+lB66lXnIJaZIM8kPKxfL8vGi5kq+7LoxB0cgLqSW
	 /Q7gENlxZpyocnFMeISVnIQSltZZCTlQRFtSJ3mJOW9F6q9gR/ebufiDM1E5EixqyX
	 dLZAlBGhjNLX73z7PAva0f5YMVHXhxTy8GpjvvVE3cdRQbyWMqXrI7GyBeYuiZNqw+
	 63moS8GAO4JIudeZRdI3uXKjwDte0EPZh44+CPnnEZMxpYOqv0VB6SWl99U/VhkYfo
	 7WpCx6wHVGpFA==
Date: Fri, 23 Aug 2024 17:51:32 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Martin Wilck <martin.wilck@suse.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: core: freeze multipath queue early in
 nvme_update_ns_info()
Message-ID: <ZsiwBOCVqRGfEegm@ryzen.lan>
References: <20240822201413.112268-1-mwilck@suse.com>
 <ZsiQ4yCji0PexMQ-@ryzen.lan>
 <5476d3dc188caea1fa0e7cdedcdc07f58b4ec643.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5476d3dc188caea1fa0e7cdedcdc07f58b4ec643.camel@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_085137_976355_9DC96D19 
X-CRM114-Status: GOOD (  32.55  )
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

On Fri, Aug 23, 2024 at 05:26:56PM +0200, Martin Wilck wrote:
> On Fri, 2024-08-23 at 15:38 +0200, Niklas Cassel wrote:
> > On Thu, Aug 22, 2024 at 10:14:13PM +0200, Martin Wilck wrote:
> > > For multipath devices, nvme_update_ns_info() needs to freeze both
> > > the queue of the path and the queue of the multipath device. For
> > > both operations, it waits for one RCU grace period to pass, ~25ms
> > > on my test system. By calling blk_freeze_queue_start() for the
> > > multipath queue early, we avoid waiting twice; tests using ftrace
> > > have shown that the second blk_mq_freeze_queue_wait() call finishes
> > > in just a few microseconds. The path queue is unfrozen before
> > > calling blk_mq_freeze_queue_wait() on the multipath queue, so that
> > > possibly outstanding IO in the multipath queue can be flushed.
> > > 
> > > I tested this using the "controller rescan under I/O load" test
> > > I submitted recently [1].
> > > 
> > > [1]
> > > https://lore.kernel.org/linux-nvme/20240822193814.106111-3-mwilck@suse.com/T/#u
> > > 
> > > Signed-off-by: Martin Wilck <mwilck@suse.com>
> > > ---
> > >  drivers/nvme/host/core.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index 33fa01c599ad..e2454398c660 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -2217,6 +2217,9 @@ static int nvme_update_ns_info(struct nvme_ns
> > > *ns, struct nvme_ns_info *info)
> > >  	bool unsupported = false;
> > >  	int ret;
> > >  
> > > +	if (nvme_ns_head_multipath(ns->head))
> > > +		blk_freeze_queue_start(ns->head->disk->queue);
> > > +
> > 
> > From someone reading this code, it looks quite similar to
> > nvme_mpath_start_freeze().
> 
> That function takes a struct nvme_subsystem as argument, and walks over
> all namespaces in that subsystem, whereas here we're just acting on a
> single namespace.
> 
> > Perhaps create a new helper, with proper kdoc, and possibly also add
> > kdoc to
> > nvme_mpath_start_freeze(), so that a user can easily tell (from the
> > kdoc)
> > when to use which function.
> 
> What's the benefit of introducing such a trivial helper, used only in a
> single place of the code?

To make nvme_update_ns_info() easier to read, and to keep the existing code
style of calling nvme_mpath_*() functions unconditionally.

Sure, with my suggestion you would need a mpath_freeze() and mpath_unfreeze()
helper.

But if you add a helper that simply does:
if (nvme_ns_head_multipath(ns->head))
	blk_freeze_queue_start(ns->head->disk->queue);

nvme_update_ns_info() could call the helper unconditionally,
just like how e.g. nvme_passthru_start() calls nvme_mpath_start_freeze()
unconditionally for both multipath and non-multipath NS heads:
https://github.com/torvalds/linux/blob/v6.11-rc4/drivers/nvme/host/core.c#L1205

(And how core.c calls many other nvme_mpath_*() functions unconditionally.)

> Thanks for the suggestion, but I'd like to see other maintainers'
> opinions about this.

Of course, a suggestion is just a suggestion :)


Kind regards,
Niklas

