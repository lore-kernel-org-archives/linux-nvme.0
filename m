Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4DEC5DF93
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 14:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RhTaW9/NmoyAYVT4VQizYgX9sdot2itK/I65qUFWNe0=; b=fLGgPfVbbSM0JAlbC25/9rEzpr
	h7el7pQXcIbZWWHAT7y25tOJFTGlky4bQCtwTbRoo+kcM7o73dQP9hnTYsOcYgi709rtAPyrTRLg9
	RW/fZK+JkjO4fWrbq32qw1oyCbdg4f1pVQcj78SVPFPjATglhdjdCdCnhYtiZmNwIETN/DNOrb+24
	2+Sxu3fePAt8DMtqieXkCumxy+89qkmgD8qvCyV+daf8JOf22UdKSdiwLtxmIB96pMXXaCxo7shwb
	b0SJmRIEOjkr1RnngCg0TomZjOQuxJFoVtJIFcWik7kZCdzcTvdt1dZU/LjIDeOAEwYTJB1xOT9SR
	G/5BxwOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQfH-0000000DbM0-3DRg;
	Fri, 21 Aug 2026 14:56:15 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQfF-0000000DbLo-2YnV
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 14:56:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7C0C861126;
	Fri, 21 Aug 2026 14:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1501F000E9;
	Fri, 21 Aug 2026 14:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787324172;
	bh=RhTaW9/NmoyAYVT4VQizYgX9sdot2itK/I65qUFWNe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f0uRC0P4hdkLNc5TrBsqs/fvsbuUWmJuB3QpL7ZiTg3vcpTe/EkeLVL9DotfJpgsq
	 K9ApCLvcXaA8vJgSdgeKMLzaSALfEOd5qxi7kNWX7ypCR3Al0w9jmiUhjhSHNn6ePo
	 2v/xqr/tlIj0c3N4fY+yR3YXVuuZRNh9q41pTTRZmbWSm8goQ0J5e5EPV4ElahTRUz
	 xDDKh6DD+XO4pDSpgSqhMM53Wia4Jy0H00gvii2bRln78Prvggwk7h69Keuw2x+yrM
	 kxjSvmGa3fEw8z7fKu+BnMO74Wxqg5HBoHl59SqZ6wvTnArO+yODYKYi2q2C8IxvjP
	 LK845Lv7b+kRQ==
Date: Fri, 21 Aug 2026 16:56:07 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Rihyeon Kim <rihyeon8648@gmail.com>, justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	stable@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <aohnB2sC2nspmqmH@ryzen>
References: <20260814143833.1953415-2-cassel@kernel.org>
 <20260817061815.154794-1-rihyeon8648@gmail.com>
 <aoMkX_davK7TWlaj@ryzen>
 <aoXLiFruG5s1nKch@kbusch-mbp>
 <aoX2wcyhpakryWHX@ryzen>
 <aocb3ogg34WWtRSB@kbusch-mbp>
 <aohQ9NcuMtSqWvvd@ryzen>
 <aoheN_L3iJNU3Ji6@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoheN_L3iJNU3Ji6@kbusch-mbp>
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

On Fri, Aug 21, 2026 at 08:18:31AM -0600, Keith Busch wrote:
> On Fri, Aug 21, 2026 at 03:21:56PM +0200, Niklas Cassel wrote:
> > On Thu, Aug 20, 2026 at 09:23:10AM -0600, Keith Busch wrote:
> > > On Wed, Aug 19, 2026 at 08:32:33PM +0200, Niklas Cassel wrote:
> > > > 
> > > > I am not following.
> > > > 
> > > > The options is freed in two different places, depending on if the
> > > > ops->create_ctrl(dev, opts) call in fabrics.c:nvmf_create_ctrl() was
> > > > successful or not.
> > > 
> > > Oh, not that path. You mentioned previously that ctrl->ops is
> > > dereferenced in other places. I thought this means we can successfully
> > > add the controller, which means the attributes are visible, but then
> > > fail something else later that causes the opts to free. Since the
> > > attribute was visible, something can open it before the device exporting
> > > is torn down, and access it after the opts were freed.
> > 
> > Sashiko flagged another NULL pointer defererence from the sysfs attributes:
> > 
> > "While the sysfs attributes are still fully accessible, an unprivileged user
> > could concurrently read an attribute like hostnqn, causing a NULL pointer
> > dereference.":
> > https://sashiko.dev/#/patchset/20260811125310.165487-1-rihyeon8648%40gmail.com
> > 
> > This comment was on Rihyeon Kim's patch proposal.
> > 
> > I assume that this is because the fc.c driver (both before and after
> > Rihyeon patch) force set ctrl->ops = NULL before nvme_free_ctrl() was
> > called, so a user reading the sysfs attributes at the same time as the
> > controller was tearing down, could most likely crash the kernel.
> > (Note that neither rdma.c,tcp.c,loop.c does this, so this problem does
> > not exist for them.)
> > 
> > sysfs_remove_link() is called before ctrl->ops->free_ctrl(ctrl);
> 
> When ops->create_ctrl() fails, the opts are freed from
> nvmf_create_ctrl(). We can still fail ops->create_ctrl() after a
> successful nvme_add_ctrl(), so the handle will be visible to user space
> for a moment.
> 
> I think you're relying on nvme_fc_init_ctrl's nvme_put_ctrl() error case
> to be the final reference, but it might not be if the character device
> was created and someone opened it. If so then:
> 
>   out_put_ctrl:
>      nvme_put_ctrl()   -> refcount 1, NOT zero
> 
> So now when nvme_free_ctrl is called sometime after nvmf_create_ctrl()
> freed the opts, the ctrl is pointing to freed memory.

Yes, if someone called open() without calling close() for a long time,
then I agree that refcount will be 1 in at this label, and that
nvme_free_ctrl() will run after nvmf_create_ctrl() freed the opts.

I guess that is how whoever designed nvmf_create_ctrl() implemented things...

AFAICT, this problem is there for rdma.c,tcp.c,loop.c, so it is not a fc.c
specific problem.

The unconditional NULL pointer dereference in nvme_auth_free() was specific
to fc.c, and was solved by this patch.

So while the patch does solve an unconditional fc.c specific NULL pointer
dereference in nvme_auth_free() (if DHCAP is used), it does not solve a
potential NULL pointer dereference that can happen to: rdma.c,tcp.c,loop.c
(+fc.c after my patch) if someone is very quick to grab a reference in the
short window between creation and a failure during creation.

fc.c was not affected by this bug, because of the force setting of ctrl->ops
to NULL.

I still think this patch makes sense, since it brings the fc.c driver in
line with the other fabrics drivers, and avoids the dereference in
nvme_auth_free().

But yes, someone should probably do a follow up series that cleans up the
options handling for all fabrics drivers to solve the problem you just
described. At least the options handling will be uniform after this patch,
so hopefully that cleanup will be easier to implement because of this.


Kind regards,
Niklas

