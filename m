Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D0FE77188
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Dec 2024 02:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:In-Reply-To:Date:MIME-Version:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=QuqvXbvMtVZbZONDhOasqGVfY/yDi2zdrjMYFdTopNQ=; b=NhZaDOmpvR5Azr
	dxSIa9868TxbJ7gfdtbFO8B4tSgz/ALm+6wM2zUVOTHSCFUDW/Crsq+OsY+iI1YrUXt8a+zu4uFZj
	DE7p4un8TH9GZH3Y1ix1lCGAm9Qt25g0S/MEZfO6NdF0xMoTrX1ulHdlPBrWLAMnCi+9wGDAXdWvB
	flbdV20TEMeHqUGF5OezTSaE6GLaDtWRf3X0tYX4NUcHLkfDDyJksTomV48CEQaHygiRR2UWCMo9m
	dPaPPSyP/jT4raXXtHw0PF/Mesd1fegrFfgVLYB7CEyNwzRCRHom8XNbQm6osj7Rd0USa9nPaDuoM
	xHoK3ikfvJa38zSwEZOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQHI6-0000000D7Cf-2iJx;
	Wed, 25 Dec 2024 02:38:30 +0000
Received: from mail-io1-f80.google.com ([209.85.166.80])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQHI2-0000000D7CK-3HV4
	for linux-nvme@lists.infradead.org;
	Wed, 25 Dec 2024 02:38:28 +0000
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-844e9b88efeso927247339f.0
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 18:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735094305; x=1735699105;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QuqvXbvMtVZbZONDhOasqGVfY/yDi2zdrjMYFdTopNQ=;
        b=tD6Swr9GIhaX4X3gucTTdAcU11D6dNR9s8VXKeblUmShRHct5pUmrIA6l8YOIGfCNj
         h11GBLJQCl2MHk8MH0Bb4ffR4H3+FcUyf3ZAOjkCLy7ap/OJHcPuhDiEuPcrSkofy0Uy
         GmSxmc9DXcI7Q7ZEx9l+AVc075gaPGeHhhhsKFHvvH5aG5RpGTFxqWjG5j7LgosWC2FE
         g4dW/wZCDT4xfxbqBqKwH7e7fIIKk0hEHGR+qxHruPJwCQund5kFFucTlxF6j+jESL8F
         leez0nG3wwSFcCoAJ6PJkX5zXFLq6OrM/cZAsH8U5ZhU6IjwdZtg11dHR79bwkkkIJ+i
         FeZg==
X-Forwarded-Encrypted: i=1; AJvYcCXbnJXLlW1ZR915dK3yTN4b06s8T+xjN9vHHBKTgIE9ztnZVeGSorVow7M9TI1QCZH8FPSn+kONH4fU@lists.infradead.org
X-Gm-Message-State: AOJu0YxYH+Sv+KFm81Nxe8m2yEijsAgxJzLfEv9kFWdlnV+Ir1iLC6xM
	umI/vaQrcs1eOjCuDzpocj4jhoQxrW14ivOh+mPHl33bM/kADBmnSLv8UocyLOFJ133RbQgtbto
	Q6wuMLcU1qZkPuPWRMEOPJodoxru8kLm66GJ2LVu6krfaeQuuvLdNFXw=
X-Google-Smtp-Source: AGHT+IEo/gBB6Z3EvY/aSebg/v7nc7SfDVoh8UEhSG+V2dah+ai8npQMCnTeeQSpJAko6xxp4KECSY6Ry+SM2um66q1qnkQOzkky
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e4:b0:3a7:1f72:ad3c with SMTP id
 e9e14a558f8ab-3c2d514ff8cmr142680225ab.19.1735094304837; Tue, 24 Dec 2024
 18:38:24 -0800 (PST)
Date: Tue, 24 Dec 2024 18:38:24 -0800
In-Reply-To: <67627b39.050a0220.29fcd0.0087.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676b7020.050a0220.226966.0061.GAE@google.com>
Subject: Re: [syzbot] [nvme?] KASAN: slab-out-of-bounds Read in nvmet_root_discovery_nqn_show
From: syzbot <syzbot+a84181c81389771eb46a@syzkaller.appspotmail.com>
To: dvyukov@google.com, hch@lst.de, kch@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_183826_833678_701F10BE 
X-CRM114-Status: UNSURE (   7.37  )
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    9b2ffa6148b1 Merge tag 'mtd/fixes-for-6.13-rc5' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a26adf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c078001e66e4a17e
dashboard link: https://syzkaller.appspot.com/bug?extid=a84181c81389771eb46a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109800b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162422f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c1d66e09941d/disk-9b2ffa61.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8aa24ea0a81d/vmlinux-9b2ffa61.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0d9c0b1e880a/bzImage-9b2ffa61.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a84181c81389771eb46a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in string_nocheck lib/vsprintf.c:646 [inline]
BUG: KASAN: slab-out-of-bounds in string+0x398/0x3d0 lib/vsprintf.c:728
Read of size 1 at addr ffff8880263c0b25 by task syz-executor329/5823

CPU: 0 UID: 0 PID: 5823 Comm: syz-executor329 Not tainted 6.13.0-rc4-syzkaller-00012-g9b2ffa6148b1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 string_nocheck lib/vsprintf.c:646 [inline]
 string+0x398/0x3d0 lib/vsprintf.c:728
 vsnprintf+0xc67/0x1870 lib/vsprintf.c:2848
 snprintf+0xc8/0x100 lib/vsprintf.c:2983
 nvmet_root_discovery_nqn_show+0x69/0x90 drivers/nvme/target/configfs.c:2250
 fill_read_buffer fs/configfs/file.c:68 [inline]
 configfs_read_iter+0x40d/0x690 fs/configfs/file.c:88
 __kernel_read+0x3f1/0xb50 fs/read_write.c:523
 integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:28
 ima_calc_file_hash_tfm+0x2c9/0x3e0 security/integrity/ima/ima_crypto.c:480
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1ba/0x490 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x8a7/0xa10 security/integrity/ima/ima_api.c:293
 process_measurement+0x1271/0x2370 security/integrity/ima/ima_main.c:372
 ima_file_check+0xc6/0x110 security/integrity/ima/ima_main.c:572
 security_file_post_open+0x8e/0x210 security/security.c:3121
 do_open fs/namei.c:3830 [inline]
 path_openat+0x1419/0x2d60 fs/namei.c:3987
 do_filp_open+0x20c/0x470 fs/namei.c:4014
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1428
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f733fa0ca79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc342ba758 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f733fa0ca79
RDX: 0000000000189002 RSI: 0000000020000100 RDI: ffffffffffffff9c
RBP: 000000000000fe6f R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc342ba76c
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>

The buggy address belongs to the object at ffff8880263c0b00
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 0 bytes to the right of
 allocated 37-byte region [ffff8880263c0b00, ffff8880263c0b25)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880263c0300 pfn:0x263c0
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000200 ffff88801ac418c0 ffffea0000ba8cd0 ffffea0000a178d0
raw: ffff8880263c0300 000000000020001f 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 35, tgid 35 (kworker/u8:2), ts 8598107284, free_ts 8552526219
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1558
 prep_new_page mm/page_alloc.c:1566 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3476
 __alloc_pages_noprof+0x223/0x25b0 mm/page_alloc.c:4753
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2269
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab mm/slub.c:2589 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2642
 ___slab_alloc+0xce2/0x1650 mm/slub.c:3830
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __kmalloc_cache_noprof+0xf6/0x420 mm/slub.c:4324
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 percpu_ref_init+0xd9/0x400 lib/percpu-refcount.c:76
 blk_alloc_queue+0x578/0x710 block/blk-core.c:447
 blk_mq_alloc_queue+0x1a6/0x2e0 block/blk-mq.c:4339
 scsi_alloc_sdev+0x890/0xd80 drivers/scsi/scsi_scan.c:337
 scsi_probe_and_add_lun+0x789/0xda0 drivers/scsi/scsi_scan.c:1210
 __scsi_scan_target+0x1ea/0x580 drivers/scsi/scsi_scan.c:1757
 scsi_scan_channel drivers/scsi/scsi_scan.c:1845 [inline]
 scsi_scan_channel+0x149/0x1e0 drivers/scsi/scsi_scan.c:1821
 scsi_scan_host_selected+0x302/0x400 drivers/scsi/scsi_scan.c:1874
page last free pid 57 tgid 57 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0x661/0x1080 mm/page_alloc.c:2659
 vfree+0x174/0x950 mm/vmalloc.c:3383
 delayed_vfree_work+0x56/0x70 mm/vmalloc.c:3303
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff8880263c0a00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880263c0a80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff8880263c0b00: 00 00 00 00 05 fc fc fc fc fc fc fc fc fc fc fc
                               ^
 ffff8880263c0b80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880263c0c00: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

