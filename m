Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2FEC48260
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Feb 2024 17:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h+0yrZSpModLNFXQZ0NEsCQ5tcdSJqQ6dM1FajfCnoo=; b=W6gwH1za/uEzAYInFpn+1JIxih
	MT+AYYIdZnivugGwOqijYIShMum4a1Oo3Otl6qBdNJllfUcjKCEtHKtd5ws8LponVCdNVeDb6M7B/
	x5jjH7F+mtNokgCX8wdMbL6A1csRy2v411Ah7YJwDTR1oToAzop7aaVIEAMu/CulEMcItUafUDbnz
	lAekPZywyzCXiZOH/KkEgcQjpiNlCSvwYq2Hvi4cPgqOFXaTZibPUhSJ8kwkk4FyY91Ux3hHy6BpK
	wU1OUn8u8QmFRb36fFeNFXMIYii2Tnrjh7u4XWwXGe7ECIrNcEIbHTEjGgWwnM/8TTthcR0X55kt6
	TVZdL4lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rY8ID-0000000EVOW-1BSp;
	Thu, 08 Feb 2024 17:34:33 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rY8Hx-0000000EVH2-47uZ
	for linux-nvme@lists.infradead.org;
	Thu, 08 Feb 2024 17:34:24 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B4EE31FCF9;
	Thu,  8 Feb 2024 17:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707413640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h+0yrZSpModLNFXQZ0NEsCQ5tcdSJqQ6dM1FajfCnoo=;
	b=PVo85f/e969ansHigCZ/BOT2nRHWSGTtyW7NhAYAtWxIm5uDdmmXtqnXuglrPVa8S7yKQa
	ETmZvxkSepFS893Tiks6wNVWNNAyQDFyA8kfnKIX9N7ofuAkTGF8lW0NfTwYfL34Q2NuXo
	Zw65V8TjJ6szvDqKcrQlAb1m/0JDwSU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707413640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h+0yrZSpModLNFXQZ0NEsCQ5tcdSJqQ6dM1FajfCnoo=;
	b=PVo85f/e969ansHigCZ/BOT2nRHWSGTtyW7NhAYAtWxIm5uDdmmXtqnXuglrPVa8S7yKQa
	ETmZvxkSepFS893Tiks6wNVWNNAyQDFyA8kfnKIX9N7ofuAkTGF8lW0NfTwYfL34Q2NuXo
	Zw65V8TjJ6szvDqKcrQlAb1m/0JDwSU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98F9513984;
	Thu,  8 Feb 2024 17:34:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qh9aIogQxWUQHwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 08 Feb 2024 17:34:00 +0000
Date: Thu, 8 Feb 2024 18:33:51 +0100
From: Michal Hocko <mhocko@suse.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Message-ID: <ZcUQfzfQ9R8X0s47@tiehlicka>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <ZZzP6731XwZQnz0o@dread.disaster.area>
 <3ba0dffa-beea-478f-bb6e-777b6304fb69@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ba0dffa-beea-478f-bb6e-777b6304fb69@kernel.org>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="PVo85f/e"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[fromorbit.com,infradead.org,lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.infradead.org,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: B4EE31FCF9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240208_093419_237258_6DAB6FA2 
X-CRM114-Status: GOOD (  39.34  )
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

On Thu 08-02-24 17:02:07, Vlastimil Babka (SUSE) wrote:
> On 1/9/24 05:47, Dave Chinner wrote:
> > On Thu, Jan 04, 2024 at 09:17:16PM +0000, Matthew Wilcox wrote:
> >> This is primarily a _FILESYSTEM_ track topic.  All the work has already
> >> been done on the MM side; the FS people need to do their part.  It could
> >> be a joint session, but I'm not sure there's much for the MM people
> >> to say.
> >> 
> >> There are situations where we need to allocate memory, but cannot call
> >> into the filesystem to free memory.  Generally this is because we're
> >> holding a lock or we've started a transaction, and attempting to write
> >> out dirty folios to reclaim memory would result in a deadlock.
> >> 
> >> The old way to solve this problem is to specify GFP_NOFS when allocating
> >> memory.  This conveys little information about what is being protected
> >> against, and so it is hard to know when it might be safe to remove.
> >> It's also a reflex -- many filesystem authors use GFP_NOFS by default
> >> even when they could use GFP_KERNEL because there's no risk of deadlock.
> >> 
> >> The new way is to use the scoped APIs -- memalloc_nofs_save() and
> >> memalloc_nofs_restore().  These should be called when we start a
> >> transaction or take a lock that would cause a GFP_KERNEL allocation to
> >> deadlock.  Then just use GFP_KERNEL as normal.  The memory allocators
> >> can see the nofs situation is in effect and will not call back into
> >> the filesystem.
> > 
> > So in rebasing the XFS kmem.[ch] removal patchset I've been working
> > on, there is a clear memory allocator function that we need to be
> > scoped: __GFP_NOFAIL.
> > 
> > All of the allocations done through the existing XFS kmem.[ch]
> > interfaces (i.e just about everything) have __GFP_NOFAIL semantics
> > added except in the explicit cases where we add KM_MAYFAIL to
> > indicate that the allocation can fail.
> > 
> > The result of this conversion to remove GFP_NOFS is that I'm also
> > adding *dozens* of __GFP_NOFAIL annotations because we effectively
> > scope that behaviour.
> > 
> > Hence I think this discussion needs to consider that __GFP_NOFAIL is
> > also widely used within critical filesystem code that cannot
> > gracefully recover from memory allocation failures, and that this
> > would also be useful to scope....
> > 
> > Yeah, I know, mm developers hate __GFP_NOFAIL. We've been using
> > these semantics NOFAIL in XFS for over 2 decades and the sky hasn't
> > fallen. So can we get memalloc_nofail_{save,restore}() so that we
> > can change the default allocation behaviour in certain contexts
> > (e.g. the same contexts we need NOFS allocations) to be NOFAIL
> > unless __GFP_RETRY_MAYFAIL or __GFP_NORETRY are set?
> 
> Your points and Kent's proposal of scoped GFP_NOWAIT [1] suggests to me this
> is no longer FS-only topic as this isn't just about converting to the scoped
> apis, but also how they should be improved.

Scoped GFP_NOFAIL context is slightly easier from the semantic POV than
scoped GFP_NOWAIT as it doesn't add a potentially unexpected failure
mode. It is still tricky to deal with GFP_NOWAIT requests inside the
NOFAIL scope because that makes it a non failing busy wait for an
allocation if we need to insist on scope NOFAIL semantic. 

On the other hand we can define the behavior similar to what you
propose with RETRY_MAYFAIL resp. NORETRY. Existing NOWAIT users should
better handle allocation failures regardless of the external allocation
scope.

Overriding that scoped NOFAIL semantic with RETRY_MAYFAIL or NORETRY
resembles the existing PF_MEMALLOC and GFP_NOMEMALLOC semantic and I do
not see an immediate problem with that.

Having more NOFAIL allocations is not great but if you need to
emulate those by implementing the nofail semantic outside of the
allocator then it is better to have those retries inside the allocator
IMO.

> [1] http://lkml.kernel.org/r/Zbu_yyChbCO6b2Lj@tiehlicka
> 
> > We already have memalloc_noreclaim_{save/restore}() for turning off
> > direct memory reclaim for a given context (i.e. equivalent of
> > clearing __GFP_DIRECT_RECLAIM), so if we are going to embrace scoped
> > allocation contexts, then we should be going all in and providing
> > all the contexts that filesystems actually need....
> > 
> > -Dave.

-- 
Michal Hocko
SUSE Labs

