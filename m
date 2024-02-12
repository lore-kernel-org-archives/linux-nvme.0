Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B588C4829B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 02:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zGpbWcfwQU4LVqL/ANKrblaGXAW8mRNF+7w5voOO+QQ=; b=vdXadgY8bIan7OORzeoGPln4eY
	aiiLN4a2DuaM3+8CfDkmNLBkEMZWnPcfJCtec9gVZSLW1fxf9aJn941zmzUzsoXmWcL6/tXZPUe7i
	9cOaUfJ81v/XC8fx3YF7rkIjZSv3hGwsEygGnEwicRXzBwMpRX9pE2t8RFB5pUjKDTCiy++nJmFfF
	bIUHL0dM1DyuGRSUR4fOmim1C0Rz6zht6AwOMgCz279XjcoCrucsDP1h092UwpHUtPNtRFu9tfgET
	Ab0FSD5xGQz2XEME97wWh+pf5XusfVkKq7rFBEdtvncmvZcfDIURIfNqU0nrOTajc8UlzsaLZdeZm
	AvzB2aGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZM5I-000000048wc-2Prz;
	Mon, 12 Feb 2024 02:30:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZL02-00000003u0C-2mVr
	for linux-nvme@bombadil.infradead.org;
	Mon, 12 Feb 2024 01:20:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zGpbWcfwQU4LVqL/ANKrblaGXAW8mRNF+7w5voOO+QQ=; b=NgWbB8D6h1D6jTtfRqCqBTQmAA
	S9O8NWsao+vY+SFzvEwIimiBQEf1wYbjEFdDX86zaA6TRBwhnKEL0orgcINNJxhdtQv0SQoSBO9OU
	sOPXd2JtsNR5CzWfuM9gFGLBPiYMLjUq0DS0txnbthAeFS+r6LJGX0Ie1L/JlpjS4tetJEN474BF7
	0rhrmRrxkBD3HXetI649CdHT5QtOVK6DwTZ61XLmMjxMdjgNVqTuAVOH0ICwZtYox4VHzQ+9Bh/0w
	tB/gCvTpJgpWW3OFvUHqy3DW3RRr450AkXqMIsljjo3VHkaeTdVeJpLVTXvN5Tt1FCptG2YcgLvT3
	7vkEj8cQ==;
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZKzz-0000000F3i9-0GE1
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 01:20:45 +0000
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-21920c78c9fso1643476fac.1
        for <linux-nvme@lists.infradead.org>; Sun, 11 Feb 2024 17:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707700836; x=1708305636; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zGpbWcfwQU4LVqL/ANKrblaGXAW8mRNF+7w5voOO+QQ=;
        b=t257LjBVPWTviK1V3TMDsrbw1bFfb3KSU7we8SnnP7Y9Py/T6riTwJGQpLOkLDAQcp
         7SjTZ/7xjTa3nwWaWGnhXiltHe10ZbK3C6LwX2lRXNXvcBvrm/f196E1ZAOcTReUWsqd
         cdZFMYFPAjXsmMIw9f5guSMlXG7OxsOZQnhBlTlQCppmcdy8SPWhY/pDNgnJ0sNAfyHD
         QsoQccF1HPG3hUf2Iiv5qL4rvPeCyf3IZpo47fh0CLYn54FoTnZ9o2S6PMQrEzfF75J4
         QZVig2axB4KH8/Q6cUn4d73DxZnBri4PiAsRQV8IhMcq5AC4od7mwWAoopODmqz+Y2jQ
         YhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707700836; x=1708305636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGpbWcfwQU4LVqL/ANKrblaGXAW8mRNF+7w5voOO+QQ=;
        b=ilci2RgkUPRDkuacIdMkOh+euz1rE61arYyVy9nR6Yf7oO5nsdwg2kTPzHHu9i/vSL
         GvbznUqGmvPnj0Xcme/ztsBTLHX3OLv3B6GVYQMDOHsGTqE51kq5PQ3cMpqwWlmCxSyf
         nWas4z8TtOmeXTCqrvkh43xyJcTD8dvsgDqjb5bASoZ1t2s01ZtG9wlI5bvmkEcv87h/
         doRwG5ce0eNLRnz/v+TMDVdALLpOQWYg29JUZO+kK58nprqZp5JJVoTow1D6hn4Ogt5E
         ua84fgcj1JACAFyXJHEoNlTm6fyEalqj9LUjhPgoX81Kyu6bpPk6M7xGg9D7bbgTCkUr
         jDQw==
X-Gm-Message-State: AOJu0Yzzb1HSLh5Txt7f3xipLJ9p3xQ7/OVfY6YV0q9Ckq794M8AYi7H
	7ewgdae1DBvGvdWcDcCZVwQIkbYJUrB2loTsjHvztRgEkvYNKyquJrX2WpwQIoY=
X-Google-Smtp-Source: AGHT+IGgzZfJ5MrlRBimvLaq2eWIMRYS7eIl1L8FsxbVpNRlgcJNKvUgAVQugoKnaLI/DUbFaYMsZQ==
X-Received: by 2002:a05:6870:fba4:b0:219:d60e:92c2 with SMTP id kv36-20020a056870fba400b00219d60e92c2mr7064846oab.34.1707700836697;
        Sun, 11 Feb 2024 17:20:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZDYUZSbhur42pGyKP46OTNJeg9O4vyN0rt5q6Db4n5o1xjnjmewhgy5pjV8Yka3kQcDvepjkHZ2eUjCzj7I3RwflAA2aA1GqWmpBsTqeQnZY1o7PP8fyNYN0e2tiPlEza3YG2aGjFQs8R+hQWspLhBEtJhRVvjuBw3q08pTUtxMBArQxIYC2gIIH579/1f4YYP3wGpIjGBileEZz2C2Ua2g7XUbnplD7CodPEopniMvSmtGoCnO6Mimpp362/ccVIJBT/u7Zc0nIndQ8kpzwyzbKzmqZYDqnqClLqXU0+/Hexp8cbhuZfHzL0aN+G70o7OdvEAEKw+3iIYBB5jLVfKnecAka+v6fXgzEGxHq4/P09A1UCkIouwY1E+25n139b4SRX4MkLZg==
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id j17-20020a635951000000b005d8b2f04eb7sm5604643pgm.62.2024.02.11.17.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 17:20:35 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rZKzo-005HoK-1j;
	Mon, 12 Feb 2024 12:20:32 +1100
Date: Mon, 12 Feb 2024 12:20:32 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Message-ID: <ZclyYBO0vcQHZ5dV@dread.disaster.area>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <ZZzP6731XwZQnz0o@dread.disaster.area>
 <3ba0dffa-beea-478f-bb6e-777b6304fb69@kernel.org>
 <ZcUQfzfQ9R8X0s47@tiehlicka>
 <3aa399bb-5007-4d12-88ae-ed244e9a653f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aa399bb-5007-4d12-88ae-ed244e9a653f@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_012043_476480_36234F07 
X-CRM114-Status: GOOD (  35.08  )
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

On Thu, Feb 08, 2024 at 08:55:05PM +0100, Vlastimil Babka (SUSE) wrote:
> On 2/8/24 18:33, Michal Hocko wrote:
> > On Thu 08-02-24 17:02:07, Vlastimil Babka (SUSE) wrote:
> >> On 1/9/24 05:47, Dave Chinner wrote:
> >> > On Thu, Jan 04, 2024 at 09:17:16PM +0000, Matthew Wilcox wrote:
> >> 
> >> Your points and Kent's proposal of scoped GFP_NOWAIT [1] suggests to me this
> >> is no longer FS-only topic as this isn't just about converting to the scoped
> >> apis, but also how they should be improved.
> > 
> > Scoped GFP_NOFAIL context is slightly easier from the semantic POV than
> > scoped GFP_NOWAIT as it doesn't add a potentially unexpected failure
> > mode. It is still tricky to deal with GFP_NOWAIT requests inside the
> > NOFAIL scope because that makes it a non failing busy wait for an
> > allocation if we need to insist on scope NOFAIL semantic. 
> > 
> > On the other hand we can define the behavior similar to what you
> > propose with RETRY_MAYFAIL resp. NORETRY. Existing NOWAIT users should
> > better handle allocation failures regardless of the external allocation
> > scope.
> > 
> > Overriding that scoped NOFAIL semantic with RETRY_MAYFAIL or NORETRY
> > resembles the existing PF_MEMALLOC and GFP_NOMEMALLOC semantic and I do
> > not see an immediate problem with that.
> > 
> > Having more NOFAIL allocations is not great but if you need to
> > emulate those by implementing the nofail semantic outside of the
> > allocator then it is better to have those retries inside the allocator
> > IMO.
> 
> I see potential issues in scoping both the NOWAIT and NOFAIL
> 
> - NOFAIL - I'm assuming Dave is adding __GFP_NOFAIL to xfs allocations or
> adjacent layers where he knows they must not fail for his transaction. But
> could the scope affect also something else underneath that could fail
> without the failure propagating in a way that it affects xfs?

Memory allocaiton failures below the filesystem (i.e. in the IO
path) will fail the IO, and if that happens for a read IO within
a transaction then it will have the same effect as XFS failing a
memory allocation. i.e. it will shut down the filesystem.

The key point here is the moment we go below the filesystem we enter
into a new scoped allocation context with a guaranteed method of
returning errors: NOIO and bio errors.

Once we cross an allocation scope boundary, NOFAIL is no
longer relevant to the code that is being run because there are
other errors that can occur that the filesysetm must handle
that. Hence memory allocation errors just don't matter at this
point, and the NOFAIL constraint is no longer relevant.

Hence we really need to conside NOFAIL differently to NOFS/NOIO.
NOFS/NOIO are about avoiding reclaim recursion deadlocks, so are
relevant all the way down the stack. NOFAIL is only relevant to a
specific subsystem to prevent subsystem allocations from failing,
but as soon as we cross into another subsystem that can (and does)
return errors for memory allocation failures, the NOFAIL context is
no longer relevant.

i.e NOFAIL scopes are not relevant outside the subsystem that sets
it.  Hence we likely need helpers to clear and restore NOFAIL when
we cross an allocation context boundaries. e.g. as we cross from
filesystem to block layer in the IO stack via submit_bio(). Maybe
they should be doing something like:

	nofail_flags = memalloc_nofail_clear();
	noio_flags = memalloc_noio_save();

	....

	memalloc_noio_restore(noio_flags);
	memalloc_nofail_reinstate(nofail_flags);

> Maybe it's a
> high-order allocation with a low-order fallback that really should not be
> __GFP_NOFAIL? We would need to hope it has something like RETRY_MAYFAIL or
> NORETRY already. But maybe it just relies on >costly order being more likely
> to fail implicitly, and those costly orders should be kept excluded from the
> scoped NOFAIL? Maybe __GFP_NOWARN should also override the scoped nofail?

We definitely need NORETRY/RETRY_MAYFAIL to override scoped NOFAIL
at the filesystem layer (e.g. for readahead buffer allocations,
xlog_kvmalloc(), etc to correctly fail fast within XFS
transactions), but I don't think we should force every subsystem to
have to do this just in case a higher level subsystem had a scoped
NOFAIL set for it to work correctly.

> - NOWAIT - as said already, we need to make sure we're not turning an
> allocation that relied on too-small-to-fail into a null pointer exception or
> BUG_ON(!page).

Agreed. NOWAIT is removing allocation failure constraints and I
don't think that can be made to work reliably. Error injection
cannot prove the absence of errors  and so we can never be certain
the code will always operate correctly and not crash when an
unexepected allocation failure occurs.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

