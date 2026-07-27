Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DD5C531D0
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 22:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qupqUdlX99CdUtC+CkCyVAh9c2+CD/D2e/3ahOTD5f8=; b=0GXFL//TA4g0Xu6otO12OhCXLt
	o5VicTJnIscM7DCgrdxZQozI5kJbiVYAMuU1UUwPasNkA7qKwrPQhFdj5xHdJ3u9uXZfDbF2hdqJS
	lp1rMMyOZ4JMpOX6zLJOEjtbcXBTg0dgo7OCPfQir0CFA4xNwZCmQMCmXqTIATNMw4fqh0K8l+4oB
	X/vWD964VjN0ye9FWfcWW1LF6M4b8favi7OyGaS+eKfEdyDQNODE0OBd0MjySM5C7yqZQ60EYlceN
	a0x1+W7OLgfxCAypSpMfqewzPXcShDmShDh5NLfQkbAKza1Mm+DAt6ATDm25GrWdB9nKuugnmaG6I
	7Bd/M5LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woUAi-000000042nd-1fB0;
	Mon, 27 Jul 2026 22:51:44 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woUAg-000000042nS-2XYs
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 22:51:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4D3EE40F86;
	Mon, 27 Jul 2026 22:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E931F000E9;
	Mon, 27 Jul 2026 22:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785192702;
	bh=qupqUdlX99CdUtC+CkCyVAh9c2+CD/D2e/3ahOTD5f8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pm1eQTU01NMBZzUpHyl68i8EKDDDo10ibGCTLXpPHR2KQ8FH+APLQpjJlyAI9qCMJ
	 V2fGdU/Kl2bgKulJuo6ACtYvSW1pfufhHd4N6KEhkmK0Bzum4laLG51k/BPUTI0n1S
	 p9DuyszNbgLwScXtifF6XXhzf7E7qnOWyjH7wpHreWdpd8jnQyg2nG8UG16h1Ogda2
	 6Ay9wqoxEoeUQRclQPOTPHqn+y952DPwJkGwEJujpJzE+dH0KLbvCp3YBg1Pskkz1B
	 ELOCHUjMrUAHOT0wPAOI5wlmZ5NeKN/Ialg776+dptWU+3VdplknHvC37MQOzr8fZf
	 GYKY8rwvYM8bw==
Date: Mon, 27 Jul 2026 16:51:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hari Mishal <harimishal1@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: drop WARN_ON_ONCE on write_stream bounds check
Message-ID: <amfg_OFiyDadWb3v@kbusch-mbp>
References: <20260725135111.14041-1-harimishal1@gmail.com>
 <20260725135111.14041-3-harimishal1@gmail.com>
 <amdqKEI44SKwq-K2@kbusch-mbp>
 <2026072748-unpopular-onlooker-4a2b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026072748-unpopular-onlooker-4a2b@gregkh>
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

On Mon, Jul 27, 2026 at 09:19:27PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 27, 2026 at 08:24:40AM -0600, Keith Busch wrote:
> > On Sat, Jul 25, 2026 at 03:51:11PM +0200, Hari Mishal wrote:
> > > write_stream is validated against bdev_max_write_streams() in both
> > > generic block direct I/O (block/fops.c) and F2FS before a bio
> > > carrying it is ever built, so write_stream > nr_plids shouldn't be
> > > reachable through any current legitimate path. The remaining users
> > > of bio->bi_write_stream elsewhere in the block layer only copy an
> > > already-validated value between bios (bio.c, blk-crypto-fallback.c)
> > > or compare it for merge eligibility (blk-merge.c); none of them
> > > introduce a new, unvalidated value.
> > > 
> > > Using WARN_ON_ONCE as the backstop for that assumption isn't worth
> > > it given how many deployed systems run with panic-on-warn enabled;
> > > the existing graceful return BLK_STS_INVAL already handles it on
> > > its own.
> > 
> > That's not a very good reason to remove a WARN_ON. You've left the check
> > in for a condition that should never happen, so when it does happen,
> > it'll be impossible to debug without the WARN.
> > 
> > And the WARN also annotates the branch as unlikely, which is desirable
> > for this case.
> 
> But, if it ever does happen, a WARN_ON will reboot the box, given that
> billions of Linux systems have panic-on-warn enabled.  

So WARN_ON is the new BUG_ON now? If the condition happens we need to
know how we got here and make it obvious something is wrong. So I guess
we'd have to replace every one of these:

	if (WARN_ON_ONCE(condition)) ...

With an open-coded version like:

	if (unlikely(condition)) {
		do_once(dump_stack());
		...
	}

?

That doesn't seem right, so if that is the suggestion, then I think we
need a new macro to provide the result that the WARN_ON usage expected.

> So if this can ever happen, 

But it can't ever happen. This patch's commit message reasoned that as
justification to remove the warn, but we need to know how we got here
when it does happen because it means somebody broke contract.

> just properly handle it and recover and don't loose user
> data.

We can't save the data from this specific condition: the data from the
request is unwritable and lost. We've also learned that EINVAL errors
are not handled for many DM stacking drivers in very bad ways, so again,
we need to know how we got here when something breaks the API contract
otherwise it'll be a difficult problem to debug without that visibility.

