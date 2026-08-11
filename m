Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8D9C5AD7B
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 02:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Date:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ys4iNrLMN1lLcVcwA1rz6SIXJyiiK9AiRG0W1tcnzVw=; b=e+lUgpdGzMzjMc/5FYCmu0wZmO
	WIcKJvLGkORlq7uQgiElWP8c3kycdaLxU1VW3YFp1L5IeOy47xEY9Qr9oTJkgWgMnjgkSBrB7ZAZ7
	6ae2CdMH9rDUusL2gWFduW+VQa5overMxww/yvUXcGIVuxbRnP/UGzAE8/SdUqD1n/T1XFtZRzlNk
	x892aBmMYgiff9x+jxsVn4vqWymWWdNr46QUZ115AP9KGxA7MdtORHDdOGOWAlBatStBmyR53jeVN
	QW4/zf5dTXAohGpXZUPltzD+9IjCqH9jOpcSJLwXTLhKYSjW5ItqI64pdmLRHmtTw/NwYmBdp2se8
	F3af3mbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtbt4-0000000D8tU-44Dr;
	Tue, 11 Aug 2026 02:06:42 +0000
Received: from mail-oi1-f206.google.com ([209.85.167.206])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtbsz-0000000D8sK-3G5l
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 02:06:39 +0000
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-4a485034d01so3833443b6e.3
        for <linux-nvme@lists.infradead.org>; Mon, 10 Aug 2026 19:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786413996; x=1787018796;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ys4iNrLMN1lLcVcwA1rz6SIXJyiiK9AiRG0W1tcnzVw=;
        b=Dfb4WmMRhlRSgUch4oekk9mpyVQBLDXp1X9qrcz8WY6mb1d2QHIqPozecpjdlLuVZs
         D7G+9CprZBw0KZjjC+nfXFEymtHDGGGhjPCThqdYNq5RhYVn1R8pyNeiYWHYehlf1LH6
         OScnjTG/b/2o2PLktGuOHBHCs73pYdo2bN5R65W6RVVEKjwjuj+TSvjgz8yk+XR5DCBC
         s9M/G+wJzouOXYZkL00/ivfyBt3T6d32UCpkxOpVHEM5ZzQkcTNhtnEd83eou5FgZt+o
         mTnAc6Qu/7wnEo3sPU6PgWc/Q4Tc3PntFvcTE3OIEeDhY9UJDojmgIF+zcC37JRw4rZT
         I0vg==
X-Forwarded-Encrypted: i=1; AHgh+Rq0KliBb+ueXSgR6DrcRQrTpe43YU5aM4EiI+G1FtqaZ44iqkkuSF2O1F3wvZH+MWiCzhUSjkJqzGnK@lists.infradead.org
X-Gm-Message-State: AOJu0YzH/NX7XV7RwpG0RJpoNQqLDXI1RY53ka+p1U4zJs8INQ4ZyLw5
	NrY48VeOMtct37PHq+Ntn0we/Gz7xCf+zXb0+QCTgv1GELNzX4OMK2JhWjoPdpQyihz2RVXopMM
	p7pWhsoOcPyAH06aCWvQ31qAbkURkV4AOlqEbJWfNxKebaKqPtUMSB3bXa3c=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1512:b0:496:e0:a47b with SMTP id
 5614622812f47-4b1aba7f07cmr12723779b6e.20.1786413996055; Mon, 10 Aug 2026
 19:06:36 -0700 (PDT)
Date: Mon, 10 Aug 2026 19:06:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7a83ac.01d0871a.3a0d52.00bb.GAE@google.com>
Subject: [syzbot] [nvme?] KASAN: slab-use-after-free Read in nvmf_free_options
From: syzbot <syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_190637_893621_68965E51 
X-CRM114-Status: UNSURE (   8.69  )
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

HEAD commit:    0d8395707651 Merge tag 'soc-fixes-7.2-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130897b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c05be6c9b0d36cb9
dashboard link: https://syzkaller.appspot.com/bug?extid=f58e57380a6083c4041d
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-0d839570.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f71d0db84455/vmlinux-0d839570.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9e4025aaafe2/bzImage-0d839570.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com

FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
CPU: 0 UID: 0 PID: 5326 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 fail_dump lib/fault-inject.c:73 [inline]
 should_fail_ex+0x40c/0x560 lib/fault-inject.c:174
 should_failslab+0xa8/0x100 mm/failslab.c:46
 slab_pre_alloc_hook mm/slub.c:4539 [inline]
 slab_alloc_node mm/slub.c:4897 [inline]
 __do_kmalloc_node mm/slub.c:5333 [inline]
 __kmalloc_node_track_caller_noprof+0x100/0x730 mm/slub.c:5471
 kvasprintf+0xeb/0x1a0 lib/kasprintf.c:25
 kobject_set_name_vargs+0x61/0x110 lib/kobject.c:274
 dev_set_name+0xe2/0x140 drivers/base/core.c:3560
 nvme_add_ctrl+0x6e/0x270 drivers/nvme/host/core.c:5248
 nvme_fc_init_ctrl+0xcb0/0x1450 drivers/nvme/host/fc.c:3554
 nvme_fc_create_ctrl+0x4cd/0x520 drivers/nvme/host/fc.c:3723
 nvmf_create_ctrl drivers/nvme/host/fabrics.c:1359 [inline]
 nvmf_dev_write+0x24ca/0x2d90 drivers/nvme/host/fabrics.c:1406
 vfs_write+0x296/0xba0 fs/read_write.c:685
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fea9b39e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fea9c299fe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fea9b625fa0 RCX: 00007fea9b39e0d9
RDX: 000000000000007e RSI: 0000200000000a00 RDI: 0000000000000005
RBP: 00007fea9c29a050 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fea9b626038 R14: 00007fea9b625fa0 R15: 00007ffe156ed1b8
 </TASK>
==================================================================
BUG: KASAN: slab-use-after-free in nvmf_free_options+0x30/0x190 drivers/nvme/host/fabrics.c:1284
Read of size 8 at addr ffff88801f4a2550 by task syz.0.0/5326

CPU: 0 UID: 0 PID: 5326 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 nvmf_free_options+0x30/0x190 drivers/nvme/host/fabrics.c:1284
 nvmf_create_ctrl drivers/nvme/host/fabrics.c:1374 [inline]
 nvmf_dev_write+0x267f/0x2d90 drivers/nvme/host/fabrics.c:1406
 vfs_write+0x296/0xba0 fs/read_write.c:685
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fea9b39e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fea9c299fe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fea9b625fa0 RCX: 00007fea9b39e0d9
RDX: 000000000000007e RSI: 0000200000000a00 RDI: 0000000000000005
RBP: 00007fea9c29a050 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fea9b626038 R14: 00007fea9b625fa0 R15: 00007ffe156ed1b8
 </TASK>

Allocated by task 5326:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x32d/0x660 mm/slub.c:5489
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 nvmf_create_ctrl drivers/nvme/host/fabrics.c:1315 [inline]
 nvmf_dev_write+0x243/0x2d90 drivers/nvme/host/fabrics.c:1406
 vfs_write+0x296/0xba0 fs/read_write.c:685
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5326:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2677 [inline]
 slab_free mm/slub.c:6377 [inline]
 kfree+0x1c5/0x640 mm/slub.c:6692
 nvme_fc_ctrl_free drivers/nvme/host/fc.c:2374 [inline]
 kref_put include/linux/kref.h:65 [inline]
 nvme_fc_ctrl_put+0x2cc/0x340 drivers/nvme/host/fc.c:2381
 nvme_free_ctrl+0x38c/0x570 drivers/nvme/host/core.c:5146
 device_release+0xc4/0x1f0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x222/0x550 lib/kobject.c:737
 nvme_put_ctrl drivers/nvme/host/nvme.h:833 [inline]
 nvme_fc_init_ctrl+0xe17/0x1450 drivers/nvme/host/fc.c:3605
 nvme_fc_create_ctrl+0x4cd/0x520 drivers/nvme/host/fc.c:3723
 nvmf_create_ctrl drivers/nvme/host/fabrics.c:1359 [inline]
 nvmf_dev_write+0x24ca/0x2d90 drivers/nvme/host/fabrics.c:1406
 vfs_write+0x296/0xba0 fs/read_write.c:685
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801f4a2500
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 80 bytes inside of
 freed 192-byte region [ffff88801f4a2500, ffff88801f4a25c0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1f4a2
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b0413c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xd2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5289, tgid 5289 (syz-executor), ts 83703979346, free_ts 83087386547
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
 __kmalloc_node_track_caller_noprof+0x557/0x730 mm/slub.c:5471
 kmemdup_noprof+0x2b/0x70 mm/util.c:138
 kmemdup_noprof include/linux/fortify-string.h:715 [inline]
 ebt_register_table+0x18e/0x1190 net/bridge/netfilter/ebtables.c:1197
 find_inlist_lock_noload+0x171/0x260 net/bridge/netfilter/ebtables.c:344
 find_inlist_lock net/bridge/netfilter/ebtables.c:372 [inline]
 find_table_lock net/bridge/netfilter/ebtables.c:380 [inline]
 do_ebt_get_ctl+0x367/0x1f30 net/bridge/netfilter/ebtables.c:2512
 nf_getsockopt+0x26e/0x290 net/netfilter/nf_sockopt.c:116
 ip_getsockopt+0x19e/0x230 net/ipv4/ip_sockglue.c:1777
 do_sock_getsockopt+0x569/0xa70 net/socket.c:2474
 __sys_getsockopt net/socket.c:2505 [inline]
 __do_sys_getsockopt net/socket.c:2512 [inline]
 __se_sys_getsockopt net/socket.c:2509 [inline]
 __x64_sys_getsockopt+0x1a4/0x240 net/socket.c:2509
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
page last free pid 75 tgid 75 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1406 [inline]
 free_unref_folios+0xd84/0x14a0 mm/page_alloc.c:3011
 shrink_folio_list+0x4b16/0x5330 mm/vmscan.c:1582
 evict_folios+0x3821/0x49e0 mm/vmscan.c:4834
 try_to_shrink_lruvec+0xb4f/0xed0 mm/vmscan.c:4983
 shrink_one+0x233/0x730 mm/vmscan.c:5024
 shrink_many mm/vmscan.c:5087 [inline]
 lru_gen_shrink_node mm/vmscan.c:5165 [inline]
 shrink_node+0x3303/0x3b60 mm/vmscan.c:6154
 kswapd_shrink_node mm/vmscan.c:7008 [inline]
 balance_pgdat mm/vmscan.c:7186 [inline]
 kswapd+0x17b6/0x31c0 mm/vmscan.c:7462
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff88801f4a2400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801f4a2480: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff88801f4a2500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff88801f4a2580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88801f4a2600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

