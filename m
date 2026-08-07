Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10D3C5AC67
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2026 00:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Date:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DHl/omsnQZWAsLsuqjcopC+CiqjuXwfHPzn9WjLQBxs=; b=B551/C+i8k8vIl0SI9Na3mdFlb
	lzilG446EcfyF7tVHv/p0Pd8lVLjxfo+wdwXzQf42rMQ5FvOyEVhARhRrQLAsswJ38CZ0J46wjUMC
	Acq4FYaH3hUK/VXh8Bqid4Alm3jTL20/V43mZ6wBjmi6CAOiUBv/gfsvZHQEgyi3zvjy5B8cvKFEx
	oshDLug+l0VXZto/L25dxdLp3ii75KfiEyR190OG0U9RpJt6NhBxRAHhOEWCKVykr0bwbfkYcVZMl
	C5cYcjxn0RxMwiyCbGt7fV+xq/5UXzegVxJVFh7SMTvOM4R0u16Sr/04GI5uH4KkUI/D1EM+ysF25
	8+3XGCxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ws81p-00000006skA-1sEV;
	Fri, 07 Aug 2026 00:01:37 +0000
Received: from mail-ot1-f79.google.com ([209.85.210.79])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ws81m-00000006sjU-48cD
	for linux-nvme@lists.infradead.org;
	Fri, 07 Aug 2026 00:01:36 +0000
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7e9e741693bso1567213a34.0
        for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2026 17:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786060893; x=1786665693;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DHl/omsnQZWAsLsuqjcopC+CiqjuXwfHPzn9WjLQBxs=;
        b=RIqbpG63bHhM5302hVpOy/XHrviwAYuAerhRhw56eLVzF6LH0QIncUk+NBxkNCTFOl
         SUbAUeWe3RA/cemNCj0mT05wwHIi8f0W835T0HVgJzQxY5G+JzPF/UXGgn1Hne/d2wpz
         t1h4FZQinSC56v4zsR/iymKHVnr+Y1DPcA9dFdxpVGMOVarhLpaNFeyoBrKidKn9KUko
         vFsJ/4D5XvpqVsOXzuVL72bz97/D9/Ih4gaeJ8Vq+OEb9nO1vQqAnHmqfgtmdxVKHy9Q
         V1Vog0zM/uPML10RKzAXcdRKiqdzmlGZ05St1t7FI4fiEOxFw5lRFm4tsKxXcB1iwUF2
         8tmQ==
X-Forwarded-Encrypted: i=1; AHgh+RqOa6rKgqr3TwTxHRKUYE8W5W1a+/epgjZCzZ+tkNjefdI3NXS2+7F7DrN3FNIL9Mm59isqwp80sUTw@lists.infradead.org
X-Gm-Message-State: AOJu0YzXMvzHkuMIhiLW7VaP+KTBzb5SAN4cVHKMAiHLWC2GJD1C7dDd
	C3iBUuIMgWWAMo/UTVjRlOi/AVtmpL/ut/oQ5hpF8MdpJ+zT6NVmjZQClAyIPCCmWs8brUZNxjy
	PI8ie4LcA8/QWv8jOYPj++CnCiNZZSRVvbBWGbYJJWOf4oStfydXghk9qd5M=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f024:b0:6af:f3a3:7f5d with SMTP id
 006d021491bc7-6aff3a486f6mr4081871eaf.26.1786060892795; Thu, 06 Aug 2026
 17:01:32 -0700 (PDT)
Date: Thu, 06 Aug 2026 17:01:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a75205c.01d0871a.3a0d52.0033.GAE@google.com>
Subject: [syzbot] [nvme?] KASAN: slab-out-of-bounds Read in nvmet_install_queue
From: syzbot <syzbot+2626e846cd2585c9aa67@syzkaller.appspotmail.com>
To: hch@lst.de, kch@nvidia.com, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, sagi@grimberg.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_170135_041465_BD0E2FD0 
X-CRM114-Status: UNSURE (   7.70  )
X-CRM114-Notice: Please train this message.
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

Hello,

syzbot found the following issue on:

HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12cb8bb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=2626e846cd2585c9aa67
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6fb497cc0c8d/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/663ccee34982/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2626e846cd2585c9aa67@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in nvmet_install_queue+0x522/0x590 drivers/nvme/target/fabrics-cmd.c:189
Read of size 8 at addr ffff888058219a70 by task kworker/u33:8/1166

CPU: 1 UID: 0 PID: 1166 Comm: kworker/u33:8 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: nvmet-wq nvme_loop_execute_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 nvmet_install_queue+0x522/0x590 drivers/nvme/target/fabrics-cmd.c:189
 nvmet_execute_io_connect+0x294/0x490 drivers/nvme/target/fabrics-cmd.c:380
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 1174:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5334 [inline]
 __kmalloc_noprof+0x322/0x820 mm/slub.c:5359
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 nvmet_alloc_ctrl+0x9c2/0x1560 drivers/nvme/target/core.c:1655
 nvmet_execute_admin_connect+0x3c3/0x5b0 drivers/nvme/target/fabrics-cmd.c:317
 process_one_work+0xa23/0x1940 kernel/workqueue.c:3322
 process_scheduled_works kernel/workqueue.c:3405 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3486
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888058219a60
 which belongs to the cache kmalloc-16 of size 16
The buggy address is located 0 bytes to the right of
 allocated 16-byte region [ffff888058219a60, ffff888058219a70)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888058219f80 pfn:0x58219
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000200 ffff88801bc42640 ffffea000169a050 ffffea00015fa390
raw: ffff888058219f80 000000080080007f 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5739, tgid 5739 (syz-executor), ts 50610714726, free_ts 49976327990
 create_dummy_stack mm/page_owner.c:103 [inline]
 register_dummy_stack+0x74/0xb0 mm/page_owner.c:109
 init_page_owner+0x42/0xa10 mm/page_owner.c:127
 invoke_init_callbacks mm/page_ext.c:152 [inline]
 page_ext_init+0x71d/0x780 mm/page_ext.c:490
 mm_core_init+0x229/0x270 mm/mm_init.c:2748
page last free pid 33 tgid 33 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0x79f/0x1090 mm/page_alloc.c:2950
 __pagetable_free include/linux/mm.h:3695 [inline]
 pagetable_free include/linux/mm.h:3719 [inline]
 pagetable_dtor_free include/linux/mm.h:3818 [inline]
 __tlb_remove_table include/asm-generic/tlb.h:221 [inline]
 __tlb_remove_table_free mm/mmu_gather.c:228 [inline]
 tlb_remove_table_rcu+0x2cf/0x380 mm/mmu_gather.c:291
 rcu_do_batch kernel/rcu/tree.c:2645 [inline]
 rcu_core+0x5a2/0x10d0 kernel/rcu/tree.c:2897
 handle_softirqs+0x1ea/0x9b0 kernel/softirq.c:622
 run_ksoftirqd kernel/softirq.c:1076 [inline]
 run_ksoftirqd+0x38/0x60 kernel/softirq.c:1068
 smpboot_thread_fn+0x3d3/0xaa0 kernel/smpboot.c:160
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888058219900: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
 ffff888058219980: fa fb fc fc fa fb fc fc fa fb fc fc 00 02 fc fc
>ffff888058219a00: 00 00 fc fc fa fb fc fc fa fb fc fc 00 00 fc fc
                                                             ^
 ffff888058219a80: fa fb fc fc fa fb fc fc fa fb fc fc 00 00 fc fc
 ffff888058219b00: 00 00 fc fc 00 00 fc fc 00 00 fc fc 00 00 fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

