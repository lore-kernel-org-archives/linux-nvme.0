Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAB1C4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 15:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZbGDeRJmDQjqTCeYEI4ULf6ULadhlIT0/4yy3wdLoGM=; b=UFJcJ/KWNbTG+w90hxGTL21axX
	NEVM7vJztaDadb0fhYgqVwIazLcGsdbH5pLVmdfCnpZSn1wXiYa598CE0mKmiRMU0p0t2Zv1q3h6l
	zmePkAj1c9C3jcMyfPttCATq5ASgx2EqaMa9JIFTaqz8SAZoaGwKgN1IEvC4yHVevJN3SnRGQc52h
	neeI04WWLEGJAJPNCK720YQ1ZSY2Ww4Nt/19uScJM4HKfnTzB9vVPMpr54Tp3zrfht6wiBnldNgzU
	A8sygeVmPDqKxR/YyTR4yypXWvG+YWonksiDEd57M+5n/3xanzcs2YGpFrGY8clKGcWrYJpZVFfl8
	3aalVmAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXkDZ-0000000B8wQ-2PKm;
	Wed, 07 Feb 2024 15:52:09 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXkDX-0000000B8vg-2YlZ
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 15:52:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B11B6CE13C7;
	Wed,  7 Feb 2024 15:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9B4C43394;
	Wed,  7 Feb 2024 15:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707321123;
	bh=/1x7h2DpHjWcd/k76A8g5THiTurxMbwv+SYlEW+93sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S4roDxo8tVqC2GezTlb3cfXFcp6weQcwLaiGZmdf1pdhhuOhtMsuGhDXsDCMV8GbO
	 RLxAo3vtpqHJdWUBeO1ZdBUc+YJEiBqPKnzeW10gKgdzx5yAj262qNEjatFr2oewA5
	 U96gkG8+cuJWYr/hLXC31VNHfddrz7/y70HWgLAxw3ppS44aI4YAdO6JffVBmwOlG8
	 XU9HW6HuV+8zPXv4xQ3gBEg6Ps5noXk7cufMK2v4qV4yePWova47vaD8FNN7s7EdTb
	 NB9oCYbsmwivsZGgDOIpD/iQoZTqpkGenaDhqgpVnREaQgX0b1oUD9pyX7pTlppedD
	 uLYLbPbnYYeQg==
Date: Wed, 7 Feb 2024 17:51:44 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Reclaiming & documenting page flags
Message-ID: <ZcOnEGyr6y3jei68@kernel.org>
References: <Zbcn-P4QKgBhyxdO@casper.infradead.org>
 <Zb9pZTmyb0lPMQs8@kernel.org>
 <ZcACya-MJr_fNRSH@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcACya-MJr_fNRSH@casper.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_075207_999123_232C09C0 
X-CRM114-Status: GOOD (  31.91  )
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

On Sun, Feb 04, 2024 at 09:34:01PM +0000, Matthew Wilcox wrote:
> On Sun, Feb 04, 2024 at 11:39:33AM +0100, Mike Rapoport wrote:
> > On Mon, Jan 29, 2024 at 04:32:03AM +0000, Matthew Wilcox wrote:
> > > Our documentation of the current page flags is ... not great.  I think
> > > I can improve it for the page cache side of things; I understand the
> > > meanings of locked, writeback, uptodate, dirty, head, waiters, slab,
> > > mlocked, mappedtodisk, error, hwpoison, readahead, anon_exclusive,
> > > has_hwpoisoned, hugetlb and large_remappable.
> > > 
> > > Where I'm a lot more shaky is the meaning of the more "real MM" flags,
> > > like active, referenced, lru, workingset, reserved, reclaim, swapbacked,
> > > unevictable, young, idle, swapcache, isolated, and reported.
> > > 
> > > Perhaps we could have an MM session where we try to explain slowly and
> > > carefully to each other what all these flags actually mean, talk about
> > > what combinations of them make sense, how we might eliminate some of
> > > them to make more space in the flags word, and what all this looks like
> > > in a memdesc world.
> > > 
> > > And maybe we can get some documentation written about it!  Not trying
> > > to nerd snipe Jon into attending this session, but if he did ...
> > 
> > I suspect Jon will be there anyway, but not sure he'd be willing to do the
> > writing :)
> > 
> > I was going to propose the "mm docs" session again, but this one seems more
> > useful than talking yet again about how hard it is to get MM documentation
> > done.
> 
> I'm doing my best to write documentation as I go.  I think we're a bit
> better off than we were last year.  Do we have scripts to tell us which
> public functions (ie EXPORT_SYMBOL and static inline functions in header
> files) have kernel-doc?  And could we run them against kernels from, say,
> April 2023, 2022, 2021, 2020, 2019 (and in two months against April 2024)
> and see how we're doing in terms of percentage undocumented functions?

We didn't have such script, but it was easy to compare "grep
EXPORT_SYMBOL\|static inline" with ".. c:function" in kernel-doc.
We do improve slowly, but we are still below 50% with kernel-doc for
EXPORT_SYMBOL functions and slightly above 10% for static inlines.

Although with static inlines it's quite possible that the percentage of
actual public API documentation is higher because some of the functions in
inlcude/linux/ are only used inside mm.

There are also APIs that are not EXPORT_SYMBOL, but I didn't find an easy
way to check how well there are documented.

EXPORT_SYMBOL
version     	funcs	docs	percent
v5.0        	514	177	34
v5.6        	538	208	38
v5.12       	550	209	38
v5.17       	580	228	39
v6.3        	580	235	40
v6.8-rc1    	565	238	42

static inline
version     	funcs	docs	percent
v5.0        	581	33	5
v5.6        	596	41	6
v5.12       	629	42	6
v5.17       	746	74	9
v6.3        	867	95	10
v6.8-rc1    	944	116	12

 
> There's also the problem of getting long-form documentation done.
> But I think that's a different problem from getting kernel-doc written.
> Looking at the 55 commits in the last year to Documentation/mm, we seems
> to be doing a pretty good job of keeping the documentation we have up
> to date.  Just not a great job of adding new documentation.

I agree that long-form documentation is a different problem from getting
kernel-doc written and we are not doing a great job in writing new
documentation.

-- 
Sincerely yours,
Mike.

