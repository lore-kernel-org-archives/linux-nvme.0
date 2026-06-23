Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0FBCDB46F
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2026 00:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7PTFSvARfP+izVQxaR6V7pBafvpomsDJq67jAqCb+Bg=; b=OlmdJmd+8mBcZCaxjqI8P8Na0n
	yF/fWSCBOR6PAXu9icf1kIrC9ERSAKaE8FrRUqKTTUWElfSv7a3/WYUFqCLrXMKZBzdXo/f3D1BVr
	I1m80mstAfK1r4MDHWQSSN7fUhlxq8VxTDrz2CdIywxVX46WxJhWZP84SfWPc1pkiuiIJikaLpM/s
	YVEgC2daCFrXAuHjBivsZa1y8Alwy/77oL/dbD7fUciv++1oQQu2yg2AXGGhu0oob/uR2Hiyo8jDE
	RSPj8Hup6GunpPTLJWdoUZdF4/vrXymxTzcRQDzcCXmNwDyh7A1nShKR0RTAF3G9s3H4l4nNpPNGV
	LD8lL5Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbovT-00000005Um2-3JWs;
	Tue, 23 Jun 2026 00:23:39 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbovQ-00000005UlU-0ily
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jun 2026 00:23:38 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2c77d52bec4so2384355ad.1
        for <linux-nvme@lists.infradead.org>; Mon, 22 Jun 2026 17:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782174215; x=1782779015; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7PTFSvARfP+izVQxaR6V7pBafvpomsDJq67jAqCb+Bg=;
        b=dXvc9xQ9RMpwu6a5IJvrWS/Ve9oa6cSZ3oOT2O3HX6+FTHgI+IOfOVY1CkPhSy7WD0
         0lhCJXBe2WRccIymQiALLQ6YqVPDAyWWV8TazDnEhFv0cXz11m+u8IRRY+tGe+oULwY9
         aqtMX/ja/0hpRC/WuVgvW77XBHeaOdhnrjerJvYfG6VAQpk5epouNEf8WeWpHqEODSDi
         99kyTaNsM8S4Dn0Q9tMzfTmmZK5uxEfMepFuwoxU/ZPB5tYhS2g6nLqQ9QUpJdycrsNF
         XoNujE7uqm6lQ2QIoAmCqnspKwL9oZLEZ8qQYyqNxO96Kqv5uVsGSDnkbaFzsl/sea5X
         trVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782174215; x=1782779015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PTFSvARfP+izVQxaR6V7pBafvpomsDJq67jAqCb+Bg=;
        b=POgzsBUp1y0YCyIsOwvZypRyatch4hg7aQrIqjQCLFMaWkVvPd7Vm+sLx6AmvTEBRb
         oRYbJLCzhKHEIovv0utRHhUhaITDv/oVYdS/VamXkDoOG2R0EnLsGphFiA3OR15Gklt+
         8Wm0i9l4BnoOA9/GpveykReJptWXczfXs2074raHXs9zSKoP2BVC96QzkwF321d10iDA
         8xnma+1WaLzxe0Vv1d0fHhHOaJkOOeHDLRy7JrQEEgjO+Q9lmMSDSTk6RHVdrOpHAKDw
         PQSQ8VVMlczvriKegZ6ainuXJfJXz2an9hwspxL9KQj2WsZ5S2ZqFzGAJ8k2OAgxNAdd
         z06Q==
X-Gm-Message-State: AOJu0YylHh7H8NUN1y//t4HyY8K6witOy2klkgYj2M2d0Hzqa1Fd0KJB
	+wAZc2R4beAvMP1FPsHxKg5HPw4HSDcz+QMPXrj4fYcpS24ZtY0qi4d5
X-Gm-Gg: AfdE7clycvOvObsqi5F3r25Og2lK0HKuPvu62C6zd4UBUHyKgGiqmaDi5zpSL6oxA5y
	G0TKTWPaT+5ckWTKL30vVzSFKy+1krETWX05jXnHphDBKCQX6mjwWtlqAxk4I18aHid/BNszxss
	MqxKocmjpwBmJNVCp52HBfz9uUY1HkvzzfaxTIq+sWAAECEpLPJofDoO55l/uQgj1Pn0P8Q1L7D
	hTbLIZU+cYWcKX/ZRZHXbCuLeh49wZROhbjVSZtyZi7jl0s3Duy5ock1K94TMv4AsN72Hv/3FDu
	Atb7Y9cHgBoyAIvEJlIMSNUdSMzbiKjXnf7od+WdIxI5MxIF995K6wQ6DUBih0M6tgoTnqGbPkt
	nINdRCc9Zmqr4gIRJlYItyjngRfb6mhEvpZ2sWgQd7g1kmLwasTAa9/bTgUpHHHuEHJjmKtndgJ
	jhAot60go=
X-Received: by 2002:a17:903:946:b0:2c0:fa52:1c47 with SMTP id d9443c01a7336-2c7c400fd0bmr10594565ad.25.1782174215113;
        Mon, 22 Jun 2026 17:23:35 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436f7e0asm102210025ad.30.2026.06.22.17.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 17:23:34 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	Steve Wise <larrystevenwise@gmail.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v3] nvme-rdma: pin device wrapper in remove_one
Date: Tue, 23 Jun 2026 08:23:29 +0800
Message-Id: <20260623002329.3880334-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_172336_217399_9FC4691D 
X-CRM114-Status: GOOD (  14.80  )
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

nvme_rdma_remove_one() first verifies that an ib_device has an
nvme_rdma_device on device_list, but it drops device_list_mutex before it
walks nvme_rdma_ctrl_list. It then identifies matching controllers by
dereferencing ctrl->device->dev while holding only nvme_rdma_ctrl_mutex.

ctrl->device is a cached copy of queue 0's nvme_rdma_device. Queue
teardown owns that wrapper's kref, so controller list membership does not
keep the wrapper alive.

The buggy scenario involves two paths, with each column showing the order
within that path:

RDMA remove callback:                Controller error recovery:
  1. find ndev on device_list        1. run nvme_rdma_error_recovery_work()
  2. drop device_list_mutex          2. tear down the admin queue
  3. walk nvme_rdma_ctrl_list        3. drop the final queue device ref
  4. read ctrl->device->dev          4. free the nvme_rdma_device wrapper

Fix this by taking a temporary reference to the matching nvme_rdma_device
while still holding device_list_mutex. The controller walk can then
compare ctrl->device directly with the pinned wrapper without
dereferencing a queue-owned object that might have been freed. Release the
temporary reference after the delete workqueue flush.

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
v3:
Removed the temporary iterator and goto-based lookup in
nvme_rdma_remove_one().
Preserved the original found-based device-list flow while pinning the
matched nvme_rdma_device.

v2:
Reworked the fix to take a temporary nvme_rdma_device reference during the
device_list lookup instead of adding a cached ib_device field to struct
nvme_rdma_ctrl.
Changed the controller-list match to compare ctrl->device against the pinned
wrapper while preserving the existing delete workqueue flush behavior.

 drivers/nvme/host/rdma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6909e3542794..663e38540073 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2378,7 +2378,7 @@ static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 	mutex_lock(&device_list_mutex);
 	list_for_each_entry(ndev, &device_list, entry) {
 		if (ndev->dev == ib_device) {
-			found = true;
+			found = nvme_rdma_dev_get(ndev);
 			break;
 		}
 	}
@@ -2390,13 +2390,14 @@ static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 	/* Delete all controllers using this device */
 	mutex_lock(&nvme_rdma_ctrl_mutex);
 	list_for_each_entry(ctrl, &nvme_rdma_ctrl_list, list) {
-		if (ctrl->device->dev != ib_device)
+		if (ctrl->device != ndev)
 			continue;
 		nvme_delete_ctrl(&ctrl->ctrl);
 	}
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
 	flush_workqueue(nvme_delete_wq);
+	nvme_rdma_dev_put(ndev);
 }
 
 static struct ib_client nvme_rdma_ib_client = {
-- 
2.43.0


