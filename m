Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E95CCA464
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 12:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Date:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1jkkYesDBen/rYXjtPWsjU+QZRef01zmLNH+fPT/sgw=; b=byFYwaXfo3XIHhmbku4pX7Y7k5
	FDunvjN5syGbwr8AiAgZMN6nmYcgJyYGYUMbbLcrIKoYFMsIx0t3OCp2VN/6YLr3+OHa2ffQY2pOe
	zfggtkzD532Z1S9TEcMOoSYjJNsf1lqsAbcY7KSIU8XEH5uzCikGoBVXJuedCM0HyFHk9wthNBQT+
	r/EnCpMbRXCZuELKhUGwCIsAl/VJS4bHXAqf1iYiB2ZfgDFQBYi6zs8YfhYxtIS9bY0495GkIWKQt
	/RT74SQBsE6vupuQmnihqopoZbCzmcZasFoNBbTksUzQK0zDKq4KoKN3TyDtZpj2xhaRZkUXaOBn0
	eO/DU7eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHgld-00000002pLI-3O63;
	Fri, 16 Oct 2026 12:10:33 +0000
Received: from mail-oi1-f199.google.com ([209.85.167.199])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHgla-00000002pKa-31Tm
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 12:10:32 +0000
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4f9b643ae53so5618908b6e.3
        for <linux-nvme@lists.infradead.org>; Fri, 16 Oct 2026 05:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792152629; x=1792757429;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1jkkYesDBen/rYXjtPWsjU+QZRef01zmLNH+fPT/sgw=;
        b=wVgKz4Y4Rx8l7EoW/R4xSYnUtF1V8sE3KPdVWE5/V9DeaTu93wXC0NFxF1vm0HuFQC
         wKeqHdToyquURFXEQ6rqi1pRt16m3dt0YloFWliDctq2Apm94vzvzqifHL3juUIlhao4
         gOREV+KrXGjShBwaN6wri9ybUi9xC2oH6S5peTMHjpx8I9yh8NkJeDx5O4S/5uJzM2l1
         jto5F0DhjsbSZNbuifd68vfYIMZMetYAV5ReuHz5ZRRwT1qOJ2OY0L3Jn2HQ9u9E4QkZ
         F9H7ixPpqGG82CNOBwAFXyVTu8f57Uflii50xcm2NnA1TeA6jMe0AvPnubxKbl8br61l
         0XYw==
X-Forwarded-Encrypted: i=1; AKwUvBx6LCMlVUa4AUIzue/LGJd9pQodq5ctBeegF02KCI6sJz5WHRTRdhPuglx1TLuxLcCvl/4ha5geXwzt@lists.infradead.org
X-Gm-Message-State: AFq9FYKg8eXfu/jP5JXwXPDs9PrhgXLR9KywgT1NLYHR5u+5Ys6vrOTC
	AlgY8qwe2kWPOr4YbLXjZ764kqZJdHdH6xO4Id2cdOuMyRTgS5jVJUlVyEyBrNBZZH2Ek2UHNsR
	snGaqYyV0xPK7/dWsMS05AcjjiTwKkVnbg/So9asY0SejecuiRUZyoUpN5iE=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f0a:b0:4f1:6ab6:8fc0 with SMTP id
 5614622812f47-50c4e681490mr26095731b6e.15.1792152629228; Fri, 16 Oct 2026
 05:10:29 -0700 (PDT)
Date: Fri, 16 Oct 2026 05:10:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad21435.7514cce4.1ece07.0150.GAE@google.com>
Subject: [syzbot] [nvme?] WARNING in nvmet_fc_portentry_rebind_tgt
From: syzbot <syzbot+be62d4b375542ecebd17@syzkaller.appspotmail.com>
To: hch@lst.de, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_051030_765051_C4081EC7 
X-CRM114-Status: UNSURE (   8.26  )
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

HEAD commit:    4056b3c9d3c9 Merge tag 'nios2_update_for_v7.4' of git://gi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14108235580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b38d39c45202f4fa
dashboard link: https://syzkaller.appspot.com/bug?extid=be62d4b375542ecebd17
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16108235580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+be62d4b375542ecebd17@syzkaller.appspotmail.com

------------[ cut here ]------------
pe->tgtport
WARNING: drivers/nvme/target/fc.c:1327 at nvmet_fc_portentry_rebind_tgt+0x1d7/0x1e0 drivers/nvme/target/fc.c:1327, CPU#1: syz-executor148/5937
Modules linked in:
CPU: 1 UID: 0 PID: 5937 Comm: syz-executor148 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/07/2026
RIP: 0010:nvmet_fc_portentry_rebind_tgt+0x1d7/0x1e0 drivers/nvme/target/fc.c:1327
Code: 6d 3d fc 48 8b 04 24 49 89 06 48 c7 c7 20 0f c8 8f 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d e9 3f ab 66 05 e8 ba a7 d0 fb 90 <0f> 0b 90 eb a6 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000155fa78 EFLAGS: 00010293
RAX: ffffffff85f63196 RBX: dffffc0000000000 RCX: ffff888032880000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff520002abf40 R12: 1ffff1100741b8d0
R13: 0000000000000001 R14: ffff88803a0dc680 R15: ffff888012526800
FS:  00007f3c0db506c0(0000) GS:ffff888124abb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3c0db4fff8 CR3: 0000000042756000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 nvmet_fc_register_targetport+0x75a/0x950 drivers/nvme/target/fc.c:1417
 fcloop_create_target_port+0x135/0x4d0 drivers/nvme/target/fcloop.c:1558
 kernfs_fop_write_iter+0x3a5/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61e/0xbb0 fs/read_write.c:687
 ksys_write+0x156/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3c0e3ae35e
Code: 08 0f 85 f5 e2 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 90 41 57 41 56 4d 89 c6 41 55 4d 89 cd 41 54 55 53 48 83 ec 08
RSP: 002b:00007f3c0db50118 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f3c0db506c0 RCX: 00007f3c0e3ae35e
RDX: 000000000000002f RSI: 00007f3c0e427b40 RDI: 0000000000000004
RBP: 00007f3c0e427b40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffd0
R13: 0000000000000010 R14: 00007ffdb343b7d0 R15: 00007ffdb343b8b8
 </TASK>


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

