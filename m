Return-Path: <SRS0=zgHd=LK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B80BC48BE5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 21:18:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 451B7613DE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 21:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451B7613DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:From:Subject:Message-ID:Date:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=OR05CbFTiSfdhwarpwz4fc+8i3NPuT1xlR5ITXntsH4=; b=tb/
	fU3u1waDYuDdE3S0LnT6cBW9cjyR9aq45D2/Hr9dTjysldE/s8YuekZO14U9pbfENjXIQf1Zoae/O
	i0mw7f+ZzcntxW1RtbdtoJAIMGOA0rGtd87YPJwizrkRAenjhKs+SM+sL3SpvOtzctN/1IrCg1590
	zNC1RvK2iBGJjWhSAcSea9eZYxiaVs+1vRqNZXz1HIaeyFzVJGzYydWi8uKz2tBTvIINK7qQ9iw2S
	dX0+YHxMMWmqAyPmUDAv0lSHdv1DGEVSFQ+75/svo43avPeSNyFoF6SGGDxKoHhwo1WEgzvQL5DvF
	jIW5eSdyXX4lHmGgWc7kjh3v5e/oAow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltcvX-007jjR-4p; Wed, 16 Jun 2021 21:18:23 +0000
Received: from mail-io1-f71.google.com ([209.85.166.71])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltcvT-007jiR-Ni
 for linux-nvme@lists.infradead.org; Wed, 16 Jun 2021 21:18:21 +0000
Received: by mail-io1-f71.google.com with SMTP id
 n1-20020a6b8b010000b02904be419d64eeso374069iod.6
 for <linux-nvme@lists.infradead.org>; Wed, 16 Jun 2021 14:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
 bh=duTj10WutJtiQxaoqsHiF2wpfRhcgG9nBHs+cYY/O0s=;
 b=ILQ/mVEwd6yUQWQgWqgBi6mQEcZQ1n/8wwvIUHb9qkscHr9o/eH0HaxYr5LldB91cw
 hmaW6pWm+w2Tih28slvgKgt01Bc4UFMFJuqKKR2zcNgt+WhA9azQGNVTWCN47c6cO5m2
 jhnNuxAcbBhucehHGCm98okDXIG6g2sosLOnwrbh2qS7bznEu3eNFYMrW/3EEnlNyMQh
 T0iiPpYI7H2AeUU0rfYZ4W86jZ8ErTTQTPd6/gOrsyutJXzx7GpAJMzLx4FYDImx+a13
 KO0N/gma8WQAhk/ItFvxWb74Uto15aXhI/PnWNxULPscDnxDRw/ZPAcAj3PwLD6j6thp
 +ntw==
X-Gm-Message-State: AOAM533diWaSgULezQxcSdfqMpD6I/VOlZaDIzmmIHsZEqpgErO+6Agp
 JbiJf/on206tArQI9/CUjmzqwGNSzY3gvdkqKKk1AXcSGXz3
X-Google-Smtp-Source: ABdhPJwp/dBh+MkVc0KZmpZLXAAiEn5MS/4VUH2mxB5N0vOGhMX6oCBHieqfWMlrl2kv8YPDzd4TUAAo+cZTVJkfO7p6+IYUW4Og
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1be4:: with SMTP id
 y4mr1078399ilv.135.1623878297558; 
 Wed, 16 Jun 2021 14:18:17 -0700 (PDT)
Date: Wed, 16 Jun 2021 14:18:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015a81105c4e8a1c3@google.com>
Subject: [syzbot] possible deadlock in loop_probe
From: syzbot <syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com>
To: axboe@fb.com, axboe@kernel.dk, gregkh@linuxfoundation.org, hch@lst.de, 
 kbusch@kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, rafael@kernel.org, sagi@grimberg.me, 
 syzkaller-bugs@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210616_141819_830093_4DEF9C4F 
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

syzbot found the following issue on:

HEAD commit:    8ecfa36c Merge tag 'riscv-for-linus-5.13-rc6' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17121304300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=547a5e42ca601229
dashboard link: https://syzkaller.appspot.com/bug?extid=6a8a0d93c91e8fbf2e80
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17065d1fd00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12de53afd00000

The issue was bisected to:

commit 5befc7c26e5a98cd49789fb1beb52c62bd472dba
Author: Keith Busch <kbusch@kernel.org>
Date:   Wed Mar 24 23:18:05 2021 +0000

    nvme: implement non-mdts command limits

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e62857d00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17e62857d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13e62857d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com
Fixes: 5befc7c26e5a ("nvme: implement non-mdts command limits")

======================================================
WARNING: possible circular locking dependency detected
5.13.0-rc5-syzkaller #0 Not tainted
------------------------------------------------------
systemd-udevd/8445 is trying to acquire lock:
ffffffff8d671688 (loop_ctl_mutex){+.+.}-{3:3}, at: loop_probe+0xe1/0x220 drivers/block/loop.c:2234

but task is already holding lock:
ffffffff8d4db008 (major_names_lock){+.+.}-{3:3}, at: blk_request_module+0x2f/0x1c0 block/genhd.c:680

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (major_names_lock){+.+.}-{3:3}:
       lock_acquire+0x17f/0x720 kernel/locking/lockdep.c:5512
       __mutex_lock_common+0x1bf/0x3100 kernel/locking/mutex.c:959
       __mutex_lock kernel/locking/mutex.c:1104 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
       __register_blkdev+0x2c/0x360 block/genhd.c:223
       register_mtd_blktrans+0x94/0x3d0 drivers/mtd/mtd_blkdevs.c:534
       do_one_initcall+0x1a7/0x400 init/main.c:1249
       do_initcall_level+0x14a/0x1f5 init/main.c:1322
       do_initcalls+0x4b/0x8c init/main.c:1338
       kernel_init_freeable+0x3fd/0x58a init/main.c:1560
       kernel_init+0xd/0x290 init/main.c:1447
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

-> #2 (mtd_table_mutex){+.+.}-{3:3}:
       lock_acquire+0x17f/0x720 kernel/locking/lockdep.c:5512
       __mutex_lock_common+0x1bf/0x3100 kernel/locking/mutex.c:959
       __mutex_lock kernel/locking/mutex.c:1104 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
       blktrans_open+0x61/0x430 drivers/mtd/mtd_blkdevs.c:212
       __blkdev_get+0x293/0xa50 fs/block_dev.c:1311
       blkdev_get_by_dev+0xf9/0x640 fs/block_dev.c:1451
       blkdev_open+0x132/0x2c0 fs/block_dev.c:1546
       do_dentry_open+0x7cb/0x1010 fs/open.c:826
       do_open fs/namei.c:3361 [inline]
       path_openat+0x28e6/0x39b0 fs/namei.c:3494
       do_filp_open+0x221/0x460 fs/namei.c:3521
       do_sys_openat2+0x124/0x460 fs/open.c:1187
       do_sys_open fs/open.c:1203 [inline]
       __do_sys_open fs/open.c:1211 [inline]
       __se_sys_open fs/open.c:1207 [inline]
       __x64_sys_open+0x221/0x270 fs/open.c:1207
       do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (&bdev->bd_mutex){+.+.}-{3:3}:
       lock_acquire+0x17f/0x720 kernel/locking/lockdep.c:5512
       __mutex_lock_common+0x1bf/0x3100 kernel/locking/mutex.c:959
       __mutex_lock kernel/locking/mutex.c:1104 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
       del_gendisk+0x2ab/0x860 block/genhd.c:610
       loop_remove drivers/block/loop.c:2180 [inline]
       loop_control_ioctl+0x62c/0x770 drivers/block/loop.c:2280
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:1069 [inline]
       __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
       do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (loop_ctl_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:2938 [inline]
       check_prevs_add+0x4f9/0x5b60 kernel/locking/lockdep.c:3061
       validate_chain kernel/locking/lockdep.c:3676 [inline]
       __lock_acquire+0x4307/0x6040 kernel/locking/lockdep.c:4902
       lock_acquire+0x17f/0x720 kernel/locking/lockdep.c:5512
       __mutex_lock_common+0x1bf/0x3100 kernel/locking/mutex.c:959
       __mutex_lock kernel/locking/mutex.c:1104 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
       loop_probe+0xe1/0x220 drivers/block/loop.c:2234
       blk_request_module+0x19d/0x1c0 block/genhd.c:683
       blkdev_get_no_open+0x44/0x1f0 fs/block_dev.c:1374
       blkdev_get_by_dev+0x82/0x640 fs/block_dev.c:1437
       blkdev_open+0x132/0x2c0 fs/block_dev.c:1546
       do_dentry_open+0x7cb/0x1010 fs/open.c:826
       do_open fs/namei.c:3361 [inline]
       path_openat+0x28e6/0x39b0 fs/namei.c:3494
       do_filp_open+0x221/0x460 fs/namei.c:3521
       do_sys_openat2+0x124/0x460 fs/open.c:1187
       do_sys_open fs/open.c:1203 [inline]
       __do_sys_open fs/open.c:1211 [inline]
       __se_sys_open fs/open.c:1207 [inline]
       __x64_sys_open+0x221/0x270 fs/open.c:1207
       do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  loop_ctl_mutex --> mtd_table_mutex --> major_names_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(major_names_lock);
                               lock(mtd_table_mutex);
                               lock(major_names_lock);
  lock(loop_ctl_mutex);

 *** DEADLOCK ***

1 lock held by systemd-udevd/8445:
 #0: ffffffff8d4db008 (major_names_lock){+.+.}-{3:3}, at: blk_request_module+0x2f/0x1c0 block/genhd.c:680

stack backtrace:
CPU: 1 PID: 8445 Comm: systemd-udevd Not tainted 5.13.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x202/0x31e lib/dump_stack.c:120
 print_circular_bug+0xb17/0xdc0 kernel/locking/lockdep.c:2007
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2129
 check_prev_add kernel/locking/lockdep.c:2938 [inline]
 check_prevs_add+0x4f9/0x5b60 kernel/locking/lockdep.c:3061
 validate_chain kernel/locking/lockdep.c:3676 [inline]
 __lock_acquire+0x4307/0x6040 kernel/locking/lockdep.c:4902
 lock_acquire+0x17f/0x720 kernel/locking/lockdep.c:5512
 __mutex_lock_common+0x1bf/0x3100 kernel/locking/mutex.c:959
 __mutex_lock kernel/locking/mutex.c:1104 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1119
 loop_probe+0xe1/0x220 drivers/block/loop.c:2234
 blk_request_module+0x19d/0x1c0 block/genhd.c:683
 blkdev_get_no_open+0x44/0x1f0 fs/block_dev.c:1374
 blkdev_get_by_dev+0x82/0x640 fs/block_dev.c:1437
 blkdev_open+0x132/0x2c0 fs/block_dev.c:1546
 do_dentry_open+0x7cb/0x1010 fs/open.c:826
 do_open fs/namei.c:3361 [inline]
 path_openat+0x28e6/0x39b0 fs/namei.c:3494
 do_filp_open+0x221/0x460 fs/namei.c:3521
 do_sys_openat2+0x124/0x460 fs/open.c:1187
 do_sys_open fs/open.c:1203 [inline]
 __do_sys_open fs/open.c:1211 [inline]
 __se_sys_open fs/open.c:1207 [inline]
 __x64_sys_open+0x221/0x270 fs/open.c:1207
 do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f666c06a840
Code: 73 01 c3 48 8b 0d 68 77 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 bb 20 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e f6 ff ff 48 89 04 24
RSP: 002b:00007ffc880be598 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 000055dd2c8278f0 RCX: 00007f666c06a840
RDX: 000055dd2c52efe3 RSI: 00000000000a0800 RDI: 000055dd2c827830
RBP: 00007ffc880be710 R08: 000055dd2c52e670 R09: 0000000000000010
R10: 000055dd2c52ed0c R11: 0000000000000246 R12: 00007ffc880be660
R13: 000055dd2c829010 R14: 0000000000000003 R15: 000000000000000e


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
