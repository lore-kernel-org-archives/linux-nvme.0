Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA9210F6FC2
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 15:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uP5c6JzjwZwnGCsqflyTr1RQBZf98/zHqoDjD1LVIe8=; b=Cejd89LDHsHwo26U+8BTwfHm3v
	pJMYt9noPpMrhSFBbRBXYDd5afx9A/+YVWw9qSqOhDA9tlnLb2EVjqif/Sem7RPTLM1tCHtz3iu6b
	Kriqgy4NOrlFzHG6BGMBt5K1xinNb2b6yXyZxqzz7yXOeZ8NVe+K/Ncrtg4GqHs4ilh1YjjGGe/fg
	YC6XwkhlHqLEZwBn4pZDtC8wMt/7UBH80aDfCN3bNqncTUzxbv11+JD89kuzddj6zLGrZA8udOnPU
	mmfNWruRjBFQlTWExap6/Rxhqoa80m6bDuMekGb0++kdxkfc0GymRgnDMoTiF3Z7CIP+4N83t0Xxu
	Nr/cbhbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7x5D-0000000FYyL-0WSU;
	Wed, 01 Apr 2026 15:02:15 +0000
Received: from iad-out-007.esa.us-east-1.outbound.mail-perimeter.amazon.com ([3.221.209.22])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7vkq-0000000FKNI-1bsi;
	Wed, 01 Apr 2026 13:37:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1775050628; x=1806586628;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=uP5c6JzjwZwnGCsqflyTr1RQBZf98/zHqoDjD1LVIe8=;
  b=ryyqZyeEtxxfEjo+FnYPhxh1HTVzw58wq8j3sj9RrEFO1Y2GjpVmvogq
   JBHUw9wrd6LaTrGAFqi9p9f6pBaffl8tKoRpmHqO6zsgm9HMGgzWFeGYy
   01Zry6zqUHHmeqe4yBLkKwk/gBJQGWkUNVHeWCquGd1MHwduzhdvVd7HO
   gA+o2isRNLVAoxs8tAU5+PtLAnyeTmbBedSJux/WjK8GLBsLU8kgCdEGi
   ZQ9a7FBSgquiYgjvFiTjX/FbDeN6SHul7UZXTF9rV44v778BPNhp376N9
   31GyEuGSiukIpTTTKy6LGRpbKSO+hz0b3p+lvNCP02QDO4AjTzh025GcP
   g==;
X-CSE-ConnectionGUID: zLawT+wTR4W8WnCI2LkUkQ==
X-CSE-MsgGUID: GueIiePrRhahwivpK1isTg==
X-IronPort-AV: E=Sophos;i="6.23,153,1770595200"; 
   d="scan'208";a="15299642"
Received: from ip-10-4-3-150.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.3.150])
  by internal-iad-out-007.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 13:37:07 +0000
Received: from EX19MTAUEB001.ant.amazon.com [72.21.198.67:5444]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.17.255:2525] with esmtp (Farcaster)
 id 0f038195-b495-4681-bad2-e90935ddb4f6; Wed, 1 Apr 2026 13:37:07 +0000 (UTC)
X-Farcaster-Flow-ID: 0f038195-b495-4681-bad2-e90935ddb4f6
Received: from EX19D012UEC004.ant.amazon.com (10.252.135.219) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 1 Apr 2026 13:37:07 +0000
Received: from EX19D012UEC003.ant.amazon.com (10.252.135.160) by
 EX19D012UEC004.ant.amazon.com (10.252.135.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 1 Apr 2026 13:37:07 +0000
Received: from EX19D012UEC003.ant.amazon.com ([fe80::67ea:859:1e17:25a9]) by
 EX19D012UEC003.ant.amazon.com ([fe80::67ea:859:1e17:25a9%3]) with mapi id
 15.02.2562.037; Wed, 1 Apr 2026 13:37:07 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Heyne, Maximilian" <mheyne@amazon.de>, Keith Busch <kbusch@kernel.org>,
	Casey Chen <cachen@purestorage.com>, Christoph Hellwig <hch@lst.de>, "Hannes
 Reinecke" <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, Chaitanya Kulkarni
	<kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Hector Martin
	<marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig
	<alyssa@rosenzweig.io>, Sagi Grimberg <sagi@grimberg.me>, "James E.J.
 Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Alim Akhtar <alim.akhtar@samsung.com>, "Avri
 Altman" <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, "Sasha
 Levin" <sashal@kernel.org>, Peter Wang <peter.wang@mediatek.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Wonkon Kim
	<wkon.kim@samsung.com>, Sanjeev Yadav <sanjeev.y@mediatek.com>, Brian Kao
	<powenkao@google.com>, Seunghui Lee <sh043.lee@samsung.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>
Subject: [PATCH 6.1.y 7/8] nvme: fix admin request_queue lifetime
Thread-Topic: [PATCH 6.1.y 7/8] nvme: fix admin request_queue lifetime
Thread-Index: AQHcwdyhnryy0gEdpE2mdsVx0tSoPQ==
Date: Wed, 1 Apr 2026 13:37:06 +0000
Message-ID: <20260401-clef-ken-54e30c4e@mheyne-amazon>
References: <20260401-defer-gleam-5226cb65@mheyne-amazon>
In-Reply-To: <20260401-defer-gleam-5226cb65@mheyne-amazon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.235.223]
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_063708_551084_5B6BF751 
X-CRM114-Status: GOOD (  15.63  )
X-Mailman-Approved-At: Wed, 01 Apr 2026 08:02:12 -0700
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 03b3bcd319b3ab5182bc9aaa0421351572c78ac0]

The namespaces can access the controller's admin request_queue, and
stale references on the namespaces may exist after tearing down the
controller. Ensure the admin request_queue is active by moving the
controller's 'put' to after all controller references have been released
to ensure no one is can access the request_queue. This fixes a reported
use-after-free bug:

  BUG: KASAN: slab-use-after-free in blk_queue_enter+0x41c/0x4a0
  Read of size 8 at addr ffff88c0a53819f8 by task nvme/3287
  CPU: 67 UID: 0 PID: 3287 Comm: nvme Tainted: G            E       6.13.2-=
ga1582f1a031e #15
  Tainted: [E]=3DUNSIGNED_MODULE
  Hardware name: Jabil /EGS 2S MB1, BIOS 1.00 06/18/2025
  Call Trace:
   <TASK>
   dump_stack_lvl+0x4f/0x60
   print_report+0xc4/0x620
   ? _raw_spin_lock_irqsave+0x70/0xb0
   ? _raw_read_unlock_irqrestore+0x30/0x30
   ? blk_queue_enter+0x41c/0x4a0
   kasan_report+0xab/0xe0
   ? blk_queue_enter+0x41c/0x4a0
   blk_queue_enter+0x41c/0x4a0
   ? __irq_work_queue_local+0x75/0x1d0
   ? blk_queue_start_drain+0x70/0x70
   ? irq_work_queue+0x18/0x20
   ? vprintk_emit.part.0+0x1cc/0x350
   ? wake_up_klogd_work_func+0x60/0x60
   blk_mq_alloc_request+0x2b7/0x6b0
   ? __blk_mq_alloc_requests+0x1060/0x1060
   ? __switch_to+0x5b7/0x1060
   nvme_submit_user_cmd+0xa9/0x330
   nvme_user_cmd.isra.0+0x240/0x3f0
   ? force_sigsegv+0xe0/0xe0
   ? nvme_user_cmd64+0x400/0x400
   ? vfs_fileattr_set+0x9b0/0x9b0
   ? cgroup_update_frozen_flag+0x24/0x1c0
   ? cgroup_leave_frozen+0x204/0x330
   ? nvme_ioctl+0x7c/0x2c0
   blkdev_ioctl+0x1a8/0x4d0
   ? blkdev_common_ioctl+0x1930/0x1930
   ? fdget+0x54/0x380
   __x64_sys_ioctl+0x129/0x190
   do_syscall_64+0x5b/0x160
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x7f765f703b0b
  Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 6=
6 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 8b 0d dd 52 0f 00 f7 d8 64 89 01 48
  RSP: 002b:00007ffe2cefe808 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 00007ffe2cefe860 RCX: 00007f765f703b0b
  RDX: 00007ffe2cefe860 RSI: 00000000c0484e41 RDI: 0000000000000003
  RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
  R10: 00007f765f611d50 R11: 0000000000000202 R12: 0000000000000003
  R13: 00000000c0484e41 R14: 0000000000000001 R15: 00007ffe2cefea60
   </TASK>

Reported-by: Casey Chen <cachen@purestorage.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ Because we're missing commit 0da7feaa5913 ("nvme-pci: use the tagset
  alloc/free helpers") we need to additionally remove the blk_put_queue
  from nvme_dev_remove_admin in pci.c to properly fix the UAF ]
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 drivers/nvme/host/core.c | 3 ++-
 drivers/nvme/host/pci.c  | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 044e1a9c099b3..f17318f6c82b0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5043,7 +5043,6 @@ EXPORT_SYMBOL_GPL(nvme_alloc_admin_tag_set);
 void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl)
 {
 	blk_mq_destroy_queue(ctrl->admin_q);
-	blk_put_queue(ctrl->admin_q);
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
 		blk_mq_destroy_queue(ctrl->fabrics_q);
 		blk_put_queue(ctrl->fabrics_q);
@@ -5186,6 +5185,8 @@ static void nvme_free_ctrl(struct device *dev)
 		container_of(dev, struct nvme_ctrl, ctrl_device);
 	struct nvme_subsystem *subsys =3D ctrl->subsys;
 =

+	if (ctrl->admin_q)
+		blk_put_queue(ctrl->admin_q);
 	if (!subsys || ctrl->instance !=3D subsys->instance)
 		ida_free(&nvme_instance_ida, ctrl->instance);
 =

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 38732c0c28bbb..e8b7b0004086c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1782,7 +1782,6 @@ static void nvme_dev_remove_admin(struct nvme_dev *de=
v)
 		 */
 		nvme_start_admin_queue(&dev->ctrl);
 		blk_mq_destroy_queue(dev->ctrl.admin_q);
-		blk_put_queue(dev->ctrl.admin_q);
 		blk_mq_free_tag_set(&dev->admin_tagset);
 	}
 }
-- =

2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


