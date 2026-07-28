Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45DEC54F4C
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2026 05:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SxU95iAD4hAuFqCDuuTVioyElcmVYzI9Vuh1mDjodCs=; b=K91sQbDqxYmw5/p3aNRJ3qtQ1E
	wowCWwnFWb8lI06R8Xm5vfSOXCeT1gsoNUf0Bom1ap92sZpIwfSvST5X91MevinErshcUjF6N/vzM
	vbk0BfQ4ljsrHqHEGOH3jZlBDvyC0cfRzt0JayoxgzwyvQTn/me7sN+XF6iOMiMHO5FGY63W7bVS2
	G2jN4AKr4GcGw+EQle6gZnShI3nhbgJ1Jj+peG/7BRIkcIDjqlEq2phd2VIX4/ovtH3uue5p4Cx3z
	3jRHPS7Y16dOcWjvhXZMSE0GdA3h5LQM30ZRpMLGtmkkqD4sgV7nHBuZ9qlH1fTk1SsX1s3iD4UkC
	zBfGFkMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woaDG-00000004Qu2-3PIH;
	Tue, 28 Jul 2026 05:18:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woaDD-00000004Qtd-1a1c
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 05:18:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0B55D68AFE; Tue, 28 Jul 2026 07:18:39 +0200 (CEST)
Date: Tue, 28 Jul 2026 07:18:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Keith Busch <kbusch@kernel.org>, Hari Mishal <harimishal1@gmail.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: drop WARN_ON_ONCE on write_stream bounds
 check
Message-ID: <20260728051838.GA20593@lst.de>
References: <20260725135111.14041-1-harimishal1@gmail.com> <20260725135111.14041-3-harimishal1@gmail.com> <amdqKEI44SKwq-K2@kbusch-mbp> <2026072748-unpopular-onlooker-4a2b@gregkh> <amfg_OFiyDadWb3v@kbusch-mbp> <2026072849-uproar-aqua-07c3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026072849-uproar-aqua-07c3@gregkh>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_221843_725707_8F418008 
X-CRM114-Status: GOOD (  45.86  )
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

On Tue, Jul 28, 2026 at 07:15:28AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 27, 2026 at 04:51:40PM -0600, Keith Busch wrote:
> > On Mon, Jul 27, 2026 at 09:19:27PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Jul 27, 2026 at 08:24:40AM -0600, Keith Busch wrote:
> > > > On Sat, Jul 25, 2026 at 03:51:11PM +0200, Hari Mishal wrote:
> > > > > write_stream is validated against bdev_max_write_streams() in both
> > > > > generic block direct I/O (block/fops.c) and F2FS before a bio
> > > > > carrying it is ever built, so write_stream > nr_plids shouldn't be
> > > > > reachable through any current legitimate path. The remaining users
> > > > > of bio->bi_write_stream elsewhere in the block layer only copy an
> > > > > already-validated value between bios (bio.c, blk-crypto-fallback.c)
> > > > > or compare it for merge eligibility (blk-merge.c); none of them
> > > > > introduce a new, unvalidated value.
> > > > > 
> > > > > Using WARN_ON_ONCE as the backstop for that assumption isn't worth
> > > > > it given how many deployed systems run with panic-on-warn enabled;
> > > > > the existing graceful return BLK_STS_INVAL already handles it on
> > > > > its own.
> > > > 
> > > > That's not a very good reason to remove a WARN_ON. You've left the check
> > > > in for a condition that should never happen, so when it does happen,
> > > > it'll be impossible to debug without the WARN.
> > > > 
> > > > And the WARN also annotates the branch as unlikely, which is desirable
> > > > for this case.
> > > 
> > > But, if it ever does happen, a WARN_ON will reboot the box, given that
> > > billions of Linux systems have panic-on-warn enabled.  
> > 
> > So WARN_ON is the new BUG_ON now?
> 
> It has been that way since syzbot started sending us reports (i.e. for
> many many years...)
> 
> > If the condition happens we need to
> > know how we got here and make it obvious something is wrong. So I guess
> > we'd have to replace every one of these:
> > 
> > 	if (WARN_ON_ONCE(condition)) ...
> > 
> > With an open-coded version like:
> > 
> > 	if (unlikely(condition)) {
> > 		do_once(dump_stack());
> > 		...
> > 	}
> > 
> > ?
> 
> Yes, if userspace can trigger this.  Because again, this will cause a
> box to reboot.
> 
> If we didn't have panic-on-warn, a ton of CVEs would just disappear
> tomorrow.  But that's not the world we live in :(
> 
> > That doesn't seem right, so if that is the suggestion, then I think we
> > need a new macro to provide the result that the WARN_ON usage expected.
> 
> You can provide a tracedump if you really need/want it, no need to call
> WARN_ON(), the macro is there for you to use.
> 
> > > So if this can ever happen, 
> > 
> > But it can't ever happen. This patch's commit message reasoned that as
> > justification to remove the warn, but we need to know how we got here
> > when it does happen because it means somebody broke contract.
> 
> Fair enough, but note that if userspace can trigger this, it should be
> fixed up.  See the other WARN_ON patch fix for nvme that I sent yesterday
> for an example of userspace being able to trigger this type of issue:
> 	https://lore.kernel.org/r/20260727-nvme-tcp-v1-1-61c0e36763eb@linuxfoundation.org
> 
> > > just properly handle it and recover and don't loose user
> > > data.
> > 
> > We can't save the data from this specific condition: the data from the
> > request is unwritable and lost. We've also learned that EINVAL errors
> > are not handled for many DM stacking drivers in very bad ways, so again,
> > we need to know how we got here when something breaks the API contract
> > otherwise it'll be a difficult problem to debug without that visibility.
> 
> Ok, if you want to keep this here, that's fine, because you know you
> can't recover properly and crashing the system is the only acceptable
> thing to do.  But in that case, why not make it a BUG_ON()?

Because we don't want a BUG_ON.  If you set panic on warn in anything
but a debug setup you get what you pay for, and I'm really tired of
all these totally stupid attempts to make WARN_ON the new BUG_ON.
It is not, and that's for a reason.


