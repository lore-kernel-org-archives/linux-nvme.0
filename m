Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B86CF5395
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 14:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rm+VuZon7sE688NGAJIq4hX9NaHnBpkPiowcg2G3QjQ=; b=bKzRippz3qysGW92EV3bVVfxHz
	6IXVGsKYPU/qORjKTbyDrJ/91o2FZPArvaowlEvDqEe+A4xDlLGUU5pdvHXULKZ5Ykr90hWN10Act
	00SrrbZ+pdo8p14ccZUQVzld6rthDYiYytXfQRV7+/2gx7aa7+7wzDrInL5h86VqJuERBC6Mr1c6N
	Jloj7IWkzVVIkHrpAPexv0z3Z9x1RsLCo7EKsDy3OSj580KHRSenxgKJOpVionmfSiSCbgQnerpkT
	GX1PoNFoWUStUwi78pkeoD57rCgRtiSm/ZsRbTtCpZv4a+UcYoMz+QGKkbiWU09tozxrx9MAWz+Op
	SwjlR7ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3cPk-0000000EifU-1QRY;
	Wed, 23 Oct 2024 14:32:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3cOx-0000000EiF6-3dEr
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 14:31:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 972F95C03EC;
	Wed, 23 Oct 2024 14:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA93CC4CEE5;
	Wed, 23 Oct 2024 14:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693914;
	bh=GZECt8n81F8tfUJhWMZax9AwcF4XLT1HRKaEXXmOtXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iU/CFC7eD2S/a0Ut5PQOjYSc5IUSPwGaKuQW0htzPgogipSKf8AHW75t9znC+XcK6
	 vOLo91qgGf9gc6VkAf0Er9s58RHkBTrrNz1MW+7z5i37RFnXGJKL3ggq4hy137klhS
	 rNK+JaaRCKKxM3ZC0ZSsgQZcBvhtISwCXin/2JkwT2Qt4c9erZCmm7csfS9ppkSHpa
	 YGyK0QEJYcLNYVesBpZMpIpX3C8E7ukDUQRy/mJsRl7xW5aYFeu0isyylwWkCAJ29r
	 hEdqaVslVl7sA4KY22ARc/par4OU9LA0SakD6ivpyiGryHR6KNsJsUXp4vdr+7gefN
	 7lk56BpkIxGnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 23/23] nvme: make keep-alive synchronous operation
Date: Wed, 23 Oct 2024 10:31:07 -0400
Message-ID: <20241023143116.2981369-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143116.2981369-1-sashal@kernel.org>
References: <20241023143116.2981369-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_073156_055082_5A96835C 
X-CRM114-Status: GOOD (  16.83  )
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

From: Nilay Shroff <nilay@linux.ibm.com>

[ Upstream commit d06923670b5a5f609603d4a9fee4dec02d38de9c ]

The nvme keep-alive operation, which executes at a periodic interval,
could potentially sneak in while shutting down a fabric controller.
This may lead to a race between the fabric controller admin queue
destroy code path (invoked while shutting down controller) and hw/hctx
queue dispatcher called from the nvme keep-alive async request queuing
operation. This race could lead to the kernel crash shown below:

Call Trace:
    autoremove_wake_function+0x0/0xbc (unreliable)
    __blk_mq_sched_dispatch_requests+0x114/0x24c
    blk_mq_sched_dispatch_requests+0x44/0x84
    blk_mq_run_hw_queue+0x140/0x220
    nvme_keep_alive_work+0xc8/0x19c [nvme_core]
    process_one_work+0x200/0x4e0
    worker_thread+0x340/0x504
    kthread+0x138/0x140
    start_kernel_thread+0x14/0x18

While shutting down fabric controller, if nvme keep-alive request sneaks
in then it would be flushed off. The nvme_keep_alive_end_io function is
then invoked to handle the end of the keep-alive operation which
decrements the admin->q_usage_counter and assuming this is the last/only
request in the admin queue then the admin->q_usage_counter becomes zero.
If that happens then blk-mq destroy queue operation (blk_mq_destroy_
queue()) which could be potentially running simultaneously on another
cpu (as this is the controller shutdown code path) would forward
progress and deletes the admin queue. So, now from this point onward
we are not supposed to access the admin queue resources. However the
issue here's that the nvme keep-alive thread running hw/hctx queue
dispatch operation hasn't yet finished its work and so it could still
potentially access the admin queue resource while the admin queue had
been already deleted and that causes the above crash.

This fix helps avoid the observed crash by implementing keep-alive as a
synchronous operation so that we decrement admin->q_usage_counter only
after keep-alive command finished its execution and returns the command
status back up to its caller (blk_execute_rq()). This would ensure that
fabric shutdown code path doesn't destroy the fabric admin queue until
keep-alive request finished execution and also keep-alive thread is not
running hw/hctx queue dispatch operation.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e25206c7de80c..b3c5460c6d768 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1178,10 +1178,9 @@ static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 			   nvme_keep_alive_work_period(ctrl));
 }
 
-static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
-						 blk_status_t status)
+static void nvme_keep_alive_finish(struct request *rq,
+		blk_status_t status, struct nvme_ctrl *ctrl)
 {
-	struct nvme_ctrl *ctrl = rq->end_io_data;
 	unsigned long flags;
 	bool startka = false;
 	unsigned long rtt = jiffies - (rq->deadline - rq->timeout);
@@ -1199,13 +1198,11 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 		delay = 0;
 	}
 
-	blk_mq_free_request(rq);
-
 	if (status) {
 		dev_err(ctrl->device,
 			"failed nvme_keep_alive_end_io error=%d\n",
 				status);
-		return RQ_END_IO_NONE;
+		return;
 	}
 
 	ctrl->ka_last_check_time = jiffies;
@@ -1217,7 +1214,6 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (startka)
 		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
-	return RQ_END_IO_NONE;
 }
 
 static void nvme_keep_alive_work(struct work_struct *work)
@@ -1226,6 +1222,7 @@ static void nvme_keep_alive_work(struct work_struct *work)
 			struct nvme_ctrl, ka_work);
 	bool comp_seen = ctrl->comp_seen;
 	struct request *rq;
+	blk_status_t status;
 
 	ctrl->ka_last_check_time = jiffies;
 
@@ -1248,9 +1245,9 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	nvme_init_request(rq, &ctrl->ka_cmd);
 
 	rq->timeout = ctrl->kato * HZ;
-	rq->end_io = nvme_keep_alive_end_io;
-	rq->end_io_data = ctrl;
-	blk_execute_rq_nowait(rq, false);
+	status = blk_execute_rq(rq, false);
+	nvme_keep_alive_finish(rq, status, ctrl);
+	blk_mq_free_request(rq);
 }
 
 static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
-- 
2.43.0


