Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D26C5AD5A
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 00:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Date:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VrMBy7Al5A2Dz4CsBbH308cvn5/r0MghZniVfIfYUXE=; b=l/mR5IYJVb2b5T7guU1rqDW/gv
	96bWHq8S6Ojluh95KnHVLRix1EPUWIV9oBA2FE2+lwDtL0Na8xKTKaps0eLtHbt8wFXsnuPZqM2N0
	LW3JFHJ/oFHGhiFu+H6s3avHPHStbbl2w0gBsxDGaiZtA4z3O5KjgjqlhbqX9NayXhkBWkoAvJDLD
	H59gaDnVjWno1MrhEaYZZfyS/RX9Z/QJlxHx8+/VQXwzeJiTv+UQWIUMN74AMLbtcrL+96Lz4ep0A
	P8WR2w77E7Nb+836Wie6y0j+2fxrAVa/8wXzsg6YGa1BbNxWFP7I8w6yjlzjWXNGfcfxRGV4a1uFa
	Bdvuj55w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtDnm-0000000Aqp3-0zBC;
	Mon, 10 Aug 2026 00:23:38 +0000
Received: from mail-oa1-f77.google.com ([209.85.160.77])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtDnc-0000000AqoB-3xbH
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 00:23:30 +0000
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-4519ef1babeso272443fac.2
        for <linux-nvme@lists.infradead.org>; Sun, 09 Aug 2026 17:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786321407; x=1786926207;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VrMBy7Al5A2Dz4CsBbH308cvn5/r0MghZniVfIfYUXE=;
        b=cY84JWzcQj1Ec8MARDZsRGRox62Ed6TeVyCpveB7zOlqm67trYywwk+sSyFg94XP4I
         wtxbTPdcTw/JhYB0qFh4bfz0h8/EOIwWkSG4XjmFQWODqMIC2TOYOn08xrK21oEsP8OO
         /8myyzbOlJdO7HPyWubdVEfN3aTPTBahnz/+tTw07o+U2GEBOpBnsDAqxALxLXFnGFYO
         410ROvpWvKt96WYvsYc5FHhVwn94mFyc2KOVWjGiJOaNKwxidNKQR1czCw3EWtHhs5fY
         c6fDwbesQVtA8kR1GQPCQmvzkauNWNvboR8ftfI8CE7z489w4hbd2JovYS/ll0Od8UbX
         /vzA==
X-Forwarded-Encrypted: i=1; AHgh+Rph6IG6oTF2Gx84temXO3juE0vIOhQstp4QeX9jn07y+b22GTSe6HyOLU8afCFQlVGYx1Snen6HngHF@lists.infradead.org
X-Gm-Message-State: AOJu0YzmFeVkbgdZhcPWITx+0HSmD3UGSP/iLYc3VKZOUDJMZo9D0L63
	+bM1sF5V7DB1iC9UT8618p9HEHUl/uCR/4eIFx9JIWFEaVjQUYVgH807rsSbddlPyGcHZ+y++BR
	Aj/hKLmf4t8hjLKaAIgMdA1QLPwXcBBD9ufRX359n9veJo11Un9t7ax0m+Dc=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1394:b0:497:df42:1dff with SMTP id
 5614622812f47-4b1ab72b0c1mr11684267b6e.1.1786321407331; Sun, 09 Aug 2026
 17:23:27 -0700 (PDT)
Date: Sun, 09 Aug 2026 17:23:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7919ff.9c11d2ce.289b96.00e0.GAE@google.com>
Subject: [syzbot] [nvme?] KASAN: invalid-free in nvmet_fc_alloc_ls_iodlist
From: syzbot <syzbot+b01a29c8051dcb87f37d@syzkaller.appspotmail.com>
To: hch@lst.de, justin.tee@broadcom.com, kch@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com, sagi@grimberg.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260809_172329_000598_E72EB64B 
X-CRM114-Status: UNSURE (   8.41  )
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
console output: https://syzkaller.appspot.com/x/log.txt?x=16b813b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c05be6c9b0d36cb9
dashboard link: https://syzkaller.appspot.com/bug?extid=b01a29c8051dcb87f37d
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2425c07b5d46/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cf278dd14da3/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b01a29c8051dcb87f37d@syzkaller.appspotmail.com

FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
CPU: 0 UID: 0 PID: 5325 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 fail_dump lib/fault-inject.c:73 [inline]
 should_fail_ex+0x40c/0x560 lib/fault-inject.c:174
 should_failslab+0xa8/0x100 mm/failslab.c:46
 slab_pre_alloc_hook mm/slub.c:4539 [inline]
 slab_alloc_node mm/slub.c:4897 [inline]
 __kmalloc_cache_noprof+0xa8/0x660 mm/slub.c:5485
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 nvmet_fc_alloc_ls_iodlist+0x334/0x940 drivers/nvme/target/fc.c:542
 nvmet_fc_register_targetport+0x76a/0x9e0 drivers/nvme/target/fc.c:1411
 fcloop_create_target_port+0x135/0x4c0 drivers/nvme/target/fcloop.c:1558
 kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fad8719e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fad88044fe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fad87425fa0 RCX: 00007fad8719e019
RDX: 000000000000002f RSI: 0000200000000400 RDI: 0000000000000003
RBP: 00007fad88045050 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fad87426038 R14: 00007fad87425fa0 R15: 00007ffee36393b8
 </TASK>
==================================================================
BUG: KASAN: invalid-free in nvmet_fc_alloc_ls_iodlist+0x915/0x940 drivers/nvme/target/fc.c:569
Free of addr ffff8880136fff20 by task syz.0.0/5325

CPU: 0 UID: 0 PID: 5325 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report_invalid_free+0xea/0x110 mm/kasan/report.c:557
 check_slab_allocation mm/kasan/common.c:-1 [inline]
 __kasan_slab_pre_free+0x104/0x120 mm/kasan/common.c:261
 kasan_slab_pre_free include/linux/kasan.h:199 [inline]
 slab_free_hook mm/slub.c:2622 [inline]
 slab_free mm/slub.c:6377 [inline]
 kfree+0x173/0x640 mm/slub.c:6692
 nvmet_fc_alloc_ls_iodlist+0x915/0x940 drivers/nvme/target/fc.c:569
 nvmet_fc_register_targetport+0x76a/0x9e0 drivers/nvme/target/fc.c:1411
 fcloop_create_target_port+0x135/0x4c0 drivers/nvme/target/fcloop.c:1558
 kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fad8719e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fad88044fe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fad87425fa0 RCX: 00007fad8719e019
RDX: 000000000000002f RSI: 0000200000000400 RDI: 0000000000000003
RBP: 00007fad88045050 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fad87426038 R14: 00007fad87425fa0 R15: 00007ffee36393b8
 </TASK>

Allocated by task 12:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5334 [inline]
 __kmalloc_noprof+0x375/0x720 mm/slub.c:5359
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 neigh_alloc net/core/neighbour.c:518 [inline]
 ___neigh_create+0x6d2/0x22b0 net/core/neighbour.c:652
 ip6_finish_output2+0x6d6/0x13c0 net/ipv6/ip6_output.c:128
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
 ip6_finish_output+0x292/0x770 net/ipv6/ip6_output.c:219
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x337/0x540 net/ipv6/ip6_output.c:246
 dst_output include/net/dst.h:471 [inline]
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ndisc_send_skb+0xcb2/0x1650 net/ipv6/ndisc.c:512
 ndisc_send_ns+0xd7/0x160 net/ipv6/ndisc.c:671
 addrconf_dad_work+0xa8d/0x15c0 net/ipv6/addrconf.c:4317
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880136ff800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 992 bytes to the right of
 832-byte region [ffff8880136ff800, ffff8880136ffb40)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x136fc
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b041dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b041dc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000800080008 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffffffffffff01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 12, tgid 12 (kworker/u4:0), ts 93793846953, free_ts 92088318708
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0x21fa/0x2270 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3266 [inline]
 allocate_slab+0x79/0x5e0 mm/slub.c:3380
 new_slab mm/slub.c:3426 [inline]
 refill_objects+0x2d5/0x350 mm/slub.c:7310
 refill_sheaf mm/slub.c:2804 [inline]
 __pcs_replace_empty_main+0x2bf/0x6b0 mm/slub.c:4675
 alloc_from_pcs mm/slub.c:4773 [inline]
 slab_alloc_node mm/slub.c:4905 [inline]
 __do_kmalloc_node mm/slub.c:5333 [inline]
 __kmalloc_noprof+0x485/0x720 mm/slub.c:5359
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 neigh_alloc net/core/neighbour.c:518 [inline]
 ___neigh_create+0x6d2/0x22b0 net/core/neighbour.c:652
 ip6_finish_output2+0x6d6/0x13c0 net/ipv6/ip6_output.c:128
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
 ip6_finish_output+0x292/0x770 net/ipv6/ip6_output.c:219
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x337/0x540 net/ipv6/ip6_output.c:246
 dst_output include/net/dst.h:471 [inline]
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ndisc_send_skb+0xcb2/0x1650 net/ipv6/ndisc.c:512
 ndisc_send_ns+0xd7/0x160 net/ipv6/ndisc.c:671
 addrconf_dad_work+0xa8d/0x15c0 net/ipv6/addrconf.c:4317
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
page last free pid 15 tgid 15 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0xc1e/0xd10 mm/page_alloc.c:2950
 rcu_do_batch kernel/rcu/tree.c:2645 [inline]
 rcu_core+0x78b/0x10a0 kernel/rcu/tree.c:2897
 handle_softirqs+0x225/0x840 kernel/softirq.c:622
 run_ksoftirqd+0x36/0x60 kernel/softirq.c:1076
 smpboot_thread_fn+0x57c/0xa80 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff8880136ffe00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880136ffe80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880136fff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                               ^
 ffff8880136fff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888013700000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

