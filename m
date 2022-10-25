Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E29C38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 14:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BO8wr9Tkr8wJb0TsKSc24Yum8rIAp3tswr5IkvSTAYU=; b=VBu4rkFE/fEgrJM5v6gV3JMGub
	WTtOFV/E7M4U44ZlCMiTXhi3WhcDZsYj6SiyZy4wsHYnH/WUNL7QTEHp4DG5rnxLK/DzntQpPvKMh
	4KNXu7ZgCNQrOVu2ZJYJ1i73iy07At2ZLUNATHHcPJ8+rjipEwrKYNkAF5H3DDv3dHFQiyvBPbFFi
	n2MOjOnfVUa4DbjBGejeYRKggjTwnnz+EMkWuxHMsgwMN9GF42cm0QMgnDlxfAN47RG9NwzY58q7A
	PvV86yy8ApUXUclq0odZ79ruwUFq076D5MEgKAQrfAVO0NL7xSD9bHzNNMZ1VTH7x/mT1TTZjLFgs
	FiBOLkIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onL7x-005qpO-8r; Tue, 25 Oct 2022 14:42:01 +0000
Received: from [12.47.128.130] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onL6P-005poo-EZ; Tue, 25 Oct 2022 14:40:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 15/17] blk-mq: pass a tagset to blk_mq_wait_quiesce_done
Date: Tue, 25 Oct 2022 07:40:18 -0700
Message-Id: <20221025144020.260458-16-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025144020.260458-1-hch@lst.de>
References: <20221025144020.260458-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Nothing in blk_mq_wait_quiesce_done needs the request_queue now, so just
pass the tagset, and move the non-mq check into the only caller that
needs it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chao Leng <lengchao@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq.c           | 14 ++++++++------
 drivers/nvme/host/core.c |  4 ++--
 drivers/scsi/scsi_lib.c  |  2 +-
 include/linux/blk-mq.h   |  2 +-
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6cbf34921e33f..8f88c24a55c94 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -254,15 +254,17 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
 /**
  * blk_mq_wait_quiesce_done() - wait until in-progress quiesce is done
- * @q: request queue.
+ * @set: tag_set to wait on
  *
  * Note: it is driver's responsibility for making sure that quiesce has
- * been started.
+ * been started on or more of the request_queues of the tag_set.  This
+ * function only waits for the quiesce on those request_queues that had
+ * the quiesce flag set using blk_mq_quiesce_queue_nowait.
  */
-void blk_mq_wait_quiesce_done(struct request_queue *q)
+void blk_mq_wait_quiesce_done(struct blk_mq_tag_set *set)
 {
-	if (q->tag_set->flags & BLK_MQ_F_BLOCKING)
-		synchronize_srcu(q->tag_set->srcu);
+	if (set->flags & BLK_MQ_F_BLOCKING)
+		synchronize_srcu(set->srcu);
 	else
 		synchronize_rcu();
 }
@@ -282,7 +284,7 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 	blk_mq_quiesce_queue_nowait(q);
 	/* nothing to wait for non-mq queues */
 	if (queue_is_mq(q))
-		blk_mq_wait_quiesce_done(q);
+		blk_mq_wait_quiesce_done(q->tag_set);
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 00612e6857295..012ef0772f5b3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5090,7 +5090,7 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
 	if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
 		blk_mq_quiesce_queue(ns->queue);
 	else
-		blk_mq_wait_quiesce_done(ns->queue);
+		blk_mq_wait_quiesce_done(ns->queue->tag_set);
 }
 
 /* let I/O to all namespaces fail in preparation for surprise removal */
@@ -5180,7 +5180,7 @@ void nvme_stop_admin_queue(struct nvme_ctrl *ctrl)
 	if (!test_and_set_bit(NVME_CTRL_ADMIN_Q_STOPPED, &ctrl->flags))
 		blk_mq_quiesce_queue(ctrl->admin_q);
 	else
-		blk_mq_wait_quiesce_done(ctrl->admin_q);
+		blk_mq_wait_quiesce_done(ctrl->admin_q->tag_set);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_admin_queue);
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 8b89fab7c4206..249757ddd8fea 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2735,7 +2735,7 @@ static void scsi_stop_queue(struct scsi_device *sdev, bool nowait)
 			blk_mq_quiesce_queue(sdev->request_queue);
 	} else {
 		if (!nowait)
-			blk_mq_wait_quiesce_done(sdev->request_queue);
+			blk_mq_wait_quiesce_done(sdev->request_queue->tag_set);
 	}
 }
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index dc189d6b1a367..678ce8a661ec9 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -881,7 +881,7 @@ void blk_mq_start_hw_queues(struct request_queue *q);
 void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
 void blk_mq_quiesce_queue(struct request_queue *q);
-void blk_mq_wait_quiesce_done(struct request_queue *q);
+void blk_mq_wait_quiesce_done(struct blk_mq_tag_set *set);
 void blk_mq_unquiesce_queue(struct request_queue *q);
 void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
-- 
2.30.2


