Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E18CA9ECF
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Oct 2026 17:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Date:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u0o4MtJdz+i7038O/zO8/MdLCh4dr9Ow4hnPcKqRLHE=; b=a1Qh9KtnpGlCWlbxpihlnSieC1
	STLV9RDt+Y+kpzhTjVpSahaveLTeOfEuw2zZQQsQvd8Yxr5iCrJ4Bf1l3NlfhfvqFG/EI5Ie6xtgQ
	wgpEKDN4mH734513uzSG47UaFuoCsBSjLd5eJuybiNMrjUKi3uE7KwkTMLhkdsnMbdRgoR8pI7gUP
	LICWZA70BrhaCR7UrKrjqj2ms+4cCZaoFnaEVfHyLp4nBkDjYDk3pbnZVQ2N6j8XMOF2QU86KNlhb
	aygKhSxSvgL6lJqQKxUIFhBkhq02bkFaoY+4rPb76k1Vdh3C+LiXvGz3LsU4nZj9JTl5gYNml1qKb
	kr0Ys6BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFxPj-00000009GB2-0AIR;
	Sun, 11 Oct 2026 17:32:47 +0000
Received: from mail-oi1-f197.google.com ([209.85.167.197])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFxPb-00000009GAf-2wkt
	for linux-nvme@lists.infradead.org;
	Sun, 11 Oct 2026 17:32:41 +0000
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4cc89e86e4dso2404747b6e.2
        for <linux-nvme@lists.infradead.org>; Sun, 11 Oct 2026 10:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791739958; x=1792344758;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u0o4MtJdz+i7038O/zO8/MdLCh4dr9Ow4hnPcKqRLHE=;
        b=L2TwKbO1vocZCcLNDOLWfRxX8VFXXMkRMBBgsUVyS2PvkwXoTepqp4NiKDR4hqsWI4
         zkn0kTti1MDu0eznwTDGjWGBlVd68/Q+F/RWJLBd6c4hmUd4lvn9Nzxceaev2Q70KRj0
         rOeDtC6D98PFxUWiunDihc8tmo9/TIwMoE8XiafrFhVQEJWPjuOrU0Q/AK/JULBVlMvz
         fj+dk8mg74AvYtvqzULCQTeZBFksJggWHgawsp9iQ114GUCtds3XNqkB+So0ymkLykwn
         JO6n+BMDYzr1YnFYPM9Dy8BwIkb04W+218wnxkmUxZPma+CANaFLY+dZ+XnGprMt+EKW
         3Pgw==
X-Forwarded-Encrypted: i=1; AKwUvBzQDKS5WrzRIuC344OUdWMBBSYVu1aStX10WoGECcL5EpRFS+HKn+YuZYsZ0f95lb8GDMhiRFWn84Q1@lists.infradead.org
X-Gm-Message-State: AFq9FYJc4qwt32xWsJoWAjO9L5BAQZvbHVtSs0Xh8IAppsWwFNdD7+EG
	3K5SJ84cyc8Fj6FKh0ypLeqgfsU6omr0W50qlQvKqmpWNIWfgPeJDeUlkg6tcxMnlLV9R8ySWOu
	V8sBr2LbyX6McIXRkq8bIjtiy8O4Rvn2WT2LOBtnGM4GrLp2Z01qgnueMsHU=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1b97:b0:4f3:e98f:fa0b with SMTP id
 5614622812f47-50c556bc9d7mr7201373b6e.5.1791739957943; Sun, 11 Oct 2026
 10:32:37 -0700 (PDT)
Date: Sun, 11 Oct 2026 10:32:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6acbc835.a150a118.27e199.003c.GAE@google.com>
Subject: [syzbot] [nvme?] BUG: corrupted list in nvmet_fc_remove_port
From: syzbot <syzbot+c98b21427617af7f547a@syzkaller.appspotmail.com>
To: hch@lst.de, justin.tee@broadcom.com, kch@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com, sagi@grimberg.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261011_103239_748680_AE27F761 
X-CRM114-Status: UNSURE (   9.03  )
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

HEAD commit:    a5ebb76233b7 Merge tag 'edac_urgent_for_v7.3_rc7' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1494923e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df4bbab1c2172b9f
dashboard link: https://syzkaller.appspot.com/bug?extid=c98b21427617af7f547a
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126a0f15580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166a0f15580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d24cfbd75fba/disk-a5ebb762.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d0874c703893/vmlinux-a5ebb762.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2a424fa32a7b/bzImage-a5ebb762.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c98b21427617af7f547a@syzkaller.appspotmail.com

nvmet_tcp: enabling port 1 (127.0.0.1:4420)
 non-slab/vmalloc memory
list_del corruption. prev->next should be ffff88802af3b020, but was 0000000000000000. (prev=ffffffff9aecd340)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:64!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 5680 Comm: syz-executor403 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:__list_del_entry_valid_or_report+0x15a/0x190 lib/list_debug.c:62
Code: e8 ab ea 37 fd 43 80 3c 2c 00 74 08 4c 89 ff e8 6c b1 58 fd 49 8b 17 48 c7 c7 40 71 cc 8b 48 89 de 4c 89 f9 e8 a7 7a 4c fc 90 <0f> 0b 4c 89 f7 e8 7c ea 37 fd 43 80 3c 2c 00 74 08 4c 89 ff e8 3d
RSP: 0018:ffffc90004cdfc30 EFLAGS: 00010246
RAX: 000000000000006d RBX: ffff88802af3b020 RCX: 7d3c36a647dfae00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000201 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed101708490b R12: 1ffffffff35d9a68
R13: dffffc0000000000 R14: ffffffff85f7f740 R15: ffffffff9aecd340
FS:  0000555594721400(0000) GS:ffff8881249bb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555594721340 CR3: 0000000038dd8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:140 [inline]
 __list_del_entry include/linux/list.h:261 [inline]
 list_del include/linux/list.h:275 [inline]
 nvmet_fc_portentry_unbind drivers/nvme/target/fc.c:1281 [inline]
 nvmet_fc_remove_port+0x16b/0x320 drivers/nvme/target/fc.c:2927
 nvmet_disable_port+0x13e/0x1f0 drivers/nvme/target/core.c:400
 nvmet_port_subsys_drop_link+0x1e8/0x210 drivers/nvme/target/configfs.c:1123
 configfs_unlink+0x44f/0x6b0 fs/configfs/symlink.c:258
 vfs_unlink+0x27b/0x6e0 fs/namei.c:5678
 filename_unlinkat+0x3d3/0x610 fs/namei.c:5748
 __do_sys_unlinkat fs/namei.c:5777 [inline]
 __se_sys_unlinkat+0x83/0x1a0 fs/namei.c:5769
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0ad400d8b9
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe650d4178 EFLAGS: 00000246 ORIG_RAX: 0000000000000107
RAX: ffffffffffffffda RBX: 0000200000000780 RCX: 00007f0ad400d8b9
RDX: 0000000000000000 RSI: 0000200000000780 RDI: 00000000ffffff9c
RBP: 00000000000f4240 R08: 0000000000000009 R09: 0000000000000009
R10: 0000000000000009 R11: 0000000000000246 R12: 0000000000014e22
R13: 00007ffe650d418c R14: 00007ffe650d41a0 R15: 00007ffe650d4190
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x15a/0x190 lib/list_debug.c:62
Code: e8 ab ea 37 fd 43 80 3c 2c 00 74 08 4c 89 ff e8 6c b1 58 fd 49 8b 17 48 c7 c7 40 71 cc 8b 48 89 de 4c 89 f9 e8 a7 7a 4c fc 90 <0f> 0b 4c 89 f7 e8 7c ea 37 fd 43 80 3c 2c 00 74 08 4c 89 ff e8 3d
RSP: 0018:ffffc90004cdfc30 EFLAGS: 00010246
RAX: 000000000000006d RBX: ffff88802af3b020 RCX: 7d3c36a647dfae00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000201 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed101708490b R12: 1ffffffff35d9a68
R13: dffffc0000000000 R14: ffffffff85f7f740 R15: ffffffff9aecd340
FS:  0000555594721400(0000) GS:ffff8881249bb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555594721340 CR3: 0000000038dd8000 CR4: 00000000003526f0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

