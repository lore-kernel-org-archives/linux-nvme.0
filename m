Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCE8C4828F
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Feb 2024 19:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fsPJ5omAsHbebGoKAX+m54ZzUdjULnFYtbhcZzgcDQw=; b=41Gh7G7yuteSzZTbaM6GPfiX4y
	FmWGRt/VCpUFAicfkGBuODnuZzQprkFGqinYJiKE5ZCzOu1vcqQAEcPZHnqjBRpTy2YPfmf1T4RKl
	ALNp+FZ/KY5R0SAYc/SsA39mVhwn9S16MKMDt4YKSPaIEfPOJ1mb9s5TS0Npg88ZSN2IW8Ogoo7fx
	7FSLsVlQUM4xqEY+WSxo7ovPrRgWozzwrKUihXGhJtd+1FySXLTEzwJxC+WlbPX+Dmd0s+lnZyD0c
	ADPDAoUn1XysYAaaJB/AbkSD3dOR6ln3zC5Ho2nxSjXOAtQ0scPYztiKW3Hb89iZTPY54/LWgW6Ne
	EdvEc02w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYAUM-0000000Eo51-1YF1;
	Thu, 08 Feb 2024 19:55:14 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYAUJ-0000000Eo4I-15Z2
	for linux-nvme@lists.infradead.org;
	Thu, 08 Feb 2024 19:55:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A536961EE1;
	Thu,  8 Feb 2024 19:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C640C433F1;
	Thu,  8 Feb 2024 19:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707422110;
	bh=lOfJwpXUdnEs4NdD2l4UxOLwSgcIGRsZp7hL7KAWBwk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fHFRsg6WccEchUFyrMTDbpsND8UtEeB7G2dQt7WSwW8EOSdvsfxtiFUpL1Bdc8Bek
	 mh+UH3E7pdkOXekpzAzB2Pte0DAjqeQI7oJCq5r591oq0M4sd/i3vPYbBzncVnNDqg
	 VdQaxpWDwOL96HRfsQNAt52NDO1G0JOuNMlGofKNd9hhSd8oBzVG7s6bJ8A8fR5LBJ
	 yysBINVtEdH6Xnc0eqoSx/ALVkQLvXDJRAk7TG96ukqW5tcoESko0YM4DQ9pryNltg
	 B7qluL+vCL/+79c0MwGCki1auhtFUIYmiLQZ3ztfxrpEONfxrA79RQpZ5zr/curMdQ
	 h/meCLWH4APjQ==
Message-ID: <3aa399bb-5007-4d12-88ae-ed244e9a653f@kernel.org>
Date: Thu, 8 Feb 2024 20:55:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>
Cc: Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>,
 lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 Kent Overstreet <kent.overstreet@gmail.com>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <ZZzP6731XwZQnz0o@dread.disaster.area>
 <3ba0dffa-beea-478f-bb6e-777b6304fb69@kernel.org>
 <ZcUQfzfQ9R8X0s47@tiehlicka>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <ZcUQfzfQ9R8X0s47@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240208_115511_431119_37283DE6 
X-CRM114-Status: GOOD (  26.10  )
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

On 2/8/24 18:33, Michal Hocko wrote:
> On Thu 08-02-24 17:02:07, Vlastimil Babka (SUSE) wrote:
>> On 1/9/24 05:47, Dave Chinner wrote:
>> > On Thu, Jan 04, 2024 at 09:17:16PM +0000, Matthew Wilcox wrote:
>> 
>> Your points and Kent's proposal of scoped GFP_NOWAIT [1] suggests to me this
>> is no longer FS-only topic as this isn't just about converting to the scoped
>> apis, but also how they should be improved.
> 
> Scoped GFP_NOFAIL context is slightly easier from the semantic POV than
> scoped GFP_NOWAIT as it doesn't add a potentially unexpected failure
> mode. It is still tricky to deal with GFP_NOWAIT requests inside the
> NOFAIL scope because that makes it a non failing busy wait for an
> allocation if we need to insist on scope NOFAIL semantic. 
> 
> On the other hand we can define the behavior similar to what you
> propose with RETRY_MAYFAIL resp. NORETRY. Existing NOWAIT users should
> better handle allocation failures regardless of the external allocation
> scope.
> 
> Overriding that scoped NOFAIL semantic with RETRY_MAYFAIL or NORETRY
> resembles the existing PF_MEMALLOC and GFP_NOMEMALLOC semantic and I do
> not see an immediate problem with that.
> 
> Having more NOFAIL allocations is not great but if you need to
> emulate those by implementing the nofail semantic outside of the
> allocator then it is better to have those retries inside the allocator
> IMO.

I see potential issues in scoping both the NOWAIT and NOFAIL

- NOFAIL - I'm assuming Dave is adding __GFP_NOFAIL to xfs allocations or
adjacent layers where he knows they must not fail for his transaction. But
could the scope affect also something else underneath that could fail
without the failure propagating in a way that it affects xfs? Maybe it's a
high-order allocation with a low-order fallback that really should not be
__GFP_NOFAIL? We would need to hope it has something like RETRY_MAYFAIL or
NORETRY already. But maybe it just relies on >costly order being more likely
to fail implicitly, and those costly orders should be kept excluded from the
scoped NOFAIL? Maybe __GFP_NOWARN should also override the scoped nofail?

- NOWAIT - as said already, we need to make sure we're not turning an
allocation that relied on too-small-to-fail into a null pointer exception or
BUG_ON(!page). It's probably not feasible to audit everything that can be
called underneath when adding a new scoped NOWAIT. Static analysis probably
won't be powerful enough as well. Kent suggested fault injection [1]. We
have the framework for a system-wide one but I don't know if anyone is
running it and how successful it is. But maybe we could have a special fault
injection mode (CONFIG_ option or something) for the NOWAIT scoped
allocations only. If everything works as expected, there are no crashes and
the pattern Kent described in [1] has a fallback that's slower but still
functional. If not, we get a report and known which place to fix, and the
testing only focuses on the relevant parts. When a new scoped NOWAIT is
added and bots/CIs running this fault injection config report no issues, we
can be reasonably sure it's fine?

[1]
https://lore.kernel.org/all/zup5yilebkgkrypis4g6zkbft7pywqi57k5aztoio2ufi5ujsd@mfnqu4rarort/

>> [1] http://lkml.kernel.org/r/Zbu_yyChbCO6b2Lj@tiehlicka
>> 
>> > We already have memalloc_noreclaim_{save/restore}() for turning off
>> > direct memory reclaim for a given context (i.e. equivalent of
>> > clearing __GFP_DIRECT_RECLAIM), so if we are going to embrace scoped
>> > allocation contexts, then we should be going all in and providing
>> > all the contexts that filesystems actually need....
>> > 
>> > -Dave.
> 


