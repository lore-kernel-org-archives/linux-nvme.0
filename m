Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCFDF55102
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Mar 2026 19:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=V8aOBZcZ9tXID5tssFJJhBM5poUTOsJuGpZdRZooCLM=; b=owGwBWo4r7ri2aW/f88jBrP7U6
	AtCsQokAexWl+WS18DFBAmKi1vf3rNaNUPiZ34odragFSCeHJxe8VMTlROdiH3WXBYWzUOXAy6CvP
	OMfyCT1m29BXbRzaEPwTthFqX+fcuSNNSso6wpsgrt/ZSh8sw8t0ge23Hd0bK7Fn4H+a68shYb7+K
	tILKspgi7g3Np3Ntyh3m10Op3D1hrmE/smAsc6eXs2hUhcQH0O6mOr7bN3JNX6zFEMFTWHB4eRs8A
	FN5/mSU8KW9k4p5zTy1snPVmZUGIyxkvloAea+wAf86Wy0FJfloAMKCFHJHt8UVzGT5sHdi9DEc8l
	EifggIUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyxcd-00000005Sla-1lNs;
	Sat, 07 Mar 2026 19:47:35 +0000
Received: from mail-yw1-f172.google.com ([209.85.128.172])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyxcX-00000005SlD-1sIL
	for linux-nvme@lists.infradead.org;
	Sat, 07 Mar 2026 19:47:30 +0000
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79868cde1eeso114411387b3.2
        for <linux-nvme@lists.infradead.org>; Sat, 07 Mar 2026 11:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772912847; x=1773517647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8aOBZcZ9tXID5tssFJJhBM5poUTOsJuGpZdRZooCLM=;
        b=e0A2bo7wcvcBxNxWVpdKkUDJfSX3hP5G0ShVgZEI/x9sy18PVGmJR94WAe6s0W/UEG
         eXrAPsNHfBk9LTp+8G70RzWx4KIvFsjEffgEoWqkidvlAM9Gl4LWuJETwzW7Ts5Vl2ia
         /Y+U3PN3uenpNwzf5z2jqrMXQsyXFssZFpNIuClREa4NsLu0e1m16BCEp3woqBJKUE8z
         EuZzvmUuT7jetSHZWV9BEiY50LZ6+s/2DofY7pm3fuZ5dV2JImf3FVETyvVshAI4vDTa
         kgK/rQJDa0wIGJ4MWbT2hYo3SFrGvCIVO6pBOON5FuJlH4a4+24+Oz4XB9o+yDQyaA/L
         GN/w==
X-Forwarded-Encrypted: i=1; AJvYcCWyUo8dDn8TMq1yrb5IRLOz62K6KHsEeA0zYv8tEzPurrbaw6ae8hR/X6VxF1IKxv35QbyEdUELvKsW@lists.infradead.org
X-Gm-Message-State: AOJu0YxahjpIQ2N8tCN/8q1XR8DGSb2sXbmHjHXFGo4CLmHLdLz7ndI1
	DQBDaUrhxkbKXOUj34jR+lA7S6qcxdIwycN9FrJS8Byl7B9lTEYcfch1
X-Gm-Gg: ATEYQzz1VeAvFiFvS8QQaBUa1c7NKOFp5uENlG0SQv4i9fFDWlZdbm/AqK2Wt8zswN1
	Xot1RLzMjnxn2iwiJ0Z+nweWYTO9T3l+ZqPpP4sXzMkrI+cgntm/eg1C5Zq5cZsbevAILCgnG9a
	Vbax1bQAzspDkn73TSdoUuVotdJ46U3RRT6Mghrtle7AWaMNjlC+IkVCtf+GeQYjUwyUH7nq+Vq
	f3ndUjylO5JKmRrq76S86epq6gjuo8QU3yZ5mt+UQgzD6GHCQ+iaZC4QYVyZcmcdVUNmHXkdufm
	97sDZFc14V4L2drOdetGtfsoDATrn1GmbgB2r02gJUI1pk3z5wgEo9F+0BGVXxSKFJJ7CdBD574
	cedtBi1HzKBHoPNdHDJTL1pri8A38hfxgd1DSfuVr4PhXMB7iSG0RRqoC6w0uBYjUyijxQuUKV4
	uMtr5axZI0pA==
X-Received: by 2002:a05:690c:dd3:b0:794:7be0:8217 with SMTP id 00721157ae682-798dd775535mr58874817b3.52.1772912847172;
        Sat, 07 Mar 2026 11:47:27 -0800 (PST)
Received: from tofu.. ([128.210.0.165])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-798ded6eca9sm23409447b3.22.2026.03.07.11.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 11:47:26 -0800 (PST)
From: Sungwoo Kim <iam@sung-woo.kim>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Sungwoo Kim <iam@sung-woo.kim>,
	Chao Shi <cshi008@fiu.edu>,
	Weidong Zhu <weizhu@fiu.edu>,
	Dave Tian <daveti@purdue.edu>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix race bug in nvme_poll_irqdisable()
Date: Sat,  7 Mar 2026 14:46:36 -0500
Message-ID: <20260307194636.2755443-2-iam@sung-woo.kim>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260307_114729_497749_7F95FB42 
X-CRM114-Status: GOOD (  14.52  )
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

In the following scenario, pdev can be disabled between (1) and (3) by
(2). This sets pdev->msix_enabled = 0. Then, pci_irq_vector() will
return MSI-X IRQ(>15) for (1) whereas return INTx IRQ(<=15) for (2).
This causes IRQ warning because it tries to enable INTx IRQ that has
never been disabled before.

To fix this, save IRQ number into a local variable and ensure
disable_irq() and enable_irq() operate on the same IRQ number.
Even if pci_free_irq_vectors() frees the IRQ concurrently, disable_irq()
and enable_irq() on a stale IRQ number is still valid and safe, and the
depth accounting reamins balanced.

task 1:
nvme_poll_irqdisable()
  disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector)) ...(1)
  enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector))  ...(3)

task 2:
nvme_reset_work()
  nvme_dev_disable()
    pdev->msix_enable = 0;  ...(2)

crash log:

------------[ cut here ]------------
Unbalanced enable for IRQ 10
WARNING: kernel/irq/manage.c:753 at __enable_irq+0x102/0x190 kernel/irq/manage.c:753, CPU#1: kworker/1:0H/26
Modules linked in:
CPU: 1 UID: 0 PID: 26 Comm: kworker/1:0H Not tainted 6.19.0-dirty #9 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: kblockd blk_mq_timeout_work
RIP: 0010:__enable_irq+0x107/0x190 kernel/irq/manage.c:753
Code: ff df 48 89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 79 48 8d 3d 2e 7a 3f 05 41 8b 74 24 2c <67> 48 0f b9 3a e8 ef b9 21 00 5b 41 5c 5d e9 46 54 66 03 e8 e1 b9
RSP: 0018:ffffc900001bf550 EFLAGS: 00010046
RAX: 0000000000000007 RBX: 0000000000000000 RCX: ffffffffb20c0e90
RDX: 0000000000000000 RSI: 000000000000000a RDI: ffffffffb74b88f0
RBP: ffffc900001bf560 R08: ffff88800197cf00 R09: 0000000000000001
R10: 0000000000000003 R11: 0000000000000003 R12: ffff8880012a6000
R13: 1ffff92000037eae R14: 000000000000000a R15: 0000000000000293
FS:  0000000000000000(0000) GS:ffff8880b49f7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555da4a25fa8 CR3: 00000000208e8000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 enable_irq+0x121/0x1e0 kernel/irq/manage.c:797
 nvme_poll_irqdisable+0x162/0x1c0 drivers/nvme/host/pci.c:1494
 nvme_timeout+0x965/0x14b0 drivers/nvme/host/pci.c:1744
 blk_mq_rq_timed_out block/blk-mq.c:1653 [inline]
 blk_mq_handle_expired+0x227/0x2d0 block/blk-mq.c:1721
 bt_iter+0x2fc/0x3a0 block/blk-mq-tag.c:292
 __sbitmap_for_each_set include/linux/sbitmap.h:269 [inline]
 sbitmap_for_each_set include/linux/sbitmap.h:290 [inline]
 bt_for_each block/blk-mq-tag.c:324 [inline]
 blk_mq_queue_tag_busy_iter+0x969/0x1e80 block/blk-mq-tag.c:536
 blk_mq_timeout_work+0x627/0x870 block/blk-mq.c:1763
 process_one_work+0x956/0x1aa0 kernel/workqueue.c:3257
 process_scheduled_works kernel/workqueue.c:3340 [inline]
 worker_thread+0x65c/0xe60 kernel/workqueue.c:3421
 kthread+0x41a/0x930 kernel/kthread.c:463
 ret_from_fork+0x6f8/0x8c0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
irq event stamp: 74478
hardirqs last  enabled at (74477): [<ffffffffb5720a9c>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (74477): [<ffffffffb5720a9c>] _raw_spin_unlock_irq+0x2c/0x60 kernel/locking/spinlock.c:202
hardirqs last disabled at (74478): [<ffffffffb57207b5>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (74478): [<ffffffffb57207b5>] _raw_spin_lock_irqsave+0x85/0xa0 kernel/locking/spinlock.c:162
softirqs last  enabled at (74304): [<ffffffffb1e9466c>] __do_softirq kernel/softirq.c:656 [inline]
softirqs last  enabled at (74304): [<ffffffffb1e9466c>] invoke_softirq kernel/softirq.c:496 [inline]
softirqs last  enabled at (74304): [<ffffffffb1e9466c>] __irq_exit_rcu+0xdc/0x120 kernel/softirq.c:723
softirqs last disabled at (74287): [<ffffffffb1e9466c>] __do_softirq kernel/softirq.c:656 [inline]
softirqs last disabled at (74287): [<ffffffffb1e9466c>] invoke_softirq kernel/softirq.c:496 [inline]
softirqs last disabled at (74287): [<ffffffffb1e9466c>] __irq_exit_rcu+0xdc/0x120 kernel/softirq.c:723
---[ end trace 0000000000000000 ]---

Fixes: fa059b856a59 (nvme-pci: Simplify nvme_poll_irqdisable)
Acked-by: Chao Shi <cshi008@fiu.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Acked-by: Dave Tian <daveti@purdue.edu>
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
 drivers/nvme/host/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d86f2565a..a7fb88aa8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1484,14 +1484,16 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 {
 	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
+	int irq;
 
 	WARN_ON_ONCE(test_bit(NVMEQ_POLLED, &nvmeq->flags));
 
-	disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
+	irq = pci_irq_vector(pdev, nvmeq->cq_vector);
+	disable_irq(irq);
 	spin_lock(&nvmeq->cq_poll_lock);
 	nvme_poll_cq(nvmeq, NULL);
 	spin_unlock(&nvmeq->cq_poll_lock);
-	enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
+	enable_irq(irq);
 }
 
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
-- 
2.47.3


