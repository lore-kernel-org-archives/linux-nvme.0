Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879201048922
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Feb 2026 00:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jxBYsfIl1dQDj7E0Mud0kfpYkTy2bn5OOdrQxDSmBiY=; b=IXmANA6ZzagpPJIQABTSbE8JBH
	5zPH1ua1ps+D3ri8WmP3ns/NTpufxjFO7uAzjaqq4OIsajC0Qm0F3PMGFl4wyC0b22UpVhoCv4R6u
	vSRzY3UzykwzUKnoyTSARPBC7BNi6XSLeuAziLe+rdq90OdDBZNmIwyMW+wXxXGB425rDCFR7SLJe
	V18gn6dlGEGqWDaIflkoltB+lvjLTtGNElVvVgBW74ZLJXlezTNAJdzaEf1WeK73eveomeyjZ+Jy8
	zHGrUe1DWb+1Wy9d0mhbo4mBzgdA9rdHfpm3KeblE+/xQ60yDE++0+1W0xXv9OPVMt5m6kKJ/hH/H
	CDkJtL8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw868-00000009K7J-2PcU;
	Sat, 28 Feb 2026 00:22:20 +0000
Received: from mail-yx1-f48.google.com ([74.125.224.48])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw865-00000009K6y-1l0p
	for linux-nvme@lists.infradead.org;
	Sat, 28 Feb 2026 00:22:18 +0000
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ad79dfb7cso2832464d50.2
        for <linux-nvme@lists.infradead.org>; Fri, 27 Feb 2026 16:22:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772238135; x=1772842935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxBYsfIl1dQDj7E0Mud0kfpYkTy2bn5OOdrQxDSmBiY=;
        b=m9nvxF/lRkAVk+9WduDWPTobXdIWPFb0723oEipiMg9m1npuDIy5d/sBSRyfTYPS5+
         IPAzKk2eCNj/Ujb2yxBoQD5Z1ElSMWlpoWda77U3voj7dIiE3wdCDxJnyws6zDxHy92t
         bGsmSKzkX3ZIKn1ausYJ22pNPbVGyfJkWV3/8JrQkm5c1ShM+zflSoozMcdLhj29tjzG
         D468Z2oKe3t60UU8XIbzzhq54lHfDDdJCWE5JY7KQ/TUd/Eizy+hjBjYKdMwE8G3h7Yp
         COhBQVb1yJM7/imkMC8/m5kBHSHLOV6WpCBleUPEWJAe+4j3xVlvwGt7GafGDJVtwp+d
         h9vg==
X-Forwarded-Encrypted: i=1; AJvYcCVphXFLGEnVXIg8ro1Lqhs5axpNRKvnZ1tRjR6YNdIDm9cvjxrSbkqyzSTXNjk0gCh7LqhmflVBbvuz@lists.infradead.org
X-Gm-Message-State: AOJu0YxpCq3pqCpuehs6nskiKRzjuqFRZw/Dt/08/hbQJPu7UoIS2Xb6
	LugMzcPGuUb2Ei9yMBT5D9yOGisZTwQKJ3UmavIdRzJP9EI3MODxMnIDegTly5k8
X-Gm-Gg: ATEYQzzLg62vMDLnVLJP13NfzQ29jN/EHc+URnJFOwojFkWu8znvqHiZ2qAZTCMdzpx
	fKj/zPv8Dcguf9fs9MNvEMa5XV9oDJSE5xhA+oPmwD1r+V6f1keowr3lGIwrs6RKJzSl9pzuEeZ
	8ygsHp1QEgQcT3jzyyndJwf2VBJAnr8dVr1Kb0iZi+/ON8y3WIhgVLG3ay/P16L19EK0Gy2sCFN
	c49HyN/7K9FXkIbbeMtMLVoH3u/AiT5EpJAqWrlIf9PDOEHEbLkJTdt0e2UC6TJinpILPbIYMVd
	og79EJvjv+sOKsdp2UiegynBO/p7XYyzKs7YD4wdhL4sZzi/kMCYD+42G34i/gEE4HZCk9wjSgp
	NFoevgVv3VIQtfm4X3d/GxfYE1bEJMMSFPluLxHLI2N9nf0SB5kOoY9ZhbT9/FyiUV8TQAremhC
	Ca7ZxVcnthzA==
X-Received: by 2002:a53:c9d2:0:b0:64c:9ee6:1ff5 with SMTP id 956f58d0204a3-64cc22fdd04mr3351893d50.65.1772238135399;
        Fri, 27 Feb 2026 16:22:15 -0800 (PST)
Received: from tofu.. ([128.210.0.165])
        by smtp.googlemail.com with ESMTPSA id 956f58d0204a3-64cb75ae57esm2872687d50.9.2026.02.27.16.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 16:22:14 -0800 (PST)
From: Sungwoo Kim <iam@sung-woo.kim>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Sungwoo Kim <iam@sung-woo.kim>,
	Chao Shi <cshi008@fiu.edu>,
	Weidong Zhu <weizhu@fiu.edu>,
	Dave Tian <daveti@purdue.edu>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvme: fix memory allocation in nvme_pr_read_keys()
Date: Fri, 27 Feb 2026 19:19:28 -0500
Message-ID: <20260228001927.382810-3-iam@sung-woo.kim>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_162217_485165_9E0A84F4 
X-CRM114-Status: GOOD (  16.96  )
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

nvme_pr_read_keys() takes num_keys from userspace and uses it to
calculate the allocation size for rse via struct_size(). The upper
limit is PR_KEYS_MAX (64K).

A malicious or buggy userspace can pass a large num_keys value that
results in a 4MB allocation attempt at most, causing a warning in
the page allocator when the order exceeds MAX_PAGE_ORDER.

To fix this, use kvzalloc() instead of kzalloc().

This bug has the same reasoning and fix with the patch below:
https://lore.kernel.org/linux-block/20251212013510.3576091-1-kartikey406@gmail.com/

Warning log:
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
v2: add missing kvfree

 drivers/nvme/host/pr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index ad2ecc2f49a97..fe7dbe2648158 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -242,7 +242,7 @@ static int nvme_pr_read_keys(struct block_device *bdev,
 	if (rse_len > U32_MAX)
 		return -EINVAL;
 
-	rse = kzalloc(rse_len, GFP_KERNEL);
+	rse = kvzalloc(rse_len, GFP_KERNEL);
 	if (!rse)
 		return -ENOMEM;
 
@@ -267,7 +267,7 @@ static int nvme_pr_read_keys(struct block_device *bdev,
 	}
 
 free_rse:
-	kfree(rse);
+	kvfree(rse);
 	return ret;
 }
 
-- 
2.47.3


