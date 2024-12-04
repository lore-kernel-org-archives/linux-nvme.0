Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59689E7716F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2024 23:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PV0AoSzoNtSmKdV92PAwJX1psTojhg2rlDThBvxNVPI=; b=RV0M40nvwZwAzWR+mn5QSJHF4T
	EnhjDYQkXRTHrYjCeHRPpdN2e6LFoLkAx8zGiTb1D4o8dghLWBkUxZ5WmpCJxuMGid2jo/yjwAA/n
	ZXxpVaLhI6imvaNFukF9WSQHgQgtCV4WxBcP+XOOsvjMMCzEtcRatKrsLL1oiiYTGBYQ4l7v4Rce8
	Yy8efG6KWx+8HuPVCPOV1ILs7IdinNgjfc39YMqP9xxcAiT5mHf0T7KmnaG+EUvxtTGNEuO5oPfVl
	O6mgI730NSzfCo7mDxeuUF+EzHgmIyCPXy8T488TKZytdc6fPacdDJqqKs+kYxgLqpywlOWn2YeAV
	sfsZV+pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIz1h-0000000EDcq-3VhZ;
	Wed, 04 Dec 2024 23:43:25 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIytY-0000000EBHZ-0EBe
	for linux-nvme@lists.infradead.org;
	Wed, 04 Dec 2024 23:35:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9299D5C6B57;
	Wed,  4 Dec 2024 23:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFE7C4CECD;
	Wed,  4 Dec 2024 23:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355299;
	bh=mySt0fYMqgoez91XtSSxwO2AuX+R3na3yJ+LTPWcMEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mQv4yN00md77DfZqUFG78A4aMF9oD9uhbpqgA1IVjwD6PLnANmt5SPHP/ufY3zjZz
	 8R653Wjo4bFvQTB563Bz90MS2y2/3i7aTwNKaampurPBFbI7vtwhnzv0tW89Qvj3fo
	 dEmXDg1p4jtHjSbZL+PXu+3KD17PleIYp4cb5RCTQGyiXU3REY1msuxzRN74qZOFU8
	 DXux5G/ahm54gXuDKjAH1QVKF2sE0f7xCvh05IzVLas3fDipe6Xnnl9rwbulJrmlXp
	 mSUS+8F/VSEn38QBh8i8yRQy+kYciOVJunyKlgQN4F3rsMegI3fKxjhhFilsGH5VTq
	 YYqvK1Tvza8TQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 4/8] Revert "nvme: make keep-alive synchronous operation"
Date: Wed,  4 Dec 2024 17:23:20 -0500
Message-ID: <20241204222334.2249307-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204222334.2249307-1-sashal@kernel.org>
References: <20241204222334.2249307-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_153500_177223_5B639D19 
X-CRM114-Status: GOOD (  13.36  )
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

[ Upstream commit 84488282166de6b6760ada8030e87aaa08bce3aa ]

This reverts commit d06923670b5a5f609603d4a9fee4dec02d38de9c.

It was realized that the fix implemented to contain the race condition
among the keep alive task and the fabric shutdown code path in the commit
d06923670b5ia ("nvme: make keep-alive synchronous operation") is not
optimal. The reason being keep-alive runs under the workqueue and making
it synchronous would waste a workqueue context.
Furthermore, we later found that the above race condition is a regression
caused due to the changes implemented in commit a54a93d0e359 ("nvme: move
stopping keep-alive into nvme_uninit_ctrl()"). So we decided to revert the
commit d06923670b5a ("nvme: make keep-alive synchronous operation") and
then fix the regression.

Link: https://lore.kernel.org/all/196f4013-3bbf-43ff-98b4-9cb2a96c20c2@grimberg.me/
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 855b42c92284d..e44eca6b3ebed 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1303,9 +1303,10 @@ static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 	queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
 }
 
-static void nvme_keep_alive_finish(struct request *rq,
-		blk_status_t status, struct nvme_ctrl *ctrl)
+static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
+						 blk_status_t status)
 {
+	struct nvme_ctrl *ctrl = rq->end_io_data;
 	unsigned long rtt = jiffies - (rq->deadline - rq->timeout);
 	unsigned long delay = nvme_keep_alive_work_period(ctrl);
 	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
@@ -1322,17 +1323,20 @@ static void nvme_keep_alive_finish(struct request *rq,
 		delay = 0;
 	}
 
+	blk_mq_free_request(rq);
+
 	if (status) {
 		dev_err(ctrl->device,
 			"failed nvme_keep_alive_end_io error=%d\n",
 				status);
-		return;
+		return RQ_END_IO_NONE;
 	}
 
 	ctrl->ka_last_check_time = jiffies;
 	ctrl->comp_seen = false;
 	if (state == NVME_CTRL_LIVE || state == NVME_CTRL_CONNECTING)
 		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
+	return RQ_END_IO_NONE;
 }
 
 static void nvme_keep_alive_work(struct work_struct *work)
@@ -1341,7 +1345,6 @@ static void nvme_keep_alive_work(struct work_struct *work)
 			struct nvme_ctrl, ka_work);
 	bool comp_seen = ctrl->comp_seen;
 	struct request *rq;
-	blk_status_t status;
 
 	ctrl->ka_last_check_time = jiffies;
 
@@ -1364,9 +1367,9 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	nvme_init_request(rq, &ctrl->ka_cmd);
 
 	rq->timeout = ctrl->kato * HZ;
-	status = blk_execute_rq(rq, false);
-	nvme_keep_alive_finish(rq, status, ctrl);
-	blk_mq_free_request(rq);
+	rq->end_io = nvme_keep_alive_end_io;
+	rq->end_io_data = ctrl;
+	blk_execute_rq_nowait(rq, false);
 }
 
 static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
-- 
2.43.0


