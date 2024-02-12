Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D7BC4829B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 04:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PXkXLwVNWLT3J3oeKK9tqqTL6F+hQb3SLALc77jiL0g=; b=hEBjbJEvljF34NUZKbC+Os32kx
	FnWEqJWaefVESRrbkJ0G/acCmoLcibgeYYue7m+8zUdeOUqyJvMNhgqeGDTFUXihBkSmeoaFnBqM/
	tZLoGgHUQKRnwbgogI69zbTmZ3KaZ6B+WqhnNDcKlds1AJGRdswNIBWkd9y98SXOEh0IthZk55qi4
	KyTzSmR8Ir4dG+R/JGcmmEgexF2Sxc5iDTv9YSC9s9PSa6c7wAVPWZClhNU8oG5G5dp1HFtiELEoh
	n39tx1d/WZkbKSSD5BLgAmmBnH8eK/RjMi5VcZ4DnyJj1o70QQyl0oetSnkDm0c1vv9IHYKztItue
	J/+ZMM9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZO2e-00000004JZB-2FS5;
	Mon, 12 Feb 2024 04:35:40 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZO2b-00000004JYb-41DX
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 04:35:39 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1da0cd9c0e5so19801855ad.0
        for <linux-nvme@lists.infradead.org>; Sun, 11 Feb 2024 20:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707712536; x=1708317336; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PXkXLwVNWLT3J3oeKK9tqqTL6F+hQb3SLALc77jiL0g=;
        b=za2lZxqlnvCAC9revSs5HUG7WE8wkM9H/HKnTUqWi77vNBlHNf9Du3SsKY+6fFOaJ6
         Re+wQx80zK0Yo/7ijwviVftJkuric0mh3WfdeMl8RUGVZhq76FD+TjECY1l3esGVfzFi
         g9wOTD20g6T3u+nD+nMELYdodUki68gTkpxrze7uzT5KrfcPHg6jPHK8TOO1STnf0s40
         HJZd8JBlcG2mtFcNuU0YkcUVvseVnDTmn06xC+SV+ANd09cUpOi1J0fEvwVLbSKjw7P5
         ttCsm3uRBWsSD+MHkEZ2n7bCahSs/EtGi4KL92f7nmbILC4HsM5oDms4ag9ECshyHkK1
         7Yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707712536; x=1708317336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXkXLwVNWLT3J3oeKK9tqqTL6F+hQb3SLALc77jiL0g=;
        b=oRIrbYnV6WMo6Jfe6qtnDFEYk0LNt21DFLllJC4eHD8hCbbRIMq7qnSa2hI+6Cy886
         jehLzF7QdI/z9f+xSBEnAO1L0sUsIW6/zOQcI3qYLa1UuNqiaRLJmTc7zSdeEFqVreUS
         I010st62aT1aeg2EbU5rpVDoXfO9GecRjobv73tqP8vsf9C8Sp6gfXUsrhNmn85Pvpyq
         krJBxfNYzYZY+8wB+3WFPsBRxzRSNo01TjxU3pHNkjZBFrzXgN1jg2pGrOUoW+kU3eDd
         oqmJAnC8GchjwL/6iw5wJJpyDmhF+Qy7++6fVAVmtcPv4Acy9FdG8slBaiJ0jN5AVXoe
         V+yQ==
X-Gm-Message-State: AOJu0Yzsyn3mJWHepfGGh1PKiFJIXuA2wslOhYRYgGTXrL2FX8AR6pOO
	iAvOK0u79bFRkJuXawzPQU5i9TGq5/XRNKQA/4HlgWnrykifZ0kjMsJZLc7rEwA=
X-Google-Smtp-Source: AGHT+IEiPpX2ipLt/DqNdet7IkGo1IKBe0NX+8bKLXh5WQVjqaXPj6kfmFWvz6lYLEhiD9w85rSD3g==
X-Received: by 2002:a17:903:489:b0:1d9:6fce:54f7 with SMTP id jj9-20020a170903048900b001d96fce54f7mr8875338plb.9.1707712536495;
        Sun, 11 Feb 2024 20:35:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqYigSqkzKjzntBWqHqJJRytUl2NfL/vuX6pRjrmsQiEdDZC6LOzD5N/+F3JdZ6t8/ESb6pY/jI37xatgAKqn1PqKpmR27R/KQov8SF2WTizs8/uv+tGT/BAswJfQHF7PW+f22zOBB+yG6J0VPNhEA7p359+ysXO8hFiZbbltS9UC/SW6ZCNsT9KjxGynYyLtL6ueQYbXS2vAgIq+10rKYLKNH3h98EIMCXbUK5oDEO0tzUweEBzUkl2KodVSnykYRMsiv8tDEWYDAnKkvIvE//ZH0BIftykn8uou80tWY1rJmuzsJ8tO6VjDaOCNEsyXVSciLPxV/UkzlkwXI9npFhCoYLXcNgeVAO5EKUDKQtvpAcJVXhFgucEcMzd0RIj1J0z6vfy/CPGjeBDuqt2SFcO8avI1+92di
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id kf13-20020a17090305cd00b001d8f393f3cfsm4968659plb.248.2024.02.11.20.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 20:35:36 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rZO2X-005Lcx-1m;
	Mon, 12 Feb 2024 15:35:33 +1100
Date: Mon, 12 Feb 2024 15:35:33 +1100
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
Message-ID: <ZcmgFThkhh9HYsXh@dread.disaster.area>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <ZZzP6731XwZQnz0o@dread.disaster.area>
 <3ba0dffa-beea-478f-bb6e-777b6304fb69@kernel.org>
 <ZcUQfzfQ9R8X0s47@tiehlicka>
 <3aa399bb-5007-4d12-88ae-ed244e9a653f@kernel.org>
 <ZclyYBO0vcQHZ5dV@dread.disaster.area>
 <5p4zwxtfqwm3wgvzwqfg6uwy5m3lgpfypij4fzea63gu67ve4t@77to5kukmiic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5p4zwxtfqwm3wgvzwqfg6uwy5m3lgpfypij4fzea63gu67ve4t@77to5kukmiic>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240211_203538_025387_1F9F841A 
X-CRM114-Status: GOOD (  52.74  )
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

On Sun, Feb 11, 2024 at 09:06:33PM -0500, Kent Overstreet wrote:
> On Mon, Feb 12, 2024 at 12:20:32PM +1100, Dave Chinner wrote:
> > On Thu, Feb 08, 2024 at 08:55:05PM +0100, Vlastimil Babka (SUSE) wrote:
> > > On 2/8/24 18:33, Michal Hocko wrote:
> > > > On Thu 08-02-24 17:02:07, Vlastimil Babka (SUSE) wrote:
> > > >> On 1/9/24 05:47, Dave Chinner wrote:
> > > >> > On Thu, Jan 04, 2024 at 09:17:16PM +0000, Matthew Wilcox wrote:
> > > >> 
> > > >> Your points and Kent's proposal of scoped GFP_NOWAIT [1] suggests to me this
> > > >> is no longer FS-only topic as this isn't just about converting to the scoped
> > > >> apis, but also how they should be improved.
> > > > 
> > > > Scoped GFP_NOFAIL context is slightly easier from the semantic POV than
> > > > scoped GFP_NOWAIT as it doesn't add a potentially unexpected failure
> > > > mode. It is still tricky to deal with GFP_NOWAIT requests inside the
> > > > NOFAIL scope because that makes it a non failing busy wait for an
> > > > allocation if we need to insist on scope NOFAIL semantic. 
> > > > 
> > > > On the other hand we can define the behavior similar to what you
> > > > propose with RETRY_MAYFAIL resp. NORETRY. Existing NOWAIT users should
> > > > better handle allocation failures regardless of the external allocation
> > > > scope.
> > > > 
> > > > Overriding that scoped NOFAIL semantic with RETRY_MAYFAIL or NORETRY
> > > > resembles the existing PF_MEMALLOC and GFP_NOMEMALLOC semantic and I do
> > > > not see an immediate problem with that.
> > > > 
> > > > Having more NOFAIL allocations is not great but if you need to
> > > > emulate those by implementing the nofail semantic outside of the
> > > > allocator then it is better to have those retries inside the allocator
> > > > IMO.
> > > 
> > > I see potential issues in scoping both the NOWAIT and NOFAIL
> > > 
> > > - NOFAIL - I'm assuming Dave is adding __GFP_NOFAIL to xfs allocations or
> > > adjacent layers where he knows they must not fail for his transaction. But
> > > could the scope affect also something else underneath that could fail
> > > without the failure propagating in a way that it affects xfs?
> > 
> > Memory allocaiton failures below the filesystem (i.e. in the IO
> > path) will fail the IO, and if that happens for a read IO within
> > a transaction then it will have the same effect as XFS failing a
> > memory allocation. i.e. it will shut down the filesystem.
> > 
> > The key point here is the moment we go below the filesystem we enter
> > into a new scoped allocation context with a guaranteed method of
> > returning errors: NOIO and bio errors.
> 
> Hang on, you're conflating NOIO to mean something completely different -
> NOIO means "don't recurse in reclaim", it does _not_ mean anything about
> what happens when the allocation fails,

Yes, I know that's what NOIO means. I'm not conflating it with
anything else.

> and in particular it definitely
> does _not_ mean that failing the allocation is going to result in an IO
> error.

Exactly. FS level NOFAIL contexts simply do not apply to NOIO
context functionality. NOIO contexts require different mechanisms to
guarantee forwards progress under memory pressure. They work
pretty well, and we don't want or need to perturb them by having
them inherit filesystem level NOFAIL semantics.

i.e. architecturally speaking, NOIO is a completely separate
allocation domain to NOFS.

> That's because in general most code in the IO path knows how to make
> effective use of biosets and mempools (which may take some work! you
> have to ensure that you're always able to make forward progress when
> memory is limited, and in particular that you don't double allocate from
> the same mempool if you're blocking the first allocation from
> completing/freeing).

Yes, I understand this, and that's my point: NOIO context tends to
be able to use mempools and other mechanisms to prevent memory
allocation failure, not NOFAIL.

The IO layers are request based and that enables one-in, one out
allocation pools that can guarantee single IO progress. That's all
the IO layers need to guarantee to the filesystems so that forwards
progress can always be made until memory pressure.

However, filesystems cannot guarantee "one in, one out" allocation
behaviour. A transaction can require a largely unbound number of
memory allocations to succeed to make progress through to
completion, and so things like mempools -cannot be used- to prevent
memory allocation failures whilst providing a forwards progress
guarantee.

Hence a NOFAIL scope if useful at the filesystem layer for
filesystem objects to ensure forwards progress under memory
pressure, but it is compeltely unnecessary once we transition to the
IO layer where forwards progress guarantees ensure memory allocation
failures don't impede progress.

IOWs, we only need NOFAIL at the NOFS layers, not at the NOIO
layers. The entry points to the block layer should transition the
task to NOIO context and restore the previous context on exit. Then
it becomes relatively trivial to apply context based filtering of
allocation behaviour....

> > i.e NOFAIL scopes are not relevant outside the subsystem that sets
> > it.  Hence we likely need helpers to clear and restore NOFAIL when
> > we cross an allocation context boundaries. e.g. as we cross from
> > filesystem to block layer in the IO stack via submit_bio(). Maybe
> > they should be doing something like:
> > 
> > 	nofail_flags = memalloc_nofail_clear();
> 
> NOFAIL is not a scoped thing at all, period; it is very much a
> _callsite_ specific thing, and it depends on whether that callsite has a
> fallback.

*cough*

As I've already stated, NOFAIL allocation has been scoped in XFS for
the past 20 years.

Every memory allocation inside a transaction *must* be NOFAIL unless
otherwise specified because memory allocation inside a dirty
transaction is a fatal error. However, that scoping has never been
passed to the NOIO contexts below the filesytsem - it's scoped
purely within the filesystem itself and doesn't pass on to other
subsystems the filesystem calls into.

> The most obvious example being, as mentioned previously, mempools.

Yes, they require one-in, one-out guarantees to avoid starvation and
ENOMEM situations. Which, as we've known since mempools were
invented, these guarantees cannot be provided by most filesystems.

> > > - NOWAIT - as said already, we need to make sure we're not turning an
> > > allocation that relied on too-small-to-fail into a null pointer exception or
> > > BUG_ON(!page).
> > 
> > Agreed. NOWAIT is removing allocation failure constraints and I
> > don't think that can be made to work reliably. Error injection
> > cannot prove the absence of errors  and so we can never be certain
> > the code will always operate correctly and not crash when an
> > unexepected allocation failure occurs.
> 
> You saying we don't know how to test code?

Yes, that's exactly what I'm saying.

I'm also saying that designing algorithms that aren't fail safe is
poor design. If you get it wrong and nothing bad can happen as a
result, then the design is fine.

But if the result of missing something accidentally is that the
system is guaranteed to crash when that is hit, then failure is
guaranteed and no amount of testing will prevent that failure from
occurring.

And we suck at testing, so we absolutely need to design fail
safe algorithms and APIs...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

