Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998BEC79FA1
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2026 15:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Date:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+IjrXitel32FTdEZ7ujqbpwDNgbWTPcI1o56TG8f6VQ=; b=s2U9j4nm0F8vov32keS6QoQbeF
	xsC1hreb2jrWilSlZvXoCA1BUDGP6I2glSXg/VfteO7I0PequEe5hlOf8aL7cu1QTE3O+wG/4O7Z+
	ZdIfQ0ZBHeM2tiebYNBw//rbrpECICvDvZZ5scZXb587lJdGazeB6fYzb5WzcvujuIY/9KdvclsRU
	hOMAiKiC5Uj+WIG3edLIVabhDyZ+/WqVOGPTC7IUdJKmDIa7w4UgT3SVm5l2F5LLIID/wd0U8Y6+t
	r6SpBcTLOoASnVFI72vcWyFGBnHPrBp3+QgSUCC/rFP8mFFt/czhXQ9cMFGqTmuJayoL01MAC7Oc1
	9qXEHzfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3b5Q-000000077wa-2lkL;
	Mon, 07 Sep 2026 15:16:44 +0000
Received: from mail-oo2-f4.google.com ([74.125.231.132])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3b5O-000000077wA-2toC
	for linux-nvme@lists.infradead.org;
	Mon, 07 Sep 2026 15:16:43 +0000
Received: by mail-oo2-f4.google.com with SMTP id 46e09a7af769-7f4e2118db8so1288211a34.1
        for <linux-nvme@lists.infradead.org>; Mon, 07 Sep 2026 08:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788794201; x=1789399001;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+IjrXitel32FTdEZ7ujqbpwDNgbWTPcI1o56TG8f6VQ=;
        b=Pa6LRMqSSZBLzCPduOChvCFsdnpGEe+ga27eyI+bwnbB3lnz9AZZ60PYbMrwVjp3YP
         4w9oL0qWqlWcs+Hgh2tfsETqMYK4JPtjfaGTHtY9VahR9060q7J1/qDUeZ2wuWVaJVfu
         Z9dnEsH9JwWe8L6np00CzNGA2zC5dOXTgarHYDYiW7Seh4D87WVWGGt4EXhbvWHzUPwj
         tIQgHW6Cgeqo0s9x/rjiLnFf9R3FdkxOthdRz/Qslfaogl/gVSIGZIfHAZp93l+9uR9h
         49xhzG0AV5g2fp6mX62zxAUHMHsyVjfVhcEQ7i/8sgz7dWwD3dLkwx1ZbW8bKKkWbsxR
         glVw==
X-Forwarded-Encrypted: i=1; AKwUvBxudT3d7kVH+qSnvsHQbAZNwB6w77CCr+sWsCwWOV0PbQbXmh5lmET+gRQ5cqvpLs6O2tMG1qWVcECj@lists.infradead.org
X-Gm-Message-State: AFuF++lq62jw2D7kvop/ceZZ1DqFa9Yt7xPThAbZi3FWvmMb66uv9OTx
	zqconoxcgqS28jwo+rxFTFtSJ+1JmbpuEhdzh2uUDm4D9rTFJW1LnpitE1zQX75V0vb5E3VeWw5
	yYlCtaCsV0jcUM80m8/6iCfJd2pVEW6n/i7vG9AF6fXgTdLkSv/9u3S4lnWA=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1795:b0:6b3:f31f:bd74 with SMTP id
 006d021491bc7-6b6fcfd90f0mr23613753eaf.20.1788794201131; Mon, 07 Sep 2026
 08:16:41 -0700 (PDT)
Date: Mon, 07 Sep 2026 08:16:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9ed559.6e6c5f9e.240462.0003.GAE@google.com>
Subject: [syzbot] [nvme?] WARNING in nvme_loop_reset_ctrl_work
From: syzbot <syzbot+4a1d521d19d6321f5aad@syzkaller.appspotmail.com>
To: hch@lst.de, kch@nvidia.com, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, sagi@grimberg.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_081642_734881_D9CDFCDF 
X-CRM114-Status: UNSURE (   8.58  )
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

HEAD commit:    940de590b839 Merge tag 'hardening-v7.3-rc2' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150e2125580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b454dc6b1b7acd30
dashboard link: https://syzkaller.appspot.com/bug?extid=4a1d521d19d6321f5aad
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/465f56673f03/disk-940de590.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8f5904c8659/vmlinux-940de590.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b2c5a5b98759/bzImage-940de590.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4a1d521d19d6321f5aad@syzkaller.appspotmail.com

------------[ cut here ]------------
1
WARNING: drivers/nvme/target/loop.c:455 at nvme_loop_reset_ctrl_work+0x423/0x810 drivers/nvme/target/loop.c:455, CPU#0: kworker/u8:16/1478
Modules linked in:
CPU: 0 UID: 0 PID: 1478 Comm: kworker/u8:16 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: nvme-reset-wq nvme_loop_reset_ctrl_work
RIP: 0010:nvme_loop_reset_ctrl_work+0x423/0x810 drivers/nvme/target/loop.c:455
Code: 00 00 48 8b 44 24 18 8b 18 83 e3 fe bf 04 00 00 00 89 de e8 ef 30 d4 fb 83 fb 04 75 07 e8 d5 2b d4 fb eb 09 e8 ce 2b d4 fb 90 <0f> 0b 90 48 83 c4 28 5b 41 5c 41 5d 41 5e 41 5f 5d e9 d7 fa 66 05
RSP: 0018:ffffc90007127a80 EFLAGS: 00010293
RAX: ffffffff85f24df2 RBX: 0000000000000002 RCX: ffff888025970000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1f63bb0 R12: ffff888024bc4c18
R13: 1ffff11004978879 R14: dffffc0000000000 R15: ffff888024bc4000
FS:  0000000000000000(0000) GS:ffff888125bd5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f899ad0b840 CR3: 00000000390e0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 process_one_work kernel/workqueue.c:3396 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

