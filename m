Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D00CC4828F
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Feb 2024 16:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K6yzxiBXb0wFPjacWgz8OttgSJ24QLmHEVfAP2h3kqY=; b=HTSwX95S9dOT3DO492E6TzHbpd
	3fBJkfUToLv1a+37KTaGckDN1ouTczw3f4F1nrVbYzejUNkMwvH1MZR+o5EIzQsGS93GCDLWnUK5B
	kuc1dXwz9+LCI8U/OlU3hCzKScVA2++7H3dQoY+DkK6vKpQM/t3TGI4R5MLYcTroWaIANhukW6Nra
	IfEOiYhHfs9pVjob//ipvJHChA6NHBUMmsQLHQXOVo9Ie1XNFbztoCaoXf4rnKT0ZJTTBIErsupBp
	TG+k6NvwXOudv9V/2WnWvInU1wQCaNMfSG1btBsxI1VwEOwnJttQFnP4rEV2DEvWnueOX97Z8sgeQ
	yYcM7uyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rY6r0-0000000EFl7-2BuF;
	Thu, 08 Feb 2024 16:02:22 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rY6qw-0000000EFhT-02q7
	for linux-nvme@lists.infradead.org;
	Thu, 08 Feb 2024 16:02:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B4E80CE1D80;
	Thu,  8 Feb 2024 16:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC76CC433C7;
	Thu,  8 Feb 2024 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707408132;
	bh=uTFe5CG7oWonbpeVbz5UaAiaJEjR9X1sZYLpZSCrroE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=obJpFnU3wW/7vWnQ2T7KbJTN1o0DhsaGAsrrj2BVE8zioOEqxNl2MiXnaak9whqbt
	 OIDJi1LDw4Ob4TOyMXecgyYlB0ULe8cbKEYD18dH7iv2VOYpw90ipR40HRow6soWvg
	 DkCTi37Z6twlWFr7xB9SDcp4WUYNmxbMlDbECEGxFl+2eUYoaRKZIyH7IwHvpQ9BQu
	 nNUhloOm8p60q6R9WsjvEZT4tnO900WaEIv/prTxnu+YOB1xTOPKTTYP8o7TuhLlr2
	 Ljl07+/LdqTtHEHadWQ3k0UZK64B9xF+oq5GtFxTc70ZUxMclN84FsAWvnJLmt4GnN
	 Cj4n/P6UyVT+g==
Message-ID: <3ba0dffa-beea-478f-bb6e-777b6304fb69@kernel.org>
Date: Thu, 8 Feb 2024 17:02:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 Kent Overstreet <kent.overstreet@gmail.com>, Michal Hocko <mhocko@kernel.org>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <ZZzP6731XwZQnz0o@dread.disaster.area>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <ZZzP6731XwZQnz0o@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240208_080218_414273_6BB05617 
X-CRM114-Status: GOOD (  27.10  )
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

On 1/9/24 05:47, Dave Chinner wrote:
> On Thu, Jan 04, 2024 at 09:17:16PM +0000, Matthew Wilcox wrote:
>> This is primarily a _FILESYSTEM_ track topic.  All the work has already
>> been done on the MM side; the FS people need to do their part.  It could
>> be a joint session, but I'm not sure there's much for the MM people
>> to say.
>> 
>> There are situations where we need to allocate memory, but cannot call
>> into the filesystem to free memory.  Generally this is because we're
>> holding a lock or we've started a transaction, and attempting to write
>> out dirty folios to reclaim memory would result in a deadlock.
>> 
>> The old way to solve this problem is to specify GFP_NOFS when allocating
>> memory.  This conveys little information about what is being protected
>> against, and so it is hard to know when it might be safe to remove.
>> It's also a reflex -- many filesystem authors use GFP_NOFS by default
>> even when they could use GFP_KERNEL because there's no risk of deadlock.
>> 
>> The new way is to use the scoped APIs -- memalloc_nofs_save() and
>> memalloc_nofs_restore().  These should be called when we start a
>> transaction or take a lock that would cause a GFP_KERNEL allocation to
>> deadlock.  Then just use GFP_KERNEL as normal.  The memory allocators
>> can see the nofs situation is in effect and will not call back into
>> the filesystem.
> 
> So in rebasing the XFS kmem.[ch] removal patchset I've been working
> on, there is a clear memory allocator function that we need to be
> scoped: __GFP_NOFAIL.
> 
> All of the allocations done through the existing XFS kmem.[ch]
> interfaces (i.e just about everything) have __GFP_NOFAIL semantics
> added except in the explicit cases where we add KM_MAYFAIL to
> indicate that the allocation can fail.
> 
> The result of this conversion to remove GFP_NOFS is that I'm also
> adding *dozens* of __GFP_NOFAIL annotations because we effectively
> scope that behaviour.
> 
> Hence I think this discussion needs to consider that __GFP_NOFAIL is
> also widely used within critical filesystem code that cannot
> gracefully recover from memory allocation failures, and that this
> would also be useful to scope....
> 
> Yeah, I know, mm developers hate __GFP_NOFAIL. We've been using
> these semantics NOFAIL in XFS for over 2 decades and the sky hasn't
> fallen. So can we get memalloc_nofail_{save,restore}() so that we
> can change the default allocation behaviour in certain contexts
> (e.g. the same contexts we need NOFS allocations) to be NOFAIL
> unless __GFP_RETRY_MAYFAIL or __GFP_NORETRY are set?

Your points and Kent's proposal of scoped GFP_NOWAIT [1] suggests to me this
is no longer FS-only topic as this isn't just about converting to the scoped
apis, but also how they should be improved.

[1] http://lkml.kernel.org/r/Zbu_yyChbCO6b2Lj@tiehlicka

> We already have memalloc_noreclaim_{save/restore}() for turning off
> direct memory reclaim for a given context (i.e. equivalent of
> clearing __GFP_DIRECT_RECLAIM), so if we are going to embrace scoped
> allocation contexts, then we should be going all in and providing
> all the contexts that filesystems actually need....
> 
> -Dave.


