Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4698FC4829E
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 22:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hdYsVJZ8Ora4iYnpb5KhpDVHQp//SzZSwGCN56T/AUA=; b=rW9GJjFYDvWmXOfrnUWH0wo37T
	qyPrUHKu5bALBnBcZMaIOtUfu1oILfGIVClz7hxi8AOP3VtB+32X4GFqzP+roJVTS21ORVjEpSXVN
	AEEh3SL5qoqelCV/HcomzuIWRGmFzg+dGf+zbfr46sL5GZ7sZqdciB/Q6v/BbBRSu8ytjF78yQnAL
	Ic78Q0sd7CgjhOhHJmBIZwm/N6n4myZhlg7i5gmpzO3Nfr9HElewi8t43rOtwzh6DSEWG6L8HXxtj
	XIN19mQwXa4Z+xCqesobpxW32UYJv7a+g6GJCTo/J6P4rEixdJpUhcym1+qhqCeyywqeRW7hGNiTV
	iVX3UBVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZeSE-000000076jl-3FjU;
	Mon, 12 Feb 2024 22:07:10 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZeSB-000000076iN-2r90
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 22:07:09 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d95d67ff45so26763505ad.2
        for <linux-nvme@lists.infradead.org>; Mon, 12 Feb 2024 14:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707775627; x=1708380427; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hdYsVJZ8Ora4iYnpb5KhpDVHQp//SzZSwGCN56T/AUA=;
        b=GDwQqhsCSNK8x2yiVb4W4ckwNxo9j3iLe3EWRp44H261cvOzObuN0gIdXu69ldW6F5
         tszv2e14f7AGoSjanhf592qXNsajeTptA4zv2Ciu+KTVW4Z4hvz7V/vXxsUaqO6A9zaS
         GHox8KeV0LQwrO+Ct86VzpQK6/rhSFfn0U1BFTCNJOCNFDmk+A3MoIVIofjy85y6C0Uq
         egNwjXYgZgQKPAbL1UgVYoenPIjpmVBvEAJzpb6kqRy5oteGpzYORslMSZ7lQuTPQXx9
         Fi551hMmutbI4HsnGOCsfVFnRJkJSUaBdQIL51QuXjRGVBoTdhMSALMA1VHM07lQNlYn
         Mucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707775627; x=1708380427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdYsVJZ8Ora4iYnpb5KhpDVHQp//SzZSwGCN56T/AUA=;
        b=D5qrfpEQMB49Hwi6R8M/6n6ihXHWKgPjHdV+N27LNmYDM5tq4b4UgHLxn769dUKUPe
         Po1rgv2lxK1ZKSb/WLZjLNPyVVWltOBqwXvRd6SMHCBrN7sVb+pqchOP1boa66eSVaLE
         oYoRnNey2SMeu9/FIKfcRwYD1XxnMmUJHBs0KgCVEKJjm+xi1YDUlBWR5dGnNtpdRZ5U
         ZOAB7Z93B+iDXfzEg32qPWBREG6G20qL7iPccn45UzTdHW1gJnlEkBSXmSyUleu3LSXS
         7b1lXjTX37tZJv9u9nsT0Q4kVxwdZqoH+SuALIZSWpMh4nKWUI0iY/DTdD3p5Gtq2Eij
         B/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYKB8Mx9VQjLRdPnc04O0k8lv7ntQC7/sxuSBa9nZy9Vv677PNiKWvpO/J/iH7Wnlbf5kfcfJd+4HamgwYikEbJE/h9ThIg40FZmwmFd0=
X-Gm-Message-State: AOJu0YyR2CyT5HpmBtyOweXH68KfPYLWpxNYx2Sf7Q/Ibinj9UzlAQJ3
	2d6GlxcNIOnkPeAhnxWEAePmG51AABxY0yTXsqW+HNmv9QngzLKahfYAbaQvCX0=
X-Google-Smtp-Source: AGHT+IGaGxGMtVNxwY57a75FxouCmxRA8F9ezxcGzJMqapTK57ZCd099OQZYPv1Zwae9AMhdE608kw==
X-Received: by 2002:a17:903:22ca:b0:1d9:d8d2:eabb with SMTP id y10-20020a17090322ca00b001d9d8d2eabbmr7857477plg.46.1707775626950;
        Mon, 12 Feb 2024 14:07:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXxIt4/SfEYX7HaojQTjTYucUuLHj8DuvbaDMOWISnbQ9PtBBz9MmhfTWbayWFO+027RmfX5weuFlbQ58Zf5GHbsugzCZ7VK+JiRK67D4qcD7HneVmqTWlRCaLqUi4B57asLAyVOHqj+V3CtzjsUwJEQCwTUKEolB3eOai9t5Rs3n9vRhSCmUprbSWcw33frZpfza6KwKY0dSnZtBqk93nt4zvqXxz9McL8gev2OVrOnSvEfNzBcGzzNaW/v6IzUOUilRxjKMiYDDVoDtg6musEghJJlZDCrX1tuu9gCcHLeqhLaee1n4ZuLAsGcxh5GgAvUbchMKvhOk/BWKbDrMzy7trHcBuJLOWc8+7ZZYVTlHKZgUEsb0HSHhNWA8ICUJhHqbqnX5iub7FdPi/cP4Uvi1vrq3useTA9
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903308b00b001d6f091ca04sm820043plc.13.2024.02.12.14.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:07:06 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rZeS7-005fsr-2C;
	Tue, 13 Feb 2024 09:07:03 +1100
Date: Tue, 13 Feb 2024 09:07:03 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Message-ID: <ZcqWh3OyMGjEsdPz@dread.disaster.area>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <ZZzP6731XwZQnz0o@dread.disaster.area>
 <3ba0dffa-beea-478f-bb6e-777b6304fb69@kernel.org>
 <ZcUQfzfQ9R8X0s47@tiehlicka>
 <3aa399bb-5007-4d12-88ae-ed244e9a653f@kernel.org>
 <ZclyYBO0vcQHZ5dV@dread.disaster.area>
 <5p4zwxtfqwm3wgvzwqfg6uwy5m3lgpfypij4fzea63gu67ve4t@77to5kukmiic>
 <ZcmgFThkhh9HYsXh@dread.disaster.area>
 <cepmpv7vdq7i6277wheqqnqsniqnkomvh7sn3535rcacvorkuu@5caayyz44qzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cepmpv7vdq7i6277wheqqnqsniqnkomvh7sn3535rcacvorkuu@5caayyz44qzr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_140707_878682_093F2E62 
X-CRM114-Status: GOOD (  62.90  )
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

On Mon, Feb 12, 2024 at 02:30:02PM -0500, Kent Overstreet wrote:
> On Mon, Feb 12, 2024 at 03:35:33PM +1100, Dave Chinner wrote:
> > On Sun, Feb 11, 2024 at 09:06:33PM -0500, Kent Overstreet wrote:
> > > That's because in general most code in the IO path knows how to make
> > > effective use of biosets and mempools (which may take some work! you
> > > have to ensure that you're always able to make forward progress when
> > > memory is limited, and in particular that you don't double allocate from
> > > the same mempool if you're blocking the first allocation from
> > > completing/freeing).
> > 
> > Yes, I understand this, and that's my point: NOIO context tends to
> > be able to use mempools and other mechanisms to prevent memory
> > allocation failure, not NOFAIL.
> > 
> > The IO layers are request based and that enables one-in, one out
> > allocation pools that can guarantee single IO progress. That's all
> > the IO layers need to guarantee to the filesystems so that forwards
> > progress can always be made until memory pressure.
> > 
> > However, filesystems cannot guarantee "one in, one out" allocation
> > behaviour. A transaction can require a largely unbound number of
> > memory allocations to succeed to make progress through to
> > completion, and so things like mempools -cannot be used- to prevent
> > memory allocation failures whilst providing a forwards progress
> > guarantee.
> 
> I don't see that that's actually true. There's no requirement that
> arbitrarily large IOs must be done atomically, within a single
> transaction:

*cough*

metadata Io needs to be set up, issued and completed before the
transaction can make progress, and then the transaction will hold
onto that metadata until it is committed and unlocked.

That means we hold every btree buffer we walk along a path in the
transaction, and if the cache is cold it means we might need to
allocate and read dozens of metadata buffers in a single
transaction.

> there's been at most talk of eventually doing atomic writes
> through the pagecache, but the people on that can't even finish atomic
> writes through the block layer, so who knows when that'll happen.

What's atomic data writes got to do with metadata transaction
contexts?

> I generally haven't been running into filesyste operations that require
> an unbounded number of memory allocations (reflink is a bit of an
> exception in the current bcachefs code, and even that is just a
> limitation I could solve if I really wanted to...)

Step outside of bcachefs for a minute, Kent. Not everything works
the same way or has the same constraints and/or freedoms as the
bcachefs implementation....

> > Hence a NOFAIL scope if useful at the filesystem layer for
> > filesystem objects to ensure forwards progress under memory
> > pressure, but it is compeltely unnecessary once we transition to the
> > IO layer where forwards progress guarantees ensure memory allocation
> > failures don't impede progress.
> > 
> > IOWs, we only need NOFAIL at the NOFS layers, not at the NOIO
> > layers. The entry points to the block layer should transition the
> > task to NOIO context and restore the previous context on exit. Then
> > it becomes relatively trivial to apply context based filtering of
> > allocation behaviour....
> > 
> > > > i.e NOFAIL scopes are not relevant outside the subsystem that sets
> > > > it.  Hence we likely need helpers to clear and restore NOFAIL when
> > > > we cross an allocation context boundaries. e.g. as we cross from
> > > > filesystem to block layer in the IO stack via submit_bio(). Maybe
> > > > they should be doing something like:
> > > > 
> > > > 	nofail_flags = memalloc_nofail_clear();
> > > 
> > > NOFAIL is not a scoped thing at all, period; it is very much a
> > > _callsite_ specific thing, and it depends on whether that callsite has a
> > > fallback.
> > 
> > *cough*
> > 
> > As I've already stated, NOFAIL allocation has been scoped in XFS for
> > the past 20 years.
> > 
> > Every memory allocation inside a transaction *must* be NOFAIL unless
> > otherwise specified because memory allocation inside a dirty
> > transaction is a fatal error.
> 
> Say you start to incrementally mempoolify your allocations inside a
> transaction - those mempools aren't going to do anything if there's a
> scoped NOFAIL, and sorting that out is going to get messy fast.

How do you mempoolify something that can have thousands of
concurrent contexts with in-flight objects across multiple
filesystems that might get stashed in a LRU rather than freed when
finished with? Not to mention that each context has an unknown
demand on the mempool before it can complete and return objects to
the mempool?

We talked about this a decade ago at LSFMM (2014, IIRC) with the MM
developers and nothing about mempools has changed since.

> > However, that scoping has never been
> > passed to the NOIO contexts below the filesytsem - it's scoped
> > purely within the filesystem itself and doesn't pass on to other
> > subsystems the filesystem calls into.
> 
> How is that managed?

Our own internal memory allocation wrappers. go look at what remains
in fs/xfs/kmem.c. See the loop there in kmem_alloc()? It's
guaranteeing NOFAIL behaviour unless KM_MAYFAIL is passed to the
allocation. Look at xlog_kvmalloc() - same thing, except it is
always run within transaction context (the "xlog" prefix is a
giveaway) and so will block until allocation succeeds.

IOWs, we scoped everything by having our own internal allocation
wrappers than never fail. In removing these wrappers (which is where
my "scoped NOFAIL" comments in this thread originated from) the
proliferation of __GFP_NOFAIL annotations across meant we went from
pretty much zero usage of __GFP_NOFAIL to having almost a hundred
allocation sites annotated with __GFP_NOFAIL. And it adds a
maintenance landmine for us - we now have to ensure that all future
allocations within a transaction scope are marked __GFP_NOFAIL.

Hence I'm looking for ways to move this NOFAIL scoping into the
generic memory allocation code to replace the scoping we current
have via subsystem-specific allocation wrappers.

> > > > > - NOWAIT - as said already, we need to make sure we're not turning an
> > > > > allocation that relied on too-small-to-fail into a null pointer exception or
> > > > > BUG_ON(!page).
> > > > 
> > > > Agreed. NOWAIT is removing allocation failure constraints and I
> > > > don't think that can be made to work reliably. Error injection
> > > > cannot prove the absence of errors  and so we can never be certain
> > > > the code will always operate correctly and not crash when an
> > > > unexepected allocation failure occurs.
> > > 
> > > You saying we don't know how to test code?
> > 
> > Yes, that's exactly what I'm saying.
> > 
> > I'm also saying that designing algorithms that aren't fail safe is
> > poor design. If you get it wrong and nothing bad can happen as a
> > result, then the design is fine.
> > 
> > But if the result of missing something accidentally is that the
> > system is guaranteed to crash when that is hit, then failure is
> > guaranteed and no amount of testing will prevent that failure from
> > occurring.
> > 
> > And we suck at testing, so we absolutely need to design fail
> > safe algorithms and APIs...
> 
> GFP_NOFAIL dosen't magically make your algorithm fail safe, though.

I never said it did - this part of the conversation was about the
failure prone design of proposed -NOWAIT- scoping, not about
trying to codify a generic mechanism for scoped behaviour we've been
using successfully for the past 20 years...

> Suren and I are trying to get memory allocation profiling into 6.9, and
> I'll be posting the improved fault injection immediately afterwards -
> this is what I used to use to make sure every allocation failure path in
> the bcachefs predecessor was tested. Hopefully that'll make things
> easier...

Tha all sounds good, but after a recent spate of "CI and post
integration testing didn't uncover fs bugs that fstests reproduced
until after tested kernels were released to test systems", I have
little confidence in the ability of larger QA organisations, let
alone individuals, to test filesystem code adequately when they are
constrained either by time or resources.

The fact of the matter is that we are all constrained by time
and resources. Hence adding more new testing methods that add time
and resources to validate new code and backports of fixes to the
test matrix overhead does nothing to improve that situation.

We need to start designing our code in a way that doesn't require
extensive testing to validate it as correct. If the only way to
validate new code is correct is via stochastic coverage via error
injection, then that is a clear sign we've made poor design choices
along the way.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

