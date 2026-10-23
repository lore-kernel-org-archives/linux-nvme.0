Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040E0606A31B
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bPEK4XK+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Date:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=ljm8bNNap3tvF9+jeCrN03t35kRNZ/yBqVC9j5iU6CA=; b=bPEK4XK+sNSCY6frTZpZxcs8Hv
	7L14Q9FepWpuV4bsrab2CqJg59IGxw2M6+J+ubB8qpUvQ86gAOKwAIEFhUBVL209b45p5kwzOuBgg
	5qcbD1CWGMpxiC11N7K4eKwBTM2gnQa1Q0FC7AcfcuaICx0dCsCVXx44fZQ33oTUr3+3KVGAbjp/l
	ze8EMBLeSLrD4oN4CH7AHQLKkA3OXboG43yASYUkBS7z+TwA0H4UETqKeylCC6WgTEyivEqaYEwWP
	wKwrS3y+BBFH2MaWoqhFrnOyG28tG2Fe2VHdRCcO2ghIoV30ZOxBlDeHVyx5RMj8c01ag1tPxy/C6
	Oy1iid/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKFXl-0000000GQLl-2LMr;
	Fri, 23 Oct 2026 13:42:49 +0000
Received: from mail-oi1-f198.google.com ([209.85.167.198])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKFXg-0000000GQHd-1Oxt
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 13:42:47 +0000
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4ab260600easo2579836b6e.1
        for <linux-nvme@lists.infradead.org>; Fri, 23 Oct 2026 06:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792762953; x=1793367753;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ljm8bNNap3tvF9+jeCrN03t35kRNZ/yBqVC9j5iU6CA=;
        b=MZm/V+KKWPjOe8fV00jBmYHjUZ2i/xPKRwN9BxfMktCFnJ7+YwGEQahahXwZzGNdFb
         ZpKz3Egde59SK8Z6YTeUDblG/eTOWldauL8MAIrNOqk7B0qVxKKmWSpZTW1NnOGwqHJ5
         WJ13znB2vLMonDiYj7asFobaVODzFwqua7erXi0SPfISbYposdS/NaNH/fRKtj437BC/
         rZ5IGy3bQwtAs71ysDcMURXw7YC65TV6tfXWQi0xWqAGthqLV1MIGEsThcSENieESUoB
         T4AYNXUFqSQnkq9l1W9u47eDJ9XNFtbLF4D1aH7/1mRuR+UaeYqQJICjr7Z3/384pqPK
         jE7A==
X-Forwarded-Encrypted: i=1; AKwUvByhZZEdioY2fMh4+1jO0Z3RIM2zACN507LghOdd2HOHip0c/FnrgqPWKZydonp7Ry/52BA5IpRAv2nM@lists.infradead.org
X-Gm-Message-State: AFq9FYJfG/m9Qmo9cr02fwyYxw91sjWUOXeRanMSmOX8U6sNENraGY5V
	GPBTwbGR2SrKUavJ0NYpHJ5KOKfyqnstQSjN05U5FphiurTqP6ZF2e3zZB26/G7xTByzno/FmxH
	GH3dF5uatHweWr5eq1SS8Pwt0BGyrBF1xdjP19ATpoh8cL+WQpcGQW8ciPlM=
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c224:b0:53a:1c29:cb37 with SMTP id
 5614622812f47-557ee87e5edmr3000376b6e.38.1792762953518; Fri, 23 Oct 2026
 06:42:33 -0700 (PDT)
Date: Fri, 23 Oct 2026 06:42:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6adb6449.5589765f.2780bb.0034.GAE@google.com>
Subject: [syzbot] [nvme?] WARNING in nvme_tcp_init_request
From: syzbot <syzbot+bdd7605037d64d5ccc10@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_064244_490388_73757CCF 
X-CRM114-Status: UNSURE (   8.29  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: 1.8 (+)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

syzbot found the following issue on:

HEAD commit:    2efb7a11f1aa Add linux-next specific files for 20261016
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1419283c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=129fca4e65ab9877
dashboard link: https://syzkaller.appspot.com/bug?extid=bdd7605037d64d5ccc10
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1219283c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1718d93e580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cd996cff1b76/disk-2efb7a11.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/59577d58bd5a/vmlinux-2efb7a11.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a3dfa3b04143/bzImage-2efb7a11.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bdd7605037d64d5ccc10@syzkaller.appspotmail.com

nvme nvme0: creating 2 I/O queues.
nvme nvme0: mapped 2/0/0 default/read/poll queues.
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: kernel/locking/mutex.c:625 at __mutex_lock_common kernel/locking/mutex.c:625 [inline], CPU#1: syz-executor121/5622
WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0x132a/0x15a0 kernel/locking/mutex.c:821, CPU#1: syz-executor121/5622
Modules linked in:
CPU: 1 UID: 0 PID: 5622 Comm: syz-executor121 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:625 [inline]
RIP: 0010:__mutex_lock+0x1331/0x15a0 kernel/locking/mutex.c:821
Code: b9 7a 91 48 c1 e8 03 0f b6 04 18 84 c0 0f 85 46 02 00 00 83 3d 93 fc 83 05 00 75 13 48 8d 3d c6 fa 86 05 48 c7 c6 c0 27 0d 8c <67> 48 0f b9 3a 90 e9 1d ee ff ff 90 0f 0b 90 e9 f0 f1 ff ff 90 0f
RSP: 0018:ffffc90003bdf1e0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffff88807e8a9f40
RDX: 0000000000000000 RSI: ffffffff8c0d27c0 RDI: ffffffff917db820
RBP: ffffc90003bdf378 R08: ffffffff917ab9e3 R09: 1ffffffff22f573c
R10: dffffc0000000000 R11: fffffbfff22f573d R12: ffff88807ed84460
R13: 0000000000000000 R14: 1ffff9200077be50 R15: 0000000000000000
FS:  000055557669a400(0000) GS:ffff888123b8b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcefd60ee9c CR3: 000000007ed68000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 nvme_tcp_init_request+0xbd/0x260 drivers/nvme/host/tcp.c:571
 blk_mq_init_request block/blk-mq.c:3596 [inline]
 blk_mq_alloc_rqs block/blk-mq.c:3664 [inline]
 blk_mq_alloc_map_and_rqs+0x66d/0x980 block/blk-mq.c:4137
 __blk_mq_alloc_map_and_rqs block/blk-mq.c:4155 [inline]
 __blk_mq_alloc_rq_maps block/blk-mq.c:4714 [inline]
 blk_mq_alloc_set_map_and_rqs+0x1a0/0x810 block/blk-mq.c:4745
 blk_mq_alloc_tag_set+0x8e5/0x1000 block/blk-mq.c:4929
 nvme_alloc_io_tag_set+0x36a/0x6f0 drivers/nvme/host/core.c:5103
 nvme_tcp_configure_io_queues drivers/nvme/host/tcp.c:2297 [inline]
 nvme_tcp_setup_ctrl+0xc6f/0x1670 drivers/nvme/host/tcp.c:2530
 nvme_tcp_create_ctrl+0xa59/0xf00 drivers/nvme/host/tcp.c:3123
 nvmf_create_ctrl drivers/nvme/host/fabrics.c:1361 [inline]
 nvmf_dev_write+0x24ca/0x2d90 drivers/nvme/host/fabrics.c:1408
 vfs_write+0x296/0xba0 fs/read_write.c:685
 ksys_write+0x150/0x270 fs/read_write.c:1036
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f86ccedd849
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffd35af4a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 6769666e6f632f2e RCX: 00007f86ccedd849
RDX: 000000000000003a RSI: 00002000000007c0 RDI: 0000000000000008
RBP: 0000000000000001 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 00007fffd35af618
R13: 431bde82d7b634db R14: 00007f86ccf70c40 R15: 0000000000000002
 </TASK>
----------------
Code disassembly (best guess):
   0:	b9 7a 91 48 c1       	mov    $0xc148917a,%ecx
   5:	e8 03 0f b6 04       	call   0x4b60f0d
   a:	18 84 c0 0f 85 46 02 	sbb    %al,0x246850f(%rax,%rax,8)
  11:	00 00                	add    %al,(%rax)
  13:	83 3d 93 fc 83 05 00 	cmpl   $0x0,0x583fc93(%rip)        # 0x583fcad
  1a:	75 13                	jne    0x2f
  1c:	48 8d 3d c6 fa 86 05 	lea    0x586fac6(%rip),%rdi        # 0x586fae9
  23:	48 c7 c6 c0 27 0d 8c 	mov    $0xffffffff8c0d27c0,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	90                   	nop
  30:	e9 1d ee ff ff       	jmp    0xffffee52
  35:	90                   	nop
  36:	0f 0b                	ud2
  38:	90                   	nop
  39:	e9 f0 f1 ff ff       	jmp    0xfffff22e
  3e:	90                   	nop
  3f:	0f                   	.byte 0xf


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

