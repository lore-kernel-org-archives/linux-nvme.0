Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A89E77183
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2024 07:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OsS7moYHTJv02lkruek9hpS7RKuUHjsiKM+R2j5C0e4=; b=TJjJYiscokQW+iSl3rQbJVjIWc
	tino/2A3NaTcBrgNamocYyK5vYcHxCj8s7lOVIVlFImo3RYLCtxeZionVGxfZ0z0gY0NpyG0ZTdDS
	Wg6SYcAX/MEG8DA1ABp6POLFHp1uVMBvsuuYFtQGcWwFDzfB4DX+v6XDyQs/9sHaP7UaraVUjlpXq
	h4DwMkSASviw2KXUjslCi9x8sypBypzh/o4X6hkPCkzZsJpqsdx34w6PloodoynMSuuZw3moQ58kN
	U0OoQ5WvZYeXRJW1eEwZ6JB4p5McsrmX+EcSnpPowGRDlSo6dTgdZrCXiduXgv9lQ5ZaUqS3nVAtz
	u0rqChcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNohH-0000000FqLg-10PA;
	Wed, 18 Dec 2024 07:42:19 +0000
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNohD-0000000FqLC-3M9g
	for linux-nvme@lists.infradead.org;
	Wed, 18 Dec 2024 07:42:17 +0000
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-30229d5b22fso64716431fa.2
        for <linux-nvme@lists.infradead.org>; Tue, 17 Dec 2024 23:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734507733; x=1735112533; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OsS7moYHTJv02lkruek9hpS7RKuUHjsiKM+R2j5C0e4=;
        b=WDaJYFyduMTuL2LJltHsbY8aA+E/WDMP6+NjepUgjUUk5yfReaAgLCDGa4R1CfTNr/
         +oJckUCQpcAJ9BsrUFdYELBLk9s4d2gwkLm7yuyC6OP+V6Uj9jI4ZUt+qYPOIY//Bc5B
         JOimVg6QqXqDi7LjSdk7saycaXVIOERk+UyjiLovkEbOe6GdOnrkzp8EHUjBxJLrFeA+
         RT0WkY1y6zF1x7kjT3eXZIsBKGUya/iAvDR+dzudXtkB1ZWGt6YH8PoZkDwaRuGPrdXG
         HDCTp5mTEyJIzMLiuV1HcbdK9/jZwTh4SkAKZuQBhx/z0V/NBTyMjP4syphMFq7CZA5L
         cw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734507733; x=1735112533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsS7moYHTJv02lkruek9hpS7RKuUHjsiKM+R2j5C0e4=;
        b=enXWKRyqK62mbmgJY4BFK3yCdqIeuZgAGZgdsB5cf/tf3E2+MhqrlPE2ccuvC8K66B
         DsXOoXXJR7Sj+gCdXkEXkMjvlZmFPFF+t6ej9U+FXS7N7O18Pcx/e4KI9fO/zgVZ0Gvb
         dRn4vl6glKzikNtp6bIFRGL6MG/LMxZpL3V093Htj4jeHg7V9yb+LyEv28PUGiFpBN+Z
         aLPe6UqpR8lAUUdOpHHkGAOpKaDgQ3pz7WT8hmBbQjuQqj8tZ0fCL1NPYKmF5E+ww7w4
         x4dZQ96L3k1JUkhpX2hw7RuRPjwvbAr+LaUSsvu28ZIyyu1ta1M0IqLMWqyT+WU5+0DG
         nwLg==
X-Forwarded-Encrypted: i=1; AJvYcCWcUjvBWh3sI9dgv8Dw9+HKGdHIvvAQZZ1HLWI6ya8mRgWLrJQ9oybUJgqs8qne+Apx5bVbxdjmG5HG@lists.infradead.org
X-Gm-Message-State: AOJu0YxNXc+8Tqoy2KcIf4fIQp1SiZR3m/zwrHsTrzcdPIve/Io4A1DL
	uV8SymdRh+8nOlsaBU0ByKuYfj2TJeqjKUp5zFgUrNXnkWo3MAB4+R3O2N0H5UovHDsLPwT9M3D
	EzEGEAosbJNePQvyNjqgUF7aK8JKnRtgwio5b
X-Gm-Gg: ASbGncshv6VTSxrBNe2vzOSLGQY34ppDEaq3GhwnnTiDC/30W4zTPG930GFKFizL9l/
	//JDsNoEmKrwbVamq587VuVQELuP+JUp8DPHBVZoN1974OUE7od7eIycNp/sXvPaQvSYXtGg=
X-Google-Smtp-Source: AGHT+IE/40DgY6lNkfSncgFtBLT7OiB/Qx2PTfP5JWTPZxnAh7RvvJdWIrHy9FkdsNFMhrcwghlpdN9Ogtpw7H9bGrs=
X-Received: by 2002:a2e:be8c:0:b0:302:2c61:a1d3 with SMTP id
 38308e7fff4ca-3044db58da0mr6292431fa.36.1734507732836; Tue, 17 Dec 2024
 23:42:12 -0800 (PST)
MIME-Version: 1.0
References: <67627b39.050a0220.29fcd0.0087.GAE@google.com>
In-Reply-To: <67627b39.050a0220.29fcd0.0087.GAE@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 18 Dec 2024 08:42:01 +0100
Message-ID: <CACT4Y+ZWUaXYJtDBTZVmZ_WdBUEfUErXW-91hD55XVpCGmtczA@mail.gmail.com>
Subject: Re: [syzbot] [nvme?] KASAN: slab-out-of-bounds Read in nvmet_root_discovery_nqn_show
To: syzbot <syzbot+a84181c81389771eb46a@syzkaller.appspotmail.com>
Cc: hch@lst.de, kch@nvidia.com, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, sagi@grimberg.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_234215_843516_309D04CB 
X-CRM114-Status: GOOD (  22.98  )
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

On Wed, 18 Dec 2024 at 08:35, syzbot
<syzbot+a84181c81389771eb46a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    a0e3919a2df2 Merge tag 'usb-6.13-rc3' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=123cbcdf980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
> dashboard link: https://syzkaller.appspot.com/bug?extid=a84181c81389771eb46a
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/669aa1e15c11/disk-a0e3919a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ee966f8b50ac/vmlinux-a0e3919a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e872e1d072f1/bzImage-a0e3919a.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a84181c81389771eb46a@syzkaller.appspotmail.com

It looks like 0 termination here is incorrect:
https://elixir.bootlin.com/linux/v6.12.5/source/drivers/nvme/target/fabrics-cmd.c#L245
should be s/NVMF_NQN_FIELD_LEN/NVMF_NQN_SIZE/


> ==================================================================
> BUG: KASAN: slab-out-of-bounds in string_nocheck lib/vsprintf.c:646 [inline]
> BUG: KASAN: slab-out-of-bounds in string+0x398/0x3d0 lib/vsprintf.c:728
> Read of size 1 at addr ffff88814371a8a5 by task syz.0.6476/29206
>
> CPU: 0 UID: 0 PID: 29206 Comm: syz.0.6476 Tainted: G     U             6.13.0-rc2-syzkaller-00333-ga0e3919a2df2 #0
> Tainted: [U]=USER
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xc3/0x620 mm/kasan/report.c:489
>  kasan_report+0xd9/0x110 mm/kasan/report.c:602
>  string_nocheck lib/vsprintf.c:646 [inline]
>  string+0x398/0x3d0 lib/vsprintf.c:728
>  vsnprintf+0xc67/0x1870 lib/vsprintf.c:2848
>  snprintf+0xc8/0x100 lib/vsprintf.c:2983
>  nvmet_root_discovery_nqn_show+0x69/0x90 drivers/nvme/target/configfs.c:2250
>  fill_read_buffer fs/configfs/file.c:68 [inline]
>  configfs_read_iter+0x40d/0x690 fs/configfs/file.c:88
>  __kernel_read+0x3f1/0xb50 fs/read_write.c:523
>  integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:28
>  ima_calc_file_hash_tfm+0x2c9/0x3e0 security/integrity/ima/ima_crypto.c:480
>  ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
>  ima_calc_file_hash+0x1ba/0x490 security/integrity/ima/ima_crypto.c:568
>  ima_collect_measurement+0x8a7/0xa10 security/integrity/ima/ima_api.c:293
>  process_measurement+0x1271/0x2370 security/integrity/ima/ima_main.c:372
>  ima_file_check+0xc6/0x110 security/integrity/ima/ima_main.c:572
>  security_file_post_open+0x8e/0x210 security/security.c:3121
>  do_open fs/namei.c:3830 [inline]
>  path_openat+0x1419/0x2d60 fs/namei.c:3987
>  do_filp_open+0x20c/0x470 fs/namei.c:4014
>  do_sys_openat2+0x17a/0x1e0 fs/open.c:1402
>  do_sys_open fs/open.c:1417 [inline]
>  __do_sys_openat fs/open.c:1433 [inline]
>  __se_sys_openat fs/open.c:1428 [inline]
>  __x64_sys_openat+0x175/0x210 fs/open.c:1428
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f3dfbd85d19
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f3dfcb03038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 00007f3dfbf76080 RCX: 00007f3dfbd85d19
> RDX: 0000000000189002 RSI: 0000000020000100 RDI: ffffffffffffff9c
> RBP: 00007f3dfbe01a20 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f3dfbf76080 R15: 00007ffc48d63a98
>  </TASK>
>
> The buggy address belongs to the object at ffff88814371a880
>  which belongs to the cache kmalloc-64 of size 64
> The buggy address is located 0 bytes to the right of
>  allocated 37-byte region [ffff88814371a880, ffff88814371a8a5)
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x14371a
> flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
> page_type: f5(slab)
> raw: 057ff00000000000 ffff88801ac418c0 ffffea00052a0a40 dead000000000004
> raw: 0000000000000000 0000000000200020 00000001f5000000 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 8577258261, free_ts 0
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1556
>  prep_new_page mm/page_alloc.c:1564 [inline]
>  get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3474
>  __alloc_pages_noprof+0x223/0x25b0 mm/page_alloc.c:4751
>  alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2269
>  alloc_slab_page mm/slub.c:2423 [inline]
>  allocate_slab mm/slub.c:2589 [inline]
>  new_slab+0x2c9/0x410 mm/slub.c:2642
>  ___slab_alloc+0xce2/0x1650 mm/slub.c:3830
>  __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3920
>  __slab_alloc_node mm/slub.c:3995 [inline]
>  slab_alloc_node mm/slub.c:4156 [inline]
>  __kmalloc_cache_noprof+0xf6/0x420 mm/slub.c:4324
>  kmalloc_noprof include/linux/slab.h:901 [inline]
>  __kthread_create_on_node+0xcb/0x400 kernel/kthread.c:436
>  kthread_create_on_node+0xc8/0x110 kernel/kthread.c:513
>  init_rescuer+0x322/0x640 kernel/workqueue.c:5562
>  __alloc_workqueue+0xc27/0x1810 kernel/workqueue.c:5731
>  alloc_workqueue+0xd3/0x200 kernel/workqueue.c:5772
>  nvmet_init+0xd2/0x220 drivers/nvme/target/core.c:1760
>  do_one_initcall+0x128/0x630 init/main.c:1266
>  do_initcall_level init/main.c:1328 [inline]
>  do_initcalls init/main.c:1344 [inline]
>  do_basic_setup init/main.c:1363 [inline]
>  kernel_init_freeable+0x58f/0x8b0 init/main.c:1577
> page_owner free stack trace missing
>
> Memory state around the buggy address:
>  ffff88814371a780: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>  ffff88814371a800: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
> >ffff88814371a880: 00 00 00 00 05 fc fc fc fc fc fc fc fc fc fc fc
>                                ^
>  ffff88814371a900: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>  ffff88814371a980: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller-bugs/67627b39.050a0220.29fcd0.0087.GAE%40google.com.

