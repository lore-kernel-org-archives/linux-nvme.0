Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2B1C433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 03:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ayrnYu7xAqKNsYJn/4yLotE7DaelTIhvopEludcEbh0=; b=bIykapx6STmJI9tWfHuhZS73D5
	y4kCVnyPIabFjieiWgTVwxWd03+15P5bmTcTXt1tyXBsBzwbA+M9odePqIkr7bWacjGtXLpSBNqNn
	o/FhxPZ6MnxFCZZds/qTYoXj7C2/Fuu7JbgtisBH9PnrKpMMdCPB9wkhPyOVzHY46a+tXSaoY1fgO
	pbtMDm/JWeNrFn2N/F17BiMgKJeGgnyjmfx2dB5GRjMZrZ++i5k4GqVHyeOp3ZLW2C/hAqZRV6SnW
	RM8AYHnFIHD+d01o2A28Xl5DzcUC9ziQnwS9f4HJD6PyjPIDabMXdwUgifHjLSxWDjSwRYBygpfan
	PUzqUb+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooyfj-00Bkp8-Tn; Sun, 30 Oct 2022 03:07:39 +0000
Received: from spam.zju.edu.cn ([61.164.42.155] helo=zju.edu.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooyfU-00Bkhs-Uf
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 03:07:27 +0000
Received: from localhost.localdomain (unknown [10.14.30.251])
	by mail-app3 (Coremail) with SMTP id cC_KCgAXlrpJ6l1jv9B1CA--.27265S5;
	Sun, 30 Oct 2022 11:07:19 +0800 (CST)
From: Jinlong Chen <nickyc975@zju.edu.cn>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	nickyc975@zju.edu.cn
Subject: [PATCH v2 3/3] block: hide back blk_freeze_queue_start and export its blk-mq alias
Date: Sun, 30 Oct 2022 11:06:48 +0800
Message-Id: <3f2b51cc7f5c21e49bfa089e594cb203a4015183.1667098953.git.nickyc975@zju.edu.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1667098953.git.nickyc975@zju.edu.cn>
References: <cover.1667098953.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cC_KCgAXlrpJ6l1jv9B1CA--.27265S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr1xCw1UZF4rGF45Ary5Arb_yoW7Kry8pF
	ZxXa13Aw10gr4UXrW8Jw47Zr9xKw4vg347C3yftryYvrn8Kas3ZF17A3W5XF48ArWkCFs8
	ArWDKrsrCr18JrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvq1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
	AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI
	7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgUTB1ZdtcKOnAABs8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221029_200725_289645_B65BDBE2 
X-CRM114-Status: GOOD (  14.53  )
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

blk_freeze_queue_start is used internally for universal queue draining and
externally for blk-mq specific queue freezing. Keep the non-blk-mq name
private and export a blk-mq alias to users.

Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
---
 block/blk-core.c              | 13 +++++++++++++
 block/blk-mq.c                | 27 ++++++++++++++-------------
 block/blk-pm.c                |  2 +-
 block/blk.h                   |  1 +
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c |  2 +-
 include/linux/blk-mq.h        |  2 +-
 7 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 5d50dd16e2a5..d3dd439a8ed4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -269,6 +269,19 @@ void blk_put_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_put_queue);
 
+void blk_freeze_queue_start(struct request_queue *q)
+{
+	mutex_lock(&q->mq_freeze_lock);
+	if (++q->mq_freeze_depth == 1) {
+		percpu_ref_kill(&q->q_usage_counter);
+		mutex_unlock(&q->mq_freeze_lock);
+		if (queue_is_mq(q))
+			blk_mq_run_hw_queues(q, false);
+	} else {
+		mutex_unlock(&q->mq_freeze_lock);
+	}
+}
+
 void blk_queue_start_drain(struct request_queue *q)
 {
 	/*
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e0654a2e80b9..d638bd0fb4d8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -161,19 +161,20 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct block_device *part,
 	inflight[1] = mi.inflight[1];
 }
 
-void blk_freeze_queue_start(struct request_queue *q)
+void blk_mq_freeze_queue_start(struct request_queue *q)
 {
-	mutex_lock(&q->mq_freeze_lock);
-	if (++q->mq_freeze_depth == 1) {
-		percpu_ref_kill(&q->q_usage_counter);
-		mutex_unlock(&q->mq_freeze_lock);
-		if (queue_is_mq(q))
-			blk_mq_run_hw_queues(q, false);
-	} else {
-		mutex_unlock(&q->mq_freeze_lock);
-	}
+	/*
+	 * Warn on non-blk-mq usages.
+	 */
+	WARN_ON_ONCE(!queue_is_mq(q));
+
+	/*
+	 * Just an alias of blk_freeze_queue_start to keep the consistency of the
+	 * blk_mq_* namespace.
+	 */
+	blk_freeze_queue_start(q);
 }
-EXPORT_SYMBOL_GPL(blk_freeze_queue_start);
+EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_start);
 
 void blk_mq_freeze_queue_wait(struct request_queue *q)
 {
@@ -196,7 +197,7 @@ EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait_timeout);
  */
 void blk_mq_freeze_queue(struct request_queue *q)
 {
-	blk_freeze_queue_start(q);
+	blk_mq_freeze_queue_start(q);
 	blk_mq_freeze_queue_wait(q);
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue);
@@ -1570,7 +1571,7 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	 * percpu_ref_tryget directly, because we need to be able to
 	 * obtain a reference even in the short window between the queue
 	 * starting to freeze, by dropping the first reference in
-	 * blk_freeze_queue_start, and the moment the last request is
+	 * blk_mq_freeze_queue_start, and the moment the last request is
 	 * consumed, marked by the instant q_usage_counter reaches
 	 * zero.
 	 */
diff --git a/block/blk-pm.c b/block/blk-pm.c
index 2dad62cc1572..ae2b950ed45d 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -80,7 +80,7 @@ int blk_pre_runtime_suspend(struct request_queue *q)
 	blk_set_pm_only(q);
 	ret = -EBUSY;
 	/* Switch q_usage_counter from per-cpu to atomic mode. */
-	blk_freeze_queue_start(q);
+	blk_mq_freeze_queue_start(q);
 	/*
 	 * Wait until atomic mode has been reached. Since that
 	 * involves calling call_rcu(), it is guaranteed that later
diff --git a/block/blk.h b/block/blk.h
index e9addea2838a..ee576bb74382 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -37,6 +37,7 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 					      gfp_t flags);
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
+void blk_freeze_queue_start(struct request_queue *q);
 void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 void blk_queue_start_drain(struct request_queue *q);
 int __bio_queue_enter(struct request_queue *q, struct bio *bio);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0090dc0b3ae6..e2d5c54c651a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5199,7 +5199,7 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_freeze_queue_start(ns->queue);
+		blk_mq_freeze_queue_start(ns->queue);
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_start_freeze);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0ea7e441e080..3bb358bd0cde 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -77,7 +77,7 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 	lockdep_assert_held(&subsys->lock);
 	list_for_each_entry(h, &subsys->nsheads, entry)
 		if (h->disk)
-			blk_freeze_queue_start(h->disk->queue);
+			blk_mq_freeze_queue_start(h->disk->queue);
 }
 
 void nvme_failover_req(struct request *req)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 569053ed959d..8600d4b4aa80 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -887,7 +887,7 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 void blk_mq_tagset_wait_completed_request(struct blk_mq_tag_set *tagset);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
-void blk_freeze_queue_start(struct request_queue *q);
+void blk_mq_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
-- 
2.31.1


