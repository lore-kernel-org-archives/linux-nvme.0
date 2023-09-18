Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA3DCD37B0
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Sep 2023 12:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=buZMiDJPa2eehET8jVdzx5tXage1Z4T66Y7ZpuKD4UE=; b=lwi7iX+3KosRXFHoJhw/TAXwM1
	9eVgvm+aZwUFQJ/6806wsDLNWQP22v0PvDvu2SF1rQN+kB34cPdJfCxtU61+mGZcrVY0TVK+uCWiI
	v4zY/wIu9FD0Xv/Czc9zOz1zwSR4z4Hi+epCdGNuH0/ztSoJtgq60oAVDSanJwDrjtTt9ow6Oi9oG
	F01YYbvOJMZqlkZjmB4BTZrfMsN2Mih48IeaeQFu5VfL08uK6mKaKA9BpcGL9TAOo/k0p10jHR7gJ
	2v1pULd78UhKNdqa+32dc6v1bfEOOoK1V5EBniZhc2LesaFUWIXGFt4IeN95RrVtZci5zGBh/9G+m
	zOgbLLRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiDA1-00FOvy-2s;
	Mon, 18 Sep 2023 12:15:29 +0000
Received: from domac.alu.unizg.hr ([161.53.235.3] helo=domac.alu.hr)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiD9u-00FOu0-36
	for linux-nvme@lists.infradead.org;
	Mon, 18 Sep 2023 12:15:25 +0000
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 4E62C6017F;
	Mon, 18 Sep 2023 14:15:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1695039315; bh=SmfqklREwhtysYYvbmNPpcGx0lhPTuzHH1rw1V6w+XE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=0YonrsqF6qkijU2DWZMLYfcdCkedqGWwK1sw5bKp61obrGYXHkGnVzwz2eTZUTOfd
	 bFCKCIP4BkyeXKb7typtBBArj1XjfrVEijDY4VtC2yKlVv1t96KdWSHIIlpDTlUgyv
	 XJTaHRqQh6RxXefQaxJ4jBYT58qxanidd6XSnBQCrXHl2zzbfcdFi4lL+rsi4ZdIge
	 zjI/UC1Nm+eiMhTbrPcQyDhjNVRXX3AC0wSAgyzilAhqnJUX6pmkx+Bu4vntBjhZ8t
	 Yvs8Mlkpd/6WyRLO+arnJe8daiRAm4i/WfxzKoRkekusM75h8TGlrp472JpkvT9n+Q
	 THybAyMpAtH1Q==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4qPMsXhXqbja; Mon, 18 Sep 2023 14:15:12 +0200 (CEST)
Received: from [192.168.1.6] (78-1-184-14.adsl.net.t-com.hr [78.1.184.14])
	by domac.alu.hr (Postfix) with ESMTPSA id 4686160173;
	Mon, 18 Sep 2023 14:15:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1695039312; bh=SmfqklREwhtysYYvbmNPpcGx0lhPTuzHH1rw1V6w+XE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gk2KGKAp7x3cXYvNB99Bmq3W6BWRwc1dUlIcR/uER2qL+5i4R6bJv5K2xdidoA5it
	 Qdli27w+eK2ko2hwFxoKZu9XUtAsfyjwOXpgeSLVo7hjrYzHOquPo/CNk3DjcvpNjs
	 V8sMSznMgovYc0nQEnqc2XJqjiR/C4jofqbR3i0bf1QL3JOBBd4KdIY4tJMTV1f3G9
	 eMQI2OSrZa7R2zH5lgMRJNvuU9J9zadNTghE5Whst5MI16ni7hU7Zg9SZ4Q6eVVTxI
	 HtFq2MIVXijNJQPJrAbkxXM59ZM8Ficd6vKsZzTUsq3yoCQ5OBgu5t3JAdqDw475vS
	 l8lu6scF36qmA==
Message-ID: <22a42774-ebe1-081a-c9b9-e11f4d74bc3a@alu.unizg.hr>
Date: Mon, 18 Sep 2023 14:15:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: BUG: KCSAN: data-race in folio_batch_move_lru / mpage_read_end_io
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <cbb9d596-43ac-bad4-b6f6-8c13f95d244e@alu.unizg.hr>
 <ZPCpQQVTtlB0FA5A@casper.infradead.org>
 <ZPs8+sLv5oaubrKj@casper.infradead.org>
Content-Language: en-US
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZPs8+sLv5oaubrKj@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_051523_163261_CBD5434B 
X-CRM114-Status: GOOD (  24.40  )
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

On 9/8/23 17:25, Matthew Wilcox wrote:
> On Thu, Aug 31, 2023 at 03:52:49PM +0100, Matthew Wilcox wrote:
>>>   read to 0xffffef9a44978bc0 of 8 bytes by task 348 on cpu 12:
>>>   folio_batch_move_lru (./include/linux/mm.h:1814 ./include/linux/mm.h:1824 ./include/linux/memcontrol.h:1636 ./include/linux/memcontrol.h:1659 mm/swap.c:216)
>>>   folio_batch_add_and_move (mm/swap.c:235)
>>>   folio_add_lru (./arch/x86/include/asm/preempt.h:95 mm/swap.c:518)
>>>   folio_add_lru_vma (mm/swap.c:538)
>>>   do_anonymous_page (mm/memory.c:4146)
>>
>> This is the part I don't understand.  The path to calling
>> folio_add_lru_vma() comes directly from vma_alloc_zeroed_movable_folio():
>>
> [snip]
>>
>> (sorry that's a lot of lines).  But there's _nowhere_ there that sets
>> PG_locked.  It's a freshly allocated page; all page flags (that are
>> actually flags; ignore the stuff up at the top) should be clear.  We
>> even check that with PAGE_FLAGS_CHECK_AT_PREP.  Plus, it doesn't
>> make sense that we'd start I/O; the page is freshly allocated, full of
>> zeroes; there's no backing store to read the page from.
>>
>> It really feels like this page was freed while it was still under I/O
>> and it's been reallocated to this victim process.
>>
>> I'm going to try a few things and see if I can figure this out.
> 
> I'm having trouble reproducing this.  Can you get it to happen reliably?
> 
> This is what I'm currently running with, and it doesn't trigger.
> I'd expect it to if we were going to hit the KCSAN bug.
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0c5be12f9336..d22e8798c326 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4439,6 +4439,7 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
>   	page = __alloc_pages_slowpath(alloc_gfp, order, &ac);
>   
>   out:
> +	VM_BUG_ON_PAGE(page && (page->flags & (PAGE_FLAGS_CHECK_AT_PREP &~ (1 << PG_head))), page);
>   	if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT) && page &&
>   	    unlikely(__memcg_kmem_charge_page(page, gfp, order) != 0)) {
>   		__free_pages(page, order);

Hi,

Caught another instance of this bug involving folio_batch_move_lru: I don't seem that I can make it
happen reliably by the nature of the data racing conditions if I understood them well.

I have only found them in dmesg, I cannot determine what exactly the system was doing at that
spurious moment ...

Hope this will get some more light on the issue (6.6-rc2 vanilla torvalds tree kernel):

[  114.557937] ==================================================================
[  114.558262] BUG: KCSAN: data-race in btrfs_page_set_uptodate [btrfs] / folio_batch_move_lru

[  114.558902] write (marked) to 0xffffea0006f68f00 of 8 bytes by task 2678 on cpu 19:
[  114.558912] btrfs_page_set_uptodate (/home/marvin/linux/kernel/torvalds2/./arch/x86/include/asm/bitops.h:55 /home/marvin/linux/kernel/torvalds2/./include/asm-generic/bitops/instrumented-atomic.h:29 /home/marvin/linux/kernel/torvalds2/./include/linux/page-flags.h:741 /home/marvin/linux/kernel/torvalds2/./include/linux/page-flags.h:751 /home/marvin/linux/kernel/torvalds2/fs/btrfs/subpage.c:642) btrfs
[  114.559539] end_page_read (/home/marvin/linux/kernel/torvalds2/fs/btrfs/extent_io.c:445) btrfs
[  114.560166] end_bio_extent_readpage (/home/marvin/linux/kernel/torvalds2/fs/btrfs/extent_io.c:660) btrfs
[  114.560796] __btrfs_bio_end_io (/home/marvin/linux/kernel/torvalds2/fs/btrfs/bio.c:120) btrfs
[  114.561434] btrfs_orig_bbio_end_io (/home/marvin/linux/kernel/torvalds2/fs/btrfs/bio.c:164) btrfs
[  114.562079] btrfs_check_read_bio (/home/marvin/linux/kernel/torvalds2/fs/btrfs/bio.c:324) btrfs
[  114.562724] btrfs_end_bio_work (/home/marvin/linux/kernel/torvalds2/fs/btrfs/bio.c:359) btrfs
[  114.563360] process_one_work (/home/marvin/linux/kernel/torvalds2/kernel/workqueue.c:2630)
[  114.563371] worker_thread (/home/marvin/linux/kernel/torvalds2/kernel/workqueue.c:2697 /home/marvin/linux/kernel/torvalds2/kernel/workqueue.c:2784)
[  114.563381] kthread (/home/marvin/linux/kernel/torvalds2/kernel/kthread.c:388)
[  114.563390] ret_from_fork (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/process.c:147)
[  114.563401] ret_from_fork_asm (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/entry_64.S:312)

[  114.563416] read to 0xffffea0006f68f00 of 8 bytes by task 3540 on cpu 20:
[  114.563426] folio_batch_move_lru (/home/marvin/linux/kernel/torvalds2/./include/linux/mm.h:1849 /home/marvin/linux/kernel/torvalds2/./include/linux/mm.h:1859 /home/marvin/linux/kernel/torvalds2/./include/linux/memcontrol.h:1639 /home/marvin/linux/kernel/torvalds2/./include/linux/memcontrol.h:1662 /home/marvin/linux/kernel/torvalds2/mm/swap.c:216)
[  114.563436] folio_batch_add_and_move (/home/marvin/linux/kernel/torvalds2/mm/swap.c:235)
[  114.563446] folio_add_lru (/home/marvin/linux/kernel/torvalds2/./arch/x86/include/asm/preempt.h:95 /home/marvin/linux/kernel/torvalds2/mm/swap.c:518)
[  114.563455] filemap_add_folio (/home/marvin/linux/kernel/torvalds2/mm/filemap.c:957)
[  114.563464] page_cache_ra_unbounded (/home/marvin/linux/kernel/torvalds2/mm/readahead.c:250)
[  114.563477] page_cache_ra_order (/home/marvin/linux/kernel/torvalds2/mm/readahead.c:547)
[  114.563490] ondemand_readahead (/home/marvin/linux/kernel/torvalds2/mm/readahead.c:669)
[  114.563499] page_cache_async_ra (/home/marvin/linux/kernel/torvalds2/mm/readahead.c:718)
[  114.563507] filemap_fault (/home/marvin/linux/kernel/torvalds2/mm/filemap.c:3227 /home/marvin/linux/kernel/torvalds2/mm/filemap.c:3281)
[  114.563518] __do_fault (/home/marvin/linux/kernel/torvalds2/mm/memory.c:4204)
[  114.563528] do_fault (/home/marvin/linux/kernel/torvalds2/mm/memory.c:4568 /home/marvin/linux/kernel/torvalds2/mm/memory.c:4705)
[  114.563538] __handle_mm_fault (/home/marvin/linux/kernel/torvalds2/mm/memory.c:3669 /home/marvin/linux/kernel/torvalds2/mm/memory.c:4978 /home/marvin/linux/kernel/torvalds2/mm/memory.c:5119)
[  114.563549] handle_mm_fault (/home/marvin/linux/kernel/torvalds2/mm/memory.c:5284)
[  114.563560] do_user_addr_fault (/home/marvin/linux/kernel/torvalds2/arch/x86/mm/fault.c:1413)
[  114.563572] exc_page_fault (/home/marvin/linux/kernel/torvalds2/./arch/x86/include/asm/paravirt.h:695 /home/marvin/linux/kernel/torvalds2/arch/x86/mm/fault.c:1513 /home/marvin/linux/kernel/torvalds2/arch/x86/mm/fault.c:1561)
[  114.563582] asm_exc_page_fault (/home/marvin/linux/kernel/torvalds2/./arch/x86/include/asm/idtentry.h:570)

[  114.563597] value changed: 0x0017ffffc0008101 -> 0x0017ffffc0008108

[  114.563612] Reported by Kernel Concurrency Sanitizer on:
[  114.563619] CPU: 20 PID: 3540 Comm: chrome Not tainted 6.6.0-rc2-kcsan-00003-g16819584c239-dirty #11
[  114.563630] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
[  114.563636] ==================================================================

Best regards,
Mirsad Todorovac

