Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8BDC982D7
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Sep 2026 00:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:Date:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xo9q5xUUXF4KjJ0+zPrqtPtiLxRKts0CpehP+nEYXok=; b=pYsF3OK58MTTklvBabalOp8F/o
	nBOOufeaNHTtQtKGws24Ezr++yby2+Abevhswbbj1H62jhx92OSxna3Twj9Z6bpUQo4zQPgnKoW5W
	rV4zO/dUcZE+KSN3Ntj+lRwJ4SfdKMvC3ZY1oNGwYSqDEU1X1FYanKNEGrrl0wQ10sk4pS7ruV8Qs
	yKdKXrnSpPA1ymhYx8/L4sX9fKX6HhNcUqAe//+UjfQAxsQv/mPAZIZE8o5jT/5ghuJZcs3Pr0uRm
	P9wX0lt3S7ukMq6C6IZFeDwFCP9Zf0/bQDNRhsTgKt2qF3tkkfJ/AU+yjAXQpMeSjTq7uA9+PadLY
	z2lY59+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7if0-0000000FjPj-2nHa;
	Sat, 19 Sep 2026 00:10:30 +0000
Received: from mail-oo2-f7.google.com ([74.125.231.135])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7iey-0000000FjP1-0Fp3
	for linux-nvme@lists.infradead.org;
	Sat, 19 Sep 2026 00:10:29 +0000
Received: by mail-oo2-f7.google.com with SMTP id 006d021491bc7-6b1bebb3ae8so543145eaf.1
        for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2026 17:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789776625; x=1790381425;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xo9q5xUUXF4KjJ0+zPrqtPtiLxRKts0CpehP+nEYXok=;
        b=mKngyoYSgLY0+izZ7NG/ogoC5A8mEAIligz2ni2zfeY0rled6/54JOX1VniI4lGWRj
         vg6CJpLEpKO5uiJPDYI+QDLXJHdUmEahJRcM+FTF+/Ck0kk7nTGB0g5vKBdi2C4HCUZL
         Ewleva0He0CTmo5jLnhTxNev1fA3D8nhFNL/WPphkajOh6Ra3DxQgZaDKtWW4vx2r8we
         53d9fWJq3CmFVVcvKzsVCcazMGX2k0ZFllAydCI/wgjG/tDBO5pdxD1ANI3ZQhOmTi6L
         QACcTSeKkQvJCnCnY2Yitl1ZOFqohUrYWRhzjSUUguj1KlwZm0PpMrxYk0G0ped3ANu/
         qnyA==
X-Forwarded-Encrypted: i=1; AKwUvBwv+RG7pCT9BqK5vfMzDBHqBJ2KS9iSQ9B/c6BeJzx6AtDwdOmAV6xELh/tePwS0BXOD867UmfuQ0OP@lists.infradead.org
X-Gm-Message-State: AFuF++nsxll5rPaUbPbIo1otfPqryxSbUCtXwi0svBKjr+/ANiLX7nIB
	bJLqqCbkKRbv6yYK+XOneu0botvCfPHXTTfBdoIn7Zu/gXWTPIH2LflMwIPU8/4x7hxPUK8Cb88
	qEUqfcgFUkJJx+gzONEbEN6LJD+eJa6WfklEZiVWTiXW1i70PT6uwk4jtRao=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:201b:b0:6c9:80d9:5e8 with SMTP id
 006d021491bc7-6ca9bf4c753mr3598445eaf.41.1789776625762; Fri, 18 Sep 2026
 17:10:25 -0700 (PDT)
Date: Fri, 18 Sep 2026 17:10:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aadd2f1.ef152331.3350b.0000.GAE@google.com>
Subject: [syzbot] [nvme?] WARNING: bad unlock balance in nvme_update_ns_info
From: syzbot <syzbot+64bc2169c92ee55ad31f@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_171028_110571_023D2F2C 
X-CRM114-Status: UNSURE (   6.84  )
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

HEAD commit:    704340f1cd0d Merge tag 'x86_urgent_for_7.3-rc4' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126bbdf9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b454dc6b1b7acd30
dashboard link: https://syzkaller.appspot.com/bug?extid=64bc2169c92ee55ad31f
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/068a35f4a268/disk-704340f1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5bb5e44895e8/vmlinux-704340f1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8cb2bd26a861/bzImage-704340f1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+64bc2169c92ee55ad31f@syzkaller.appspotmail.com

=====================================
WARNING: bad unlock balance detected!
syzkaller #0 Tainted: G             L     
-------------------------------------
kworker/u8:28/9220 is trying to release lock (&q->q_usage_counter(io)) at:
[<ffffffff85e833c7>] blk_mq_unfreeze_queue include/linux/blk-mq.h:962 [inline]
[<ffffffff85e833c7>] nvme_update_ns_info+0xa07/0x1200 drivers/nvme/host/core.c:2623
but there are no more locks to release!

other info that might help us debug this:
locks held by kworker/u8:28/9220: 2, last CPU#1:
 #0: ffff88801ae8d138 ((wq_completion)async){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffff88801ae8d138 ((wq_completion)async){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffff88801ae8d138 ((wq_completion)async){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #0: ffff88801ae8d138 ((wq_completion)async){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479
 #1: ffffc9000460fc40 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffc9000460fc40 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffc9000460fc40 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3361 [inline]
 #1: ffffc9000460fc40 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_scheduled_works+0x97a/0x1630 kernel/workqueue.c:3479

stack backtrace:
CPU: 1 UID: 0 PID: 9220 Comm: kworker/u8:28 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: async async_run_entry_fn
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_unlock_imbalance_bug+0xdc/0xf0 kernel/locking/lockdep.c:5349
 __lock_release kernel/locking/lockdep.c:5590 [inline]
 lock_release+0x252/0x3c0 kernel/locking/lockdep.c:5964
 blk_mq_unfreeze_queue include/linux/blk-mq.h:962 [inline]
 nvme_update_ns_info+0xa07/0x1200 drivers/nvme/host/core.c:2623
 nvme_alloc_ns drivers/nvme/host/core.c:4293 [inline]
 nvme_scan_ns+0x34c1/0x46c0 drivers/nvme/host/core.c:4483
 async_run_entry_fn+0x9d/0x430 kernel/async.c:129
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

