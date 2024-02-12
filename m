Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C296C48BC1
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 19:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rn+g3POrCt16v7JX8rOl/Zs5Xf7fDMrrf9BRGk2OghE=; b=ISF6FcqoZfbT4w87yVfnIEwl01
	EYpX81UBYhkbB59ACW/WT+Ueez4PRMY5NxEHmfq6kvnZuIBF7XqHl+LwRfh9GEYQhf17oE2b4Qvui
	P33yGMv4w1VfUtjzOxddBiVEwAaX2upPTQCYPGUAVMcAcMOkC9PgXYnocTOe64+XBtCfSbbA2xMsr
	jVZiHi5JJPmUhTUCJPlbVfgBIwKCvYu9jktvCi4cxc0Uw/l4/pKcqWxY04yhkHPGUVOwBWl0RsAQ/
	KT3M2bN5XEGG4uIz5EwiZOEZT+AjgCRExanz4jzCSa3wt6uqz1huJPVDseouBeAl89QoXP0d8Z8Dc
	8rWqpJqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZc0M-00000006lE0-0pof;
	Mon, 12 Feb 2024 19:30:14 +0000
Received: from out-170.mta1.migadu.com ([2001:41d0:203:375::aa])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZc0J-00000006lDH-0kuY
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 19:30:12 +0000
Date: Mon, 12 Feb 2024 14:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707766207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rn+g3POrCt16v7JX8rOl/Zs5Xf7fDMrrf9BRGk2OghE=;
	b=qlAJEgm/CtrwPB/nNjb/vD8B55ZNOWsm5jV92wK+E5nqfANbsMzyK1sF+vJMb50sKllkDV
	soOrFT4O6IJ7Ik/CqAfSvHUWFGw1xEuigZ7G+ivDvjSoDAMh8kTuZdpM0mIWsj5f1+wh6M
	lJ2xYc5vs/HXrMgJ8ngbq2VC/Igqep4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Message-ID: <cepmpv7vdq7i6277wheqqnqsniqnkomvh7sn3535rcacvorkuu@5caayyz44qzr>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <ZZzP6731XwZQnz0o@dread.disaster.area>
 <3ba0dffa-beea-478f-bb6e-777b6304fb69@kernel.org>
 <ZcUQfzfQ9R8X0s47@tiehlicka>
 <3aa399bb-5007-4d12-88ae-ed244e9a653f@kernel.org>
 <ZclyYBO0vcQHZ5dV@dread.disaster.area>
 <5p4zwxtfqwm3wgvzwqfg6uwy5m3lgpfypij4fzea63gu67ve4t@77to5kukmiic>
 <ZcmgFThkhh9HYsXh@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcmgFThkhh9HYsXh@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_113011_625644_C88DF752 
X-CRM114-Status: GOOD (  46.14  )
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

On Mon, Feb 12, 2024 at 03:35:33PM +1100, Dave Chinner wrote:
> On Sun, Feb 11, 2024 at 09:06:33PM -0500, Kent Overstreet wrote:
> > That's because in general most code in the IO path knows how to make
> > effective use of biosets and mempools (which may take some work! you
> > have to ensure that you're always able to make forward progress when
> > memory is limited, and in particular that you don't double allocate from
> > the same mempool if you're blocking the first allocation from
> > completing/freeing).
> 
> Yes, I understand this, and that's my point: NOIO context tends to
> be able to use mempools and other mechanisms to prevent memory
> allocation failure, not NOFAIL.
> 
> The IO layers are request based and that enables one-in, one out
> allocation pools that can guarantee single IO progress. That's all
> the IO layers need to guarantee to the filesystems so that forwards
> progress can always be made until memory pressure.
> 
> However, filesystems cannot guarantee "one in, one out" allocation
> behaviour. A transaction can require a largely unbound number of
> memory allocations to succeed to make progress through to
> completion, and so things like mempools -cannot be used- to prevent
> memory allocation failures whilst providing a forwards progress
> guarantee.

I don't see that that's actually true. There's no requirement that
arbitrarily large IOs must be done atomically, within a single
transaction: there's been at most talk of eventually doing atomic writes
through the pagecache, but the people on that can't even finish atomic
writes through the block layer, so who knows when that'll happen.

I generally haven't been running into filesyste operations that require
an unbounded number of memory allocations (reflink is a bit of an
exception in the current bcachefs code, and even that is just a
limitation I could solve if I really wanted to...)

> Hence a NOFAIL scope if useful at the filesystem layer for
> filesystem objects to ensure forwards progress under memory
> pressure, but it is compeltely unnecessary once we transition to the
> IO layer where forwards progress guarantees ensure memory allocation
> failures don't impede progress.
> 
> IOWs, we only need NOFAIL at the NOFS layers, not at the NOIO
> layers. The entry points to the block layer should transition the
> task to NOIO context and restore the previous context on exit. Then
> it becomes relatively trivial to apply context based filtering of
> allocation behaviour....
> 
> > > i.e NOFAIL scopes are not relevant outside the subsystem that sets
> > > it.  Hence we likely need helpers to clear and restore NOFAIL when
> > > we cross an allocation context boundaries. e.g. as we cross from
> > > filesystem to block layer in the IO stack via submit_bio(). Maybe
> > > they should be doing something like:
> > > 
> > > 	nofail_flags = memalloc_nofail_clear();
> > 
> > NOFAIL is not a scoped thing at all, period; it is very much a
> > _callsite_ specific thing, and it depends on whether that callsite has a
> > fallback.
> 
> *cough*
> 
> As I've already stated, NOFAIL allocation has been scoped in XFS for
> the past 20 years.
> 
> Every memory allocation inside a transaction *must* be NOFAIL unless
> otherwise specified because memory allocation inside a dirty
> transaction is a fatal error.

Say you start to incrementally mempoolify your allocations inside a
transaction - those mempools aren't going to do anything if there's a
scoped NOFAIL, and sorting that out is going to get messy fast.

> However, that scoping has never been
> passed to the NOIO contexts below the filesytsem - it's scoped
> purely within the filesystem itself and doesn't pass on to other
> subsystems the filesystem calls into.

How is that managed?
> 
> > The most obvious example being, as mentioned previously, mempools.
> 
> Yes, they require one-in, one-out guarantees to avoid starvation and
> ENOMEM situations. Which, as we've known since mempools were
> invented, these guarantees cannot be provided by most filesystems.
> 
> > > > - NOWAIT - as said already, we need to make sure we're not turning an
> > > > allocation that relied on too-small-to-fail into a null pointer exception or
> > > > BUG_ON(!page).
> > > 
> > > Agreed. NOWAIT is removing allocation failure constraints and I
> > > don't think that can be made to work reliably. Error injection
> > > cannot prove the absence of errors  and so we can never be certain
> > > the code will always operate correctly and not crash when an
> > > unexepected allocation failure occurs.
> > 
> > You saying we don't know how to test code?
> 
> Yes, that's exactly what I'm saying.
> 
> I'm also saying that designing algorithms that aren't fail safe is
> poor design. If you get it wrong and nothing bad can happen as a
> result, then the design is fine.
> 
> But if the result of missing something accidentally is that the
> system is guaranteed to crash when that is hit, then failure is
> guaranteed and no amount of testing will prevent that failure from
> occurring.
> 
> And we suck at testing, so we absolutely need to design fail
> safe algorithms and APIs...

GFP_NOFAIL dosen't magically make your algorithm fail safe, though.

Suren and I are trying to get memory allocation profiling into 6.9, and
I'll be posting the improved fault injection immediately afterwards -
this is what I used to use to make sure every allocation failure path in
the bcachefs predecessor was tested. Hopefully that'll make things
easier...

