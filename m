Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1317C83F10
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Aug 2023 14:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lwE1GdV6D69f6G+zYZ3quXQds5jqv1KmBeIZnoFgnz0=; b=QwPKdXIx5XPBEj3PtJROi6d7X4
	newmIEajD22cZAkyes3ujT7W4vwrf2yjUzyvbQ9Khbk/xYQwWsL78taEdgfmZNlKmj0c2etuKym1z
	E8g96XbUNXO1Ep18RWoYmNoYJj4UkHDYie2D+wD/7p9IL+4XJ/pf+3hbAWZRPMeGoGrVITX/J/kGi
	LQqqEcDTWJgABfjdfdYVO6yDkl3UAarOdxUWtQ6EBJpmiw05thg6q104JWRRiUlXk1laq/CJ6vWR6
	DoTMBrahWRKePWVoIq6vee2wvq/AlWBl9lUQksz8v008BiFbKnSgttXBcyiDF1WCbyAhNpCfQnChz
	FrIOpuCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbj2V-00FSmJ-2B;
	Thu, 31 Aug 2023 14:52:55 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbj2T-00FSmA-1F
	for linux-nvme@bombadil.infradead.org;
	Thu, 31 Aug 2023 14:52:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lwE1GdV6D69f6G+zYZ3quXQds5jqv1KmBeIZnoFgnz0=; b=ZPYbF54tuouED9z6EN3KIkl3g9
	JdC7ngDwcMKciB6aIQXbMZKb4zWv+FaIV9nJA3I6XU5VtcZfbVDQ8cKaN+3teDlXYFGr7dqQvi3YI
	QKelGrsc2qvjHRkernw6hRQtSn8i5Ubsf/BIJPH80jkHBV2takvPiJs87NWw+OBxL2/0YtclokET+
	mU2wbLkPDe82empFNt0sOlk0G+T+VHx4+gmbEfBsred9xYqmWHOtnEcetovtC4LwYQXl6PBtni9bB
	9qWxxNHXa9WoE8PEprurVWx7FWb4EM4LUcINoj7IfkVPJk8ADpj9bKBwjNYjnDnHX7A+s2affthen
	yCtonS/w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qbj2P-001ufX-K8; Thu, 31 Aug 2023 14:52:49 +0000
Date: Thu, 31 Aug 2023 15:52:49 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: BUG: KCSAN: data-race in folio_batch_move_lru / mpage_read_end_io
Message-ID: <ZPCpQQVTtlB0FA5A@casper.infradead.org>
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
>  BUG: KCSAN: data-race in folio_batch_move_lru / mpage_read_end_io

This one's still niggling at me.  I've trimmed the timestamps and some
of the other irrelevant stuff out of this to make it easier to read.

>  value changed: 0x0017ffffc0020001 -> 0x0017ffffc0020004

Notionally I understand this.  This is page->flags and the PG_locked bit
was set initially, but after a short delay PG_locked was cleared and
PG_uptodate was set.  That's _normal_.  For many, many pages, we set the
locked bit, initiate a read; the device does a DMA, sends an interrupt;
the interrupt handler sets the PG_uptodate bit and clears the PG_locked
bit to indicate the page is no longer under I/O.

But what I don't understand is how we see this for _this_ page.

>  write (marked) to 0xffffef9a44978bc0 of 8 bytes by interrupt on cpu 28:
>  mpage_read_end_io (arch/x86/include/asm/bitops.h:55 include/asm-generic/bitops/instrumented-atomic.h:29 include/linux/page-flags.h:739 fs/mpage.c:55)
>  bio_endio (block/bio.c:1617)
>  blk_mq_end_request_batch (block/blk-mq.c:850 block/blk-mq.c:1088)
>  nvme_pci_complete_batch (drivers/nvme/host/pci.c:986) nvme
>  nvme_irq (drivers/nvme/host/pci.c:1086) nvme

This is the interrupt handler.  It's doing what it's supposed to;
marking the page uptodate and unlocking it.

>  read to 0xffffef9a44978bc0 of 8 bytes by task 348 on cpu 12:
>  folio_batch_move_lru (./include/linux/mm.h:1814 ./include/linux/mm.h:1824 ./include/linux/memcontrol.h:1636 ./include/linux/memcontrol.h:1659 mm/swap.c:216)
>  folio_batch_add_and_move (mm/swap.c:235)
>  folio_add_lru (./arch/x86/include/asm/preempt.h:95 mm/swap.c:518)
>  folio_add_lru_vma (mm/swap.c:538)
>  do_anonymous_page (mm/memory.c:4146)

This is the part I don't understand.  The path to calling
folio_add_lru_vma() comes directly from vma_alloc_zeroed_movable_folio():

        folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
        if (!folio)
                goto oom;
        if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
                goto oom_free_page;
        folio_throttle_swaprate(folio, GFP_KERNEL);
        __folio_mark_uptodate(folio);
        entry = mk_pte(&folio->page, vma->vm_page_prot);
        entry = pte_sw_mkyoung(entry);
        if (vma->vm_flags & VM_WRITE)
                entry = pte_mkwrite(pte_mkdirty(entry));
        vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
                        &vmf->ptl);
        if (!vmf->pte)
                goto release;
        if (vmf_pte_changed(vmf)) {
                update_mmu_tlb(vma, vmf->address, vmf->pte);
                goto release;
        }
        ret = check_stable_address_space(vma->vm_mm);
        if (ret)
                goto release;
        /* Deliver the page fault to userland, check inside PT lock */
        if (userfaultfd_missing(vma)) {
                pte_unmap_unlock(vmf->pte, vmf->ptl);
                folio_put(folio);
                return handle_userfault(vmf, VM_UFFD_MISSING);
        }
        inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
        folio_add_new_anon_rmap(folio, vma, vmf->address);
        folio_add_lru_vma(folio, vma);

(sorry that's a lot of lines).  But there's _nowhere_ there that sets
PG_locked.  It's a freshly allocated page; all page flags (that are
actually flags; ignore the stuff up at the top) should be clear.  We
even check that with PAGE_FLAGS_CHECK_AT_PREP.  Plus, it doesn't
make sense that we'd start I/O; the page is freshly allocated, full of
zeroes; there's no backing store to read the page from.

It really feels like this page was freed while it was still under I/O
and it's been reallocated to this victim process.

I'm going to try a few things and see if I can figure this out.

>  __handle_mm_fault (mm/memory.c:3662 mm/memory.c:4939 mm/memory.c:5079)
>  handle_mm_fault (mm/memory.c:5233)
>  do_user_addr_fault (arch/x86/mm/fault.c:1392)
>  exc_page_fault (./arch/x86/include/asm/paravirt.h:695 arch/x86/mm/fault.c:1494 arch/x86/mm/fault.c:1542)
>  asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)
>  copyout (./arch/x86/include/asm/uaccess_64.h:112 ./arch/x86/include/asm/uaccess_64.h:133 lib/iov_iter.c:168)
>  _copy_to_iter (lib/iov_iter.c:316 (discriminator 5))
>  copy_page_to_iter (lib/iov_iter.c:483 lib/iov_iter.c:468)
>  filemap_read (mm/filemap.c:2712)
>  blkdev_read_iter (block/fops.c:620)
>  vfs_read (./include/linux/fs.h:1871 fs/read_write.c:389 fs/read_write.c:470)
>  ksys_read (fs/read_write.c:613)
>  __x64_sys_read (fs/read_write.c:621)


