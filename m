Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69FBC4829B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 06:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dx6sARfC/sXmZqfT3YRO2LeR15GkI17KFSCz6+3XuI0=; b=OvGcpy15Qyf9uof/kApDfr84Sh
	ZapZBzl1gGUoKcBsXomoosMuvPcfDPXsZ8FY4HeHhBjjqg0d/vbDNScI0vE5FbuEartfx69eb4rvc
	Damz4Edu/dcYvU+TKNeVg+9pnxHr2Ajyc7AQm7MxZS7HkS+om8Pi6/eAJDtp3FDkIR0+g0kkIc9z5
	+02fWKDuhvFiuuDh8DBNo/TN85ivGj5orDZivDcAygRdEvNJhQfC4su0WflyuPNMNdRbxgqPOetwZ
	B+0uzXATcc4oWF/3STV9ZC75shPgI94MDc6SCHIpo3GK+hUD6ipNEQUyasf+jtY44P8CjOoOddmSr
	BvJEvh7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQ5Z-00000004PsQ-0FSR;
	Mon, 12 Feb 2024 06:46:49 +0000
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQ5Q-00000004PjB-2w09;
	Mon, 12 Feb 2024 06:46:41 +0000
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
	virtualization@lists.linux.dev
Subject: [PATCH 08/15] block: pass a queue_limits argument to blk_alloc_queue
Date: Mon, 12 Feb 2024 07:46:02 +0100
Message-Id: <20240212064609.1327143-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212064609.1327143-1-hch@lst.de>
References: <20240212064609.1327143-1-hch@lst.de>
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

Pass a queue_limits to blk_alloc_queue and apply it after validating and
capping the values using blk_validate_limits.  This will allow allocating
queues with valid queue limits instead of setting the values one at a
time later.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 26 ++++++++++++++++++--------
 block/blk-mq.c   |  7 ++++---
 block/genhd.c    |  5 +++--
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index cb56724a8dfb25..a16b5abdbbf56f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -394,24 +394,34 @@ static void blk_timeout_work(struct work_struct *work)
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
+
+	error = blk_set_default_limits(lim);
+	if (error)
+		goto fail_stats;
+	q->limits = *lim;
 
 	q->node = node_id;
 
@@ -436,12 +446,12 @@ struct request_queue *blk_alloc_queue(int node_id)
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
@@ -452,7 +462,7 @@ struct request_queue *blk_alloc_queue(int node_id)
 	ida_free(&blk_queue_ida, q->id);
 fail_q:
 	kmem_cache_free(blk_requestq_cachep, q);
-	return NULL;
+	return ERR_PTR(error);
 }
 
 /**
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6d2f7b5caa01d8..9dd8055cc5246d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4086,12 +4086,13 @@ void blk_mq_release(struct request_queue *q)
 static struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
 		void *queuedata)
 {
+	struct queue_limits lim = { };
 	struct request_queue *q;
 	int ret;
 
-	q = blk_alloc_queue(set->numa_node);
-	if (!q)
-		return ERR_PTR(-ENOMEM);
+	q = blk_alloc_queue(&lim, set->numa_node);
+	if (IS_ERR(q))
+		return q;
 	q->queuedata = queuedata;
 	ret = blk_mq_init_allocated_queue(set, q);
 	if (ret) {
diff --git a/block/genhd.c b/block/genhd.c
index d74fb5b4ae6818..7a8fd57c51f73c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1393,11 +1393,12 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 
 struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass)
 {
+	struct queue_limits lim = { };
 	struct request_queue *q;
 	struct gendisk *disk;
 
-	q = blk_alloc_queue(node);
-	if (!q)
+	q = blk_alloc_queue(&lim, node);
+	if (IS_ERR(q))
 		return NULL;
 
 	disk = __alloc_disk_node(q, node, lkclass);
-- 
2.39.2


