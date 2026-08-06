Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3D5C5AC9E
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 15:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=InNr4PZQvcLwSs9Fl1djJex86YGYmJ3a36sRvxyk8lg=; b=I0cLoAogQ/O0IHWiVb8piSt8SB
	DWOssFO4P1N2OLZT3yYs7LnsQF7SPn9zWbCpQDz6rjSV7WjdjAe5pRcYwV9vhgDECurPMLRDVe9jm
	pfhtqJUd9bxIlFK4tKYkrdoEtOQzQCv482gg7zF4dQOUI95ApQCf5BTO9b2Vv3FZ7rTdZLGahAzam
	FWyr3iPwplb4MhoKvxcRZ6QEuOXkiMTa8sWbRMqveHDLp81d7AROtgE3McJVz6OQYNsQlZk3pDsO7
	+W0p9cv3+1TRo8kw3+6jPnUaJzU6s4CkX8ha7esfzCKUaB+5a+uvCwQiaa3CiyLKQd/c4EVX/lm76
	rFmj7DOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ws01i-000000065Qf-0iOZ;
	Thu, 06 Aug 2026 15:28:58 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ws01Y-000000065Dw-2oTO;
	Thu, 06 Aug 2026 15:28:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ABA1B60AB9;
	Thu,  6 Aug 2026 15:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55018C2BCB9;
	Thu,  6 Aug 2026 15:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786030127;
	bh=AuhuSDb8wKQjc4FtIZptQtimvxpq2uj7/79koaO+DOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nsXerGy/+XEC9jM/LAsZsKFn9Xr9oCqsyJS4kh+1DNCaZhNI5P/8wE//hdPX3Pn7W
	 ItOTv/NXfHHmR9qhMJYoSUBAz2Cqtvyne9fRAuwEHmmz9GZHZ5KJuZLZbvORjMEio1
	 EHmg5Tohbh3M1rUmbGw1t6dKLkDUMYTIyeX6FcPMdTJcf6ZHGl8/rh51K4zLxzgFTD
	 8n8qI0CRieF9YrKIeEIZA4LuPllBNIVKLP4nQ1A9g3W8V3U+bJatTCJqhJtWtQmsr4
	 TE9EHuKM/OesS/uiHFB8QGNLHfU4MtxIoQ0OmdCeGSteALWCLj/igRTzDj7b0X3UAY
	 WiqM3ORm6r5HQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4B8C56205;
	Thu,  6 Aug 2026 15:28:47 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Thu, 06 Aug 2026 17:27:33 +0200
Subject: [PATCH 1/6] nvme-apple: Destroy the admin queue on removal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-nvme-fwabi-v1-1-bde19ce8db04@kernel.org>
References: <20260806-b4-nvme-fwabi-v1-0-bde19ce8db04@kernel.org>
In-Reply-To: <20260806-b4-nvme-fwabi-v1-0-bde19ce8db04@kernel.org>
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sven Peter <sven@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5378; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=AuhuSDb8wKQjc4FtIZptQtimvxpq2uj7/79koaO+DOU=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ1bJCvXMxIjA6y8zzr5m9hWLkhSPWbX2ZeDx6y2Lyi1sV
 wpu817QUcrCIMbFICumyLJ9v73pk4dvBJduuvQeZg4rE8gQBi5OAZhITzIjw8/PR3/+2hfyOuLR
 In2JucL/butoM5V8CFQ4HSe/dtfB/hMMf2W6rYw+rZtVNv/k/V8P82KVNk094xE5LdZh4kRlH9a
 e/awA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407
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

The admin queue is allocated with blk_mq_alloc_queue() but never
destroyed. nvme_free_ctrl() only drops the last reference and
blk_mq_exit_queue() and blk_sync_queue() never run: the hctx is never
moved to q->unused_hctx_list and the timeout timer and work stay armed on
a queue that is about to be freed which will eventually oops inside
blk_mq_timeout_work().

This can only be triggered when the controller fails to come up and is
then immediately torn down again which is why no one ever ran into this
before.

Let's just copy what the pcie driver does: unquiesce and destroy the admin
queue before nvme_uninit_ctrl().

With this the following WARN followed by a panic no longer happens:

  WARNING: block/blk-mq.c:4390 at blk_mq_release+0x194/0x238, CPU#4: kworker/u34:4/119
  CPU: 4 UID: 0 PID: 119 Comm: kworker/u34:4 Not tainted 7.2.0-rc1-dirty #248 PREEMPT
  Hardware name: Apple Mac mini (M1, 2020) (DT)
  Workqueue: nvme-wq apple_nvme_remove_dead_ctrl_work
  pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
  pc : blk_mq_release+0x194/0x238
  lr : blk_mq_release+0x58/0x238
  sp : ffffc000833a3b50
  x29: ffffc000833a3b50 x28: ffff80001d0450f8 x27: ffff800020c95200
  x26: 0000000000000088 x25: 0000000000000000 x24: ffff800020f36805
  x23: 0000000000000000 x22: ffffc00081a86878 x21: ffff800020be9c60
  x20: 0000000000000000 x19: ffff800022501698 x18: 000000000000000a
  x17: 7365757165722066 x16: 666f7265776f7020 x15: 0000000000000000
  x14: 0000000000000028 x13: 0000000000004def x12: 0000000000000003
  x11: 0000000000000000 x10: 0000000000000000 x9 : ffffc000805b4fc8
  x8 : ffffc00081915820 x7 : ffffc00081c4f3c8 x6 : 0000000000000001
  x5 : 0000000000000004 x4 : ffff800022498d80 x3 : ffffc000833a3b14
  x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff800022501698
  Call trace:
   blk_mq_release+0x194/0x238 (P)
   blk_put_queue+0x8c/0xf0
   nvme_free_ctrl+0x4c/0x260
   device_release+0x44/0x128
   kobject_put+0xa0/0x120
   put_device+0x1c/0x40
   nvme_uninit_ctrl+0x48/0x60
   apple_nvme_remove+0x54/0xb0
   platform_remove+0x28/0x40
   device_remove+0x54/0x98
   device_release_driver_internal+
   device_release_driver+0x20/0x38
   apple_nvme_remove_dead_ctrl_wor
   process_one_work+0x1f4/0x770
   worker_thread+0x1b8/0x360
   kthread+0x140/0x160
   ret_from_fork+0x10/0x20
  irq event stamp: 448
  hardirqs last  enabled at (447):in_unlock_irqrestore+0x74/0x80
  hardirqs last disabled at (448): [<ffffc000811cf5c0>] el1_brk64+0x20/0x60
  softirqs last  enabled at (0): [ess+0xb28/0x2698
  softirqs last disabled at (0): [<0000000000000000>] 0x0
  ---[ end trace 0000000000000000
  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  Mem abort info:
    ESR = 0x0000000096000005
    EC = 0x25: DABT (current EL),
    SET = 0, FnV = 0
    EA = 0, S1PTW = 0
    FSC = 0x05: level 1 translation fault
  Data abort info:
    ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
    CM = 0, WnR = 0, TnD = 0, TagA
    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
  [0000000000000000] user address
  Internal error: Oops: 0000000096000005 [#1]  SMP
  CPU: 7 UID: 0 PID: 54 Comm: kwor          7.2.0-rc1-dirty #248PREEMPT
  Tainted: [W]=WARN
  Hardware name: Apple Mac mini (M1, 2020) (DT)
  Workqueue: kblockd blk_mq_timeou
  pstate: 01400005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
  pc : percpu_ref_tryget_many.cons
  lr : percpu_ref_tryget_many.constprop.0+0xc0/0x168
  sp : ffffc000829cbce0
  x29: ffffc000829cbce0 x28: ffff800020be9f48 x27: ffff800013e503c0
  x26: 0000000000000108 x25: 000009c05
  x23: 0000000000000000 x22: ffffc000819f5000 x21: ffff800020be9f48
  x20: ffff8001deda4808 x19: ffff8000a
  x17: 00000000580e1fac x16: ffffc00082bbbb7c x15: 0000000000000000
  x14: 0000000000000028 x13: 000000001
  x11: 0000000000000000 x10: 0000000000000000 x9 : ffffc000829cbc20
  x8 : ffffc00081915820 x7 : ffffc0001
  x5 : ffff80001ca77d08 x4 : 0000000000000000 x3 : ffff80001ca77cb8
  x2 : 0000000000000000 x1 : 000000007
  Call trace:
   percpu_ref_tryget_many.constpro
   blk_mq_timeout_work+0x48/0x298
   process_one_work+0x1f4/0x770
   worker_thread+0x1b8/0x360
   kthread+0x140/0x160
   ret_from_fork+0x10/0x20
  Code: 91282000 97ed44b2 17ffffd2
  ---[ end trace 0000000000000000 ]---

Fixes: 5bd2927aceba ("nvme-apple: Add initial Apple SoC NVMe driver")
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/nvme/host/apple.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index be3b91b43ea5..321502847a2c 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1636,6 +1636,15 @@ static void apple_nvme_remove(struct platform_device *pdev)
 	nvme_stop_ctrl(&anv->ctrl);
 	nvme_remove_namespaces(&anv->ctrl);
 	apple_nvme_disable(anv, true);
+	if (anv->ctrl.admin_q && !blk_queue_dying(anv->ctrl.admin_q)) {
+		/*
+		 * If the controller was reset during removal, it's possible
+		 * user requests may be waiting on a stopped queue. Start the
+		 * queue to flush these to completion.
+		 */
+		nvme_unquiesce_admin_queue(&anv->ctrl);
+		blk_mq_destroy_queue(anv->ctrl.admin_q);
+	}
 	nvme_uninit_ctrl(&anv->ctrl);
 
 	if (apple_rtkit_is_running(anv->rtk)) {

-- 
2.55.0



