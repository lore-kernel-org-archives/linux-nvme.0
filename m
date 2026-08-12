Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E85C5AC67
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 00:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Date:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ALvRCc5w+8E9Jm2AZEz/0T3ZiCqnoqzvERWPEGTrbw4=; b=SQaDbrUWzKjEJfuKXwWgeu9nih
	wBAQPnN71Ah4nUo4zaJdjwfcsEHJdyioQwCIC02a4/ajRIOOpvQJesEb/iX7U+HinJ6YqzOnttFhI
	01kbFQaYtn9exyHzrgwXu3mG1bGLizi7bcAa4+7V3PNbRmDi6IXREY41I2nQPLz+m7hvq5kbbdAMJ
	nVFxi9UxKGnAxM663SyMZMXFe2Dut8kgDnBQFUn7kPZB+dYgq3J30y4LAFhEywDa+o3xFa9cl8fee
	mXB9IwYWnOb8NKXgyA0Hg7YfxeazDXtySzp6LmP7+a+Hec/lowdjGfTLiv1TEfA+ZDaZK3MspPWLW
	sJVzrLjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtwb2-0000000F89e-2ucG;
	Wed, 12 Aug 2026 00:13:28 +0000
Received: from mail-oa1-f77.google.com ([209.85.160.77])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtwaz-0000000F892-32nV
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 00:13:27 +0000
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-451ff8b9acbso1278313fac.0
        for <linux-nvme@lists.infradead.org>; Tue, 11 Aug 2026 17:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786493604; x=1787098404;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ALvRCc5w+8E9Jm2AZEz/0T3ZiCqnoqzvERWPEGTrbw4=;
        b=oGU0izXQXviMfPsxE68uPqry+qWRkNca6YBG4XZIfjPZHr68AJTapZ9yLq/hwmDEJ4
         lOV77y1I04j/SJILlySIwugSvrxTBqHi0J6x6afsEJ48rYCldxiRxiUN+TWvLm3dgMk2
         AQwurrc9fQbzihgedVyqz4W7kHYlSkBwYp+L5agQg1ARk1di8O6QU0QRcluJwGVZvRes
         tQb/siqlmpWo5nSeTV+cPZIrDWu09edaBaOZfUY0egq0y6AwQMtC9HHVFf20iuKRmkvr
         SFClH+hjZaEkEQSL32HqdKHT/7sU6SBwUGBGY5MA/oVt+qvnAtWNRz4nELRhC5eS27O4
         dYZg==
X-Forwarded-Encrypted: i=1; AHgh+RrUl7oz0YFwulNw0SACmSPv0Yu6jmd8pWPP6BgCgQRstRJCDNP50A2CdNRqat8jb3BisPi0uNpLgc+T@lists.infradead.org
X-Gm-Message-State: AOJu0Yx3MtkNdUStJT+wOCG6XsC7sRSe616QVUnhoTCeIyb+xJHJN7yk
	Di/uK6oQzNewFiDeC+KR/mID48tR7SLmVHY/YnQlbuCnvMIm/0zVp9C/HDmIeoo2y6C1vRUR4gh
	pyxEnOr+jzbUBWBpa99DTWhWfPlCt1CAIswWBGgbNjBjJ/TrZZQOtc8/bohI=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3a06:b0:495:ca1b:7865 with SMTP id
 5614622812f47-4b20900f206mr3554396b6e.11.1786493604057; Tue, 11 Aug 2026
 17:13:24 -0700 (PDT)
Date: Tue, 11 Aug 2026 17:13:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7bbaa4.a2bb2777.31c27d.000b.GAE@google.com>
Subject: [syzbot] [nvme?] WARNING in nvmet_fc_register_targetport
From: syzbot <syzbot+18b6b27f58e98c240814@syzkaller.appspotmail.com>
To: hch@lst.de, justin.tee@broadcom.com, kch@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com, sagi@grimberg.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_171325_791871_60B675C2 
X-CRM114-Status: UNSURE (   8.16  )
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

HEAD commit:    f9a2394a2348 Merge tag 'mm-hotfixes-stable-2026-08-06-18-4..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e68fb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3f9a6906b632f9f
dashboard link: https://syzkaller.appspot.com/bug?extid=18b6b27f58e98c240814
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-f9a2394a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/969d729dd37f/vmlinux-f9a2394a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a948a2342c62/bzImage-f9a2394a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+18b6b27f58e98c240814@syzkaller.appspotmail.com

R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
------------[ cut here ]------------
!PageLargeKmalloc(page)
WARNING: mm/slub.c:6602 at free_large_kmalloc+0xbf/0x100 mm/slub.c:6602, CPU#0: syz.2.261/6867
Modules linked in:
CPU: 0 UID: 0 PID: 6867 Comm: syz.2.261 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:free_large_kmalloc+0xbf/0x100 mm/slub.c:6602
Code: 28 90 0f 0b 90 80 3d e8 ab 9c 0e 00 0f 84 c7 6e b7 fe 48 8b 74 24 28 48 89 ef e8 7c 3a 0c 00 b8 00 f0 ff ff 45 31 ed eb 9d 90 <0f> 0b 90 48 83 c4 08 48 89 df 48 c7 c6 24 df 18 8e 5b 5d 41 5c 41
RSP: 0018:ffffc9000735fa10 EFLAGS: 00010202
RAX: 00000000000000ff RBX: ffffea00017e83c0 RCX: 000000000000002e
RDX: 0000000000000000 RSI: ffff88805fa0ff20 RDI: ffffea00017e83c0
RBP: ffff88805fa0ff20 R08: ffff888023ddfc00 R09: 00000000ffffffff
R10: ffffffffffffffff R11: 0000000000000000 R12: 00000000ffffffff
R13: 1ffff92000e6bf5b R14: dead000000000122 R15: ffff888023ddfc90
FS:  0000000000000000(0000) GS:ffff888096bf4000(0063) knlGS:00000000f5456b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000025d36000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 nvmet_fc_alloc_ls_iodlist drivers/nvme/target/fc.c:569 [inline]
 nvmet_fc_register_targetport+0x114c/0x1c30 drivers/nvme/target/fc.c:1411
 fcloop_create_target_port+0x156/0x5a0 drivers/nvme/target/fcloop.c:1558
 dev_attr_store+0x58/0x80 drivers/base/core.c:2505
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xe7/0x970 arch/x86/entry/syscall_32.c:307
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:332
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7f96fec
Code: Unable to access opcode bytes at 0xf7f96fc2.
RSP: 002b:00000000f545650c EFLAGS: 00000292 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000080000200
RDX: 000000000000002f RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


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

