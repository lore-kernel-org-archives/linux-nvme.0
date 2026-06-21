Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C427CD98F0
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Jun 2026 13:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Z5ZY8L9TFmkr2jMI9G4ucnP4Z/ebhyAzAin+hRxCCFc=; b=EpOfC8fdgQfzCdMUsmN1044nuk
	QgHxMymNeWi/1hBW97f1sVclsKynS2k3wytYLJheuvdCFYHDvsIlEcSX/nxO3W1uaUEBQfjNRfCSR
	vMUrb5VS5d1Uvh+Y1OqPbBT/C+FcOYmaBmDuBhGZm8TkKP+Lpd4ROedCLQKTyVODUew7gTcIOT4XM
	5EFVsYVXlSC5oG5jFej+7HSrxBSg8tvuaoLPrEwe1RjVWiIuXZOp49ubO/DcxmOYOWzwk6+FcLcnu
	PBmnP60PsO6dLcwvC9ugClmPt7PghaeFshQzmZlRLcPKmp5gXxXRIjFc5SX06HnsYkTaci4h/7wT+
	N5dXT7Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbIiH-00000003z0r-3K3o;
	Sun, 21 Jun 2026 13:59:53 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbIiB-00000003z0V-36pR
	for linux-nvme@lists.infradead.org;
	Sun, 21 Jun 2026 13:59:48 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2c0b9328c4aso24416505ad.0
        for <linux-nvme@lists.infradead.org>; Sun, 21 Jun 2026 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782050386; x=1782655186; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5ZY8L9TFmkr2jMI9G4ucnP4Z/ebhyAzAin+hRxCCFc=;
        b=DBoMfRfwQ/POR1pvMXdwd6MGTEycMhK8FVxmiPDTfqXFPfVofwsd//UnQbPyYZx+U3
         Qij0rYQyq9YONJWy791an6IyZUKkRw0azRL84vDiaU5tdrCNdDRcXC0v7WCmo2Zy4m65
         1y8DZpfvWBoAQoCYOQBPpruCIc+7m/6v2+/PSvHGYqUXJ6CpUPoU7ncqmsQh1mAbVJCd
         vW5QvZiO27dXu8lJkA6Ux7pIToW0ErlWMGyYP82rkuscitL2vNjxxdtsw39hhTIFZB8C
         shhr1XWb6lqpoRUsyrxzShe3QaOl6KgJRVrnSSVxW4NS3G/qJFkfKIIGKhbGI5us2SZG
         MSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782050386; x=1782655186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5ZY8L9TFmkr2jMI9G4ucnP4Z/ebhyAzAin+hRxCCFc=;
        b=jb6wLm0eb7jA/mtXkXPLbvjyhlL0zobQz3WxMCIEyWARQRop0SWWLWTP0KHFfKvuAs
         OAdWYyNy0mR7GR2mOXI/V0USTQRHbGRAjxViMxDQVMaHS+zWuWMF1FM8iWqRzOVaKZTb
         zCS2R8fsmi94z3XR0kaEQlHjRezQqrZPotf4X1UTLUvT00Fh2qYCDuw6FYEL1gJQT0R9
         4KEsoYeYqvg3ENV2mfRFYAtOFFBwzsvph3ukHbAEJu7FO4s1IOamyWFJ1ypbXNCNrhTy
         bk+YBAlgfUiOLnLKceCXaLjr2pTMFUJim7P8swO4WKcmXiTAntec5+cgT1RYbcXrPGaD
         1Aeg==
X-Gm-Message-State: AOJu0YxiGoUelJ0UA4sYy9JqOQCGMoXvrXiKkrC+kYEodHJwtsfQRkF7
	tiDE26bxF4V5cJ50KbbO2Ftn4PhQIwmp3rDCX/zco7KF8dSU9Ma0rynq
X-Gm-Gg: AfdE7cljLW3BEUivUvMnSIJC20EASgU44LSdZBtpH8GuNXJ2saYWNuoBEHEItpX/efZ
	4PXhxdctT+gtt4s2Wzdix24HthanQpW6PNPtbzZkizAq61/1otzMEqQ7XqQFPcRb3CtS5MyvGZ6
	OoTA3Kzn0LyenYNtg9HWNLG3v3xiIMRbbjpdjpPUAP8CAmuOS8pkzgBFBq+CS8afFejzYik+cJA
	vtuHSyPfd+QFrVYw9voiFh6Md7k3C7xxNX56s7WgLVgIprwY3g57VZNFlre84nN5Lj+jO4Lmn+W
	GYBMMXf4Pm0MChVxt6YbtcccB9dchtvy7oOkdFG0kz4Ca+WyRxyz3/d47fVYk4l+4hcLHJCcdDR
	+SCEetQZZE713FTEqLlhXUtTyqiX9Fu0iWWlvOA1/Ga1nxEpICJ2FAhvY6FVYqhSX1sJRP8ekOt
	eV3ufqjxA=
X-Received: by 2002:a17:902:d4ca:b0:2c2:21e9:5a7d with SMTP id d9443c01a7336-2c742b68fb0mr74488095ad.34.1782050386382;
        Sun, 21 Jun 2026 06:59:46 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f9026sm48518445ad.53.2026.06.21.06.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 06:59:45 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Steve Wise <larrystevenwise@gmail.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] nvme-rdma: avoid stale device wrapper in remove_one
Date: Sun, 21 Jun 2026 21:59:39 +0800
Message-Id: <20260621135939.2658295-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260621_065947_783194_5E4D7FC5 
X-CRM114-Status: GOOD (  15.00  )
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

nvme_rdma_remove_one() walks nvme_rdma_ctrl_list under
nvme_rdma_ctrl_mutex, but it identifies matching controllers by reading
ctrl->device->dev.  The mutex only protects controller list membership.
ctrl->device is a cached copy of queue 0's nvme_rdma_device, and that
wrapper is refcounted by queue lifetime.

The buggy scenario involves two paths, with each column showing the order
within that path:

RDMA remove callback:                Controller error recovery:
  1. enter nvme_rdma_remove_one()    1. run nvme_rdma_error_recovery_work()
  2. walk nvme_rdma_ctrl_list        2. tear down the admin queue
  3. read ctrl->device->dev          3. drop the final queue device ref
                                      4. free the nvme_rdma_device wrapper

Fix this by caching the ib_device identity in the controller when the
admin queue is configured.  The remove callback can then compare the
cached pointer value against the ib_device being removed without
dereferencing the queue-owned nvme_rdma_device wrapper.  Keep the delete
workqueue flush conditional on actually matching a controller.

Validation reproduced this kernel report:
BUG: KASAN: slab-use-after-free in nvme_rdma_remove_one+0x281/0x2c0 [nvme_rdma]

Call Trace:
 <TASK>
 dump_stack_lvl+0x66/0xa0
 print_report+0xce/0x630
 ? nvme_rdma_remove_one+0x281/0x2c0 [nvme_rdma]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __virt_addr_valid+0x20d/0x410
 ? nvme_rdma_remove_one+0x281/0x2c0 [nvme_rdma]
 kasan_report+0xe0/0x110
 ? nvme_rdma_remove_one+0x281/0x2c0 [nvme_rdma]
 nvme_rdma_remove_one+0x281/0x2c0 [nvme_rdma]
 remove_client_context+0xa9/0xf0 [ib_core]
 disable_device+0x12d/0x240 [ib_core]
 ? __pfx_disable_device+0x10/0x10 [ib_core]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __mutex_unlock_slowpath+0x147/0x900
 __ib_unregister_device+0x26f/0x460 [ib_core]
 ib_unregister_device_and_put+0x55/0x70 [ib_core]
 nldev_dellink+0x29e/0x3c0 [ib_core]
 ? unwind_next_frame+0x6e3/0x2190
 ? __pfx_nldev_dellink+0x10/0x10 [ib_core]
 ? lock_acquire+0x2b8/0x2f0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? cap_capable+0x196/0x330
 ? __pfx_down_read+0x10/0x10
 rdma_nl_rcv_msg+0x2db/0x5f0 [ib_core]
 ? __pfx_rdma_nl_rcv_msg+0x10/0x10 [ib_core]
 rdma_nl_rcv_skb.constprop.0.isra.0+0x222/0x380 [ib_core]
 ? __pfx_rdma_nl_rcv_skb.constprop.0.isra.0+0x10/0x10 [ib_core]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? netlink_deliver_tap+0x150/0xac0
 netlink_unicast+0x47c/0x790
 ? __pfx_netlink_unicast+0x10/0x10
 netlink_sendmsg+0x767/0xc30
 ? __pfx_netlink_sendmsg+0x10/0x10
 ? lock_release+0x1e0/0x280
 __sys_sendto+0x339/0x390
 ? __pfx___sys_sendto+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 __x64_sys_sendto+0xe0/0x1c0
 ? do_syscall_64+0x81/0x6a0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? trace_hardirqs_on+0x18/0x160
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Allocated by task 436:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0xaa/0xb0
 nvme_rdma_cm_handler+0xcbc/0x2914 [nvme_rdma]
 cma_cm_event_handler+0xb2/0x390 [rdma_cm]
 addr_handler+0x199/0x2b0 [rdma_cm]
 process_one_req+0x113/0x650 [ib_core]
 process_one_work+0x8d0/0x1870
 worker_thread+0x575/0xf80
 kthread+0x2e7/0x3c0
 ret_from_fork+0x576/0x810
 ret_from_fork_asm+0x1a/0x30

Freed by task 436:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x5f/0x80
 kfree+0x307/0x580
 nvme_rdma_free_dev+0x16d/0x260 [nvme_rdma]
 nvme_rdma_free_queue+0x6d/0x90 [nvme_rdma]
 nvme_rdma_error_recovery_work+0x7f/0x110 [nvme_rdma]
 process_one_work+0x8d0/0x1870
 worker_thread+0x575/0xf80
 kthread+0x2e7/0x3c0
 ret_from_fork+0x576/0x810
 ret_from_fork_asm+0x1a/0x30

Fixes: e87a911fed07 ("nvme-rdma: use ib_client API to detect device removal")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 drivers/nvme/host/rdma.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6909e3542794..7c4a1e5f4991 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -116,6 +116,7 @@ struct nvme_rdma_ctrl {
 
 	struct blk_mq_tag_set	admin_tag_set;
 	struct nvme_rdma_device	*device;
+	struct ib_device	*ib_device;
 
 	u32			max_fr_pages;
 
@@ -788,6 +789,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		return error;
 
 	ctrl->device = ctrl->queues[0].device;
+	WRITE_ONCE(ctrl->ib_device, ctrl->device->dev);
 	ctrl->ctrl.numa_node = ibdev_to_node(ctrl->device->dev);
 
 	/* T10-PI support */
@@ -2372,31 +2374,20 @@ static struct nvmf_transport_ops nvme_rdma_transport = {
 static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 {
 	struct nvme_rdma_ctrl *ctrl;
-	struct nvme_rdma_device *ndev;
 	bool found = false;
 
-	mutex_lock(&device_list_mutex);
-	list_for_each_entry(ndev, &device_list, entry) {
-		if (ndev->dev == ib_device) {
-			found = true;
-			break;
-		}
-	}
-	mutex_unlock(&device_list_mutex);
-
-	if (!found)
-		return;
-
 	/* Delete all controllers using this device */
 	mutex_lock(&nvme_rdma_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_rdma_ctrl_list, list) {
-		if (ctrl->device->dev != ib_device)
+		if (READ_ONCE(ctrl->ib_device) != ib_device)
 			continue;
+		found = true;
 		nvme_delete_ctrl(&ctrl->ctrl);
 	}
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
-	flush_workqueue(nvme_delete_wq);
+	if (found)
+		flush_workqueue(nvme_delete_wq);
 }
 
 static struct ib_client nvme_rdma_ib_client = {
-- 
2.43.0


