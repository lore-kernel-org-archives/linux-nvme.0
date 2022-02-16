Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC26C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=L/CcCyyp5hu0XgplooZc86JwmaBqXw0p1v9k4qFQJ34=; b=KfEiIJUhl/60RIZBbzyvQ3ItVU
	4uhX71KOO+y26Pd5k8eGYwhYYguN1iwTZ8vjerG+yznj6fopvVvwXXOY+aD6lo6rXIyaPJ2H/RXcx
	KSpGQVcxROX0XsI46JywerYfdYSt75i/MVfrYlAxfmYbBM47eG2hJFdq5E/oXjzRG8eWuVEN8pek+
	bQ2nEGf1X/H4RqCAIO2eIuuAgctfkpH7iD2h2lPmCm6NHrxAX43PjmhTfuheN+TBOOc46eQaHgmX3
	r8uwJkdqCTuoQvjmP440kTcoB90H5zuF3hp2MZlhg3AGvxTqokvcgcvc+Lg3CA71dkLZiJ6KAvy4h
	lqSp1PLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKLvW-007RNA-Gz; Wed, 16 Feb 2022 15:09:06 +0000
Received: from [2001:4bb8:184:543c:6e8c:bf25:364a:5dde] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKLvT-007RMz-NS; Wed, 16 Feb 2022 15:09:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: kbusch@kernel.org, markus.bloechl@ipetronik.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: fix surprise removal for drivers calling
 blk_set_queue_dying
Date: Wed, 16 Feb 2022 16:09:00 +0100
Message-Id: <20220216150901.4166235-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Various block drivers call blk_set_queue_dying to mark a disk as dead due
to surprise removal events, but since commit 8e141f9eb803 that doesn't
work given that the GD_DEAD flag needs to be set to stop I/O.

Replace the driver calls to blk_set_queue_dying with a new (and properly
documented) blk_mark_disk_dead API, and fold blk_set_queue_dying into the
only remaining caller.

Fixes: 8e141f9eb803 ("block: drain file system I/O on del_gendisk")
Reported-by: Markus Blöchl <markus.bloechl@ipetronik.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c                  | 18 +++++++++++++-----
 drivers/block/mtip32xx/mtip32xx.c |  2 +-
 drivers/block/rbd.c               |  2 +-
 drivers/block/xen-blkfront.c      |  2 +-
 drivers/md/dm.c                   |  2 +-
 drivers/nvme/host/core.c          |  2 +-
 drivers/nvme/host/multipath.c     |  2 +-
 include/linux/blkdev.h            |  3 ++-
 8 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d93e3bb9a769b..15d5c5ba5bbe5 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -284,12 +284,19 @@ void blk_queue_start_drain(struct request_queue *q)
 	wake_up_all(&q->mq_freeze_wq);
 }
 
-void blk_set_queue_dying(struct request_queue *q)
+/**
+ * blk_set_disk_dead - mark a disk as dead
+ * @disk: disk to mark as dead
+ *
+ * Mark as disk as dead (e.g. surprise removed) and don't accept any new I/O
+ * to this disk.
+ */
+void blk_mark_disk_dead(struct gendisk *disk)
 {
-	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
-	blk_queue_start_drain(q);
+	set_bit(GD_DEAD, &disk->state);
+	blk_queue_start_drain(disk->queue);
 }
-EXPORT_SYMBOL_GPL(blk_set_queue_dying);
+EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
 
 /**
  * blk_cleanup_queue - shutdown a request queue
@@ -308,7 +315,8 @@ void blk_cleanup_queue(struct request_queue *q)
 	WARN_ON_ONCE(blk_queue_registered(q));
 
 	/* mark @q DYING, no new request or merges will be allowed afterwards */
-	blk_set_queue_dying(q);
+	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
+	blk_queue_start_drain(q);
 
 	blk_queue_flag_set(QUEUE_FLAG_NOMERGES, q);
 	blk_queue_flag_set(QUEUE_FLAG_NOXMERGES, q);
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index e6005c2323281..2b588b62cbbb2 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -4112,7 +4112,7 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 			"Completion workers still active!\n");
 	}
 
-	blk_set_queue_dying(dd->queue);
+	blk_mark_disk_dead(dd->disk);
 	set_bit(MTIP_DDF_REMOVE_PENDING_BIT, &dd->dd_flag);
 
 	/* Clean up the block layer. */
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4203cdab8abfd..b844432bad20b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -7185,7 +7185,7 @@ static ssize_t do_rbd_remove(struct bus_type *bus,
 		 * IO to complete/fail.
 		 */
 		blk_mq_freeze_queue(rbd_dev->disk->queue);
-		blk_set_queue_dying(rbd_dev->disk->queue);
+		blk_mark_disk_dead(rbd_dev->disk);
 	}
 
 	del_gendisk(rbd_dev->disk);
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index ccd0dd0c6b83c..ca71a0585333f 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2126,7 +2126,7 @@ static void blkfront_closing(struct blkfront_info *info)
 
 	/* No more blkif_request(). */
 	blk_mq_stop_hw_queues(info->rq);
-	blk_set_queue_dying(info->rq);
+	blk_mark_disk_dead(info->gd);
 	set_capacity(info->gd, 0);
 
 	for_each_rinfo(info, rinfo, i) {
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index dcbd6d201619d..997ace47bbd54 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2077,7 +2077,7 @@ static void __dm_destroy(struct mapped_device *md, bool wait)
 	set_bit(DMF_FREEING, &md->flags);
 	spin_unlock(&_minor_lock);
 
-	blk_set_queue_dying(md->queue);
+	blk_mark_disk_dead(md->disk);
 
 	/*
 	 * Take suspend_lock so that presuspend and postsuspend methods
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 79005ea1a33e3..469f23186159c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4574,7 +4574,7 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
 	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
 		return;
 
-	blk_set_queue_dying(ns->queue);
+	blk_mark_disk_dead(ns->disk);
 	nvme_start_ns_queue(ns);
 
 	set_capacity_and_notify(ns->disk, 0);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f8bf6606eb2fc..ff775235534cf 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -848,7 +848,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
-	blk_set_queue_dying(head->disk->queue);
+	blk_mark_disk_dead(head->disk);
 	/* make sure all pending bios are cleaned up */
 	kblockd_schedule_work(&head->requeue_work);
 	flush_work(&head->requeue_work);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f35aea98bc351..16b47035e4b06 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -748,7 +748,8 @@ extern bool blk_queue_can_use_dma_map_merging(struct request_queue *q,
 
 bool __must_check blk_get_queue(struct request_queue *);
 extern void blk_put_queue(struct request_queue *);
-extern void blk_set_queue_dying(struct request_queue *);
+
+void blk_mark_disk_dead(struct gendisk *disk);
 
 #ifdef CONFIG_BLOCK
 /*
-- 
2.30.2


