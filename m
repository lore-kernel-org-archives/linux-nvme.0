Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BEEC61DBD
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2026 03:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Date:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ilAIY4J4SwgOVJqA7pL5H8ii6qJt6mI03kJTeRtB3TA=; b=mswX2vYZowlsTBXUns/1Mi3O1v
	wxdwRnV8GcRq2gABQIoPexk6Ty8QvvrMpf/7wKEZty6JL4zjDDUJsQpdZL6OT/tmjTpZbPToSESWU
	BlpxFEiy/VFHdgjrzHuBiZXFr2Q0evV/y0h8hXcwQnUDopsCm7uhrKw949yzVPUwNtfS0JCQ8L6QP
	0P98Qm2CkAUa8MfvAFo/E6LyXQiO5g2RJUjDehhdflq6qBK57piMm803csmkm97vzee7nNuaxTg2M
	ZM0c+w+Qxs7oLKtlGkRDo0PzeZSVWMEUAriTxqOjXLpoHSGjbvdDXS3zTbl1n8ch41kbFII4G3pAk
	YvKkmZYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzQo2-00000003MY8-0USw;
	Thu, 27 Aug 2026 03:29:34 +0000
Received: from mail-oa2-f9.google.com ([74.125.231.73])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzQny-00000003MXp-3d85
	for linux-nvme@lists.infradead.org;
	Thu, 27 Aug 2026 03:29:32 +0000
Received: by mail-oa2-f9.google.com with SMTP id 586e51a60fabf-4667f43a4ccso306912fac.0
        for <linux-nvme@lists.infradead.org>; Wed, 26 Aug 2026 20:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787801368; x=1788406168;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ilAIY4J4SwgOVJqA7pL5H8ii6qJt6mI03kJTeRtB3TA=;
        b=OhEy62r71sEmQJ1nltV7VoCTQtQT+sbhfmxIfuk7m/GCcB6j7mIiJiu4Dmq6ycO4GQ
         miiS92ajg2ZDqRpdHQWO44juEfUnzL91iYjm/BnuSUU2EXv3QUQ9WiFgNwn14w244PVW
         8IqyQwnxV52YMREt96QnMawU2kZ+LKNPJWuCw3FfvnIKwzC2IFbRd5m6TnRv1SoOh1UP
         A87nLyZUYu9uSff6WuOqeu0EDeEOx0ew3PU5NNmeufulUaCESFV0Dmgl18VuCalhzdll
         esThSbF47AvRYx0EFRRxNHJ8Im4CJsT8LJggNSuz5R2ijooU65IPSsqi9NHIjCxsahLN
         rjuQ==
X-Forwarded-Encrypted: i=1; AHgh+RqacDX4Q7nSmV3vrjpaowEP0dwUR2ZDddIeeg7DR9TjZIdRGs4ZSpw9iekT4tHypEDoLW/N8A83FgAT@lists.infradead.org
X-Gm-Message-State: AFuF++n9cp6JUy9CddV/lWJRljK+v8N7wHZjex3czsTdnSG9Z1SkVtSD
	xzl2U4rpFJsTliThQHjY+TMx0mu7BKdEaGbtD8kPNqsvsSsQ/PEBp7IXz42443E9d+lmuVdrj+o
	oDC39OPXMk3W1NL/0NsnfCRK41DFp7syh78FYlWslqvmEhx+vymwsYuaR+ts=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:81d5:b0:6b1:3db9:b758 with SMTP id
 006d021491bc7-6b1a03b2eaemr11943980eaf.9.1787801368416; Wed, 26 Aug 2026
 20:29:28 -0700 (PDT)
Date: Wed, 26 Aug 2026 20:29:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8faf18.4d659fcc.734b4.0009.GAE@google.com>
Subject: [syzbot] [nvme?] KASAN: slab-use-after-free Read in nvmet_port_subsys_allow_link
From: syzbot <syzbot+b0996ac2197dd7420c3e@syzkaller.appspotmail.com>
To: hch@lst.de, kch@nvidia.com, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, sagi@grimberg.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260826_202930_932524_18195477 
X-CRM114-Status: UNSURE (   8.73  )
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

HEAD commit:    26260251022f Merge tag 'livepatching-for-7.3' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10519179580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5a17c415a27e42e
dashboard link: https://syzkaller.appspot.com/bug?extid=b0996ac2197dd7420c3e
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/05f9f33a1f1f/disk-26260251.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/197f5b9a6961/vmlinux-26260251.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ad671f043000/bzImage-26260251.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b0996ac2197dd7420c3e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in nvmet_port_subsys_allow_link+0x41/0x2e0 drivers/nvme/target/configfs.c:1059
Read of size 8 at addr ffff88801af304c8 by task syz.2.79/6124

CPU: 1 UID: 0 PID: 6124 Comm: syz.2.79 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 nvmet_port_subsys_allow_link+0x41/0x2e0 drivers/nvme/target/configfs.c:1059
 configfs_symlink+0x59a/0x1030 fs/configfs/symlink.c:196
 vfs_symlink+0x18b/0x330 fs/namei.c:5794
 filename_symlinkat+0x1cd/0x420 fs/namei.c:5819
 __do_sys_symlinkat fs/namei.c:5839 [inline]
 __se_sys_symlinkat+0x4e/0x2b0 fs/namei.c:5834
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcbe476e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcbe29c6028 EFLAGS: 00000246 ORIG_RAX: 000000000000010a
RAX: ffffffffffffffda RBX: 00007fcbe49f5fa0 RCX: 00007fcbe476e0d9
RDX: 0000200000000600 RSI: ffffffffffffff9c RDI: 00002000000005c0
RBP: 00007fcbe4805024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fcbe49f6038 R14: 00007fcbe49f5fa0 R15: 00007fffa285bf38
 </TASK>

Allocated by task 6060:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3da/0x6b0 mm/slub.c:5484
 _kmalloc_noprof include/linux/slab.h:988 [inline]
 _kzalloc_noprof include/linux/slab.h:1309 [inline]
 nvmet_ports_make+0xe6/0xf00 drivers/nvme/target/configfs.c:2051
 configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1360
 vfs_mkdir+0x408/0x620 fs/namei.c:5410
 filename_mkdirat+0x289/0x520 fs/namei.c:5443
 __do_sys_mkdirat fs/namei.c:5464 [inline]
 __se_sys_mkdirat+0x35/0x150 fs/namei.c:5461
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6127:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2678 [inline]
 slab_free mm/slub.c:6372 [inline]
 kfree+0x1c5/0x6d0 mm/slub.c:6687
 config_item_cleanup fs/configfs/item.c:128 [inline]
 config_item_release+0x13a/0x2d0 fs/configfs/item.c:137
 configfs_rmdir+0x885/0x950 fs/configfs/dir.c:1571
 vfs_rmdir+0x3e9/0x6b0 fs/namei.c:5515
 filename_rmdir+0x292/0x520 fs/namei.c:5572
 __do_sys_unlinkat fs/namei.c:5747 [inline]
 __se_sys_unlinkat+0x71/0x1a0 fs/namei.c:5740
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801af30000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 1224 bytes inside of
 freed 4096-byte region [ffff88801af30000, ffff88801af31000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1af30
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88813ffbc140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800040004 00000000f5000000 0000000000000000
head: 0080000000000040 ffff88813ffbc140 dead000000000100 dead000000000122
head: 0000000000000000 0000000800040004 00000000f5000000 0000000000000000
head: 0080000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5585, tgid 5585 (syz-executor), ts 106684716313
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x2591/0x2600 mm/page_alloc.c:3943
 __alloc_frozen_pages_noprof+0x230/0x5c0 mm/page_alloc.c:5436
 alloc_slab_page mm/slub.c:3267 [inline]
 allocate_slab+0x7c/0x5e0 mm/slub.c:3382
 new_slab mm/slub.c:3428 [inline]
 refill_objects+0x2d8/0x350 mm/slub.c:7305
 refill_sheaf mm/slub.c:2805 [inline]
 __pcs_replace_empty_main+0x334/0x690 mm/slub.c:4677
 alloc_from_pcs mm/slub.c:4775 [inline]
 slab_alloc_node mm/slub.c:4907 [inline]
 __do_kmalloc_node mm/slub.c:5336 [inline]
 __kmalloc_noprof+0x54c/0x780 mm/slub.c:5362
 _kmalloc_noprof include/linux/slab.h:992 [inline]
 tomoyo_realpath_from_path+0xef/0x640 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x283/0x560 security/tomoyo/file.c:827
 security_inode_getattr+0x12b/0x310 security/security.c:1895
 vfs_getattr+0x23/0x70 fs/stat.c:259
 vfs_statx_path+0x2b/0x230 fs/stat.c:299
 vfs_statx+0x12e/0x200 fs/stat.c:356
 vfs_fstatat+0x11b/0x170 fs/stat.c:373
 __do_sys_newfstatat fs/stat.c:538 [inline]
 __se_sys_newfstatat fs/stat.c:532 [inline]
 __x64_sys_newfstatat+0x151/0x200 fs/stat.c:532
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
page last free pid 5783 tgid 5783 ts 106512362313 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0xf8e/0x1070 mm/page_alloc.c:2962
 __slab_free+0x252/0x2a0 mm/slub.c:5736
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x99/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4586 [inline]
 slab_alloc_node mm/slub.c:4919 [inline]
 kmem_cache_alloc_noprof+0x35d/0x660 mm/slub.c:4933
 alloc_filename fs/namei.c:147 [inline]
 do_getname+0x2e/0x250 fs/namei.c:187
 class_filename_flags_constructor include/linux/fs.h:2587 [inline]
 do_sys_openat2+0xcc/0x200 fs/open.c:1416
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88801af30380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801af30400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801af30480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff88801af30500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801af30580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

