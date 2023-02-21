Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89130C678D5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Feb 2023 19:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3m7BCGAEZNjDasZrz2wufh7wDwBRXOZCBbm7SGl9TRc=; b=whmAYouFVE8ElnOxiCWgmao1ZF
	Q5KbWma6Zt9tQHiyQiPZttgxycths0Skhr4CpWpH6ajK+jmwjZpudqAl5mJdhHPhfc2dJXl1TmVKW
	UxIvg3BQljUK1JlYDjvYJX2aiZ6OtWCOIwFsdPnhrsycZPYEqY0MIYSBvLAy8XlkPTZF//m8STkqB
	dXUxi70dmUzA/yFHIv2vA52K/HK2UNvS2bYGzkDXHUWlTM9th68SCU2zMvf5UoEr09GPXN+n8Mcm0
	yaUsiUGAeqAFb/RtgLlEINbYZbNFnvNQ5VUcSi6twOhEKR1uqDROGmBZjTmlRyzT+ZeiQwEnC3Ldp
	/zyZRQTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUYmb-009byE-P5; Tue, 21 Feb 2023 19:58:37 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUYma-009bxh-Pl
	for linux-nvme@bombadil.infradead.org; Tue, 21 Feb 2023 19:58:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3m7BCGAEZNjDasZrz2wufh7wDwBRXOZCBbm7SGl9TRc=; b=IHbWhPII7qYnTuhitFCv7e8Ptx
	+DDIa91/rALCRuXZ3Y67WQ3Sf7pMxTt3xXHQ+0yy4i3B8bbi6qqT+JWr+3wQ2C7OMw5IZOMeyvMvE
	hGMoCoqSMp+aoBcnhOLm3FdWMwC6OrUvR8P65lm/ufn8IvmmsJJN5hhc50tBCz888s5FvEOxZCdek
	yE6Oma0hpMqRqM+rGYSIZ/cbZhyIiW7KmnMr5/mfRsBNUFmPxn/593lUZDWT0+Dj+NjtO0jm2SaUD
	Ch1AGOvX1J2BRTlv26sDVzx8QV5VcCkfwO9yvzMKgfeuV66IT1iHF+0/Rx6/Vju4FziwY/8lcwkyF
	lgzryj5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUYmR-00CsKI-Cd; Tue, 21 Feb 2023 19:58:27 +0000
Date: Tue, 21 Feb 2023 19:58:27 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
Message-ID: <Y/UiY/08MuA/tBku@casper.infradead.org>
References: <Y9KtCc+4n5uANB2f@casper.infradead.org>
 <8448beac-a119-330d-a2af-fc3531bdb930@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8448beac-a119-330d-a2af-fc3531bdb930@linux.alibaba.com>
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

On Wed, Feb 22, 2023 at 02:08:28AM +0800, Gao Xiang wrote:
> On 2023/1/27 00:40, Matthew Wilcox wrote:
> > I'd like to do another session on how the struct page dismemberment
> > is going and what remains to be done.  Given how widely struct page is
> > used, I think there will be interest from more than just MM, so I'd
> > suggest a plenary session.
> 
> I'm interested in this topic too, also I'd like to get some idea of the
> future of the page dismemberment timeline so that I can have time to keep
> the pace with it since some embedded use cases like Android are
> memory-sensitive all the time.

As you all know, I'm absolutely amazing at project management & planning
and can tell you to the day when a feature will be ready ;-)

My goal for 2023 is to get to a point where we (a) have struct page
reduced to:

struct page {
	unsigned long flags;
	struct list_head lru;
	struct address_space *mapping;
	pgoff_t index;
	unsigned long private;
	atomic_t _mapcount;
	atomic_t _refcount;
	unsigned long memcg_data;
#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
	int _last_cpupid;
#endif
};

and (b) can build an allnoconfig kernel with:

struct page {
	unsigned long flags;
	unsigned long padding[5];
	atomic_t _mapcount;
	atomic_t _refcount;
	unsigned long padding2;
#ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
	int _last_cpupid;
#endif
};

> Minor, it seems some apis still use ->lru field to chain bulk pages,
> perhaps it needs some changes as well:
> https://lore.kernel.org/r/20221222124412.rpnl2vojnx7izoow@techsingularity.net
> https://lore.kernel.org/r/20230214190221.1156876-2-shy828301@gmail.com

Yang Shi covered the actual (non-)use of the list version of the bulk
allocator already, but perhaps more importantly, each page allocated
by the bulk allocator is actually a separately tracked allocation.
So the obvious translation of the bulk allocator from pages to folios
is that it allocates N order-0 folios.

That may not be the best approach for all the users of the bulk allocator,
so we may end up doing something different.  At any rate, use of page->lru
isn't the problem here (yes, it's something that would need to change,
but it's not a big conceptual problem).

