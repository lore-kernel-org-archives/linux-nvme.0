Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E05CC48260
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Feb 2024 23:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W0JffnIev88BcC8Hl6egW1rjoWWfB2jwFQZciSPudNI=; b=cmWWOiw92D2QzijyQm7ViW0FVs
	t/9VHS9z3R0UFBGFoFhJR8gb4KltQgiBLokjs93woq3ZB6uu6gCsZXDO9PzpaLeJiw8R/0cBNBhvN
	m8onpN57JUgcZCzaXQA79D9+HrGNb2KRshDXzkl1DOWxSka+LTQt3vFNXoJpnxL5ApBUfzc0+A6+l
	Zuamr/27mPpa9S48QPwIrJcZml3sk5QWcSV2JH3VY3bxwSLoyjlKBJvl4+JDBTCFebfXG87vXQ0F3
	dw7qE3KPxnsm1F4Hgq4qvnmz2uTohne7pH/ANh5mx3+jNtXhzXvUNTsWKgJIvj/Q1R5S8T6RahTP+
	OSzsQvuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYE6U-0000000FZTw-3rxX;
	Thu, 08 Feb 2024 23:46:50 +0000
Received: from out-178.mta1.migadu.com ([2001:41d0:203:375::b2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYD8t-0000000FJJF-0goM
	for linux-nvme@lists.infradead.org;
	Thu, 08 Feb 2024 22:45:16 +0000
Date: Thu, 8 Feb 2024 17:45:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707432306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W0JffnIev88BcC8Hl6egW1rjoWWfB2jwFQZciSPudNI=;
	b=lezzZ+tth1kRqJyrWGGU9sTfubrW+ImjbBA+pOL5Zyj77Jb6V2xSyYhT2JTnYLoPj+y9mr
	N18RVopOFvf0ZYMtdbC8uL3XxLfP02z43Rf0IIfpkP7D9+gXog6JghmhcFAuXNwhGvPUP2
	QPc0CxJsE0Ao+uuOmFiOydtKo77qCqQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>, 
	Matthew Wilcox <willy@infradead.org>, lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Message-ID: <4qc7h3gun5lkv3p5piftgkhgmlbrgqteut3vxtjrme47kyn7q7@62ogk3chsrme>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <ZZzP6731XwZQnz0o@dread.disaster.area>
 <3ba0dffa-beea-478f-bb6e-777b6304fb69@kernel.org>
 <ZcUQfzfQ9R8X0s47@tiehlicka>
 <3aa399bb-5007-4d12-88ae-ed244e9a653f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aa399bb-5007-4d12-88ae-ed244e9a653f@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240208_144515_373752_D6F18E8E 
X-CRM114-Status: GOOD (  15.40  )
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
> - NOWAIT - as said already, we need to make sure we're not turning an
> allocation that relied on too-small-to-fail into a null pointer exception or
> BUG_ON(!page). It's probably not feasible to audit everything that can be
> called underneath when adding a new scoped NOWAIT. Static analysis probably
> won't be powerful enough as well. Kent suggested fault injection [1]. We
> have the framework for a system-wide one but I don't know if anyone is
> running it and how successful it is.

I've also got a better fault injection library in the pipeline - I'll be
posting it after memory allocation profiling is merged, since that has
the library code needed for the new fault injection.

The new stuff gives us (via the same hooks for memory allocation
profiling), per callsite individually controllable injection points -
which means it's way easier to inject memory allocation failures into
existing tests and write tests that cover a specific codepath.

e.g. what I used to do with this code was flip on random memory
allocation failures for all code in fs/bcachefs/ after mounting, and I
had every test doing that (at one point in time, bcachefs could handle
_any_ allocation failure after startup without reporting an error to
userspace, but sadly not quite anymore).

that, plus code coverage analysis should make this pretty tractable.

