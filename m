Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAABEE8015
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vsshDTPena8IquRzHvGJCywEGoxIJRLv8XBPS87Fxgg=; b=IGvoMf1Ti0GxdsH1oTrMm/NagI
	7fjWaxbbw5rwR9ivamYc3M6a42RBwTmUqetOUTq6uuK2AuoAOkvlXgmIXucoitUPTxx5ez9ym80SL
	YKTrpNxciWPNGx2zlmTL5R2U9w1YzjkNX89EIyh2uYmjQ0UVrgr43C64TsgmOEuRHYgE+QIgzjHW6
	MV6cBZI4G3TLBynRSDU8xEB6kQT9K0z+5SQEOoSRcmRFZLCRGcj6SLDvqfgGWKX1pd4rDdgFWXf6J
	cudFSJ9C7HNK+DUQ4xNQkzjF27D+djfKyZZXN3mrzqZnCGHI9ijXHcrNq7M3SllvpFFnazLe5UXgt
	PoYNGH2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qedMo-00E08B-2e;
	Fri, 08 Sep 2023 15:25:54 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qedMk-00E080-2A
	for linux-nvme@bombadil.infradead.org;
	Fri, 08 Sep 2023 15:25:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vsshDTPena8IquRzHvGJCywEGoxIJRLv8XBPS87Fxgg=; b=o4clfq8u+x8KH3RasytlmHBxBL
	yy+me8gW8yWdI3v+RmSajIELXiBY2eOeO9k5jMU9RmS8kSVBYo8h70tRZ+A0KYeuiuXK59XFMC32t
	FhYe7foIefdQ6ISlDVAN0ikAfyUNDB0o9EAH6rPg7+QvXvdeqFXYZMiU9A/fPNLQsAP1YDcGUgPY/
	9QtQoUnspXRaVMcHtjjAeUIS1w5mJz4Dtd+o4yAf9+zFKpmJLU7IAiTJfOPhviTuvc/rosviipsd6
	y8yo9nODaS+pZvW+TCK9NUC3kEJful+a/TS9i8ncepkbz3tDypzNSXV+sI9eA0IN+9Vu9JzG36jM3
	s/omrudQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qedMg-000tXu-Nw; Fri, 08 Sep 2023 15:25:46 +0000
Date: Fri, 8 Sep 2023 16:25:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: BUG: KCSAN: data-race in folio_batch_move_lru / mpage_read_end_io
Message-ID: <ZPs8+sLv5oaubrKj@casper.infradead.org>
References: <cbb9d596-43ac-bad4-b6f6-8c13f95d244e@alu.unizg.hr>
 <ZPCpQQVTtlB0FA5A@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPCpQQVTtlB0FA5A@casper.infradead.org>
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

On Thu, Aug 31, 2023 at 03:52:49PM +0100, Matthew Wilcox wrote:
> >  read to 0xffffef9a44978bc0 of 8 bytes by task 348 on cpu 12:
> >  folio_batch_move_lru (./include/linux/mm.h:1814 ./include/linux/mm.h:1824 ./include/linux/memcontrol.h:1636 ./include/linux/memcontrol.h:1659 mm/swap.c:216)
> >  folio_batch_add_and_move (mm/swap.c:235)
> >  folio_add_lru (./arch/x86/include/asm/preempt.h:95 mm/swap.c:518)
> >  folio_add_lru_vma (mm/swap.c:538)
> >  do_anonymous_page (mm/memory.c:4146)
> 
> This is the part I don't understand.  The path to calling
> folio_add_lru_vma() comes directly from vma_alloc_zeroed_movable_folio():
> 
[snip]
> 
> (sorry that's a lot of lines).  But there's _nowhere_ there that sets
> PG_locked.  It's a freshly allocated page; all page flags (that are
> actually flags; ignore the stuff up at the top) should be clear.  We
> even check that with PAGE_FLAGS_CHECK_AT_PREP.  Plus, it doesn't
> make sense that we'd start I/O; the page is freshly allocated, full of
> zeroes; there's no backing store to read the page from.
> 
> It really feels like this page was freed while it was still under I/O
> and it's been reallocated to this victim process.
> 
> I'm going to try a few things and see if I can figure this out.

I'm having trouble reproducing this.  Can you get it to happen reliably?

This is what I'm currently running with, and it doesn't trigger.
I'd expect it to if we were going to hit the KCSAN bug.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0c5be12f9336..d22e8798c326 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4439,6 +4439,7 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 	page = __alloc_pages_slowpath(alloc_gfp, order, &ac);
 
 out:
+	VM_BUG_ON_PAGE(page && (page->flags & (PAGE_FLAGS_CHECK_AT_PREP &~ (1 << PG_head))), page);
 	if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT) && page &&
 	    unlikely(__memcg_kmem_charge_page(page, gfp, order) != 0)) {
 		__free_pages(page, order);

