Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E76AE63F21
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Feb 2026 00:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hjZbfPQjcOo7c7QiCsOWz25FVBk2EHeYzjL3hfu5alw=; b=2hYKAssFyzwWAeicOx2mdnpdd5
	nSweod2seU2L/nlNKv1kZquvvHkkjddxpSlI2jo69tODMQjbKAEtNBrj0zSbqOYASP+Vq6SL4l8/R
	8nQz/hyaqNn2pqL3BnU+q+OzcfGqKbyky8uvLI+dLcOWal/5LetcxyG3QXVp+3rRa+BEotzddpK6i
	nuzoAfhKOsegF8iX3LFO/6irudwXwRD+AdRzJIRcE6KVadN4BY6nRNVlmOOfMknr4Jzfg103u948F
	kCgLi5s9f9Q5nx56btNQZwh0C/ML6Xfcl83yYsbZPFC0jr8ce78IFQYSFTnX02yPRIpu7TS7qL9rM
	0wOLMXAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrmao-00000005oh8-2Lui;
	Mon, 16 Feb 2026 00:36:02 +0000
Received: from mail-yw1-f177.google.com ([209.85.128.177])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrmam-00000005ogD-0r2L
	for linux-nvme@lists.infradead.org;
	Mon, 16 Feb 2026 00:36:01 +0000
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7950881727cso15590657b3.3
        for <linux-nvme@lists.infradead.org>; Sun, 15 Feb 2026 16:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771202158; x=1771806958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjZbfPQjcOo7c7QiCsOWz25FVBk2EHeYzjL3hfu5alw=;
        b=IVtJr4TuwbIeb3xxGliH2lE52mIT6EkfZiQFK64map37A6VqmMxAV3Q6vPsW9tLAQl
         6Vm7s75T2MCvngswpXa82CvlqhpjjFQjgQtAnkYZLH2XmwGWFSoIu8+L9JTCAxMAW6bL
         vFsQ1+Trqp+11qCdHvZRNFFJj7W4OVhq4JGqRbQgkEkPh6IcY+AUhVYUalSr/+oWhQw/
         /JidfvpOautsR0RlcFbZOSsGzAB4AK31kXKbMldX+3HPFLSXfY4dBfY2G0Y58DmNtNBx
         rmGwiBozUU4vBFoNGdEGwZX2rFK7Wlf68zDdm3CcHPHHw4I5PH1E4Co068xg8Ko3ZvpU
         Ydiw==
X-Forwarded-Encrypted: i=1; AJvYcCXbQAjUtYhcv43fwLcnuWj7Sak0IbMDvF8mjgCS9dOw2uqWUPJUUBAhOMkK7c+AEsUpXwIRj5sH9hbJ@lists.infradead.org
X-Gm-Message-State: AOJu0Yy11cNXJYEdNV274YHZj+k/OkGbQUG7w9ywK7zrm1zBI+z1G0zW
	h8Kzlts95TIvHrOmzGIWuOqH7ZBcMiSbJfK6Uh7M0cW0P1K9Ys+HhiR8
X-Gm-Gg: AZuq6aJxxf02wFMLv+EAVPU57fvK7angrE5Ji+BBAopS82LdiO9QkYAqLr8+y+cX5MK
	Kb8f0S7QrcQHOEr6EgPzwUvACMbo6u8X/w3SUPPoINoneVEefcQ+VTZuCDnJy40Mj9Z/ZHl7dqc
	wtAxYZHWT7iUaze0YFUXN8hpu5JsiT2ER1hgHeSk3AHDh7fbLgmji3Bw10EQ0ZPjxPNff8Ye06o
	XV7r37kVu/08nriGQ0rpVuCp2FrvEheaVbrgRmLy8JYHNTZD8gH+Hx0coVQDbdQLiIO3RY3A9iK
	hEINcUjD8zXvF7snzfOA8poqVu14+j9vTyeZnyfdpATqsasUKTpZLM0fAt050d72gvwKW8TzF1c
	z8YcDFivAWB8t0Sf8HcW2/DLlGh/7dFUOG2omr2ud0YfFqeq8z/f/1YRECObNxcMSWdXywvVuZD
	ta6pdtm4PK4A==
X-Received: by 2002:a05:690c:18:b0:796:3f2f:a33b with SMTP id 00721157ae682-797a0be9c0amr150571017b3.18.1771202158293;
        Sun, 15 Feb 2026 16:35:58 -0800 (PST)
Received: from tofu.. ([128.210.0.165])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-7966c16e7dcsm94417207b3.8.2026.02.15.16.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 16:35:57 -0800 (PST)
From: Sungwoo Kim <iam@sung-woo.kim>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Sungwoo Kim <iam@sung-woo.kim>,
	Chao Shi <cshi008@fiu.edu>,
	Weidong Zhu <weizhu@fiu.edu>,
	Dave Tian <daveti@purdue.edu>
Subject: [PATCH] nvme: fix memory allocator in nvme_pr_read_keys()
Date: Sun, 15 Feb 2026 19:35:27 -0500
Message-ID: <20260216003541.161806-2-iam@sung-woo.kim>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260215_163600_248688_484E3B32 
X-CRM114-Status: GOOD (  15.05  )
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

If IOC_PR_READ_KEYS is called with num_keys == PR_KEYS_MAX,
nvme_pr_read_keys() may request more than 4MB memory via kzalloc().
This always fails since kzalloc() does not allocate memory more than
4MB. As a result, ioctl() fails with ENOMEM, which is incorrect.
To fix this, use kvzalloc() instead of kzalloc().

WARNING: mm/page_alloc.c:5216 at __alloc_frozen_pages_noprof+0x5aa/0x2300 mm/page_alloc.c:5216, CPU#1: syz-executor117/272
Modules linked in:
CPU: 1 UID: 0 PID: 272 Comm: syz-executor117 Not tainted 6.19.0 #1 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:__alloc_frozen_pages_noprof+0x5aa/0x2300 mm/page_alloc.c:5216
Code: ff 83 bd a8 fe ff ff 0a 0f 86 69 fb ff ff 0f b6 1d f9 f9 c4 04 80 fb 01 0f 87 3b 76 30 ff 83 e3 01 75 09 c6 05 e4 f9 c4 04 01 <0f> 0b 48 c7 85 70 fe ff ff 00 00 00 00 e9 8f fd ff ff 31 c0 e9 0d
RSP: 0018:ffffc90000fcf450 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 1ffff920001f9ea0
RDX: 0000000000000000 RSI: 000000000000000b RDI: 0000000000040dc0
RBP: ffffc90000fcf648 R08: ffff88800b6c3380 R09: 0000000000000001
R10: ffffc90000fcf840 R11: ffff88807ffad280 R12: 0000000000000000
R13: 0000000000040dc0 R14: 0000000000000001 R15: ffffc90000fcf620
FS:  0000555565db33c0(0000) GS:ffff8880be26c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000000c CR3: 0000000003b72000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 alloc_pages_mpol+0x236/0x4d0 mm/mempolicy.c:2486
 alloc_frozen_pages_noprof+0x149/0x180 mm/mempolicy.c:2557
 ___kmalloc_large_node+0x10c/0x140 mm/slub.c:5598
 __kmalloc_large_node_noprof+0x25/0xc0 mm/slub.c:5629
 __do_kmalloc_node mm/slub.c:5645 [inline]
 __kmalloc_noprof+0x483/0x6f0 mm/slub.c:5669
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 nvme_pr_read_keys+0x8f/0x4c0 drivers/nvme/host/pr.c:245
 blkdev_pr_read_keys block/ioctl.c:456 [inline]
 blkdev_common_ioctl+0x1b71/0x29b0 block/ioctl.c:730
 blkdev_ioctl+0x299/0x700 block/ioctl.c:786
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x1bf/0x220 fs/ioctl.c:583
 x64_sys_call+0x1280/0x21b0 mnt/fuzznvme_1/fuzznvme/linux-build/v6.19/./arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x71/0x330 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fb893d3108d
Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff61f2f38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffff61f3138 RCX: 00007fb893d3108d
RDX: 0000000020000040 RSI: 00000000c01070ce RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 00007ffff61f3138
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffff61f3128 R14: 00007fb893dae530 R15: 0000000000000001
 </TASK>

Fixes: 5fd96a4e15de (nvme: Add pr_ops read_keys support)
Acked-by: Chao Shi <cshi008@fiu.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Acked-by: Dave Tian <daveti@purdue.edu>
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
 drivers/nvme/host/pr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index ad2ecc2f4..5394b6cb0 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -242,7 +242,7 @@ static int nvme_pr_read_keys(struct block_device *bdev,
 	if (rse_len > U32_MAX)
 		return -EINVAL;
 
-	rse = kzalloc(rse_len, GFP_KERNEL);
+	rse = kvzalloc(rse_len, GFP_KERNEL);
 	if (!rse)
 		return -ENOMEM;
 
-- 
2.47.3


