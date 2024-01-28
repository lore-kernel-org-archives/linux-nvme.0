Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5A8C47258
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jan 2024 16:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1rC96JPIw60wGtyelFSw0nJY6Da4CMeb34hgsyD2/tk=; b=U1iw+8TVvGmbP9vYIRZtRhgYDq
	Dw2eFqgAmI9EuqBiYkxMktBVZhMfXAk+NKoT5tPB8a6KHV2sonFbwxICCTvZSlTgeQ8+PzeMYfDjT
	cq2/mDmD9rP6BfPcFjNc3CV5iDQmmxvwk6BYtrsa9St7Dys3qIOnE1VM2gISi+0W5t3V6yTVHqiy3
	wsaJGP2njBNQzht0GbNiaDzRxPT5S6F76e5QoHzwNqDx3Ci8gtperiLv77+w9ooWciCePUpnL1DFC
	e5jM6VZZzy47Pl1/TsHXDqKWaVgcKYCke66AlOj6yN59gCxtJi/nUeeDCglmZo2lAREtG//ToVVYU
	0AMjpTnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU8Ug-0000000A2Hh-44u2;
	Sun, 28 Jan 2024 16:58:55 +0000
Received: from [2001:4bb8:182:6550:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU8Uc-0000000A2C5-0J3l;
	Sun, 28 Jan 2024 16:58:50 +0000
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
Subject: [PATCH 07/14] block: pass a queue_limits argument to blk_alloc_queue
Date: Sun, 28 Jan 2024 17:58:06 +0100
Message-Id: <20240128165813.3213508-8-hch@lst.de>
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

Pass a queue_limits to blk_alloc_queue and apply it if non-NULL.  This
will allow allocating queues with valid queue limits instead of setting
the values one at a time later.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-core.c | 30 ++++++++++++++++++++++--------
 block/blk-mq.c   |  6 +++---
 block/blk.h      |  2 +-
 block/genhd.c    |  4 ++--
 4 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 09f4a44a4aa3cc..26d3be06bcc0fd 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -393,24 +393,38 @@ static void blk_timeout_work(struct work_struct *work)
 {
 }
 
-struct request_queue *blk_alloc_queue(int node_id)
+struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
 {
 	struct request_queue *q;
+	int error;
 
 	q = kmem_cache_alloc_node(blk_requestq_cachep, GFP_KERNEL | __GFP_ZERO,
 				  node_id);
 	if (!q)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	q->last_merge = NULL;
 
+	if (lim) {
+		error = blk_validate_limits(lim);
+		if (error)
+			goto fail_q;
+		q->limits = *lim;
+	} else {
+		blk_set_default_limits(&q->limits);
+	}
+
 	q->id = ida_alloc(&blk_queue_ida, GFP_KERNEL);
-	if (q->id < 0)
+	if (q->id < 0) {
+		error = q->id;
 		goto fail_q;
+	}
 
 	q->stats = blk_alloc_queue_stats();
-	if (!q->stats)
+	if (!q->stats) {
+		error = -ENOMEM;
 		goto fail_id;
+	}
 
 	q->node = node_id;
 
@@ -435,12 +449,12 @@ struct request_queue *blk_alloc_queue(int node_id)
 	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
 	 * See blk_register_queue() for details.
 	 */
-	if (percpu_ref_init(&q->q_usage_counter,
+	error = percpu_ref_init(&q->q_usage_counter,
 				blk_queue_usage_counter_release,
-				PERCPU_REF_INIT_ATOMIC, GFP_KERNEL))
+				PERCPU_REF_INIT_ATOMIC, GFP_KERNEL);
+	if (error)
 		goto fail_stats;
 
-	blk_set_default_limits(&q->limits);
 	q->nr_requests = BLKDEV_DEFAULT_RQ;
 
 	return q;
@@ -451,7 +465,7 @@ struct request_queue *blk_alloc_queue(int node_id)
 	ida_free(&blk_queue_ida, q->id);
 fail_q:
 	kmem_cache_free(blk_requestq_cachep, q);
-	return NULL;
+	return ERR_PTR(error);
 }
 
 /**
diff --git a/block/blk-mq.c b/block/blk-mq.c
index aa87fcfda1ecfc..2ddbefdeae93e4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4092,9 +4092,9 @@ static struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
 	struct request_queue *q;
 	int ret;
 
-	q = blk_alloc_queue(set->numa_node);
-	if (!q)
-		return ERR_PTR(-ENOMEM);
+	q = blk_alloc_queue(NULL, set->numa_node);
+	if (IS_ERR(q))
+		return q;
 	q->queuedata = queuedata;
 	ret = blk_mq_init_allocated_queue(set, q);
 	if (ret) {
diff --git a/block/blk.h b/block/blk.h
index 58b5dbac2a487d..100c7a02854bfd 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -448,7 +448,7 @@ static inline void bio_release_page(struct bio *bio, struct page *page)
 }
 
 int blk_validate_limits(struct queue_limits *lim);
-struct request_queue *blk_alloc_queue(int node_id);
+struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id);
 
 int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode);
 
diff --git a/block/genhd.c b/block/genhd.c
index d74fb5b4ae6818..defcd35b421bdd 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1396,8 +1396,8 @@ struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass)
 	struct request_queue *q;
 	struct gendisk *disk;
 
-	q = blk_alloc_queue(node);
-	if (!q)
+	q = blk_alloc_queue(NULL, node);
+	if (IS_ERR(q))
 		return NULL;
 
 	disk = __alloc_disk_node(q, node, lkclass);
-- 
2.39.2


