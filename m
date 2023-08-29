Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A817C6FA8F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Aug 2023 19:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fxxwqPfI4ZPMl7V+SYOrn3sysRQ47yzu4QoySEktQoo=; b=ovW+HdNe7J2kuWEInGH/XJntD9
	iFOqSRE3SRZEg5g0n9XCEZMNA+xygBQGF/JMA73u4BYCHR8yXEDoIe3V0h/O3uWzKwJNqOLEF85Dz
	CmuGqy/9krwsuK/3WBH9WLCIqf1Ww1XBUzPxQuzWuFFj+e/1LoPYzgo8AfIwamZN7G4M7KP4dTD3x
	BVI9rovlH/vM8Oy7woWHaavQg+m9k3FTAfSmPR/JWIAfW/ch6JVhThDvpso6ZONCY0iWoJSCWWuRF
	sbHmjglI1sYuUYiWuRoYxDBQpZ5BCYKnMolDP1DTQv5PAr8zv3j6AMtde7J60r7PPEnRs/nUreCNS
	sVmpjpjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qb49N-00C7Q4-2J;
	Tue, 29 Aug 2023 19:13:17 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qb49L-00C7Po-2w
	for linux-nvme@bombadil.infradead.org;
	Tue, 29 Aug 2023 19:13:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fxxwqPfI4ZPMl7V+SYOrn3sysRQ47yzu4QoySEktQoo=; b=ogx7s3SFQLQiyWYzlQWAnZK7lG
	FNLqdscOtjWC/sSSxEncfqfmhkBl8rxupJMDs42+XCG5iXuPt4+/RXIUeWzgStQ1qZTd4PJo6S/T6
	bb7f87eOut5C31YwG+i+Ym5F3XJjjmFDl5+fyAajyRkq+1cD4j7g1UTB65aVDrnYVsKwB2A4toF/W
	CcAFzBlQtN2YOxNuwPPG3iSnM8S8FbIAq6pCoAbFjfOs0pXCAm2vSxaXxMzI83/z2V3F8Yd1vOpB7
	tiVa8POAqeBya2dz6KFYV9lBqHDL4Y0qNCWfKh2GeTa1BSk4j5a9k5hcfWKpmZW16AVHRKZdrkRwg
	jSTzku9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qb49H-008Iun-SQ; Tue, 29 Aug 2023 19:13:11 +0000
Date: Tue, 29 Aug 2023 20:13:11 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: BUG: KCSAN: data-race in folio_batch_move_lru / mpage_read_end_io
Message-ID: <ZO5DR771Khv1d5gR@casper.infradead.org>
References: <cbb9d596-43ac-bad4-b6f6-8c13f95d244e@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbb9d596-43ac-bad4-b6f6-8c13f95d244e@alu.unizg.hr>
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

On Mon, Aug 28, 2023 at 11:14:23PM +0200, Mirsad Todorovac wrote:
> In the vanilla torvalds tree 6.5 kernel on the Ubuntu 22.04 system, KCSAN found another data race:

KCSAN is wrong.

> [   34.102069] write (marked) to 0xffffef9a44978bc0 of 8 bytes by interrupt on cpu 28:
> [   34.108569] mpage_read_end_io (/home/marvin/linux/kernel/linux_torvalds/./arch/x86/include/asm/bitops.h:55 /home/marvin/linux/kernel/linux_torvalds/./include/asm-generic/bitops/instrumented-atomic.h:29 /home/marvin/linux/kernel/linux_torvalds/./include/linux/page-flags.h:739 /home/marvin/linux/kernel/linux_torvalds/fs/mpage.c:55)

        bio_for_each_folio_all(fi, bio) {
                if (err)
                        folio_set_error(fi.folio);
                else
                        folio_mark_uptodate(fi.folio);
                folio_unlock(fi.folio);
        }

It's noting the write to folio->flags in folio_mark_uptodate().  You can
see it's locked.  Also, the folio is under I/O.

> [   34.115221] read to 0xffffef9a44978bc0 of 8 bytes by task 348 on cpu 12:
> [   34.121702] folio_batch_move_lru (/home/marvin/linux/kernel/linux_torvalds/./include/linux/mm.h:1814 /home/marvin/linux/kernel/linux_torvalds/./include/linux/mm.h:1824 /home/marvin/linux/kernel/linux_torvalds/./include/linux/memcontrol.h:1636 /home/marvin/linux/kernel/linux_torvalds/./include/linux/memcontrol.h:1659 /home/marvin/linux/kernel/linux_torvalds/mm/swap.c:216)

Here, it's noting the read to folio->flags that's part of page_to_nid().

> [   34.121713] folio_batch_add_and_move (/home/marvin/linux/kernel/linux_torvalds/mm/swap.c:235)
> [   34.121724] folio_add_lru (/home/marvin/linux/kernel/linux_torvalds/./arch/x86/include/asm/preempt.h:95 /home/marvin/linux/kernel/linux_torvalds/mm/swap.c:518)
> [   34.121735] folio_add_lru_vma (/home/marvin/linux/kernel/linux_torvalds/mm/swap.c:538)
> [   34.121746] do_anonymous_page (/home/marvin/linux/kernel/linux_torvalds/mm/memory.c:4146)

Here we can see the page is freshly allocated.

So KCSAN has three things wrong here.  One is that the write to
folio_mark_uptodate() is setting a bit, that is nowhere near the bits
that are used for the node ID.  It can't know that; it doesn't track
writes at that granularity.

The second thing is that the node bits in folio->flags are immutable.
They're set at boot (or memory hotplug).  There is never a race risk when
reading them.  Presumably there needs to be some kind of annotation to
tell KCSAN that this is always safe.

The third thing is that these two accesses cannot race.  The write is
to a folio which is under I/O, so cannot be freed.  The read is to a
folio which has just been allocated, so cannot be under I/O.  This is
some kind of failure of KCSAN.


