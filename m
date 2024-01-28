Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2AEC47DA9
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jan 2024 16:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VkQnGHLYfsZR7BQ15iBgrA+jpFNlFz7GlsqkawjnWmg=; b=PBdGn8/xq2kG/cqMIlRqHzo0MP
	8XfZvi5jylI3HjjxIo+tYQ1DoiDjmyuI+DAkb+XK7eoPol6ubP9Ru3cI9NHcvodnndKO8ukY3RDaF
	luAJHVmH7T6SmaARfHyYABY2NDN5yKzxHNgtD9hCcPZLYRUVbzopV/I3kfgkRA6xAsowDstFvJ5+q
	ZQdpm4ZnaY+UvCox/zc7z6775PTRAKy7ldvcSD5d1OnTlnL/9n8xqcij4vzw7fVcgCWMvlrcxFSdD
	dfetOF265jFF3s0TB/gNicGUtXEIixjH7/+uOneiFmkjkw1KlWnwZhIZVjn5zMtSpmimKF3PPkXmo
	hNShlxug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU8Uk-0000000A2LE-1cdO;
	Sun, 28 Jan 2024 16:58:58 +0000
Received: from [2001:4bb8:182:6550:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU8Uf-0000000A2FP-2Q0m;
	Sun, 28 Jan 2024 16:58:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 08/14] block: pass a queue_limits argument to blk_mq_init_queue
Date: Sun, 28 Jan 2024 17:58:07 +0100
Message-Id: <20240128165813.3213508-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240128165813.3213508-1-hch@lst.de>
References: <20240128165813.3213508-1-hch@lst.de>
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

Pass a queue_limits to blk_mq_init_queue and apply it if non-NULL.  This
will allow allocating queues with valid queue limits instead of setting
the values one at a time later.

Also rename the function to blk_mq_alloc_queue as that is a much better
name for a function that allocates a queue and always pass the queuedata
argument instead of having a separate version for the extra argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq.c            | 19 +++++++------------
 block/bsg-lib.c           |  2 +-
 drivers/nvme/host/apple.c |  2 +-
 drivers/nvme/host/core.c  |  6 +++---
 drivers/scsi/scsi_scan.c  |  2 +-
 drivers/ufs/core/ufshcd.c |  2 +-
 include/linux/blk-mq.h    |  3 ++-
 7 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2ddbefdeae93e4..87fbf4a6d1dbed 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4086,13 +4086,13 @@ void blk_mq_release(struct request_queue *q)
 	blk_mq_sysfs_deinit(q);
 }
 
-static struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
-		void *queuedata)
+struct request_queue *blk_mq_alloc_queue(struct blk_mq_tag_set *set,
+		struct queue_limits *lim, void *queuedata)
 {
 	struct request_queue *q;
 	int ret;
 
-	q = blk_alloc_queue(NULL, set->numa_node);
+	q = blk_alloc_queue(lim, set->numa_node);
 	if (IS_ERR(q))
 		return q;
 	q->queuedata = queuedata;
@@ -4103,20 +4103,15 @@ static struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
 	}
 	return q;
 }
-
-struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
-{
-	return blk_mq_init_queue_data(set, NULL);
-}
-EXPORT_SYMBOL(blk_mq_init_queue);
+EXPORT_SYMBOL(blk_mq_alloc_queue);
 
 /**
  * blk_mq_destroy_queue - shutdown a request queue
  * @q: request queue to shutdown
  *
- * This shuts down a request queue allocated by blk_mq_init_queue(). All future
+ * This shuts down a request queue allocated by blk_mq_alloc_queue(). All future
  * requests will be failed with -ENODEV. The caller is responsible for dropping
- * the reference from blk_mq_init_queue() by calling blk_put_queue().
+ * the reference from blk_mq_alloc_queue() by calling blk_put_queue().
  *
  * Context: can sleep
  */
@@ -4143,7 +4138,7 @@ struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata,
 	struct request_queue *q;
 	struct gendisk *disk;
 
-	q = blk_mq_init_queue_data(set, queuedata);
+	q = blk_mq_alloc_queue(set, NULL, queuedata);
 	if (IS_ERR(q))
 		return ERR_CAST(q);
 
diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index b3acdbdb6e7ea8..bcc7dee6abced6 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -383,7 +383,7 @@ struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
 	if (blk_mq_alloc_tag_set(set))
 		goto out_tag_set;
 
-	q = blk_mq_init_queue(set);
+	q = blk_mq_alloc_queue(set, NULL, NULL);
 	if (IS_ERR(q)) {
 		ret = PTR_ERR(q);
 		goto out_queue;
diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 596bb11eeba5a9..02d01614c729dd 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1515,7 +1515,7 @@ static int apple_nvme_probe(struct platform_device *pdev)
 		goto put_dev;
 	}
 
-	anv->ctrl.admin_q = blk_mq_init_queue(&anv->admin_tagset);
+	anv->ctrl.admin_q = blk_mq_alloc_queue(&anv->admin_tagset, NULL, NULL);
 	if (IS_ERR(anv->ctrl.admin_q)) {
 		ret = -ENOMEM;
 		goto put_dev;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 85ab0fcf9e8864..d40e6f82bdd753 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4313,14 +4313,14 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	if (ret)
 		return ret;
 
-	ctrl->admin_q = blk_mq_init_queue(set);
+	ctrl->admin_q = blk_mq_alloc_queue(set, NULL, NULL);
 	if (IS_ERR(ctrl->admin_q)) {
 		ret = PTR_ERR(ctrl->admin_q);
 		goto out_free_tagset;
 	}
 
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
-		ctrl->fabrics_q = blk_mq_init_queue(set);
+		ctrl->fabrics_q = blk_mq_alloc_queue(set, NULL, NULL);
 		if (IS_ERR(ctrl->fabrics_q)) {
 			ret = PTR_ERR(ctrl->fabrics_q);
 			goto out_cleanup_admin_q;
@@ -4384,7 +4384,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 		return ret;
 
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
-		ctrl->connect_q = blk_mq_init_queue(set);
+		ctrl->connect_q = blk_mq_alloc_queue(set, NULL, NULL);
         	if (IS_ERR(ctrl->connect_q)) {
 			ret = PTR_ERR(ctrl->connect_q);
 			goto out_free_tag_set;
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 44680f65ea1455..9969f4e2f1c3d9 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -332,7 +332,7 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 
 	sdev->sg_reserved_size = INT_MAX;
 
-	q = blk_mq_init_queue(&sdev->host->tag_set);
+	q = blk_mq_alloc_queue(&sdev->host->tag_set, NULL, NULL);
 	if (IS_ERR(q)) {
 		/* release fn is set up in scsi_sysfs_device_initialise, so
 		 * have to free and put manually here */
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 029d017fc1b66b..c502a86db16b30 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -10592,7 +10592,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	err = blk_mq_alloc_tag_set(&hba->tmf_tag_set);
 	if (err < 0)
 		goto out_remove_scsi_host;
-	hba->tmf_queue = blk_mq_init_queue(&hba->tmf_tag_set);
+	hba->tmf_queue = blk_mq_alloc_queue(&hba->tmf_tag_set, NULL, NULL);
 	if (IS_ERR(hba->tmf_queue)) {
 		err = PTR_ERR(hba->tmf_queue);
 		goto free_tmf_tag_set;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 7a8150a5f05133..7d42c359e2ab28 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -692,7 +692,8 @@ struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata,
 })
 struct gendisk *blk_mq_alloc_disk_for_queue(struct request_queue *q,
 		struct lock_class_key *lkclass);
-struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *);
+struct request_queue *blk_mq_alloc_queue(struct blk_mq_tag_set *set,
+		struct queue_limits *lim, void *queuedata);
 int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		struct request_queue *q);
 void blk_mq_destroy_queue(struct request_queue *);
-- 
2.39.2


